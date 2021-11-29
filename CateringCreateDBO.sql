/* CateringCreateDBO.sql
 * Author: Laura Rountree
 * Date Created: 11/15/2021
 * Description: Catering app
 *
 * Tables:
 *    Vendors (VendorName, Phone, Contact)
 *    Products (ProductName, VendorID, VendorItemCode, Quantity, Unit, ProductType)
 *    CateringTypes (CateringType)
 *    PackagingTypes (PackagingType)
 *    CateringDisposables (CateringTypeID, ProductID)
 *    PackagingDisposables (PackagingTypeID, CateringTypeID, ProductID, NumberOfGuestsPerEach)
 *    MenuItems (ItemName, RecipeServings, PackagingTypeID)
 *    MenuItemIngredients (MenuItemID, ProductID, ProductQuantity)
 *    Orders (OrderName, CateringType, NumberOfGuests, Date, Time)
 *    OrderItems (OrderID, MenuItemID, MenuItemQuantity)
 *
 * Indexes:
 *    MenuItems
 *    OrderNames
 *
 * Views:
 *    IngredientProductList(VendorName, VendorItemCode, ProductName, ProductQuantityNeeded, 
 *                          CaseQuantityNeeded, Date, CaseQuantity, CaseUnit)
 *    PackagingDisposablesProductList(VendorName, VendorItemCode, ProductName, ProductQuantityNeeded, 
 *                                    CaseQuantityNeeded, Date, CaseQuantity, CaseUnit)
 *     CateringDisposablesProductList(VendorName, VendorItemCode, ProductName, ProductQuantityNeeded, 
 *                                    CaseQuantityNeeded, Date, CaseQuantity, CaseUnit)
 *    AllDisposablesList(VendorName, VendorItemCode, ProductName, ProductQuantityNeeded, 
 *                       CaseQuantityNeeded, Date, CaseQuantity, CaseUnit)
 *    AllProductList(VendorName, VendorItemCode, ProductName, ProductQuantityNeeded, 
 *                   CaseQuantityNeeded, Date, CaseQuantity, CaseUnit)

 * Stored Procedures
 *    NewOrderItem (@OrderID, @MenuItem, @Quantity)
 *    CreateOrderSheet (@StartDate, @EndDate)
 *    CreateDisposablesOrderSheet (@StartDate, @EndDate)
 *    UpdateProduct (@OldProductID, @NewProductID)
 *    DeleteOrderByID (@OrderID)
 *    DeleteOrderByName (@OrderName)
 *
*/

--Create Database
DROP DATABASE IF EXISTS Catering
CREATE DATABASE Catering;

USE Catering


/******************************************************
    Tables
******************************************************/
DROP TABLE IF EXISTS dbo.Vendors
DROP TABLE IF EXISTS dbo.Products
DROP TABLE IF EXISTS dbo.CateringTypes
DROP TABLE IF EXISTS dbo.PackagingTypes
DROP TABLE IF EXISTS dbo.CateringDisposables
DROP TABLE IF EXISTS dbo.PackagingDisposables
DROP TABLE IF EXISTS dbo.MenuItems
DROP TABLE IF EXISTS dbo.MenuItemIngredients
DROP TABLE IF EXISTS dbo.Orders 
DROP TABLE IF EXISTS dbo.OrderItems

CREATE TABLE dbo.Vendors
  (
     [ID]         int NOT NULL IDENTITY PRIMARY KEY,
     [VendorName] varchar(40) NOT NULL,
     [Phone]      varchar(40),
     [Contact]    varchar(100),
  )

CREATE TABLE dbo.Products
  (
     [ID]             int NOT NULL IDENTITY PRIMARY KEY,
     [ProductName]    varchar(100) NOT NULL,
     [VendorID]       int NOT NULL,
     [VendorItemCode] varchar(40) NOT NULL,
     [Quantity]       decimal(10, 2) NOT NULL,
     [Unit]           varchar(10) NOT NULL,
     [ProductType]    int NOT NULL
     FOREIGN KEY(VendorID) REFERENCES Vendors(ID)
  )

