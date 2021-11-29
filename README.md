# Catering

## Project Description

Catering was built to address a problem I had as a restaurant chef. I could easily generate a weekly order for the restaurant by checking inventory against par lists, but my order for supplies needed for catering orders (which often included items not on the regular menu) was calculated by hand and sometimes included time-consuming searches through vendor catalogs. 

The main purpose of this application is to maintain a database of all products associated with the catering menu and generate a supply needs list, which can then be checked against inventory--on its own or combined with a restaurant par list--to create an order sheet.

Catering was my project for the [Code Louisville](https://www.codelouisville.org/) Fall 2021 SQL course.

## Features

- Produce lists of supply needs based on catering orders
- Update products used for each ingredient/disposable

## User Instructions

| Feature | Command |
| ----------- | ----------- |
| Create All Catering Supplies Needed List For Specified Time Period| CreateOrderSheet @StartDate=="day one of time period, @EndDate="last day of time period" *YYYYMMDD format expected*|
| Create Disposables Supplies Needed List For Specified Time Period| CreateDisposablesOrderSheet @StartDate=="day one of time period, @EndDate="last day of time period" *YYYYMMDD format expected*|
| Change Product Used In Ingredients List | UpdateProduct @NewProductID = "new product ID" , @OldProductID = "old product ID" |
| Delete Order By ID| DeleteOrderByID @OrderID = "order ID" |
| Delete Order By Name| DeleteOrderByName @OrderName = "order name" |
| Add Item To Order| NewOrderItem @OrderID = "order ID", @MenuItem = "menu item", @Quantity = "menu item quantity needed"|                    |

## Technical Instructions

- Requires MS SQL Server
- Execute the CateringCreateDBO.sql script to create the database objects
- Execute the CateringData.sql script to load the sample data
- CateringSampleCommands.sql has example commands to show how to use stored procedures
