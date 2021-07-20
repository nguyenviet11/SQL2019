CREATE DATABASE lophoc

USE lophoc
GO
CREATE TABLE Class(
ClassCode varchar(10) PRIMARY KEY,
HeadTeacher varchar(30),
Room varchar(30),
Time char,
CloseDate datetime
)
INSERT INTO Class VALUES ('C101L','Mai','Class 1','G','05/10/2020')
INSERT INTO Class VALUES ('C102L','Phương','Class 2','I','08/05/2017')
INSERT INTO Class VALUES ('C103L','Hạnh','Class 3','M','10/09/2020')
INSERT INTO Class VALUES ('C104L','Hương','Class 4','H','02/11/2018')
INSERT INTO Class VALUES ('C105L','Hoà','Class 5','L','05/12/2019')


CREATE TABLE Student(
RollNo varchar(10) PRIMARY KEY,
ClassCode varchar(10),
FullName varchar(30),
Male bit,
BirthDate datetime,
Address varchar(30),
Provice char(20),
Email varchar(20),
CONSTRAINT FK_class FOREIGN KEY (ClassCode) REFERENCES Class(ClassCode)
)
INSERT INTO Student VALUES ('A00260','C101L','Nguyễn Văn Hoàng','1','05/20/1996','Hai bà trưng','HN','nguyen@gmail')
INSERT INTO Student VALUES ('A00261','C102L','Huỳnh Văn Mạnh','1','03/20/1998','Ngô Gia Tự','HCM','manh@gmail')
INSERT INTO Student VALUES ('A00262','C103L','Nguyễn Văn Mạnh','1','04/20/1999','Đại Phúc','BN','mai@gmail')
INSERT INTO Student VALUES ('A00263','C104L','Nguyễn Văn Việt','1','06/20/1997','Hai bà trưng','TN','hai@gmail')
INSERT INTO Student VALUES ('A00264','C101L','Hoàng Thị Thảo','0','07/20/1990','Hai bà trưng','HN','nguyen@gmail')


CREATE TABLE Subjects(
SubjectCode varchar(10) PRIMARY KEY,
SubjectName varchar(40),
W_Mark bit,
P_Mark bit,
WTest_per int,
PTest_per int,
)
INSERT INTO Subjects VALUES ('ACS','Outline','1','0',8,9)
INSERT INTO Subjects VALUES ('CF','Philosophy','0','1',7,9)
INSERT INTO Subjects VALUES ('JVC','Geographic','1','1',6,8)
INSERT INTO Subjects VALUES ('AMR','Maths','0','0',5,6)
INSERT INTO Subjects VALUES ('GER','Literature','1','1',7,9)


CREATE TABLE Mark(
RollNo varchar(10) ,
SubjectCode varchar(10),
WMark float,
PMark float,
Mark float,
PRIMARY KEY (RollNo, SubjectCode),
CONSTRAINT FK_ROL FOREIGN KEY (RollNo) REFERENCES Student(RollNo),
CONSTRAINT FK_SU FOREIGN KEY (SubjectCode) REFERENCES Subjects(SubjectCode)
)


INSERT INTO Mark VALUES ('A00260','ACS',8,9,6)
INSERT INTO Mark VALUES ('A00261','CF',8,9,8)
INSERT INTO Mark VALUES ('A00262','JVC',7,9,8)
INSERT INTO Mark VALUES ('A00263','AMR',6,9,7)
INSERT INTO Mark VALUES ('A00264','GER',8,6,7)


--2
CREATE VIEW view_sv AS
SELECT a.FullName,W_Mark,P_Mark FROM Student AS a JOIN Mark as b ON a.RollNo = b.RollNo
											  JOIN Subjects as c ON c.SubjectCode = b.SubjectCode
WHERE W_Mark = 1 and P_Mark = 1

--3
CREATE VIEW view_miss AS
SELECT FullName,Mark FROM Student AS a JOIN Mark AS b ON a.RollNo = b.RollNo
WHERE Mark > 6

--4
CREATE VIEW view_time AS
SELECT FullName,Time FROM Student AS a JOIN Class AS b ON a.ClassCode = b.ClassCode
WHERE Time ='G'

--5
CREATE VIEW view_gv AS
SELECT HeadTeacher FROM Student AS a JOIN Mark as b ON a.RollNo = b.RollNo
											  JOIN Class as c ON c.ClassCode = a.ClassCode
WHERE WMark < 7 or PMark < 7 or Mark < 7


--6
CREATE VIEW view_epc AS
SELECT FullName,Room,HeadTeacher,SubjectCode FROM Student AS a JOIN Mark as b ON a.RollNo = b.RollNo
											  JOIN Class as c ON c.ClassCode = a.ClassCode
WHERE SubjectCode = 'AMR' and (Mark < 7 or WMark < 7 or PMark < 7)
select * from view_epc
