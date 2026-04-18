-- SET 3 – University Management System

-- Scenario: Manage student and faculty data.

-- Create Database
CREATE DATABASE UniversityDB;
USE UniversityDB;


-- Tables & Attributes: 
-- 1. Students (StudentID, Name, DOB, Gender, DeptID, Email) 
-- 2. Departments (DeptID, DeptName, HOD) 
-- 3. Courses (CourseID, CourseName, DeptID, Credits) 
-- 4. Faculty (FacultyID, Name, DeptID, Email) 
-- 5. Enrollments (EnrollmentID, StudentID, CourseID, Semester, Grade) 

--------------------------------------------------
-- TABLE CREATION
--------------------------------------------------

-- 1. Departments
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(100),
    HOD VARCHAR(100)
);

-- 2. Students
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100),
    DOB DATE,
    Gender VARCHAR(10),
    DeptID INT,
    Email VARCHAR(100),
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

-- 3. Courses
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    DeptID INT,
    Credits INT,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

-- 4. Faculty
CREATE TABLE Faculty (
    FacultyID INT PRIMARY KEY,
    Name VARCHAR(100),
    DeptID INT,
    Email VARCHAR(100),
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

-- 5. Enrollments
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    Semester VARCHAR(20),
    Grade DECIMAL(4,2),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- EXTRA TABLE (for Query 7: courses taught by faculty)
CREATE TABLE CourseFaculty (
    CFID INT PRIMARY KEY,
    CourseID INT,
    FacultyID INT,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    FOREIGN KEY (FacultyID) REFERENCES Faculty(FacultyID)
);

--------------------------------------------------
-- INSERT DATA
--------------------------------------------------

-- Departments
INSERT INTO Departments VALUES
(1, 'Computer Science', 'Dr. Sharma'),
(2, 'Physics', 'Dr. Rao'),
(3, 'Mathematics', 'Dr. Iyer'),
(4, 'Commerce', 'Dr. Mehta'),
(5, 'Electronics', 'Dr. Patel');

-- Students
INSERT INTO Students VALUES
(1, 'Sahil Khan', '2002-05-10', 'Male', 1, 'sahil@gmail.com'),
(2, 'Anita Desai', '1999-08-15', 'Female', 2, 'anita@gmail.com'),
(3, 'Suresh Patel', '2001-03-20', 'Male', 3, 'suresh@gmail.com'),
(4, 'Riya Sharma', '2003-11-25', 'Female', 1, 'riya@gmail.com'),
(5, 'Karan Singh', '1998-01-01', 'Male', 4, 'karan@gmail.com');

-- Courses
INSERT INTO Courses VALUES
(1, 'Database Systems', 1, 4),
(2, 'Quantum Physics', 2, 5),
(3, 'Linear Algebra', 3, 3),
(4, 'Accounting Basics', 4, 2),
(5, 'Digital Electronics', 5, 4);

-- Faculty
INSERT INTO Faculty VALUES
(1, 'Dr. Verma', 1, 'verma@gmail.com'),
(2, 'Dr. Rao', 2, 'rao@gmail.com'),
(3, 'Dr. Iyer', 3, 'iyer@gmail.com'),
(4, 'Dr. Shah', 4, 'shah@gmail.com'),
(5, 'Dr. Patel', 5, 'patel@gmail.com');

-- CourseFaculty
INSERT INTO CourseFaculty VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);

-- Enrollments
INSERT INTO Enrollments VALUES
(1, 1, 1, 'Sem1', 8.5),
(2, 1, 2, 'Sem1', 7.0),
(3, 2, 2, 'Sem1', 6.5),
(4, 3, 3, 'Sem1', 9.0),
(5, 4, 1, 'Sem1', 8.0),
(6, 1, 3, 'Sem2', 7.5),
(7, 1, 4, 'Sem2', 6.0),
(8, 1, 5, 'Sem2', 5.0);

--------------------------------------------------
-- QUERIES
--------------------------------------------------

-- 1 List students in 'Computer Science' department.
SELECT S.* FROM Students S
JOIN Departments D ON S.DeptID = D.DeptID
WHERE D.DeptName = 'Computer Science';

