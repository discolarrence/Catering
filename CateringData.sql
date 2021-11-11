USE Catering;

GO


--Insert Data

INSERT INTO Vendors
            (VendorName,Phone,Contact)
     VALUES ('Creation Gardens','502-555-1234',
             'William'),
            ('Piazza Produce','502-555-2345',
             'Jose'),
            ('Ashbourne Farm','502-555-3456',
             'Joseph'),
            ('GFS',
             '502-555-4567','Phil');
			 
INSERT INTO Products
            (ProductName,VendorID,Quantity,Unit)
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
            ('Eggs',3,'37131',60,'count'); 
