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
	WeightQuantityOz int,
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
	ProductQuantityOz int NOT NULL,
)

CREATE TABLE dbo.Orders(
	OrderID int NOT NULL PRIMARY KEY,
	RecipeID int NOT NULL,
	ReadyBy datetime NOT NULL,
	CateringType varchar(40) NOT NULL,
	People int NOT NULL
)

--All products needed for order 1
SELECT ProductID, 
       ProductName, 
	   VendorID
  FROM Products p
       JOIN Ingredients i
	     ON i.ProductID = p.ProductID
	   JOIN Orders o
	     ON o.RecipeID = i.RecipeID
 WHERE OrderID = 1
 ORDER BY VendorID;

 --Change corresponding product id to 1 for ingredient 1
UPDATE Ingredients
   SET ProductID = 1
 WHERE IngredientID = 1