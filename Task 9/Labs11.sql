CREATE DATABASE Lab11
GO
USE AdventureWorks2019

CREATE VIEW ProductList
AS
SELECT DepartmentID,Name FROM HumanResources.Department

SELECT * FROM ProductList
go

VD2
USE Asign_05
CREATE VIEW Product
AS
SELECT TenKH,NgaySinh,DienThoai
FROM DanhBaCT AS a JOIN DanhBa AS b ON a.MaDB = b.MaDB
										  JOIN KhachHang AS c ON c.MaKH = b.MaKH
SELECT * FROM Product