Use BTTL
drop table NhanVien
drop table PhongBan
drop table LuongDA
CREATE TABLE PhongBan
(MaPB varchar(7),
TenPB nvarchar(50),
CONSTRAINT PM_PhongBan PRIMARY KEY (MaPB)
)
insert into PhongBan values (0001,N'Phong 1')
insert into PhongBan values (0002,N'Phong 2')
insert into PhongBan values (0003,N'Phong 3')
insert into PhongBan values (0004,N'Phong 4')
insert into PhongBan values (0005,N'Phong 5')
GO

CREATE TABLE NhanVien
(MaNV varchar(7) PRIMARY KEY NOT NULL,
TenNV nvarchar(50),
NgaySinh datetime CHECK (NgaySinh < getdate()),
SoCMND char(9),
GioiTinh char(1) DEFAULT ('M') CHECK (GioiTinh = 'M' OR GioiTinh = 'F'),
DiaChi nvarchar(100),
NgayVaoLam datetime,
MaPB varchar(7),
CONSTRAINT FK_Mapb FOREIGN KEY (MaPB) REFERENCES PhongBan(MaPB)
)
GO
ALTER TABLE NhanVien
ADD CONSTRAINT MyCheck
CHECK ( ABS(DATEDIFF(year, NgaySinh, NgayVaoLam)) > 20);

Insert into NhanVien values(01,N'hùng','4/4/1993', 12695423,'F',N'lào cai','4/5/2020',0001)
Insert into NhanVien values(02,N'nam','5/4/1992', 12695423,'M',N'thái nguyên','4/5/2020',0002)
Insert into NhanVien values(03,N'hoàng','2/20/1996', 12695423,'M',N'bắc kạn','4/5/2020',0003)
Insert into NhanVien values(04,N'huy','4/10/1995', 12695423,'F',N'hồ chí minh','4/5/2020',0004)
Insert into NhanVien values(05,N'khánh','4/20/1994', 12695423,'M',N'bắc ninh','4/5/2020',0005)
Insert into NhanVien values(06,N'khánh2','4/20/1994', 12695423,'M',N'bắc ninh','4/5/2020',0005)

Go
CREATE TABLE LuongDA
(MaDA varchar(8),
MaNV varchar(7) ,
NgayNhan datetime NOT NULL DEFAULT getdate(),
SoTien money CHECK (SoTien > 0),
CONSTRAINT PM_Ma PRIMARY KEY (MaDA,MaNV),
CONSTRAINT FK_MaNV FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV)
)
Insert into LuongDA values(159,01,'12/30/2020',50000)
Insert into LuongDA values(357,02,'12/30/2020',20000)
Insert into LuongDA values(258,03,'12/30/2020',41000)
Insert into LuongDA values(456,04,'12/30/2020',70000)
Insert into LuongDA values(856,05,'12/30/2020',60000)
Insert into LuongDA values(486,06,'12/30/2020',60000)
--hiển thị thông tin các 3 bảng
select * from PhongBan
select * from NhanVien
select * from LuongDA
--hiển thi nhân viên giới tính 'F'
select GioiTinh from NhanVien where GioiTinh Like 'F'
--hiển thị  tất cả dự án mỗi dự án trên 1 dòng
select top(1) * from PhongBan
select top(1)* from NhanVien
select top(1)* from LuongDA
-- hiển thị tổng lương của từng nhân viên
select MaNV,SUM(SoTien) AS Tong_tien from LuongDA GROUP BY MaNV 
--hiển thị tất cả nhân viên trên 1 phòng ban cho trc
select MaNV,TenPB from  NhanVien as a inner join PhongBan as b on a.MaPB = b.MaPB
--hiển thị mức lương của nhân viên phòng 1
select SoTien,TenPB from LuongDA as a inner join PhongBan as b on a.MaNV= b.MaPB where MaPB = 1
--hiển thị số lượng nhân viên của từng phòng
select TenPB, COUNT(MaNV) AS so_luong from NhanVien as a inner join PhongBan as b on a.MaPB = b.MaPB GROUP BY TenPB
-- hiển thị phòng ban có nhiều nhân viên nhất
select TenPB, COUNT(MaNV) AS so_luong into #soluongnv from NhanVien as a inner join PhongBan as b on a.MaPB = b.MaPB GROUP BY TenPB
SELECT Max(TenPB) AS so_phong, MAX(so_luong) As so_luong FROM #soluongnv
--hiển thị tổng lương của các nhân viên có CMND số cuối là 9
SELECT a.MaNV,SUM(SoTien) AS Tong_tien, SoCMND
FROM LuongDA as a join NhanVien as b ON a.MaNV = b.MaNV 
WHERE SoCMND like '%9'
GROUP BY a.MaNv, SoCMND
--hiển thị nhân viên có số lương cao nhất
DECLARE @maxluong numeric(16,2)
SELECT @maxluong = MAX(SoTien) 
FROM LuongDA

SELECT MaNV,SoTien 
FROM LuongDA
WHERE SoTien = @maxluong

--tìm nhân viên ở phòng 1 có giới tính = F và có mức lương > 1200
SELECT a.MaNV,a.GioiTinh,c.SoTien 
FROM NhanVien as a	JOIN PhongBan b ON a.MaPB = b.MaPB 
					JOIN LuongDA c ON a.MaNV = c.MaNV  
WHERE b.MaPB = 1 AND a.GioiTinh = 'F' AND c.SoTien > 1200
-- tìm tổng lương trên từng phòng
select TenPB,SUM(SoTien) AS Tong_tien 
from LuongDA as a JOIN NhanVien b ON a.MaNV = b.MaNV
				   JOIN PhongBan c ON c.MaPB = b.MaPB
GROUP BY TenPB
-- thông tin của nhân viên bắt đầu bằng chữ 'n'
SELECT * FROM NhanVien
WHERE TenNV Like 'n%'
-- xoá đi từ bảng LuongDA những nhân viên có lương 20000
DELETE FROM LuongDA WHERE SoTien= 20000
-- xoá đi các bản ghi từ NhanVien với những nv k tồn tại tỏng LuongDA
DELETE FROM NhanVien WHERE MaNV= 2
-- sửa tất cả ngày vào làm của nhân viên  thuộc phòng 5 thành ngày 12/02/2015
UPDATE NhanVien set NgayVaoLam = '12/02/2015' WHERE MaPB = 5 

