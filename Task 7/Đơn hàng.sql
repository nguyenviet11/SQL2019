USE [Don hang]

CREATE TABLE Customer(
MaKH varchar(10) Primary key,
TenKH nvarchar(20),
DiaChi nvarchar(30),
SDT char(10),
)
GO
INSERT INTO Customer values (11, N'Nguyễn Văn A',N'Hà Nội',295615)
INSERT INTO Customer values (12, N'Nguyễn Văn B',N'Yên Thế',56154)
INSERT INTO Customer values (13,N'Nguyễn Văn C',N'Lĩnh Nam',656154)
INSERT INTO Customer values (14,N'Anh',N'Lĩnh Nam',6546154)
GO

CREATE TABLE SanPham(
MaSP varchar(10) Primary key,
TenSP nvarchar(20),
MoTa nvarchar(40),
DonVi nvarchar(10),
GiaSP money,
SoLuong int,
Status nvarchar(20)
)
GO
INSERT INTO SanPham values (103,N'Máy tính T45',N'Máy nhập mới' ,N'chiếc',2000,2,N'Đã bán')
INSERT INTO SanPham values (104,N'ĐT nokia',N'Máy nhập cũ', N'chiếc',500,3,N'Còn nhiều')
INSERT INTO SanPham values (106,N'Iphone XS max',N'Điên thoại hot', N'chiếc',200,1,N'Hàng tồn')
INSERT INTO SanPham values (107,N'Máy in',N'Máy bị lỗi', N'chiếc',3000,2,N'Đã bán hết')
GO

CREATE TABLE Oder(
MaSoDH varchar(10) PRIMARY KEY,
MaKH varchar(10),
OdDate varchar(10),
Status nvarchar(20),
CONSTRAINT FK_KH FOREIGN KEY (MaKH) REFERENCES Customer(MaKH)
)
GO
INSERT INTO Oder values (114,11,'10/15/2020',N'Đang xử lí')
INSERT INTO Oder values (115,12,'09/15/2018',N'Đang vận chuyển')
INSERT INTO Oder values (116,11,'04/14/2021',N'Đã giao')
INSERT INTO Oder values (117,13,'08/15/2020',N'Đã giao')
INSERT INTO Oder values (119,12,'10/19/2020',N'Đang vận chuyển')
GO

CREATE TABLE OderDetail(
MaSoDH varchar(10) PRIMARY KEY,
MaSP varchar(10) ,
GiaSP money,
SoLuong int,
)
GO
ALTER TABLE OderDetail ADD FOREIGN KEY (MaSoDH) REFERENCES Oder(MaSoDH)
ALTER TABLE OderDetail ADD FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP)
GO
INSERT INTO OderDetail values (114,103,2000,1)
INSERT INTO OderDetail values (115,104,500,2)
INSERT INTO OderDetail values (116,106,200,3)
INSERT INTO OderDetail values (117,107,3000,2)
INSERT INTO OderDetail values (119,107,2000,2)

--4
--danh sách khách hàng đã mua hàng
SELECT TenKH,MaSP FROM Customer as a JOIN Oder as b on a.MaKH = b.MaKH
									 JOIN OderDetail as c on c.MaSoDH = b.MaSoDH
GROUP BY TenKH, MaSP
--liệt kê danh sách sản phẩm
SELECT MaSP,TenSP FROM SanPham
--liệt kê danh sách đơn đặt hàng
SELECT a.MaSoDH, b.MaSP, a.OdDate FROM Oder as a JOIN OderDetail as b on a.MaSoDH = b.MaSoDH
GROUP BY a.MaSoDH, b.MaSP, a.OdDate
--5
--liệt kê danh sách KH theo thứ tự alpha
SELECT TenKH FROM Customer
ORDER BY TenKH ASC;
--liệt kê danh sách SP theo giảm dần
SELECT MaSP,TenSP,GiaSP FROM SanPham 
ORDER BY GiaSP DESC;
--liệt kê sp nguyễn văn a mua
SELECT a.MaKH,a.TenKH,d.TenSP FROM Customer as a JOIN Oder as b on a.MaKH = b.MaKH
											JOIN OderDetail as c on c.MaSoDH = b.MaSoDH
											JOIN SanPham as d on d.MaSP = c.MaSP
WHERE a.TenKH = N'Nguyễn Văn A'
GROUP BY a.MaKH,a.TenKH, d.TenSP
--6
--Số khách hàng đã mua
SELECT COUNT(TenKH) AS So_luong_mua_hang FROM Customer
--Số mặt hàng đã bán
SELECT TenSP, b.SoLuong FROM SanPham as a JOIN OderDetail as b on a.MaSP = b.MaSP
GROUP BY TenSP, b.SoLuong
-- tổng tiền của từng đơn hàng
SELECT MaSoDH,MaSP , GiaSP * SoLuong as Tong_tien FROM OderDetail
--7
-- viết câu lệnh để thay đổi trường giá tiền của từng mặt hàng là dương
ALTER TABLE SanPham ADD CONSTRAINT CK CHECK (GiaSP > 0)
--ngày đặt hàng phải < hơn ngày hiện tại
ALTER TABLE Oder ADD CONSTRAINT Od CHECK (OdDate < getdate())
--thêm cột ngày xuất hiện trên bảng sản phẩm
ALTER TABLE SanPham ADD ngay_xuat_hien varchar(10)
--8
--tạo chỉ mục index cho cột tên hàng và người đặt hàng
CREATE INDEX ID_Tensp ON SanPham(TenSP);
CREATE INDEX ID_Tenkh ON Customer(TenKH);
--view khách hàng
CREATE VIEW veiw_khachhang AS
SELECT TenKH,DiaChi,SDT
FROM Customer
select * from veiw_khachhang
--view sản phẩm
CREATE VIEW veiw_sanpham AS
SELECT TenSP,GiaSP
FROM SanPham
--view khách hàng, sản phẩm
CREATE VIEW veiw_sanpham_khachhang AS
SELECT a.TenKH,a.SDT,d.TenSP,d.SoLuong,b.OdDate 
FROM Customer as a 
JOIN Oder as b ON a.MaKH = b.MaKH 
JOIN OderDetail as c ON c.MaSoDH = b.MaSoDH
JOIN SanPham as d ON d.MaSP = c.MaSP
select * from  veiw_sanpham_khachhang