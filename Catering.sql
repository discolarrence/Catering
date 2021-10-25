CREATE DATABASE catering;

USE catering;

CREATE TABLE dbo.Vendors(
	VendorID int NOT NULL PRIMARY KEY IDENTITY(1,1),
	VendorName varchar(40) NOT NULL,
	VendorURL varchar(100),
	VendorPhone int,
	VendorContact varchar(100),
)

CREATE TABLE dbo.Product(
	ProductID int NOT NULL PRIMARY KEY IDENTITY(1,1),
	ProductName varchar(40) NOT NULL,
	VendorID int NOT NULL,
	VendorItemCode varchar(40) NOT NULL,
	WeightQuantityOz int,
)

CREATE TABLE dbo.Recipes(
	RecipeID int NOT NULL PRIMARY KEY IDENTITY(1,1),
	RecipeName varchar(40) NOT NULL,
	RecipeServings int NOT NULL,
	RecipeServingQuantity int NOT NULL,
	RecipeServingUnit varchar(40) NOT NULL
)

CREATE TABLE dbo.Ingredients(
	IngredientID int NOT NULL PRIMARY KEY IDENTITY(1,1),
	RecipeID int NOT NULL,
	ProductID int NOT NULL,
	ProductQuantityOz int NOT NULL,
)

CREATE TABLE dbo.Orders(
	OrderID int NOT NULL PRIMARY KEY IDENTITY(1,1),
	RecipeID int NOT NULL,
	ReadyBy datetime NOT NULL,
	CateringType varchar(40) NOT NULL,
	People int NOT NULL
)
