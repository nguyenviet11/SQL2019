CREATE DATABASE SellingPoint

USE SellingPoint

CREATE TABLE Categories(
CateID char(6) PRIMARY KEY,
CateName nvarchar(100) NOT NULL,
Description nvarchar(200)
)
GO
INSERT INTO Categories VALUES ('A101', 'RAM' , N'là một trong những linh kiện quan trọng')
INSERT INTO Categories VALUES ('A102', 'HDD' , N'tất cả dữ liệu của người dùng như hệ điều hành Windows hoặc dữ liệu cá nhân đều được lưu trữ trong ổ cứng')
INSERT INTO Categories VALUES ('A103', 'CPU' , N'là các mạch điện tử trong một máy tính')
INSERT INTO Categories VALUES ('A104', 'CHIP' , N'một bộ phận hoạt động như trung tâm truyền thông và điều khiển lưu lượng của bo mạch chủ')


CREATE TABLE Parts(
PartID int PRIMARY KEY,
PartName nvarchar(100) NOT NULL,
CateID char(6),
Description nvarchar(1000),
Price money NOT NULL DEFAULT (0),
Quantity int DEFAULT (0),
Warranty int DEFAULT (1),
Photo nvarchar(200) DEFAULT ('photo/nophoto.png'),
CONSTRAINT FK_Cate FOREIGN KEY (CateID) REFERENCES Categories(CateID)
)
GO

SET IDENTITY_INSERT Parts ON;

INSERT Parts (PartID,PartName,CateID,Description,Price,Quantity,Warranty,Photo) VALUES  (1,N'Nhóm 1','A101',N'Kỹ thuật',200,20,3,'Photo/no.png')
INSERT Parts (PartID,PartName,CateID,Description,Price,Quantity,Warranty,Photo) VALUES  (2,N'Nhóm 2','A102',N'Maketting',300,60,2,'Photo/no.png')
INSERT Parts (PartID,PartName,CateID,Description,Price,Quantity,Warranty,Photo) VALUES  (3,N'Nhóm 3','A103',N'Điều hành',400,10,6,'higlight/no.png')
INSERT Parts (PartID,PartName,CateID,Description,Price,Quantity,Warranty,Photo) VALUES  (4,N'Nhóm 4','A104',N'Kinh doanh',500,70,8,'change/no.png')

GO

--4
SELECT CateName,Price FROM Categories AS a JOIN Parts AS b ON a.CateID = b.CateID
WHERE Price > 100

--5
SELECT * FROM Categories AS a JOIN Parts AS b ON a.CateID = b.CateID
WHERE CateName = 'CPU'

--6
CREATE VIEW v_Parts AS
SELECT b.PartID,b.PartName,a.CateName,b.Price,b.Quantity FROM Categories AS a JOIN Parts AS b ON a.CateID = b.CateID
Select * from v_Parts

--7
CREATE VIEW v_TopParts AS
SELECT top(5)Price FROM Parts 
ORDER BY Price
