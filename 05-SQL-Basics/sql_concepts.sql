-- =====================================
-- DATABASE CREATION
-- =====================================
CREATE DATABASE CollegeDB;
USE CollegeDB;

-- =====================================
-- DDL COMMANDS
-- =====================================
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

-- =====================================
-- INSERT (DML)
-- =====================================
INSERT INTO Students VALUES (1, 'Rahul', 22, 'Mumbai');
INSERT INTO Students VALUES (2, 'Priya', 23, 'Delhi');
INSERT INTO Students VALUES (3, 'Amit', 21, 'Pune');

INSERT INTO Courses VALUES (101, 'SQL');
INSERT INTO Courses VALUES (102, 'DBMS');

-- =====================================
-- SELECT
-- =====================================
SELECT * FROM Students;

-- DISTINCT
SELECT DISTINCT City FROM Students;

-- WHERE
SELECT * FROM Students WHERE Age > 21;

-- AND / OR
SELECT * FROM Students WHERE City = 'Mumbai' AND Age > 20;

-- LIKE
SELECT * FROM Students WHERE Name LIKE 'A%';

-- BETWEEN
SELECT * FROM Students WHERE Age BETWEEN 20 AND 25;

-- IN
SELECT * FROM Students WHERE City IN ('Mumbai', 'Delhi');

-- =====================================
-- ORDER BY
-- =====================================
SELECT * FROM Students ORDER BY Age DESC;

-- =====================================
-- UPDATE
-- =====================================
UPDATE Students
SET Age = 24
WHERE StudentID = 1;

-- =====================================
-- DELETE
-- =====================================
DELETE FROM Students
WHERE StudentID = 3;

-- =====================================
-- AGGREGATE FUNCTIONS
-- =====================================
SELECT COUNT(*) FROM Students;
SELECT AVG(Age) FROM Students;
SELECT MAX(Age) FROM Students;
SELECT MIN(Age) FROM Students;

-- =====================================
-- GROUP BY + HAVING
-- =====================================
SELECT City, COUNT(*) AS Total
FROM Students
GROUP BY City;

SELECT City, COUNT(*) AS Total
FROM Students
GROUP BY City
HAVING COUNT(*) > 1;

-- =====================================
-- JOINS
-- =====================================
CREATE TABLE Enrollment (
    StudentID INT,
    CourseID INT,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- INNER JOIN
SELECT s.Name, c.CourseName
FROM Students s
INNER JOIN Enrollment e ON s.StudentID = e.StudentID
INNER JOIN Courses c ON e.CourseID = c.CourseID;

-- LEFT JOIN
SELECT s.Name, c.CourseName
FROM Students s
LEFT JOIN Enrollment e ON s.StudentID = e.StudentID
LEFT JOIN Courses c ON e.CourseID = c.CourseID;

-- =====================================
-- SUBQUERY
-- =====================================
SELECT Name
FROM Students
WHERE Age > (SELECT AVG(Age) FROM Students);

-- =====================================
-- ALTER TABLE
-- =====================================
ALTER TABLE Students ADD Email VARCHAR(100);

-- =====================================
-- DROP TABLE
-- =====================================
-- DROP TABLE Students;
