/* create database and table */

create database College;

use college;

create table Student
(Student_Id varchar(10), Name varchar(30), Age int, Course varchar(30), Academic_level varchar(10));
insert into student values ('CSE-01', 'Farhan', 23,'Programming', 'BSc'),
	('CSE-02', 'Tamjid', 24,'Database', 'MSc'),
	('CSE-03', 'Shopnil', 22, 'Data Analyst', 'BSc'),
    ('EEE-01', 'Shahid',22, 'Circuit', 'BSc'),
    ('EEE-02', 'Karim', 21, 'System Design', 'MSc'),
    ('EEE-03', 'Shawon',23 , 'Electrical Engineering', 'BSc'),
    ('CE-01', 'Raihan', 24, 'Structure Design', 'BSc'),
    ('CE-02', 'Real', 20, 'Software Engineering', 'BSc'),
    ('CE-03', 'Pantho', 25, 'Application Enginnerig', 'BSc'),
    ('CE-04', 'Rana', 23, 'System Analyst', 'MSc');
    
select * from student;
describe student;

create table Teacher
(Teacher_Id varchar(10), Name varchar(30), Designation varchar(30));
insert into Teacher values ('TCSE-01', 'Farhan','Lecturer'),
	('TCSE-02', 'Tamjid','Assistant Professor'),
	('TCSE-03', 'Robin','Assistant Professor'),
    ('TEEE-01', 'Shahid', 'Assistant Professor'),
    ('TEEE-02', 'Karim','Professor'),
    ('TEEE-03', 'Shawontona', 'Professor'),
    ('TCE-01', 'Raihan', 'Professor'),
    ('TCE-02', 'Rahim', 'Lecturer'),
    ('TCE-03', 'Raju', 'Assistant Professor'),
    ('TCE-04', 'Raiysa', 'Lecturer');
    
select * from Teacher;
describe Teacher;

create table Department
(Department_Id varchar(10), Department_Name varchar(30), Student_Id varchar(10), Teacher_Id varchar(10));
insert into Department values ('D-01', 'CSE','CSE-01', 'TCSE-01'),
	('D-01', 'CSE','CSE-02', 'TCSE-02'),
	('D-01', 'CSE', 'CSE-03', 'TCSE-03'),
    ('D-02', 'EEE', 'EEE-01', 'TEEE-01'),
    ('D-02', 'EEE', 'EEE-02', 'TEEE-02'),
    ('D-02', 'EEE', 'EEE-03', 'TEEE-03'),
    ('D-03', 'CE', 'CE-01', 'TCE-01'),
    ('D-03', 'CE', 'CE-02', 'TCE-02'),
    ('D-03', 'CE', 'CE-03', 'TCE-03'),
    ('D-03', 'CE', 'CE-04', 'TCE-04');
    
select * from Department;
describe Department;

-- Add Foreign Key Constraint for Student to Department
ALTER TABLE Student
ADD CONSTRAINT fk_Student_Department
FOREIGN KEY (Student_Id)
REFERENCES Department(Student_Id)
ON DELETE CASCADE;

-- Add Foreign Key Constraint for Teacher to Department
ALTER TABLE Teacher
ADD CONSTRAINT fk_Teacher_Department
FOREIGN KEY (Teacher_Id)
REFERENCES Department(Teacher_Id)
ON DELETE CASCADE;

/* Write the query to return all student that age more than 22. */

SELECT *
FROM Student
WHERE Age > 22;

/* Write the query to return the teacher’s ID, designation that teacher’s designation are maximum
in the database. */

SELECT Teacher_Id, Designation
FROM Teacher
WHERE Designation = (
    SELECT MAX(Designation) 
    FROM Teacher
);

/* Write the query to return the teacher’s designation that teacher’s name second character is ‘T’ */

SELECT Designation
FROM Teacher
WHERE Name LIKE '_T%';

/* Write the query to return the DepartmentName, student Age where average age of student 
more than or equal 22 in descending order. */

SELECT d.Department_Name, AVG(s.Age) AS Average_Age
FROM Department d
JOIN Student s ON d.Student_Id = s.Student_Id
GROUP BY d.Department_Name
HAVING AVG(s.Age) >= 22
ORDER BY AVG(s.Age) DESC;

/* Find the Second Highest Student age of all department. */

SELECT MAX(Age) AS Second_Highest_Age
FROM Student
WHERE Age < (
    SELECT MAX(Age)
    FROM Student
    WHERE Age NOT IN (
        SELECT MAX(Age)
        FROM Student
    )
);