CREATE TABLE dbo.CateringTypes
  (
     [ID]           int NOT NULL IDENTITY PRIMARY KEY,
     [CateringType] varchar(40) NOT NULL
  )

CREATE TABLE dbo.PackagingTypes
  (
     [ID]            int NOT NULL IDENTITY PRIMARY KEY,
     [PackagingType] varchar(40) NOT NULL
  )

CREATE TABLE dbo.CateringDisposables
  (
     [CateringTypeID] int NOT NULL,
     [ProductID]      int NOT NULL,
     FOREIGN KEY(CateringTypeID) REFERENCES CateringTypes(ID),
     FOREIGN KEY(ProductID) REFERENCES Products(ID)
  )

CREATE TABLE dbo.PackagingDisposables
  (
     [PackagingTypeID]       int NOT NULL,
     [CateringTypeID]        int NOT NULL,
     [ProductID]             int NOT NULL,
     [NumberOfGuestsPerEach] int NOT NULL,
     FOREIGN KEY(PackagingTypeID) REFERENCES PackagingTypes(ID),
     FOREIGN KEY(CateringTypeID) REFERENCES CateringTypes(ID),
     FOREIGN KEY(ProductID) REFERENCES Products(ID)
  )

CREATE TABLE dbo.MenuItems
  (
     [ID]              int NOT NULL IDENTITY PRIMARY KEY,
     [ItemName]        varchar(40) NOT NULL UNIQUE,
     [RecipeServings]  int NOT NULL,
     [PackagingTypeID] int NOT NULL,
     FOREIGN KEY(PackagingTypeID) REFERENCES PackagingTypes(ID)
  )

CREATE TABLE dbo.MenuItemIngredients
  (
     [MenuItemID]      int NOT NULL,
     [ProductID]       int NOT NULL,
     [ProductQuantity] decimal(10, 2) NOT NULL,
     FOREIGN KEY(MenuItemID) REFERENCES MenuItems(ID),
     FOREIGN KEY(ProductID) REFERENCES Products(ID),
  )

CREATE TABLE dbo.Orders
  (
     [ID]             int NOT NULL IDENTITY PRIMARY KEY,
     [OrderName]      varchar(100) NOT NULL,
     [CateringTypeID] int NOT NULL,
     [NumberOfGuests] int NOT NULL,
     [Date]           date NOT NULL,
     [Time]           time NOT NULL,
     FOREIGN KEY(CateringTypeID) REFERENCES CateringTypes(ID)
  )

CREATE TABLE dbo.OrderItems
  (
     [OrderID]          int NOT NULL,
     [MenuItemID]       int NOT NULL,
     [MenuItemQuantity] int NOT NULL,
     FOREIGN KEY(MenuItemID) REFERENCES MenuItems(ID),
     FOREIGN KEY(OrderID) REFERENCES Orders(ID)
  ); 

GO 

/******************************************************
    Index
******************************************************/
--Create menu item and order name indexes
DROP INDEX IF EXISTS MenuItemsIndex ON dbo.MenuItems;
DROP INDEX IF EXISTS OrderNames ON dbo.OrderNames;

CREATE NONCLUSTERED INDEX MenuItemsIndex
    ON MenuItems (ItemName);

CREATE NONCLUSTERED INDEX OrderNames
    ON Orders (OrderName);

GO 

/******************************************************
    Views
******************************************************/
--Create ingredients view
CREATE OR ALTER VIEW IngredientsProductList
AS
SELECT v.VendorName,
       p.VendorItemCode,
       p.ProductName,
       ( ( o.NumberOfGuests / m.RecipeServings ) * mi.ProductQuantity ) AS
       ProductQuantityNeeded,
       ( ( o.NumberOfGuests / m.RecipeServings ) * mi.ProductQuantity ) /
       p.Quantity AS
       CaseQuantityNeeded,
       o.Date,
       p.Quantity AS
       CaseQuantity,
       p.Unit AS
       CaseUnit
  FROM Orders o
       INNER JOIN OrderItems i
               ON o.ID = i.OrderID
        LEFT JOIN MenuItems m
               ON i.MenuItemID = m.ID
        LEFT JOIN MenuItemIngredients mi
               ON m.ID = mi.MenuItemID
        LEFT JOIN Products p
               ON mi.ProductID = p.ID
        LEFT JOIN Vendors v
               ON v.ID = p.VendorID; 

