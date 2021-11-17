/* CateringData.sql
 * Author: Laura Rountree
 * Date Created: 11/15/2021
 * Description: sample data for catering order app
*/


INSERT INTO Vendors
            (VendorName,Phone,Contact)
     VALUES ('Creation Gardens','502-555-1234','William'),
            ('Piazza Produce','502-555-2345','Jose'),
            ('Ashbourne Farm','502-555-3456','Joseph'),
            ('GFS','502-555-4567','Phil');

INSERT INTO Products
            (ProductName,VendorID,VendorItemCode,Quantity,Unit,ProductType)
     VALUES ('Potatoes, Russet',1,'41385',800,'oz.',1),
            ('Milk, Whole',1,'80898',128,'fl.oz.',1),
            ('Butter, Unsalted',2,'11293',16,'oz.',1),
            ('Salt, Kosher',4,'64603',48,'oz.',1),
            ('Garlic Cloves, Peeled',2,'44196',16,'oz.',1),
            ('Heavy Cream',2,'74272',32,'fl.oz.',1),
            ('Chicken Broth',2,'50798',32,'fl.oz.',1),
            ('Parmesean Cheese, Shredded',1,'57519',80,'oz.',1),
            ('Beef, Ground, 80/20',1,'86804',160,'oz.',1),
            ('Salsa, Medium',4,'89752',32,'oz.',1),
            ('Tater Tots',4,'37611',80,'oz.',1),
            ('Cheddar Cheese, Shredded',2,'80624',80,'oz.',1),
            ('Black Beans, Canned',4,'36295',96,'fl.oz.',1),
            ('Corn, canned',4,'67267',96,'fl.oz.',1),
            ('Taco Seasoning',4,'24046',16,'oz.',1),
            ('Pan, Steam Table, 2", Half Size',4,'17138',50,'count',2),
            ('Lid, Steam Table, Half Size',4,'86106',50,'count',2),
            ('Tongs, Serving',4,'21886',12,'count',2),
            ('Spoon, Serving',4,'54288',12,'count',2),
            ('Box, 9x9x2.5", Compostable',1,'59822',100,'count',2),
            ('Deli Paper, 10x10"',4,'88906',500,'count',2),
            ('Bowl, 5 Qt., Black',4,'63884',50,'count',2),
            ('Lid for 5 Ot .Bowl',4,'62998',50,'count',2),
            ('Utensil Set, Wrapped, FSKNSP',4,'85593',250,'count',3),
            ('Plates, 8 1/2 inch, Compostable',1,'81215',100,'count',3),
            ('Box, 3 3/4 X 3 3/4",Compostable',1,'53201',100,'count',2),
            ('Cup, 6 oz., Compostable',1,'65803',250,'count',2),
            ('Lid for 6 oz. Cup, Compostable',1,'24196',250,'count',2),
            ('Romaine, Chopped',2,'65518',80,'oz.',1),
            ('Carrots, shredded',2,'92284',16,'oz.',1),
            ('Tomaoes, Roma',3,'37595',16,'oz.',1),
            ('Ranch, Packet',4,'96369',48,'count',1),
            ('Rotini',4,'32603',80,'oz.',1),
            ('Onion, Red',2,'61510',16,'oz.',1),
            ('Mayonnaise',1,'21081',128,'fl.oz.',1),
            ('Italian Seasoning',4,'77939',6.25,'oz.',1),
            ('Caesar Dressing, Packets',4,'65424',48,'count',1),
            ('Croutons',4,'75637',40,'oz.',1),
            ('Green Beans, Canned',4,'31143',96,'oz.',1),
            ('Bacon',2,'56356',40,'oz.',1),
            ('Black Pepper, Ground',4,'25934',16,'oz.',1),
            ('Chicken Breast, boneless, 7 oz',4,'48066',25,'count',1),
            ('Mustard, Yellow',1,'90212',32,'oz.',1),
            ('Relish, Sweet Pickle',2,'55237',32,'oz.',1),
            ('Ketchup',4,'48002',96,'oz.',1),
            ('Eggs',3,'72111',60,'count',1),
            ('Napkin',4,'96077',1000,'count',3),
            ('Napkin',2,'50717',1500,'count',3),
            ('Deli Paper, 10.5 x 12',2,'92788',1000,'count',2),
            ('Mayonnaise, Dukes',4,'24881',128,'fl.oz.',1); 	

