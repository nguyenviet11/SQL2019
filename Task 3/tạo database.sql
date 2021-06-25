create database product

use product

create table tabl
(ma_sp char(16),
ten_sp ntext,
gia_sp int,
status char(1),
so_luong int )

INSERT INTO tabl values (1, N'Quần',50000,'H', 50)
INSERT INTO tabl values (2, N'Áo', 60000, 'M', 49)
INSERT INTO tabl values (3, N'Túi', 70000, 'M', 9)
INSERT INTO tabl values (4, N'Cặp', 80000, 'K', 79)
INSERT INTO tabl values (5, N'Balo', 80000, 'M', 49)

select * from tabl

update tabl set ten_sp=N'Gấu bông' where ma_sp=1

delete from tabl where ma_sp=4



create database customer

use customer

create table tabl2
(CusID char(16),
name ntext,
email varchar(20),
phone int,
level int,
status char(1))

INSERT INTO tabl2 values (123, N'Nguyễn Văn A','nguyenvana@gmail.com',123456, 10,'M')
INSERT INTO tabl2 values (112, N'Nguyễn Văn B','nguyenvanb@gmail.com',123457, 2,'H')
INSERT INTO tabl2 values (115, N'Nguyễn Văn C','nguyenvanc@gmail.com',123458, 156, 'M')
INSERT INTO tabl2 values (119, N'Nguyễn Văn D','nguyenvand@gmail.com',369258, 147, 'H')
INSERT INTO tabl2 values (191, N'Nguyễn Văn E','nguyenvane@gmail.com',147285, 123, 'G')

select * from tabl2

update tabl2 set name=N'Nguyễn Văn H' where CusID=123

delete from tabl2 where CusID=119