USE Catering;

--Create product & recipe indexes
CREATE NONCLUSTERED INDEX Products
    ON Products (ProductName);

CREATE NONCLUSTERED INDEX Recipes
    ON Recipes (RecipeName);
GO

--Create new order in order table
CREATE PROCEDURE NewOrder @RecipeID     int,
                          @ReadyBy      datetime,
                          @CateringType varchar(40),
                          @Guests       int
AS
    INSERT INTO Orders
                (RecipeID,
                 ReadyBy,
                 CateringType,
                 NumberOfGuests)
         VALUES (@RecipeID,
                 @ReadyBy,
                 @CateringType,
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
CREATE PROCEDURE UpdateProduct @ProductID    int,
                               @IngredientID int
AS
    UPDATE Ingredients
       SET ProductID = @ProductID
     WHERE IngredientID = @IngredientID 

GO

--Delete order
CREATE PROCEDURE DeleteOrder @OrderID int
AS
    DELETE FROM Orders
     WHERE OrderID = @OrderID

GO 