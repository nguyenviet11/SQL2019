USE north

CREATE TABLE Shipper
(ShipperID int identity Not Null,
CompanyName varchar(30) not null,
Phone varchar(20) null,
CONSTRAINT  PK_ship PRIMARY KEY (ShipperID)
)
GO
set identity_insert Shipper on
GO
INSERT "Shipper"("ShipperID","CompanyName","Phone") VALUES(1,'Speedy Express','(503) 555-9831')
INSERT "Shipper"("ShipperID","CompanyName","Phone") VALUES(2,'United Package','(503) 555-3199')
INSERT "Shipper"("ShipperID","CompanyName","Phone") VALUES(3,'Federal Shipping','(503) 555-9931')
go
select * from Shipper