GO

--Create packaging disposables view
CREATE OR ALTER VIEW PackagingDisposablesProductList
AS
SELECT v.VendorName,
       p.VendorItemCode,
       p.ProductName,
       CASE
         WHEN d.NumberOfGuestsPerEach = 0 THEN 1
         ELSE i.MenuItemQuantity / d.NumberOfGuestsPerEach 
       END AS
	     ProductQuantityNeeded,
       CASE
         WHEN d.NumberOfGuestsPerEach = 0 THEN 1 / p.Quantity
         ELSE ( i.MenuItemQuantity / d.NumberOfGuestsPerEach ) / p.Quantity
       END AS
       CaseQuantityNeeded,
       o.Date,
       p.Quantity AS
       CaseQuantity,
       p.Unit AS
       CaseUnit
  FROM Orders o
       INNER JOIN OrderItems i
               ON o.ID = i.OrderID
        LEFT JOIN MenuItems m
               ON i.MenuItemID = m.ID
        LEFT JOIN PackagingDisposables d
               ON m.PackagingTypeID = d.PackagingTypeID
        LEFT JOIN Products p
               ON d.ProductID = p.ID
        LEFT JOIN Vendors v
               ON v.ID = p.VendorID
  WHERE o.CateringTypeID = d.CateringTypeID; 

GO

--Create catering disposables view
CREATE OR ALTER VIEW CateringDisposablesProductList
AS
SELECT v.VendorName,
       p.VendorItemCode,
       p.ProductName,
       o.NumberOfGuests AS ProductQuantityNeeded,
       o.NumberOfGuests / p.Quantity AS CaseQuantityNeeded,
       o.Date,
       p.Quantity AS
       CaseQuantity,
       p.Unit AS
	     CaseUnit
  FROM Orders o
       INNER JOIN CateringDisposables c
               ON o.CateringTypeID = c.CateringTypeID
        LEFT JOIN Products p
               ON p.ID = c.ProductID
        LEFT JOIN Vendors v
               ON v.ID = p.VendorID; 

GO

--Create all disposables view
CREATE OR ALTER VIEW AllDisposablesProductList
AS
SELECT VendorName,
       VendorItemCode,
       ProductName,
       ProductQuantityNeeded,
       CaseQuantityNeeded,
       Date,
       CaseQuantity,
       CaseUnit
  FROM PackagingDisposablesProductList
UNION ALL
SELECT VendorName,
       VendorItemCode,
       ProductName,
       ProductQuantityNeeded,
       CaseQuantityNeeded,
       Date,
       CaseQuantity,
       CaseUnit
  FROM CateringDisposablesProductList; 

GO

--Create all product view
CREATE OR ALTER VIEW AllProductList
AS
SELECT VendorName,
       VendorItemCode,
       ProductName,
       ProductQuantityNeeded,
       CaseQuantityNeeded,
       Date,
       CaseQuantity,
       CaseUnit
  FROM IngredientsProductList
UNION ALL
SELECT VendorName,
       VendorItemCode,
       ProductName,
       ProductQuantityNeeded,
       CaseQuantityNeeded,
       Date,
       CaseQuantity,
       CaseUnit
  FROM PackagingDisposablesProductList
UNION ALL
SELECT VendorName,
       VendorItemCode,
       ProductName,
       ProductQuantityNeeded,
       CaseQuantityNeeded,
       Date,
       CaseQuantity,
       CaseUnit
  FROM CateringDisposablesProductList; 

GO

