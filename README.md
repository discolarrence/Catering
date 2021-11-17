# SQL Project for Code Louisville

## Introduction
This repository is an example project for the [Code Louisville](https://www.codelouisville.org/) Fall 2021 SQL course. The purpose of this code is to demonstrate the use of SQL and Git.

## Project Description

**Catering**

Catering is a database created to assist chefs/kitchen managers in ordering supplies based on catering orders. The main purpose is to generate a supply needs list to use for ordering, on its own or combined with a restaurant par list and chacked against inventory to generate an order sheet.

## Features

- Produce lists of supply needs based on catering orders
- Update products used for each ingredient/disposable

## User Instructions

| Feature | Command |
| ----------- | ----------- |
| Create All Catering Supplies Needed List For Specified Time Period| CreateOrderSheet @StartDate=="day one of time period, @EndDate="last day of time period" |
| Create Disposables Supplies Needed List For Specified Time Period| CreateDisposablesOrderSheet @StartDate=="day one of time period, @EndDate="last day of time period" |
| Change Product Used In Ingredients List | UpdateProduct @NewProductID = "new product ID" , @OldProductID = "old product ID", @ProductType = "product type" |
| Delete Order By ID| DeleteOrderByID @OrderID = "order ID" |
| Delete Order By Name| DeleteOrderByName @OrderName = "order name" |
| Add Item To Order| NewOrderItem @OrderID = "order ID", @MenuItem = "menu item", @Quantity = "menu item quantity needed"|                    |

## Technical Instructions

- Requires MS SQL Server
- Execute the CateringCreateDBO.sql script to create the database objects
- Execute the CateringData.sql script to load the sample data
- CateringSampleCommands.sql has example commands to show how to use stored procedures

## Project Requirements

**Group 1: Reading Data from a Database**

- Write a SELECT query that uses a WHERE clause.
- Write a  SELECT query that utilizes a JOIN.
- Write a  SELECT query that utilizes a JOIN with 3 or more tables.
- Write a  SELECT query that utilizes a LEFT JOIN.
- Write a  SELECT query that utilizes a variable in the WHERE clause.
- Write a  SELECT query that utilizes an ORDER BY clause.
- Write a  SELECT query that utilizes a GROUP BY clause along with an aggregate function.
- Write a SELECT query that utilizes a CALCULATED FIELD.
- Write a SELECT query that utilizes a SUBQUERY.

**Group 2: Updating/Deleting Data from a Database**

- Write a DML statement that UPDATEs a set of rows with a WHERE clause. The values used in the WHERE clause should be a variable.
- Write a DML statement that DELETEs a set of rows with a WHERE clause. The values used in the WHERE clause should be a variable.
- Write a DML statement that DELETEs rows from a table that another table references. This script will have to also DELETE any records that reference these rows. Both of the DELETE statements need to be wrapped in a single TRANSACTION.

**Group 3: Optimizing a Database**

- Design a NONCLUSTERED INDEX with ONE KEY COLUMN that improves the performance of one of the above queries.