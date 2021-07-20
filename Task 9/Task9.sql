USE View_09

CREATE TABLE Customer(
CustomerID int PRIMARY KEY,
CustomerName varchar(50),
Address nvarchar(100),
Phone varchar(12)
)
INSERT INTO Customer VALUES (11,'Hùng',N'Hà nội','09515174')
INSERT INTO Customer VALUES (12,'Hậu',N'Ninh Xá','095151745')
INSERT INTO Customer VALUES (13,'Hoàng',N'Thái Nguyên','095154235')
INSERT INTO Customer VALUES (14,'Mai Anh',N'Cao Bằng','09546578')
INSERT INTO Customer VALUES (15,'Linh',N'Hải Phòng','09569845')
GO

CREATE TABLE Book(
BookCode int PRIMARY KEY,
Category varchar(50),
Author varchar(50),
Publisher varchar(50),
Title varchar(100),
Price int ,
InStore int
)
INSERT INTO Book VALUES (105,'Văn học','Liên','Tri thức','Ngày mai',20000,100)
INSERT INTO Book VALUES (106,'Kinh tế','Quỳnh','Thiên nga','Ngày kia',30000,100)
INSERT INTO Book VALUES (107,'Toán học','Hải','Bìm bịp','Ngày kìa',24000,30)
INSERT INTO Book VALUES (108,'Sử học','Đức','Gõ kiến','Hôm qua',50000,40)
INSERT INTO Book VALUES (109,'Chính trị','Hào','Ngải cứu','Chủ nhật',45000,80)

CREATE TABLE BookSold(
BookSoldID int PRIMARY KEY,
CustomerID int,
BookCode int,
Date datetime,
Price int,
Amount int,
CONSTRAINT FK_Cus FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
CONSTRAINT FK_Book FOREIGN KEY (BookCode) REFERENCES Book(BookCode),
)
INSERT INTO BookSold VALUES (91,11,105,'03/08/2010',10000,20)
INSERT INTO BookSold VALUES	(92,12,105,'02/04/2018',20000,10)
INSERT INTO BookSold VALUES (93,13,106,'10/25/2014',30000,10)
INSERT INTO BookSold VALUES (94,14,106,'11/24/2020',40000,12)
INSERT INTO BookSold VALUES (95,15,107,'11/22/2013',41000,10)
INSERT INTO BookSold VALUES (96,14,106,'03/04/2015',30000,10)
INSERT INTO BookSold VALUES (97,11,108,'03/04/2015',30000,40)
INSERT INTO BookSold VALUES (98,12,108,'03/04/2015',30000,12)
INSERT INTO BookSold VALUES (99,14,107,'03/04/2015',30000,15)
INSERT INTO BookSold VALUES (90,15,109,'03/04/2015',30000,10)
GO

--2
CREATE VIEW view_CS 
AS
SELECT a.BookCode,Title,a.Price,Amount FROM Book AS a JOIN BookSold AS b ON a.BookCode = b.BookCode
SELECT * FROM view_CS

--3
CREATE VIEW view_KH
AS
SELECT a.CustomerID,CustomerName,Address,Amount  FROM Customer AS a JOIN BookSold AS b ON a.CustomerID = b.CustomerID
SELECT * FROM view_KH

--4
CREATE VIEW view_damua
AS
SELECT a.CustomerID,a.CustomerName,Address,c.Title,b.Date FROM Customer AS a JOIN BookSold AS b ON a.CustomerID = b.CustomerID
																 JOIN Book AS c ON c.BookCode = b.BookCode
WHERE MONTH(Date) = 03
SELECT * FROM view_damua
drop view view_damua

--5
CREATE VIEW view__tong
AS
SELECT a.CustomerName,b.Price * Amount as tong_tien FROM Customer AS a JOIN BookSold AS b ON a.CustomerID = b.CustomerID
SELECT * FROM view__tong