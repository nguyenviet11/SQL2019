use AdventureWorks2019

select * from HumanResources.Employee

go
declare @depID int
select @depID=1
select name, groupname from HumanResources.Department where DepartmentID = @depID
go
 
select @@LANGUAGE
select @@VERSION

go

--lấy tổng giá cả giá trị các bản ghi trường standardcost thuộc bảng productcosthistory
select sum(standardcost) from Production.ProductCostHistory

-- tính giá trị trung bình của trường standardcost thuộc bảng productcosthistory
select avg(standardcost) from Production.ProductCostHistory

-- lấy ra giá trị lớn nhất của trường stanstandardcost trong bảng productcosthistory
select max(standardcost) from Production.ProductCostHistory

-- đếm tổng số bản ghi trong bảng productphoto
select count(*) from Production.ProductPhoto

--lấy ra ngày giờ hệ thống:
select GETDATE()

--lấy ra giờ hệ thống
select DATEPART(hh,getdate())

--định dạng ngày dùng hàm convert
select CONVERT(varchar(50), getdate(),103)


--lấy ra định danh của cơ sở dữ liệu
select DB_ID('adventurework2019')

-- tạo cơ sở dữ liệu:
create database example3

use example3

--tạo bảng trong cơ sở dữ liệu
create table contacts
(mailID varchar(20),
	Name ntext,
telephonenumber int)

--thêm 1 cột vào bảng đã có:
alter table contacs add address nvarchar(50)

--thêm dữ liệu vào bảng contacts:
insert into contacts value ('abc@yahoo.com',N'Nguyễn Văn A',9898998,N'Hà Nội')
insert into contacts value ('nguyenthiB@yahoo.com',N'Nguyễn Thị B', 4329234,N'Hà Nội')
insert into contacts value ('tranvanC@yahoo.com',N'Trần Văn C', 905243524,N'Hà Nội')
insert into contacts value ('trinhvanD@yahoo.com',N'Trịnh Văn D',4563576,N'Hà Nội')

-- lấy ra tất cả bản ghi trong bảng:
select * from contacts

--Xoá bản ghi có maiid-tranvanC@yahoo.com
delete from contact where maiID='tranvanC@yahoo.com'

--sửa bản ghi có maiid-trinhvanD@yahoo.com
update contacts set name=N'Trịnh Hoàng Long' where mailID='trinhvanD@yahoo.com'

--tạo login account để test grant
create login example3 with password='123456'

--tạo user từ login account vừa tạo
create user example3 from login example3

--huỷ bỏ tất cả các quyền của user example3 trên bảng contacts
revoke all on contacts from example3

-- gán quyền select cho example3 trên bảng contacts
grant select on contacts to example3