CREATE DATABASE CodeLean

USE CodeLean

CREATE TABLE Classes(
ClassName char(6),
Teacher varchar(30),
TimeSlot varchar(30),
Class int,
Lab int
)
--2
CREATE UNIQUE CLUSTERED INDEX MyClusteredIndex ON Classes(ClassName);
--3
CREATE NONCLUSTERED INDEX TeacherIndex ON Classes(Teacher);
--4
drop index TeacherIndex ON Classes;
--5
CREATE INDEX ClassLabIndex ON Classes(Class,Lab);
--6
EXECUTE sp_helpindex Classes;
select * from sys.indexes CodeLean



