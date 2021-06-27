CREATE DATABASE BookLibrary

USE BookLibrary
GO

CREATE TABLE Book(
BookCode int,
BookTitle varchar(100) NOT NULL,
Author varchar(50) NOT NULL,
Edition int,
BookPrice money,
Copies int,
CONSTRAINT bok PRIMARY KEY (BookCode)
)
GO
INSERT INTO Book values(1234, 'a ', 'hh', 6,50,10)
INSERT INTO Book values(1235, 'd' , 'hh', 5,80,16)
INSERT INTO Book values(1236, 'c' ,'hh', 7,60,15)
INSERT INTO Book values(1237, 'b' , 'hh', 8,80,14)
GO
SELECT * FROM Book
GO
CREATE TABLE Member(
MemberCode int ,
Name varchar(50) NOT NULL,
Addres varchar(100) NOT NULL,
PhoneNumber int,
CONSTRAINT mem PRIMARY KEY (MemberCode)
)
INSERT INTO Member values(21,'Nam','Ha Noi', 195)
INSERT INTO Member values(22,'Ha','Ha Noi', 196)
INSERT INTO Member values(23,'Hung','Ha Noi', 197)
INSERT INTO Member values(24,'Chien','Ha Noi',1 99)
GO
SELECT * FROM Member
Go
CREATE TABLE IssueDetails(
BookCode int, 
CONSTRAINT dkm FOREIGN KEY ( BookCode ) references Book(BookCode),
MemberCode int,
CONSTRAINT DKF FOREIGN KEY (MemberCode) references Member(MemberCode),
IssueDate datetime,
ReturnDate datetime
)
INSERT INTO IssueDetails values(1234 , 21, 27/6 , 27/9)
INSERT INTO IssueDetails values(1235  ,22 , 20/6 , 27/8)
INSERT INTO IssueDetails values(1237 , 24 , 29/6 , 30/9)
INSERT INTO IssueDetails values(1236 , 23 , 2/6 , 30/9)
GO
SELECT * FROM IssueDetails
Go

-- xoá các ràng buộc
ALTER TABLE IssueDetails DROP CONSTRAINT dkm
GO
ALTER TABLE IssueDetails DROP CONSTRAINT DKF
GO
ALTER TABLE Book DROP CONSTRAINT bok
GO
ALTER TABLE Member DROP CONSTRAINT mem
GO

-- thêm mới ràng buộc
ALTER TABLE Book ADD CONSTRAINT lla PRIMARY KEY(BookCode)
GO
ALTER TABLE Member ADD CONSTRAINT llal PRIMARY KEY(MemberCode)
GO
ALTER TABLE IssueDetails ADD CONSTRAINT hh FOREIGN KEY (BookCode) REFERENCES Book(Bookcode)
Go
ALTER TABLE IssueDetails ADD CONSTRAINT gg FOREIGN KEY (MemberCode) REFERENCES Member(Membercode)
GO
ALTER TABLE Book ADD CONSTRAINT Bk Check(BookPrice > 0 and BookPrice < 200)
Go
ALTER TABLE Member ADD CONSTRAINT me UNIQUE (PhoneNumber) 
GO
ALTER TABLE IssueDetails ALTER Column BookCode int NOT NULL
GO
ALTER TABLE IssueDetails ALTER Column MemberCode int NOT NULL
GO
ALTER TABLE IssueDetails ADD CONSTRAINT pri PRIMARY KEY(BookCode,MemberCode)
GO

