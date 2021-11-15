USE Catering;

GO

--Create new order in order table
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
CREATE OR ALTER PROCEDURE dbo.CreateOrderSheet @StartDate date,
                                               @EndDate date
AS
SELECT VendorName,
       VendorItemCode,
       ProductName,
       SUM(ProductQuantityNeeded)                      AS ProductQuantityNeeded,
       CEILING(SUM(CaseQuantityNeeded))                AS CaseQuantityNeeded,
       CAST(SUM(CaseQuantityNeeded) AS DECIMAL(10, 2)) AS RawCaseQuantityNeeded,
       CaseQuantity,
       CaseUnit
  FROM AllProductList
 WHERE Date BETWEEN @StartDate AND @EndDate
 GROUP BY ProductName,
          VendorName,
          VendorItemCode,
          CaseQuantity,
          CaseUnit
 ORDER BY VendorName,
          ProductName 

GO

--Change corresponding product for an ingredient


--Delete order 
CREATE OR ALTER PROCEDURE dbo.DeleteOrder @OrderID int
AS
    DELETE FROM OrderItems
     WHERE OrderID = @OrderID

    DELETE FROM Orders
     WHERE ID = @OrderID; 

GO