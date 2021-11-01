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

--Quantity each ingredient for each order
WITH WeeklyProductQuantities
     AS (SELECT p.ProductID,
            	((o.Guests/r.RecipeServings) * i.IngredientQuantityOz) / p.ProductID AS ProductQuantity
           FROM Orders o
                JOIN Recipes r
				  ON o.RecipeID = r.RecipeID
                JOIN Ingredients i
                  ON i.RecipeID = r.RecipeID
				JOIN Products p
				  ON p.ProductID = i.ProductID
          WHERE o.ReadyBy BETWEEN DATEADD(Day,7,GETDATE()) AND DATEADD(Day,14,GETDATE()))
SELECT w.ProductQuantity,
       p.ProductID, 
       p.ProductName, 
       p.VendorID
  FROM Products p
       JOIN WeeklyProductQuantities w
         ON p.ProductID = w.ProductQuantity
 GROUP BY p.ProductID
 ORDER BY VendorID;

 --Change corresponding product id to 1 for ingredient 1
UPDATE Ingredients
   SET ProductID = 1
 WHERE IngredientID = 1