/******************************************************
    Stored Procedures
******************************************************/
/** 
    Stored Procedure: NewOrderItem 
    Usage: Creates a new order item in order item table
    Parameters:
       @OrderID--Corresponding order ID
       @MenuItem--Name of menu item
       @Quantity--Quantity of menu item needed
    Returns:
       None
    Error Checks:
       Can't add item if @MenuItem input refers to multiple or no menu items.
**/
CREATE OR ALTER PROCEDURE dbo.NewOrderItem @OrderID  INT,
                                           @MenuItem VARCHAR(40),
                                           @Quantity INT
AS
    IF (SELECT Count(*)
          FROM MenuItems
         WHERE ItemName LIKE '%' + @MenuItem + '%') > 1
      THROW 50000, 'More than one menu item returned', 1

    IF (SELECT Count(*)
          FROM MenuItems
         WHERE ItemName LIKE '%' + @MenuItem + '%') = 0
      THROW 50001, 'No menu items returned', 1

    DECLARE @MenuItemID AS INT

    SELECT @MenuItemID = ID
      FROM MenuItems
     WHERE ItemName LIKE '%' + @MenuItem + '%'

    INSERT INTO OrderItems
                (OrderID,
                 MenuItemID,
                 MenuItemQuantity)
         VALUES (@OrderID,
                 @MenuItemID,
                 @Quantity);
  
GO

/** 
    Stored Procedure: CreateOrderSheet 
    Usage: Create supply order sheet based on catering orders for a specified time period 
    Parameters:
       @StartDate--first day of order period (YYYYMMDD format expected)
       @EndDate--last day of order period (YYYYMMDD format expected)
    Returns:
       Result Set: VendorName, VendorItemCode, ProductName, ProductQuantityNeeded, 
	     CaseQuantityNeeded, RawCaseQuantityNeeded, CaseQuantity, CaseUnit
    Error Checks:
       None
**/
CREATE OR ALTER PROCEDURE dbo.CreateOrderSheet @StartDate date,
                                               @EndDate   date
AS
    SELECT VendorName,
           VendorItemCode,
           ProductName,
           Sum(ProductQuantityNeeded)                      AS ProductQuantityNeeded,
           Ceiling(Sum(CaseQuantityNeeded))                AS CaseQuantityNeeded,
           Cast(Sum(CaseQuantityNeeded) AS DECIMAL(10, 2)) AS RawCaseQuantityNeeded,
           CaseQuantity,
           CaseUnit
      FROM AllProductList
     WHERE Date BETWEEN @StartDate AND @EndDate
     GROUP BY ProductName,
              VendorName,
              VendorItemCode,
              CaseQuantity,
              CaseUnit
     ORDER BY VendorName,
              ProductName

GO

/** 
    Stored Procedure: CreateDisposablesOrderSheet 
    Usage: Create supply order sheet based on catering orders for a specified time period 
    Parameters:
       @StartDate--first day of order period (YYYYMMDD format expected)
       @EndDate--last day of order period (YYYYMMDD format expected)
    Returns:
       Result Set: VendorName, VendorItemCode, ProductName, ProductQuantityNeeded, 
	     CaseQuantityNeeded, RawCaseQuantityNeeded, CaseQuantity, CaseUnit
    Error Checks:
       None
**/
CREATE OR ALTER PROCEDURE dbo.CreateDisposablesOrderSheet @StartDate date,
                                                          @EndDate   date
AS
    SELECT VendorName,
           VendorItemCode,
           ProductName,
           Sum(ProductQuantityNeeded)                      AS ProductQuantityNeeded,
           Ceiling(Sum(CaseQuantityNeeded))                AS CaseQuantityNeeded,
           Cast(Sum(CaseQuantityNeeded) AS DECIMAL(10, 2)) AS RawCaseQuantityNeeded,
           CaseQuantity,
           CaseUnit
      FROM AllDisposablesProductList
     WHERE Date BETWEEN @StartDate AND @EndDate
     GROUP BY ProductName,
              VendorName,
              VendorItemCode,
              CaseQuantity,
              CaseUnit
     ORDER BY VendorName,
              ProductName 

