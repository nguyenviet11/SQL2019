CREATE DATABASE Asign_03

USE Asign_03

CREATE TABLE KhachHang(
MaKH varchar(10) PRIMARY KEY,
TenKH nvarchar(20),
CMND varchar(10),
DiaChi nvarchar(30),
)
GO
INSERT INTO KhachHang values (11, N'Nguyễn Văn A',12345678,N'Bắc Giang')
INSERT INTO KhachHang values (12, N'Duy',12345679,N'Bắc Ninh')
INSERT INTO KhachHang values (13, N'Hạnh',12345677,N'Hà Nội')
INSERT INTO KhachHang values (14, N'Hoàng',12345676,N'Lào Cai')

CREATE TABLE GiayDKTT(
MaDKTT varchar(10) PRIMARY KEY,
MaKH varchar(10),
OdDate varchar(10),
CONSTRAINT FK_MaKH FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH) 
)
GO
INSERT INTO GiayDKTT values (112,11,'05/06/2020')
INSERT INTO GiayDKTT values (113,12,'06/07/2020')
INSERT INTO GiayDKTT values (114,13,'08/08/2019')
INSERT INTO GiayDKTT values (115,14,'09/06/2018')
INSERT INTO GiayDKTT values (116,11,'10/06/2017')


CREATE TABLE GiayDKTTCT(
MaDKTT varchar(10) PRIMARY KEY,
SoTB varchar(10),
LoaiTB nvarchar(20),
)
ALTER TABLE GiayDKTTCT ADD FOREIGN KEY (MaDKTT) REFERENCES GiayDKTT(MaDKTT)
GO
INSERT INTO GiayDKTTCT values (112,852741, N'Trả trước')
INSERT INTO GiayDKTTCT values (113,159486, N'Trả sau')
INSERT INTO GiayDKTTCT values (114,856147, N'Trả giữa')
INSERT INTO GiayDKTTCT values (115,369258, N'Trả sau')
INSERT INTO GiayDKTTCT values (116,369257, N'Trả sau')

--4a
SELECT * FROM KhachHang
--4b
SELECT * FROM GiayDKTTCT
--5a
SELECT * FROM GiayDKTTCT 
WHERE SoTB = 159486
--5b
SELECT * FROM KhachHang
WHERE CMND = 12345679
--5c
SELECT SoTB FROM GiayDKTTCT as a JOIN GiayDKTT as b ON a.MaDKTT = b.MaDKTT
								 JOIN KhachHang as c ON c.MaKH = b.MaKH
WHERE CMND = 12345679
GROUP BY SoTB
--5d
SELECT a.OdDate,b.SoTB FROM GiayDKTT as a JOIN GiayDKTTCT as b ON a.MaDKTT = b.MaDKTT
WHERE OdDate = '06/07/2020'
GROUP BY a.OdDate,b.SoTB
--5e
SELECT a.SoTB,c.DiaChi FROM GiayDKTTCT as a JOIN GiayDKTT as b ON a.MaDKTT = b.MaDKTT
								 JOIN KhachHang as c ON c.MaKH = b.MaKH
WHERE DiaChi = N'Hà Nội'
GROUP BY a.SoTB,c.DiaChi
--6A
SELECT COUNT(TenKH) AS So_khach_hang FROM KhachHang
--6b
SELECT COUNT(SoTB) AS Tong_so_TB FROM GiayDKTTCT
--6c
SELECT OdDate,COUNT(SoTB) as Tong_so FROM GiayDKTTCT as a JOIN GiayDKTT as b ON a.MaDKTT = b.MaDKTT
WHERE OdDate = '08/08/2019'
GROUP BY OdDate
--6d
select a.TenKH,a.CMND,a.DiaChi,c.SoTB,c.LoaiTB from KhachHang as a JOIN GiayDKTT as b ON a.MaKH = b.MaKH
														 JOIN GiayDKTTCT as c ON c.MaDKTT = b.MaDKTT
GROUP BY a.TenKH,a.CMND,a.DiaChi,c.SoTB,c.LoaiTB
--7a
ALTER TABLE GiayDKTT ALTER COLUMN OdDate varchar(10) NOT NULL;
--7b
ALTER TABLE GiayDKTT ADD CONSTRAINT Od CHECK (OdDate <= getdate());
--7c
UPDATE GiayDKTTCT SET SoTB = '09'+ SoTB
--7d
ALTER TABLE GiayDKTTCT ADD Diem_thuong varchar(10);
--8a
CREATE INDEX ID_TenKH ON KhachHang(TenKH)
--8b
CREATE VIEW view_khachhang AS
SELECT MaKH,TenKH,DiaChi
FROM KhachHang

CREATE VIEW view_khachhang_thuebao AS
SELECT a.MaKH,a.TenKH,c.SoTB 
FROM KhachHang AS a JOIN GiayDKTT as b ON a.MaKH = b.MaKH
					JOIN GiayDKTTCT as c ON c.MaDKTT = b.MaDKTT
