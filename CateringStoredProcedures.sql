
--Create new order in order table


GO 

--Weekly catering order sheet for week of yyyy-mm-dd
CREATE VIEW ProductQuantitiesPerOrder
AS
  (SELECT p.ID,
          ( ( o.NumberOfGuests / r.RecipeServings ) * i.IngredientQuantityOz ) /
          p.ID AS
          ProductQuantity,
		  o.ReadyBy
     FROM OrderItems os
	      JOIN Orders o
		    ON o.ID = os.OrderID
          JOIN Recipes r
            ON os.RecipeID = r.ID
          JOIN Ingredients i
            ON i.RecipeID = r.ID
          JOIN Products p
            ON p.ID = i.ProductID);

GO 

CREATE PROCEDURE WeeklyCateringOrderSheet @Date datetime
AS
    SELECT q.ProductQuantity,
           p.ID,
           p.ProductName,
           p.ID
      FROM Products p
           JOIN ProductQuantitiesPerOrder q
             ON p.ID = q.ProductQuantity
     GROUP BY p.ID
	HAVING q.ReadyBy BETWEEN @Date AND Dateadd(Day, 7, @Date)
     ORDER BY VendorID; 

 GO 

 --Change corresponding product for an ingredient
CREATE PROCEDURE UpdateProduct @NewProductID int,
                               @OldProductID int
AS
    UPDATE MenuItemIngredients
       SET ProductID = @NewProductID
     WHERE ProductID = @OldProductID 

GO

--Delete order
CREATE PROCEDURE DeleteOrder @OrderID int
AS
    DELETE FROM Orders
     WHERE ID = @OrderID

GO 