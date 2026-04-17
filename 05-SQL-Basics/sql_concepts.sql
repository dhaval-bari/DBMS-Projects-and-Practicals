-- ===============================
-- DATABASE CREATION
-- ===============================
CREATE DATABASE CollegeDB;
USE CollegeDB;

-- ===============================
-- DDL COMMANDS
-- ===============================
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Age INT,
    City VARCHAR(50)
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100)
);

-- ===============================
-- DML COMMANDS
-- ===============================
INSERT INTO Students VALUES (1, 'Rahul', 22, 'Mumbai');
INSERT INTO Students VALUES (2, 'Priya', 23, 'Delhi');

INSERT INTO Courses VALUES (101, 'SQL');
INSERT INTO Courses VALUES (102, 'DBMS');

-- ===============================
-- SELECT + WHERE
-- ===============================
SELECT * FROM Students;

SELECT * FROM Students
WHERE City = 'Mumbai';

-- ===============================
-- ORDER BY
-- ===============================
SELECT * FROM Students
ORDER BY Age DESC;

-- ===============================
-- AGGREGATE FUNCTIONS
-- ===============================
SELECT COUNT(*) FROM Students;
SELECT AVG(Age) FROM Students;

-- ===============================
-- GROUP BY + HAVING
-- ===============================
SELECT City, COUNT(*) AS TotalStudents
FROM Students
GROUP BY City
HAVING COUNT(*) > 0;

-- ===============================
-- JOINS
-- ===============================
CREATE TABLE Enrollment (
    StudentID INT,
    CourseID INT,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

SELECT s.Name, c.CourseName
FROM Students s
INNER JOIN Enrollment e ON s.StudentID = e.StudentID
INNER JOIN Courses c ON e.CourseID = c.CourseID;

-- ===============================
-- SUBQUERY
-- ===============================
SELECT Name
FROM Students
WHERE Age > (SELECT AVG(Age) FROM Students);

-- ===============================
-- UPDATE
-- ===============================
UPDATE Students
SET Age = 24
WHERE StudentID = 1;

-- ===============================
-- DELETE
-- ===============================
DELETE FROM Students
WHERE StudentID = 2;
