USE MASTER;

GO

DROP DATABASE IF EXISTS Catering
CREATE DATABASE Catering;

USE Catering

DROP TABLE IF EXISTS dbo.Vendors
DROP TABLE IF EXISTS dbo.Products
DROP TABLE IF EXISTS dbo.CateringType
DROP TABLE IF EXISTS dbo.DisposableType
DROP TABLE IF EXISTS dbo.Disposables
DROP TABLE IF EXISTS dbo.MenuItems
DROP TABLE IF EXISTS dbo.Ingredients
DROP TABLE IF EXISTS dbo.Orders 
DROP TABLE IF EXISTS dbo.OrderItems

CREATE TABLE dbo.Vendors(
	ID int NOT NULL IDENTITY PRIMARY KEY,
	VendorName varchar(40) NOT NULL,
	Phone varchar(40),
	Contact varchar(100),
)

CREATE TABLE dbo.Products(
	ID int NOT NULL IDENTITY PRIMARY KEY,
	ProductName varchar(100) NOT NULL,
	VendorID int NOT NULL,
	VendorItemCode varchar(40) NOT NULL,
	Quantity decimal(10,2) NOT NULL,
	Unit varchar(10), 
	FOREIGN KEY(VendorID) REFERENCES Vendors(ID)
)

CREATE TABLE dbo.CateringTypes(
    ID int NOT NULL IDENTITY PRIMARY KEY,
	CateringType varchar(40) NOT NULL,
	Utensils bit NOT NULL,
	Plates bit NOT NULL
)

CREATE TABLE dbo.DisposableTypes(
    ID int NOT NULL IDENTITY PRIMARY KEY,
	DisposableType varchar(40) NOT NULL
)
CREATE TABLE dbo.Disposables(
    DisposableTypeID int NOT NULL,
    CateringTypeID int NOT NULL,
	ProductID int NOT NULL,
	NumberOfGuestsPerEach int NOT NULL,
	FOREIGN KEY(DisposableTypeID) REFERENCES DisposableTypes(ID),
	FOREIGN KEY(CateringTypeID) REFERENCES CateringTypes(ID),
	FOREIGN KEY(ProductID) REFERENCES Products(ID)
)

CREATE TABLE dbo.MenuItems(
	ID int NOT NULL IDENTITY PRIMARY KEY,
	ItemName varchar(40) NOT NULL UNIQUE,
	RecipeServings int NOT NULL,
	DisposableTypeID int NOT NULL,
	FOREIGN KEY(DisposableTypeID) REFERENCES DisposableTypes(ID)
)

CREATE TABLE dbo.MenuItemIngredients(
	MenuItemID int NOT NULL,
	ProductID int NOT NULL,
	ProductQuantity decimal(10,2) NOT NULL,
	FOREIGN KEY(MenuItemID) REFERENCES MenuItems(ID),
	FOREIGN KEY(ProductID) REFERENCES Products(ID),
)

CREATE TABLE dbo.Orders(
	ID int NOT NULL IDENTITY PRIMARY KEY,
	CateringTypeID int NOT NULL,
	NumberOfGuests int NOT NULL,
	ReadyBy datetime NOT NULL,
	ContactName varchar(100) NOT NULL,
	ContactPhone varchar(40) NOT NULL,
	ContactEmail varchar(100) NOT NULL,
	FOREIGN KEY(CateringTypeID) REFERENCES CateringTypes(ID)
)

CREATE TABLE dbo.OrderItems(
	OrderID int NOT NULL REFERENCES Orders(ID),
	MenuItemID int NOT NULL,
	MenuItemQuantity int NOT NULL,
	FOREIGN KEY(MenuItemID) REFERENCES MenuItems(ID)
);

GO 

--Create product & recipe indexes
CREATE NONCLUSTERED INDEX Products
    ON Products (ProductName);

CREATE NONCLUSTERED INDEX MenuItems
    ON MenuItems (Name);
