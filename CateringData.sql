USE Catering;

GO

--Insert Data
INSERT INTO Vendors
            (VendorName,Phone,Contact)
     VALUES ('Creation Gardens','502-555-1234','William'),
            ('Piazza Produce','502-555-2345','Jose'),
            ('Ashbourne Farm','502-555-3456','Joseph'),
            ('GFS','502-555-4567','Phil');

INSERT INTO Products
            (ProductName,VendorID,VendorItemCode,Quantity,Unit)
     VALUES ('Potatoes, Russet',1,'82702',800,'oz.'),
            ('Milk, Whole',1,'59875',128,'fl.oz.'),
            ('Butter, Unsalted',2,'59382',16,'oz.'),
            ('Salt, Kosher',4,'90434',48,'oz.'),
            ('Garlic Cloves, Peeled',2,'10336',16,'oz.'),
            ('Heavy Cream',2,'42989',32,'fl.oz.'),
            ('Chicken Broth',2,'90401',32,'fl.oz.'),
            ('Parmesean Cheese, Shredded',1,'80865',80,'oz.'),
            ('Beef, Ground, 80/20',1,'73306',160,'oz.'),
            ('Salsa, Medium',4,'59395',32,'oz.'),
            ('Tater Tots',4,'91057',80,'oz.'),
            ('Cheddar Cheese, Shredded',2,'59947',80,'oz.'),
            ('Black Beans, Canned',4,'44495',96,'fl.oz.'),
            ('Corn, canned',4,'41449',96,'fl.oz.'),
            ('Taco Seasoning',4,'73405',16,'oz.'),
            ('Pan, Steam Table, 2", Half Size',4,'46349',50,'count'),
            ('Lid, Steam Table, Half Size',4,'80693',50,'count'),
            ('Tongs, Serving',4,'29275',12,'count'),
            ('Spoon, Serving',4,'93653',12,'count'),
            ('Box, 9x9x2.5", Compostable',1,'61864',100,'count'),
            ('Deli Paper, 10x10"',4,'74503',500,'count'),
            ('Bowl, 5 Qt., Black',4,'41863',50,'count'),
            ('Lid for 5 Ot .Bowl',4,'50758',50,'count'),
            ('Utensil Set, Wrapped, FSKNSP',4,'90631',250,'count'),
            ('Plates, 8 1/2 inch, Compostable',1,'14532',100,'count'),
            ('Box, 3 3/4 X 3 3/4",Compostable',1,'51460',100,'count'),
            ('Cup, 6 oz., Compostable',1,'75002',250,'count'),
            ('Lid for 6 oz. Cup, Compostable',1,'13954',250,'count'),
            ('Romaine, Chopped',2,'53730',80,'oz.'),
            ('Carrots, shredded',2,'63249',16,'oz.'),
            ('Tomaoes, Roma',3,'92555',16,'oz.'),
            ('Ranch, Packet',4,'99701',48,'count'),
            ('Rotini',4,'75001',80,'oz.'),
            ('Onion, Red',2,'56325',16,'oz.'),
            ('Mayonnaise',1,'76434',128,'fl.oz.'),
            ('Italian Seasoning',4,'40619',6.25,'oz.'),
            ('Caesar Dressing, Packets',4,'85226',48,'count'),
            ('Croutons',4,'41251',40,'oz.'),
            ('Green Beans, Canned',4,'66451',96,'oz.'),
            ('Bacon',2,'31672',40,'oz.'),
            ('Black Pepper, Ground',4,'83700',16,'oz.'),
            ('Chicken Breast, boneless, 7 oz',4,'24148',25,'count'),
            ('Mustard, Yellow',1,'80772',32,'oz.'),
            ('Relish, Sweet Pickle',2,'72461',32,'oz.'),
            ('Ketchup',4,'48666',96,'oz.'),
            ('Eggs',3,'37131',60,'count'),
            ('Napkin',4,'23856',1000,'count');

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
            (CateringTypeID,NumberOfGuests,Date,Time)
     VALUES (2,100,'2021-11-30','18:00'),
            (1,30,'2021-12-02','12:00'),
            (2,150,'2021-12-02','16:30'),
            (2,75,'2021-12-15','17:30'),
            (1,15,'2021-11-29','13:00');

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