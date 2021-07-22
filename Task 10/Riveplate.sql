CREATE DATABASE Riverplate

USE RiverPlate

CREATE TABLE Student(
StudentNo int PRIMARY KEY, 
StudentName nvarchar(50),
StudentAddress nvarchar(100),
PhoneNo int
)
GO
INSERT INTO Student VALUES ('121','Hoàng','Hà Nội','0665489')
INSERT INTO Student VALUES ('122','Văn','Thái Nguyên','0663589')
INSERT INTO Student VALUES ('123','Hậu','Bắc Kạn','0668789')
INSERT INTO Student VALUES ('124','Mai','Bắc Ninh','0647489')
INSERT INTO Student VALUES ('125','Hương','Hà Nội','0651489')


CREATE TABLE Department(
DeptNo int PRIMARY KEY,
DeptName nvarchar(50),
ManagerName nvarchar(30)
)
INSERT INTO Department VALUES (101,N'Nhóm 1',N'Táo')
INSERT INTO Department VALUES (102,N'Nhóm 2',N'Lê')
INSERT INTO Department VALUES (103,N'Nhóm 3',N'Nho')
INSERT INTO Department VALUES (104,N'Nhóm 4',N'Dưa')


CREATE TABLE Assignment(
AssignmentNo int PRIMARY KEY,
Description nvarchar(100),
)
INSERT INTO Assignment VALUES (911,N'Xoá bảng')
INSERT INTO Assignment VALUES (912,N'Vẽ đường tròn')
INSERT INTO Assignment VALUES (913,N'Quay lại B1')
INSERT INTO Assignment VALUES (914,N'Ứng dụng thực tế các tỉ số lượng giác của góc nhọn')
INSERT INTO Assignment VALUES (915,N'Mô tả cánh')

CREATE TABLE Works_Assign(
JobID int PRIMARY KEY,
StudentNo int,
AssignmentNo int,
TotalHours int,
JobDetails nvarchar(450),
CONSTRAINT FK_Stu FOREIGN KEY (StudentNo) REFERENCES Student(StudentNo),
CONSTRAINT FK_Assi FOREIGN KEY (AssignmentNo) REFERENCES Assignment(AssignmentNo)
)
INSERT INTO Works_Assign VALUES (456,'121',911,8,N'Hãy tính các độ dài AC, BD, AB của cánh')
INSERT INTO Works_Assign VALUES (789,'122',912,8,N'Hãy tính các độ dài AC, BD, AB của Sách')
INSERT INTO Works_Assign VALUES (321,'123',913,8,N'Hãy tính các độ dài AC, BD, AB của Máy tính')
INSERT INTO Works_Assign VALUES (159,'124',914,8,N'Hãy tính các độ dài AC, BD, AB của Cửa sổ')
INSERT INTO Works_Assign VALUES (357,'125',915,8,N'Hãy tính các độ dài AC, BD, AB của ngôi nhà')


--2 
CREATE CLUSTERED INDEX IX_Students ON Student(StudentNo)
--3
drop index IX_Student ON Student
--4
CREATE UNIQUE NONCLUSTERED INDEX IX_Dept ON Department(DeptName,ManagerName)








