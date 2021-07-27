CREATE DATABASE Triger

USE Triger

CREATE TABLE Employee(
EmployeeID int PRIMARY KEY,
Name varchar(100),
Tel char(11),
Email varchar(30)
)
GO
INSERT INTO Employee VALUES('100','Hoàng','023654','hoang@gmail.com')
INSERT INTO Employee VALUES('101','Minh','023654','hoang@gmail.com')
INSERT INTO Employee VALUES('102','Ngọc','023654','hoang@gmail.com')
INSERT INTO Employee VALUES('103','Anh','023654','hoang@gmail.com')


CREATE TABLE Project(
ProjectID int PRIMARY KEY,
ProjectName varchar(30),
StartDate datetime,
EndDate datetime,
Period int,
Cost money
)
INSERT INTO Project VALUES('333','kỹ thuật','01/20/2010','03/05/2021',15,50000)
INSERT INTO Project VALUES('444','maketing','01/20/2014','03/05/2021',15,60000)
INSERT INTO Project VALUES('555','Nhà ở','01/20/2008','03/05/2021',15,70000)
INSERT INTO Project VALUES('666','máy tính','01/20/2018','03/05/2021',15,10000)



CREATE TABLE Groups(
GroupID int PRIMARY KEY,
GroupName varchar(30),
LeaderID int,
ProjectID int,
CONSTRAINT FK_PRO FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID),
CONSTRAINT FK_lead FOREIGN KEY (LeaderID) REFERENCES Employee(EmployeeID),
)
INSERT INTO Groups VALUES (401,'nhóm 1','100','333')
INSERT INTO Groups VALUES (402,'nhóm 2','101','444')
INSERT INTO Groups VALUES (403,'nhóm 3','102','555')
INSERT INTO Groups VALUES (404,'nhóm 4','102','555')


CREATE TABLE GroupDetail(
GroupID int,
EmployeeID int,
Status char(20),
PRIMARY KEY (GroupID,EmployeeID),
CONSTRAINT FK_Gr FOREIGN KEY (GroupID) REFERENCES Groups(GroupID),
CONSTRAINT FK_em FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
)

INSERT INTO GroupDetail VALUES (401,'100','inprogress')
INSERT INTO GroupDetail VALUES (402,'101','done')
INSERT INTO GroupDetail VALUES (403,'102','pending')
INSERT INTO GroupDetail VALUES (404,'102','pending')


--3a
SELECT * FROM Employee

--3b
SELECT a.EmployeeID,a.Name,c.ProjectName FROM Employee AS a JOIN Groups AS b ON a.EmployeeID = b.LeaderID
										  JOIN Project AS c ON c.ProjectID = b.ProjectID
WHERE c.ProjectName = 'maketing'	

--3c
SELECT GroupName,COUNT(LeaderID) AS so_luong FROM Groups
GROUP BY GroupName

--3d
SELECT b.GroupName,EmployeeID,Name,Tel,Email FROM Employee AS a JOIN Groups AS b ON a.EmployeeID = b.LeaderID

--3e
SELECT a.GroupName,c.EmployeeID,b.StartDate,b.Period,b.Cost FROM Groups AS a JOIN Project AS b ON a.ProjectID = b.ProjectID
																   JOIN GroupDetail AS c ON c.EmployeeID = a.LeaderID
WHERE b.StartDate < '12/10/2010'
GROUP BY a.GroupName,c.EmployeeID,b.StartDate,b.Period,b.Cost

--3g
SELECT d.EmployeeID,a.Name,a.Tel,a.Email,b.GroupName,c.ProjectName,d.Status FROM Employee AS a JOIN Groups AS b ON a.EmployeeID = b.LeaderID
																				 JOIN Project AS c ON c.ProjectID = b.ProjectID
																				 JOIN GroupDetail AS d ON d.EmployeeID = b.LeaderID
GROUP BY d.EmployeeID,a.Name,a.Tel,a.Email,b.GroupName,c.ProjectName,d.Status

--4a
ALTER TABLE Project ADD CHECK (EndDate > StartDate)
--4b	
ALTER TABLE Employee ALTER COLUMN Name varchar(100) NOT NULL;
--4c
ALTER TABLE GroupDetail ADD CHECK (Status = 'inprogress' or Status = 'pending' or Status = 'done') 
--4d
ALTER TABLE Project ADD CHECK (Cost > 9000)
--4e
SELECT LeaderID,EmployeeID FROM Employee AS a JOIN Groups AS b ON a.EmployeeID = b.LeaderID
GROUP BY LeaderID,EmployeeID
--4f
SELECT Tel FROM Employee
WHERE Tel like '0%'
--5a
CREATE PROC sp_chan  
AS
BEGIN
	UPDATE Project SET Cost = Cost * 0.1 WHERE (Cost < 20000)
END
--6a
CREATE INDEX IX_Group ON GroupDetail(GroupID,EmployeeID)
--6b
CREATE INDEX IX_Projec ON Project(ProjectName,StartDate,EndDate)
--7a
CREATE VIEW view_sa AS
SELECT EmployeeID,Name,Tel,Email,GroupName FROM Employee AS a JOIN Groups AS b ON a.EmployeeID = b.LeaderID
--7b
CREATE VIEW view_dd AS
SELECT Name,ProjectName,GroupName FROM Employee AS a JOIN Groups AS b ON a.EmployeeID = b.LeaderID
													JOIN Project AS c ON c.ProjectID = b.ProjectID

