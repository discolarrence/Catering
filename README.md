# SQL Project for Code Louisville

## Introduction
This repository is an example project for the [Code Louisville](https://www.codelouisville.org/) Fall 2021 SQL course. The purpose of this code is to demonstrate the use of SQL and Git.

## Project Description

**Catering**

Catering is a database created to assist chefs in ordering supplies based on catering orders.

## Features

- Produce list of weekly catering product needs
- Produce list of disposables needed
- Update product used in recipes
- Create & delete order in database


## User Instructions

| Feature | Command |
| ----------- | ----------- |
| Create Catering Supplies List For One Week | WeeklyCateringOrderSheet @Date = "day one" |
| Change Product Used In Ingredients List | UpdateProduct @NewProductID = "new product ID" , @OldProductID = "old product ID" |
| Delete Order | DeleteOrder @OrderID = "order ID" |
| Create Order |                      |

## Technical Instructions

- Requires MS SQL Server
- Execute the CateringCreateDBO.sql script to create the database objects
- Execute the CateringData.sql script to load the sample data

## Project Requirements

**Group 1: Reading Data from a Database**

- Write a SELECT query that uses a WHERE clause.
- Write a  SELECT query that uses an OR and an AND operator.
- Write a  SELECT query that filters NULL rows using IS NOT NULL.
- Write a  SELECT query that utilizes a JOIN.
- Write a  SELECT query that utilizes a JOIN with 3 or more tables.
- Write a  SELECT query that utilizes a LEFT JOIN.
- Write a  SELECT query that utilizes a variable in the WHERE clause.
- Write a  SELECT query that utilizes an ORDER BY clause.
- Write a  SELECT query that utilizes a GROUP BY clause along with an aggregate function.
- Write a SELECT query that utilizes a CALCULATED FIELD.
- Write a SELECT query that utilizes a SUBQUERY.
- Write a SELECT query that utilizes a JOIN, at least 2 OPERATORS (AND, OR, =, IN, BETWEEN, ETC) AND A GROUP BY clause with an aggregate function.
- Write a SELECT query that utilizes a JOIN with 3 or more tables, at 2 OPERATORS (AND, OR, =, IN, BETWEEN, ETC), a GROUP BY clause with an aggregate function, and a HAVING clause.


**Group 2: Updating/Deleting Data from a Database**

- Write a DML statement that UPDATEs a set of rows with a WHERE clause. The values used in the WHERE clause should be a variable.
- Write a DML statement that DELETEs a set of rows with a WHERE clause. The values used in the WHERE clause should be a variable.
- Write a DML statement that DELETEs rows from a table that another table references. This script will have to also DELETE any records that reference these rows. Both of the DELETE statements need to be wrapped in a single TRANSACTION.

**Group 3: Optimizing a Database**

- Design a NONCLUSTERED INDEX with ONE KEY COLUMN that improves the performance of one of the above queries.