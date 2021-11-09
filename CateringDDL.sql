USE MASTER;

GO

DROP DATABASE IF EXISTS Catering
CREATE DATABASE Catering;

USE Catering

DROP TABLE IF EXISTS dbo.Vendors
DROP TABLE IF EXISTS dbo.Products
DROP TABLE IF EXISTS dbo.Recipes
DROP TABLE IF EXISTS dbo.Ingredients
DROP TABLE IF EXISTS dbo.Orders

CREATE TABLE dbo.Vendors(
	VendorID int NOT NULL PRIMARY KEY,
	VendorName varchar(40) NOT NULL,
	VendorURL varchar(100),
	VendorPhone int,
	VendorContact varchar(100)
)

CREATE TABLE dbo.Products(
	ProductID int NOT NULL PRIMARY KEY,
	ProductName varchar(40) NOT NULL,
	VendorID int NOT NULL,
	VendorItemCode varchar(40) NOT NULL,
	ProductQuantityOz decimal(10,2) NOT NULL,
	MeasurementType varchar(10)
)

CREATE TABLE dbo.Recipes(
	RecipeID int NOT NULL PRIMARY KEY,
	RecipeName varchar(40) NOT NULL UNIQUE,
	RecipeServings int NOT NULL
)

CREATE TABLE dbo.Ingredients(
	IngredientID int NOT NULL PRIMARY KEY,
	RecipeID int NOT NULL,
	ProductID int NOT NULL,
	IngredientQuantityOz decimal(10,2) NOT NULL,
)

CREATE TABLE dbo.Orders(
	OrderID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	RecipeID int NOT NULL,
	ReadyBy datetime NOT NULL,
	CateringType varchar(40) NOT NULL,
	NumberOfGuests int NOT NULL
);

GO 

--Insert Data
