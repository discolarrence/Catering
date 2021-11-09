CREATE DATABASE catering;

USE catering;

DROP TABLE IF EXISTS Vendors
DROP TABLE IF EXISTS Products
DROP TABLE IF EXISTS Recipes
DROP TABLE IF EXISTS Ingredients
DROP TABLE IF EXISTS Orders

CREATE TABLE Vendors(
	VendorID int NOT NULL PRIMARY KEY,
	VendorName varchar(40) NOT NULL,
	VendorURL varchar(100),
	VendorPhone int,
	VendorContact varchar(100),
)

CREATE TABLE Products(
	ProductID int NOT NULL PRIMARY KEY,
	ProductName varchar(40) NOT NULL,
	VendorID int NOT NULL,
	VendorItemCode varchar(40) NOT NULL,
	ProductQuantityOz int,
)

CREATE TABLE Recipes(
	RecipeID int NOT NULL PRIMARY KEY,
	RecipeName varchar(40) NOT NULL,
	RecipeServings int NOT NULL
)

CREATE TABLE Ingredients(
	IngredientID int NOT NULL PRIMARY KEY,
	RecipeID int NOT NULL,
	ProductID int NOT NULL,
	IngredientQuantityOz int NOT NULL,
)

CREATE TABLE Orders(
	OrderID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	RecipeID int NOT NULL,
	ReadyBy datetime NOT NULL,
	CateringType varchar(40) NOT NULL,
	Guests int NOT NULL
);

GO 

--Insert Data

--Create product & recipe indexes
CREATE NONCLUSTERED INDEX Products
    ON Products (ProductName);

CREATE NONCLUSTERED INDEX Recipes
    ON Recipes (RecipeName);
GO

--Create new order in order table
CREATE PROCEDURE NewOrder @RecipeID     int,
                          @ReadyBy      datetime,
                          @CateringType varchar(40),
                          @Guests       int
AS
    INSERT INTO Orders
                (RecipeID,
                 ReadyBy,
                 CateringType,
                 Guests)
         VALUES (@RecipeID,
                 @ReadyBy,
                 @CateringType,
                 @Guests)

GO 

--Weekly catering order sheet for week of yyyy-mm-dd
CREATE VIEW WeeklyProductQuantities
AS
  (SELECT p.ProductID,
          ( ( o.Guests / r.RecipeServings ) * i.IngredientQuantityOz ) /
          p.ProductID AS
          ProductQuantity,
		  o.ReadyBy
     FROM Orders o
          JOIN Recipes r
            ON o.RecipeID = r.RecipeID
          JOIN Ingredients i
            ON i.RecipeID = r.RecipeID
          JOIN Products p
            ON p.ProductID = i.ProductID);

GO 

CREATE PROCEDURE WeeklyOrderSheet @Date datetime
AS
    SELECT w.ProductQuantity,
           p.ProductID,
           p.ProductName,
           p.VendorID
      FROM Products p
           JOIN WeeklyProductQuantities w
             ON p.ProductID = w.ProductQuantity
	
    
     GROUP BY p.ProductID
	   HAVING w.ReadyBy BETWEEN @Date AND Dateadd(Day, 7, @Date)
     ORDER BY VendorID; 

 GO 

 --Change corresponding product for an ingredient
CREATE PROCEDURE UpdateProduct @ProductID    int,
                                   @IngredientID int
AS
    UPDATE Ingredients
       SET ProductID = @ProductID
     WHERE IngredientID = @IngredientID 

GO

--Delete order
CREATE PROCEDURE DeleteOrder @OrderID int
AS
    DELETE FROM Orders
     WHERE OrderID = @OrderID

GO 