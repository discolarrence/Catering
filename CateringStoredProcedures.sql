USE Catering;

GO

--Create new order item in order item table (Add 50 servings corn to order #1)
EXEC dbo.NewOrderItem 1, 'corn', 50

--Create disposables order sheet based on catering orders for a specified time period (11/15/2021-12/01/2021)
EXEC dbo.CreateDisposablesOrderSheet '2021-11-15', '2021-12-01'

--Create disposables order sheet based on catering orders for a specified time period (11/20/2021-12/05/2021)
EXEC dbo.CreateOrderSheet '2021-11-20', '2021-12-05'

--Change corresponding product for a packaging disposable (Deli Paper)
EXEC dbo.UpdatePackagingProduct 47, 48

--Change corresponding product for a catering disposable (Napkins)
EXEC dbo.UpdateCateringProduct 21, 49

--Change corresponding product for an ingredient (Mayonnaise)
EXEC dbo.UpdateIngredientProduct 35, 50

--Delete order by ID (3)
EXEC dbo.DeleteOrderByName 3

--Delete order by name (Brown)
EXEC dbo.DeleteOrderByName 'Brown'