INSERT INTO CateringTypes
            (CateringType)
     VALUES ('Individual'),
            ('Bulk');

INSERT INTO PackagingTypes
            (PackagingType)
     VALUES ('Hot Scoop'),
            ('Cold Scoop'),
            ('Hot Grab'),
            ('Cold Grab');

INSERT INTO CateringDisposables
            (CateringTypeID,ProductID)
     VALUES (1,24),
            (1,47),
            (2,24),
            (2,47),
            (2,25);

INSERT INTO PackagingDisposables
            (PackagingTypeID,CateringTypeID,ProductID,NumberOfGuestsPerEach)
     VALUES (1,1,27,1),
            (1,1,28,1),
            (1,2,16,20),
            (1,2,17,20),
            (1,2,19,0),
            (2,1,27,1),
            (2,1,28,1),
            (2,2,22,20),
            (2,2,23,20),
            (2,2,19,0),
            (3,1,20,1),
            (3,1,21,1),
            (3,2,16,10),
            (3,2,17,10),
            (3,2,18,0),
            (4,1,26,1),
            (4,1,21,1),
            (4,2,22,10),
            (4,2,23,10),
            (4,2,18,0);

INSERT INTO MenuItems
            (ItemName,RecipeServings,PackagingTypeID)
     VALUES ('Mashed Potatoes',20,1),
            ('Au Gratin Potatoes',20,1),
            ('Tater Tot Casserole',20,1),
            ('House Salad',10,4),
            ('Pasta Salad',10,2),
            ('Caesar Salad',10,4),
            ('Green Beans',20,1),
            ('Buttered Corn',20,1),
            ('Meatloaf',20,3),
            ('Potato Salad',10,2),
            ('Stuffed Chicken',10,3);

INSERT INTO MenuItemIngredients
            (MenuItemID,ProductID,ProductQuantity)
     VALUES (1,1,80),
            (1,2,32),
            (1,3,4),
            (1,4,0.5),
            (2,3,3),
            (2,5,0.5),
            (2,6,32),
            (2,7,16),
            (2,8,32),
            (2,1,160),
            (3,9,64),
            (3,10,40),
            (3,11,40),
            (3,12,16),
            (3,13,20),
            (3,14,20),
            (3,15,2.5),
            (4,29,32),
            (4,30,5),
            (4,31,10),
            (4,32,10),
            (5,33,12),
            (5,30,5),
            (5,34,5),
            (5,8,10),
            (5,35,8),
            (5,36,1),
            (6,29,32),
            (6,8,10),
            (6,37,10),
            (6,38,5),
            (7,39,96),
            (7,7,32),
            (7,40,10),
            (7,34,10),
            (7,4,0.5),
            (7,41,0.2),
            (8,14,96),
            (8,3,10),
            (8,4,0.5),
            (8,41,0.2),
            (9,9,80),
            (9,40,8),
            (9,46,2),
            (9,45,8),
            (9,38,4),
            (9,34,5),
            (9,4,0.5),
            (9,41,0.2),
            (10,1,96),
            (10,35,24),
            (10,43,1.5),
            (10,34,5),
            (10,4,0.5),
            (10,41,0.2),
            (10,44,4),
            (11,42,10),
            (11,36,1),
            (11,8,16),
            (11,7,8),
            (11,5,0.5),
            (11,6,2),
            (11,31,10);

INSERT INTO Orders
            (OrderName,CateringTypeID,NumberOfGuests,Date,Time)
     VALUES ('Woodford',2,100,'2021-11-30','18:00'),
            ('Ramirez',1,30,'2021-12-02','12:00'),
            ('Brown',2,150,'2021-12-02','16:30'),
            ('Norton',2,75,'2021-12-15','17:30'),
            ('Burgess',1,15,'2021-11-29','13:00');

INSERT INTO OrderItems
            (OrderID,MenuItemID,MenuItemQuantity)
     VALUES (1,9,50),
            (1,11,50),
            (1,1,100),
            (1,7,100),
            (1,4,100),
            (2,9,30),
            (2,2,30),
            (2,8,30),
            (3,3,150),
            (4,10,75),
            (4,5,75),
            (4,6,75),
            (5,6,15),
            (5,11,15); 