CREATE DATABASE catering;

USE catering;

CREATE TABLE dbo.Vendors(
	VendorID int NOT NULL PRIMARY KEY,
	VendorName varchar(40) NOT NULL,
	VendorURL varchar(100),
	VendorPhone int,
	VendorContact varchar(100),
)

CREATE TABLE dbo.Products(
	ProductID int NOT NULL PRIMARY KEY,
	ProductName varchar(40) NOT NULL,
	VendorID int NOT NULL,
	VendorItemCode varchar(40) NOT NULL,
	ProductQuantityOz int,
)

CREATE TABLE dbo.Recipes(
	RecipeID int NOT NULL PRIMARY KEY,
	RecipeName varchar(40) NOT NULL,
	RecipeServings int NOT NULL
)

CREATE TABLE dbo.Ingredients(
	IngredientID int NOT NULL PRIMARY KEY,
	RecipeID int NOT NULL,
	ProductID int NOT NULL,
	IngredientQuantityOz int NOT NULL,
)

CREATE TABLE dbo.Orders(
	OrderID int NOT NULL PRIMARY KEY,
	RecipeID int NOT NULL,
	ReadyBy datetime NOT NULL,
	CateringType varchar(40) NOT NULL,
	Guests int NOT NULL
);

GO 

--Weekly catering order sheet
CREATE PROCEDURE dbo.WeeklyOrderSheet @Date date
AS
WITH WeeklyProductQuantities
     AS (SELECT p.ProductID,
                ( ( o.Guests / r.RecipeServings ) * i.IngredientQuantityOz ) /
                p.ProductID AS
                ProductQuantity
           FROM Orders o
                JOIN Recipes r
                  ON o.RecipeID = r.RecipeID
                JOIN Ingredients i
                  ON i.RecipeID = r.RecipeID
                JOIN Products p
                  ON p.ProductID = i.ProductID
          WHERE o.ReadyBy BETWEEN @Date AND
                                  Dateadd(Day, 7, @Date))
SELECT w.ProductQuantity,
       p.ProductID,
       p.ProductName,
       p.VendorID
  FROM Products p
       JOIN WeeklyProductQuantities w
         ON p.ProductID = w.ProductQuantity
 GROUP BY p.ProductID
 ORDER BY VendorID; 

 GO 

 --Change corresponding product id ingredient id
CREATE PROCEDURE dbo.UpdateProduct @ProductID    int,
                                   @IngredientID int
AS
    UPDATE Ingredients
       SET ProductID = @ProductID
     WHERE IngredientID = @IngredientID 