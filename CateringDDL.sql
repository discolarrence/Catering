USE MASTER;

GO

DROP DATABASE IF EXISTS Catering
CREATE DATABASE Catering;

USE Catering

DROP TABLE IF EXISTS dbo.Vendors
DROP TABLE IF EXISTS dbo.Products
DROP TABLE IF EXISTS dbo.Recipes
DROP TABLE IF EXISTS dbo.Ingredients
DROP TABLE IF EXISTS dbo.CateringType
DROP TABLE IF EXISTS dbo.Disposables
DROP TABLE IF EXISTS dbo.Orders 
DROP TABLE IF EXISTS dbo.OrderItems

CREATE TABLE dbo.Vendors(
	ID int NOT NULL PRIMARY KEY,
	VendorName varchar(40) NOT NULL,
	VendorURL varchar(100),
	VendorPhone int,
	VendorContact varchar(100)
)

CREATE TABLE dbo.Products(
	ID int NOT NULL PRIMARY KEY,
	ProductName varchar(40) NOT NULL,
	VendorID int NOT NULL REFERENCES Vendors(ID),
	VendorItemCode varchar(40) NOT NULL,
	ProductQuantityOz decimal(10,2) NOT NULL,
	MeasurementType varchar(10)
)

CREATE TABLE dbo.Recipes(
	ID int NOT NULL PRIMARY KEY,
	RecipeName varchar(40) NOT NULL UNIQUE,
	RecipeServings int NOT NULL
)

CREATE TABLE dbo.Ingredients(
	RecipeID int NOT NULL REFERENCES Recipes(ID),
	ProductID int NOT NULL REFERENCES Products(ID),
	IngredientQuantityOz decimal(10,2) NOT NULL,
)

CREATE TABLE dbo.CateringTypes(
    ID int NOT NULL PRIMARY KEY,
	Type varchar(40) NOT NULL
)

CREATE TABLE dbo.Disposables(
    CateringTypeID int NOT NULL REFERENCES CateringTypes(ID),
	ProductID int NOT NULL REFERENCES Products(ID),
	NumberOfGuestsPerEach int NOT NULL
)

CREATE TABLE dbo.Orders(
	ID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	ReadyBy datetime NOT NULL,
	NumberOfGuests int NOT NULL
)

CREATE TABLE dbo.OrderItems(
	OrderID int NOT NULL REFERENCES Orders(ID),
	RecipeID int NOT NULL REFERENCES Recipes(ID),
	CateringTypeID int NOT NULL REFERENCES CateringTypes(ID)
);

GO 

--Insert Data


--Create product & recipe indexes
CREATE NONCLUSTERED INDEX Products
    ON Products (ProductName);

CREATE NONCLUSTERED INDEX Recipes
    ON Recipes (RecipeName);