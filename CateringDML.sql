USE Catering;

GO

--Create new order in order table
CREATE PROCEDURE NewOrder @RecipeID     int,
                          @ReadyBy      datetime,
                          @Guests       int
AS
    INSERT INTO Orders
                (RecipeID,
                 ReadyBy,
                 NumberOfGuests)
         VALUES (@RecipeID,
                 @ReadyBy,
                 @Guests)

GO 

--Weekly catering order sheet for week of yyyy-mm-dd
CREATE VIEW ProductQuantitiesPerOrder
AS
  (SELECT p.ProductID,
          ( ( o.NumberOfGuests / r.RecipeServings ) * i.IngredientQuantityOz ) /
          p.ProductID AS
          ProductQuantity,
		  o.ReadyBy
     FROM Orders o
          JOIN Recipes r
            ON o.RecipeID = r.RecipeID
          JOIN Ingredients i
            ON i.RecipeID = r.RecipeID
          JOIN Products p
            ON p.ProductID = i.ProductID);

GO 

CREATE PROCEDURE WeeklyCateringOrderSheet @Date datetime
AS
    SELECT q.ProductQuantity,
           p.ProductID,
           p.ProductName,
           p.VendorID
      FROM Products p
           JOIN ProductQuantitiesPerOrder q
             ON p.ProductID = q.ProductQuantity
     GROUP BY p.ProductID
	HAVING q.ReadyBy BETWEEN @Date AND Dateadd(Day, 7, @Date)
     ORDER BY VendorID; 

 GO 

 --Change corresponding product for an ingredient
CREATE PROCEDURE UpdateProduct @NewProductID int,
                               @OldProductID int
AS
    UPDATE Ingredients
       SET ProductID = @NewProductID
     WHERE ProductID = @OldProductID 

GO

--Delete order
CREATE PROCEDURE DeleteOrder @OrderID int
AS
    DELETE FROM Orders
     WHERE ID = @OrderID

GO 