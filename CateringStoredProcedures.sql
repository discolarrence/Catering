USE Catering;

GO

--Create new order in order table
CREATE OR ALTER PROCEDURE dbo.NewOrder @CateringType int,
                              @Date         date,
                              @Time         time
AS
    INSERT INTO Orders
                (CateringTypeID,
                 Date,
                 Time)
         VALUES (@CateringType,
                 @Date,
                 @Time);

GO 

--Add menu item to catering order
CREATE OR ALTER PROCEDURE dbo.NewOrderItem
  @OrderID  INT,
  @MenuItem VARCHAR(40),
  @Quantity INT
AS
  DECLARE @MenuItemID AS INT
  SELECT @MenuItemID = ID
  FROM   MenuItems
  WHERE  ItemName LIKE '%' + @MenuItem + '%'
  INSERT INTO OrderItems
              (
                          OrderID,
                          MenuItemID,
                          MenuItemQuantity
              )
              VALUES
              (
                          @OrderID,
                          @MenuItemID,
                          @Quantity
              );
			  
GO

CREATE OR ALTER PROCEDURE dbo.NewOrderItem
  @OrderID  INT,
  @MenuItem VARCHAR(40),
  @Quantity INT
AS
  BEGIN
    BEGIN TRY
      SET NOCOUNT ON;
      SET XACT_ABORT ON;
      BEGIN TRANSACTION;
      DECLARE @MenuItemID AS INT
      SELECT @MenuItemID = ID
      FROM   MenuItems
      WHERE  ItemName LIKE '%'@MenuItem + '%'
      INSERT INTO OrderItems
                  (
                              OrderID,
                              MenuItemID,
                              MenuItemQuantity
                  )
                  VALUES
                  (
                              @OrderID,
                              @MenuItemID,
                              @Quantity
                  );
      
      COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
      IF (@@TRANCOUNT > 0)
      ROLLBACK TRANSACTION;
      THROW;
    END CATCH
  END
  GO

--Weekly catering order sheet for week of yyyy-mm-dd

--Change corresponding product for an ingredient

--Delete order 
CREATE PROCEDURE dbo.DeleteOrder @OrderID int
AS
    DELETE FROM OrderItems
     WHERE OrderID = @OrderID

    DELETE FROM Orders
     WHERE ID = @OrderID; 

GO