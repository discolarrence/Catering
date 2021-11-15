USE MASTER;

GO

DROP DATABASE IF EXISTS Catering
CREATE DATABASE Catering;

USE Catering

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
     [Unit]           varchar(10),
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

--Create product & recipe indexes
CREATE NONCLUSTERED INDEX MenuItemsIndex
    ON MenuItems (ItemName);

--Create ingredients view
SELECT p.ID,
       p.ProductName,
          ( ( o.NumberOfGuests / m.RecipeServings ) * mi.ProductQuantity ) / p.Quantity
           AS
          ProductQuantity,
		  o.Date
     FROM Orders o
	      JOIN OrderItems i
		    ON o.ID = i.OrderID
          LEFT JOIN MenuItems m
            ON i.MenuItemID = m.ID
          LEFT JOIN MenuItemIngredients mi
            ON m.ID = mi.MenuItemID
          LEFT JOIN Products p
            ON mi.ProductID = p.ID

--Create disposables view
SELECT o.ID,
		p.ID,
       p.ProductName,
	   CASE
           WHEN 
           WHEN
           ELSE 
       END AS DisposableQuanity,
	   o.Date
  FROM Orders o
       JOIN OrderItems i
	     ON o.ID = i.OrderID
	   LEFT JOIN MenuItems m
         ON i.MenuItemID = m.ID
       LEFT JOIN PackagingDisposables d
	     ON m.PackagingTypeID = d.PackagingTypeID
       LEFT JOIN Products p 
	     ON d.ProductID = p.ID
