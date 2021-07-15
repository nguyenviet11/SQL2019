CREATE DATABASE Asign_05

USE Asign_05

CREATE TABLE KhachHang(
MaKH varchar(10) PRIMARY KEY,
TenKH nvarchar(20),
NgaySinh varchar(10)
)
INSERT INTO KhachHang values (101,N'Nguyễn Văn Hùng','01/20/2017') 
INSERT INTO KhachHang values (102,N'Hoàng Văn Hùng','01/18/2020') 
INSERT INTO KhachHang values (103,N'Nông Văn Dền','04/26/2020') 


CREATE TABLE DanhBa(
MaDB varchar(10) PRIMARY KEY,
MaKH varchar(10),
CONSTRAINT FK_MaKH FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH)
)
INSERT INTO DanhBa values (11,101) 
INSERT INTO DanhBa values (12,102) 
INSERT INTO DanhBa values (13,103)
INSERT INTO DanhBa values (14,101) 

CREATE TABLE DanhBaCT(
MaDB varchar(10) PRIMARY KEY,
DienThoai varchar(80),
CONSTRAINT FK_MaDb FOREIGN KEY (MaDB) REFERENCES DanhBa(MaDB)
)
INSERT INTO DanhBaCT values (11,'095433597 , 2583691 , 3692581') 
INSERT INTO DanhBaCT values (12,'095433597 , 25836914 , 4562597') 
INSERT INTO DanhBaCT values (13,'095433597 , 12345677') 
INSERT INTO DanhBaCT values (14,'095433597 , 26479952') 
GO
--4a
SELECT TenKH FROM KhachHang
--4b
SELECT DienThoai FROM DanhBaCT
--5a
SELECT TenKH FROM KhachHang
ORDER BY TenKH ASC
--5b
SELECT TenKH,DienThoai FROM DanhBaCT AS a JOIN DanhBa AS b ON a.MaDB = b.MaDB
										  JOIN KhachHang AS c ON c.MaKH = b.MaKH
WHERE TenKH = N'Nguyễn Văn Hùng'
GROUP BY TenKH,DienThoai
--5c
SELECT * FROM KhachHang
WHERE NgaySinh = '01/20/2017'
--6a
SELECT TenKH,COUNT(DienThoai) AS So_dt  FROM DanhBaCT AS a JOIN DanhBa AS b ON a.MaDB = b.MaDB
										  JOIN KhachHang AS c ON c.MaKH = b.MaKH
GROUP BY TenKH
--6b
SELECT TenKH,NgaySinh FROM KhachHang 
WHERE NgaySinh like '01%'
--6c
SELECT TenKH,DienThoai,NgaySinh FROM DanhBaCT AS a JOIN DanhBa AS b ON a.MaDB = b.MaDB
										  JOIN KhachHang AS c ON c.MaKH = b.MaKH
--6d			
SELECT c.MaKH,c.TenKH,a.DienThoai,c.NgaySinh FROM DanhBaCT AS a JOIN DanhBa AS b ON a.MaDB = b.MaDB
										  JOIN KhachHang AS c ON c.MaKH = b.MaKH
WHERE a.DienThoai = '095433597 , 26479952'
GROUP BY c.MaKH,c.TenKH,a.DienThoai,c.NgaySinh
--7a
ALTER TABLE KhachHang ADD CONSTRAINT Chec_KH CHECK (NgaySinh <= getdate());
--7b
select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
--8a
CREATE INDEX ID_HoTen ON KhachHang(TenKH)

CREATE INDEX IX_SoDienThoai ON DanhBaCT(DienThoai)
--8b
CREATE VIEW View_SoDienThoai AS
SELECT TenKH,DienThoai FROM DanhBaCT AS a JOIN DanhBa AS b ON a.MaDB = b.MaDB
										  JOIN KhachHang AS c ON c.MaKH = b.MaKH

CREATE VIEW  ASView_SinhNhat AS
SELECT TenKH,NgaySinh,DienThoai FROM DanhBaCT AS a JOIN DanhBa AS b ON a.MaDB = b.MaDB
										  JOIN KhachHang AS c ON c.MaKH = b.MaKH
WHERE NgaySinh LIKE '04%'
SELECT * FROM ASView_SinhNhat
