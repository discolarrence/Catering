USE Catering;

GO

--Create new order in order table
EXEC dbo.NewOrderItem 1, 'corn', 50

--Weekly catering order sheet for week of yyyy-mm-dd
EXEC dbo.CreateOrderSheet '2021-11-15', '2021-12-01'


--Change corresponding product for a catering disposable
EXEC dbo.UpdateProduct 47, 48

--Delete order 
EXEC dbo.DeleteOrder 2


