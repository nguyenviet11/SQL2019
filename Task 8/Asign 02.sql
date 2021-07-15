USE nhanhang

CREATE TABLE SanPham(
MaSP varchar(10) Primary key,
TenSP nvarchar(20),
MoTa nvarchar(40),
DonVi nvarchar(10),
GiaSP money,
SoLuongHienCo int,
Status nvarchar(20)
)
GO
INSERT INTO SanPham VALUES (203,N'Máy tính T45',N'Máy nhập mới' ,N'chiếc',1000,10,N'Đã bán')
INSERT INTO SanPham VALUES (204,N'ĐT nokia 5670',N'Máy đang hot' ,N'chiếc',200,200,N'Còn nhiều')
INSERT INTO SanPham VALUES (205,N'Máy in SAMSUNG 450',N'Máy in đang loại bình' ,N'chiếc',300,19,N'Hàng tồn')
INSERT INTO SanPham VALUES (206,N'Bàn Phím LOGITECH',N'HOT' ,N'chiếc',2000,30,N'Số lượng có hạn')


CREATE TABLE NhanHang(
MaNH varchar(10) Primary key,
TenNH varchar(30),
DiaChi varchar(30),
SDT char(10),
)
INSERT INTO NhanHang values (11, 'Asus','USA',295615)
INSERT INTO NhanHang values (12, 'NVIDIA','Germany',2495615)
INSERT INTO NhanHang values (13, 'Tesla','Beligum',6295615)
INSERT INTO NhanHang values (14, 'Adidas','USA',7295615)

CREATE TABLE DanhSach(
MaSoDS varchar(10) PRIMARY KEY,
MaNH varchar(10),
Status nvarchar(20),
CONSTRAINT FK_NH FOREIGN KEY (MaNH) REFERENCES NhanHang(MaNH)
)
INSERT INTO DanhSach values (121,11,N'Đang giao')
INSERT INTO DanhSach values (122,12,N'Đang vận chuyển')
INSERT INTO DanhSach values (124,13,N'Đã giao')
INSERT INTO DanhSach values (125,14,N'Đang giao')
INSERT INTO DanhSach values (126,11,N'Đã giao')

CREATE TABLE DanhSachChiTiet(
MaSoDS varchar(10) PRIMARY KEY,
MaSP varchar(10),
GiaSP money,
SoLuong int,
)
ALTER TABLE DanhSachChiTiet ADD FOREIGN KEY (MaSoDS) REFERENCES DanhSach(MaSoDS)
ALTER TABLE DanhSachChiTiet ADD FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP)
GO

INSERT INTO DanhSachChiTiet values (121,203,1000,1)
INSERT INTO DanhSachChiTiet values (122,204,200,4)
INSERT INTO DanhSachChiTiet values (124,206,2000,3)
INSERT INTO DanhSachChiTiet values (125,205,300,1)
INSERT INTO DanhSachChiTiet values (126,204,200,8)

--4a
SELECT MaNH,TenNH FROM NhanHang
--4b
SELECT MaSP,TenSP FROM SanPham

--5a
SELECT MaNH,TenNH FROM NhanHang
ORDER BY TenNH DESC
--5b
SELECT MaSP,TenSP,GiaSP FROM SanPham
ORDER BY GiaSP DESC
--5c
SELECT * FROM NhanHang
WHERE TenNH = 'Asus'
--5d
SELECT MaSP,TenSP,SoLuongHienCo FROM SanPham
WHERE SoLuongHienCo < 11
--5e
SELECT a.TenNH,d.TenSP FROM NhanHang as a JOIN DanhSach as b on a.MaNH = b.MaNH
											JOIN DanhSachChiTiet as c on c.MaSoDS = b.MaSoDS
											JOIN SanPham as d on d.MaSP = c.MaSP
WHERE a.TenNH = 'Asus'
GROUP BY a.TenNH, d.TenSP

--6a
SELECT COUNT(TenNH) AS So_hang FROM NhanHang
--6b
SELECT COUNT(TenSP) AS So_mat_hang_ban FROM SanPham
--6c
SELECT TenNH,COUNT(TenSP) AS So_mat_hang_trong_hang FROM NhanHang as a JOIN DanhSach as b on a.MaNH = b.MaNH
											JOIN DanhSachChiTiet as c on c.MaSoDS = b.MaSoDS
											JOIN SanPham as d on d.MaSP = c.MaSP
GROUP BY TenNH
--6d
SELECT Sum(SoLuongHienCo) AS Tong_so_san_pham FROM SanPham
--7a
ALTER TABLE SanPham ADD CONSTRAINT CK CHECK (GiaSP > 0)
--7b
UPDATE NhanHang SET SDT= '0'+ SDT
--7c
select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS  
--8a
CREATE INDEX ID_Tensp ON SanPham(TenSP)
CREATE INDEX ID_Mota ON SanPham(MoTa)
--8b
CREATE VIEW view_sanpham AS
SELECT MaSP,TenSP,GiaSP
FROM SanPham

CREATE VIEW view_sanpham_hang AS
SELECT a.MaSP,a.TenSP,d.TenNH
FROM SanPham as a JOIN DanhSachChiTiet as b on a.MaSP = b.MaSP
				  JOIN DanhSach as c on c.MaSoDS = b.MaSoDS
				  JOIN NhanHang as d on d.MaNH = c.MaNH
--8c