-- 2 Show courses with more than 3 credits.
SELECT * FROM Courses WHERE Credits > 3;

-- 3 Find students born after 2000.
SELECT * FROM Students WHERE DOB > '2000-01-01';

-- 4 Show average grade per course.
SELECT CourseID, AVG(Grade) AS AvgGrade
FROM Enrollments
GROUP BY CourseID;

-- 5 List faculty members in 'Physics' department.
SELECT F.* FROM Faculty F
JOIN Departments D ON F.DeptID = D.DeptID
WHERE D.DeptName = 'Physics';

-- 6 Count total students per department.
SELECT D.DeptName, COUNT(S.StudentID) AS TotalStudents
FROM Departments D
LEFT JOIN Students S ON D.DeptID = S.DeptID
GROUP BY D.DeptName;

-- 7 Show courses taught by a given faculty.
SELECT C.CourseName
FROM Courses C
JOIN CourseFaculty CF ON C.CourseID = CF.CourseID
WHERE CF.FacultyID = 1;

-- 8 List students with no enrollments.
SELECT * FROM Students
WHERE StudentID NOT IN (SELECT StudentID FROM Enrollments);

-- 9 Show top 3 scorers in a course.
SELECT StudentID, Grade
FROM Enrollments
WHERE CourseID = 1
ORDER BY Grade DESC
LIMIT 3;

-- 10 Display students enrolled in more than 4 courses.
SELECT StudentID, COUNT(*) AS TotalCourses
FROM Enrollments
GROUP BY StudentID
HAVING COUNT(*) > 4;

-- 11 Find courses with no enrollments.
SELECT C.CourseName
FROM Courses C
LEFT JOIN Enrollments E ON C.CourseID = E.CourseID
WHERE E.EnrollmentID IS NULL;

-- 12 Show department names with total faculty.
SELECT D.DeptName, COUNT(F.FacultyID) AS TotalFaculty
FROM Departments D
LEFT JOIN Faculty F ON D.DeptID = F.DeptID
GROUP BY D.DeptName;

-- 13 List all courses taken by a specific student.
SELECT C.CourseName
FROM Courses C
JOIN Enrollments E ON C.CourseID = E.CourseID
WHERE E.StudentID = 1;

-- 14 Find students whose name starts with 'S'.
SELECT * FROM Students WHERE Name LIKE 'S%';

-- 15 Show the youngest student.
SELECT * FROM Students
ORDER BY DOB DESC LIMIT 1;

-- 16 List students and their average grade.
SELECT S.Name, AVG(E.Grade) AS AvgGrade
FROM Students S
JOIN Enrollments E ON S.StudentID = E.StudentID
GROUP BY S.Name;

-- 17 Find departments without students.
SELECT D.DeptName
FROM Departments D
LEFT JOIN Students S ON D.DeptID = S.DeptID
WHERE S.StudentID IS NULL;

-- 18 Show faculty email addresses.
SELECT Email FROM Faculty;

-- 19 List students enrolled in 'Mathematics' course.
SELECT S.Name
FROM Students S
JOIN Enrollments E ON S.StudentID = E.StudentID
JOIN Courses C ON E.CourseID = C.CourseID
WHERE C.CourseName = 'Linear Algebra';

-- 20 Show total credits taken by each student.
SELECT E.StudentID, SUM(C.Credits) AS TotalCredits
FROM Enrollments E
JOIN Courses C ON E.CourseID = C.CourseID
GROUP BY E.StudentID;

-- 21 Find students with failing grades.
SELECT * FROM Enrollments WHERE Grade < 5;

-- 22 List courses with maximum students.
SELECT CourseID, COUNT(StudentID) AS TotalStudents
FROM Enrollments
GROUP BY CourseID
ORDER BY TotalStudents DESC;

-- 23 Show grade distribution per course.
SELECT CourseID, Grade, COUNT(*) AS Count
FROM Enrollments
GROUP BY CourseID, Grade;

-- 24 Display students and their department names.
SELECT S.Name, D.DeptName
FROM Students S
JOIN Departments D ON S.DeptID = D.DeptID;

-- 25 Find the oldest faculty member. 
SELECT * FROM Faculty
ORDER BY FacultyID ASC LIMIT 1;