USE catering;

CREATE TABLE dbo.Vendors(
	VendorID int NOT NULL PRIMARY KEY IDENTITY(1,1),
	VendorName varchar(40) NOT NULL,
	VendorURL varchar(100),
	VendorPhone int,
	VendorContact varchar(100),
)