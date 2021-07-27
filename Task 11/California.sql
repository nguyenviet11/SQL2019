CREATE DATABASE California

USE California
GO
CREATE TABLE Toys(
ProductCode varchar(5) PRIMARY KEY,
Name varchar(30),
Category varchar(30),
Manufacturer varchar(30),
AgeRange varchar(15),
UnitPrice money,
Netweight int,
QtyOnHand int
)
INSERT INTO Toys VALUES ('A100A','Ô tô','Lắp ráp','Toyota','5+',4000,400,70)
INSERT INTO Toys VALUES ('A101A','Xe máy','Lắp ráp','Honda','5+',6000,500,40)
INSERT INTO Toys VALUES ('A102A','Xe đạp','Lắp ráp','Honda','5+',6000,500,20)
INSERT INTO Toys VALUES ('A103A','Xích lô','Lắp ráp','Toyota','5+',4000,900,40)
INSERT INTO Toys VALUES ('A104A','Container','Bộ Game','Mitsubishi','5+',6000,450,30)
GO
INSERT INTO Toys VALUES ('A105A','Dứa','Bộ Game','Asus','15+',4000,400,30)
INSERT INTO Toys VALUES ('A106A','Lê ','Bộ Game','Asus','15+',1500,400,70)
INSERT INTO Toys VALUES ('A107A','Táo','Bộ Game','Asus','5+',8500,400,80)
INSERT INTO Toys VALUES ('A108A','Xoài','Lắp ráp','Samsung','5+',6000,400,50)
INSERT INTO Toys VALUES ('A109A','Lợn','Lắp ráp','Toyota','8+',400,470,90)
GO
INSERT INTO Toys VALUES ('A110A','Khủng Long','Câu đổ','Toyota','7+',7800,400,40)
INSERT INTO Toys VALUES ('A111A','Rubik','Lắp ráp','Toyota','5+',4960,400,40)
INSERT INTO Toys VALUES ('A112A','Xếp hình','Lắp ráp','Toyota','9+',3000,400,40)
INSERT INTO Toys VALUES ('A113A','Yo yo','Câu đố','Toyota','5+',2000,490,30)
INSERT INTO Toys VALUES ('A114A','cần cẩu','Câu đố','Toyota','5+',2000,700,40)
INSERT INTO Toys VALUES ('A115A','cần cẩu','Câu đố','Toyota','5+',2000,700,40)

--2
CREATE PROCEDURE Heavytoys 
	@name int
AS
SELECT * FROM Toys
WHERE Netweight > @name
GO
EXEC Heavytoys 100


drop proc Heavytoys
--3
CREATE PROCEDURE PriceIncrease
	@Unitprice money
AS
UPDATE Toys SET UnitPrice = UnitPrice + 10 

GO
EXEC PriceIncrease 1

--4
CREATE PROCEDURE Pro_QtyOnHand 
	@Qtyon int
AS
UPDATE Toys SET QtyOnHand = QtyOnHand - 5
GO

EXEC Pro_QtyOnHand 1

--Phần 3
--1
EXEC Heavytoys '500'
GO

SELECT definition FROM sys.sql_modules
WHERE
object_id=OBJECT_ID('Pro_QtyOnHand')

GO
sp_depends 'Pro_QtyOnHand'

GO
SELECT 
OBJECT_DEFINITION(OBJECT_ID('Pro_QtyOnHand')) AS DEFINITION


--2
EXEC sp_depends @objname = N'Toys'

--3
ALTER PROCEDURE PriceIncrease
	@Uniprice money
AS
BEGIN
	UPDATE Toys SET UnitPrice = UnitPrice + 10 
	SELECT UnitPrice FROM Toys
END
GO

AlTER PROCEDURE Pro_QtyOnHand 
	@Qtyon int
AS
	UPDATE Toys SET QtyOnHand = QtyOnHand - 5
	SELECT QtyOnHand FROM Toys
GO

--4
CREATE PROC SpecificPriceIncrease
	@spec int
AS
BEGIN 
	UPDATE Toys SET UnitPrice = QtyOnHand + UnitPrice
END
EXEC SpecificPriceIncrease 1

--5
ALTER PROC SpecificPriceIncrease
	@spec int,
	@count int OUTPUT
AS
	SELECT @count=COUNT(*) FROM Toys
	UPDATE Toys SET UnitPrice = QtyOnHand + UnitPrice
	
GO
DECLARE @num int
EXEC SpecificPriceIncrease 1, @num OUTPUT
PRINT @num

--6
ALTER PROC SpecificPriceIncrease
	@spec int
AS
BEGIN 
	EXEC HeavyToys @name = @spec
END
GO
EXEC SpecificPriceIncrease 500

--7
DROP PROC SpecificPriceIncrease 
DROP PROC Heavytoys
DROP PROC [dbo].[PriceIncrease]
DROP PROC [dbo].[Pro_QtyOnHand]