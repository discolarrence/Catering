/*
    Catering Sample Commands
*/
--Create new order item in order item table
EXEC dbo.NewOrderItem 1, 'corn', 50

--Create disposables order sheet based on catering orders for a specified time period
EXEC dbo.CreateDisposablesOrderSheet '2021-11-15', '2021-12-01'

--Create disposables order sheet based on catering orders for a specified time period
EXEC dbo.CreateOrderSheet '2021-11-20', '2021-12-05'

--Change corresponding product for a packaging disposable
EXEC dbo.UpdatePackagingProduct 47, 48

--Change corresponding product for a catering disposable
EXEC dbo.UpdateCateringProduct 21, 49

--Change corresponding product for an ingredients
EXEC dbo.UpdateIngredientProduct 35, 50

--Delete order by ID
EXEC dbo.DeleteOrderByName 3

--Delete order by name
EXEC dbo.DeleteOrderByName 'Brown'