GO

/** 
    Stored Procedure: UpdateProduct 
    Usage: Change corresponding product for a packaging disposable
    Parameters:
       @OldProductID--ID of product being replaced
       @NewProductID--ID of replacement product
	     @ProductType--Product type
    Returns:
       None
    Error Checks:
      Product will not be updated if product type is not packaging, catering, or ingredient
**/
CREATE OR ALTER PROCEDURE dbo.UpdateProduct @OldProductID int,
                                            @NewProductID int
AS
    DECLARE @OldProductType AS INT,
            @NewProductType AS INT

    SELECT @OldProductType = ProductType
      FROM Products
     WHERE ID = @OldProductID

    SELECT @NewProductType = ProductType
      FROM Products
     WHERE ID = @NewProductID

    IF @OldProductType <> @NewProductType
      THROW 50007, 'Old and new product types do not match.', 1

    IF @OldProductType IS NULL
        OR @NewProductType IS NULL
      THROW 50008, 'Product ID does not exist.', 1

	IF @NewProductType = 1
	BEGIN
      UPDATE MenuItemIngredients
         SET ProductID = @NewProductID
       WHERE ProductID = @OldProductID;
	END

    IF @NewProductType = 2
	BEGIN
      UPDATE PackagingDisposables
         SET ProductID = @NewProductID
       WHERE ProductID = @OldProductID;
    END

    IF @NewProductType = 3
	BEGIN
      UPDATE CateringDisposables
         SET ProductID = @NewProductID
       WHERE ProductID = @OldProductID;
	END;

GO 

/** 
    Stored Procedure: DeleteOrderByName 
    Usage: Delete order by order ID
    Parameters:
       @OrderID--ID of order to be deleted
    Returns:
       None
    Error Checks:
      If either delete statement fails, nothing is deleted.
**/
CREATE OR ALTER PROCEDURE dbo.DeleteOrderByID @OrderID int
AS
  BEGIN
      BEGIN TRY
          SET NOCOUNT ON;
          SET XACT_ABORT ON;

          BEGIN TRANSACTION;

          DELETE FROM OrderItems
           WHERE OrderID = @OrderID

          DELETE FROM Orders
           WHERE ID = @OrderID;

          COMMIT TRANSACTION;
      END TRY

      BEGIN CATCH
          IF ( @@TRANCOUNT > 0 )
            ROLLBACK TRANSACTION;

          THROW 50004, 'No rows have been deleted', 1;
      END CATCH
  END 

GO

/** 
    Stored Procedure: DeleteOrderByName 
    Usage: Delete order by order name
    Parameters:
       @OrderName--name of order to be deleted
    Returns:
       None
    Error Checks:
      Nothing is deleted if either delete statement fails.
	    Can't add item if @OrderName input refers to multiple or no order names.
**/
CREATE OR ALTER PROCEDURE dbo.DeleteOrderByName @OrderName varchar(40)
AS
  BEGIN
      BEGIN TRY
          SET NOCOUNT ON;
          SET XACT_ABORT ON;

          BEGIN TRANSACTION;

          IF (SELECT Count(*)
                FROM Orders
               WHERE OrderName LIKE '%' + @OrderName + '%') > 1
            THROW 50002, 'More than one name returned', 1

          IF (SELECT Count(*)
                FROM Orders
               WHERE OrderName LIKE '%' + @OrderName + '%') = 0
            THROW 50003, 'No names returned', 1

          DECLARE @OrderID AS INT

          SELECT @OrderID = ID
            FROM Orders
           WHERE OrderName LIKE '%' + @OrderName + '%'

          DELETE FROM OrderItems
           WHERE OrderID = @OrderID

          DELETE FROM Orders
           WHERE ID = @OrderID;

          COMMIT TRANSACTION;
      END TRY

      BEGIN CATCH
          IF ( @@TRANCOUNT > 0 )
            ROLLBACK TRANSACTION;

          THROW 50004, 'No rows have been deleted', 1;
      END CATCH
  END 

GO
 