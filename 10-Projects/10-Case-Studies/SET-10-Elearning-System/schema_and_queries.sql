-- SET 10 – E-Learning Platform

-- Scenario: Manage online courses, instructors, and enrollments.

-- Create Database
CREATE DATABASE ElearningDB;
USE ElearningDB;


-- Tables & Attributes: 
-- 1. Courses (CourseID, Title, Category, DurationWeeks, Price) 
-- 2. Instructors (InstructorID, Name, Email, Specialty) 
-- 3. Students (StudentID, Name, Email, City) 
-- 4. Enrollments (EnrollmentID, StudentID, CourseID, EnrollDate, Status) 
-- 5. Assignments (AssignmentID, CourseID, Title, DueDate, MaxMarks)

--------------------------------------------------
-- TABLE CREATION
--------------------------------------------------

-- 1. Courses
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    Title VARCHAR(150),
    Category VARCHAR(100),
    DurationWeeks INT,
    Price DECIMAL(10,2)
);

-- 2. Instructors
CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Specialty VARCHAR(100)
);

-- 3. Students
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    City VARCHAR(50)
);

-- 4. Enrollments
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    EnrollDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- 5. Assignments
CREATE TABLE Assignments (
    AssignmentID INT PRIMARY KEY,
    CourseID INT,
    Title VARCHAR(150),
    DueDate DATE,
    MaxMarks INT,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- EXTRA: Course-Instructor mapping
CREATE TABLE CourseInstructor (
    CIID INT PRIMARY KEY,
    CourseID INT,
    InstructorID INT,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID)
);

-- EXTRA: Assignment submissions (for marks & late submission queries)
CREATE TABLE Submissions (
    SubmissionID INT PRIMARY KEY,
    AssignmentID INT,
    StudentID INT,
    Marks INT,
    SubmissionDate DATE,
    FOREIGN KEY (AssignmentID) REFERENCES Assignments(AssignmentID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);

--------------------------------------------------
-- INSERT DATA
--------------------------------------------------

-- Courses
INSERT INTO Courses VALUES
(1, 'Data Science Bootcamp', 'Data Science', 10, 10000),
(2, 'Python Basics', 'Programming', 6, 3000),
(3, 'AI Fundamentals', 'AI', 8, 7000),
(4, 'Web Development', 'Programming', 12, 9000),
(5, 'Machine Learning', 'Data Science', 10, 12000);

-- Instructors
INSERT INTO Instructors VALUES
(1, 'Dr. Sharma', 'sharma@gmail.com', 'Python'),
(2, 'Dr. Rao', 'rao@gmail.com', 'AI'),
(3, 'Ms. Patel', 'patel@gmail.com', 'Web'),
(4, 'Mr. Khan', 'khan@gmail.com', 'Data Science'),
(5, 'Ms. Iyer', 'iyer@gmail.com', 'ML');

-- Students
INSERT INTO Students VALUES
(1, 'Rahul', 'rahul@gmail.com', 'Mumbai'),
(2, 'Priya', 'priya@gmail.com', 'Delhi'),
(3, 'Amit', 'amit@gmail.com', 'Mumbai'),
(4, 'Neha', 'neha@gmail.com', 'Pune'),
(5, 'Karan', 'karan@gmail.com', 'Mumbai');

-- Enrollments
INSERT INTO Enrollments VALUES
(1, 1, 1, CURDATE() - INTERVAL 10 DAY, 'Active'),
(2, 2, 2, CURDATE() - INTERVAL 20 DAY, 'Completed'),
(3, 3, 3, CURDATE() - INTERVAL 5 DAY, 'Active'),
(4, 1, 2, CURDATE() - INTERVAL 2 DAY, 'Active'),
(5, 1, 3, CURDATE(), 'Active');

-- Assignments
INSERT INTO Assignments VALUES
(1, 1, 'Project 1', CURDATE() + INTERVAL 5 DAY, 100),
(2, 2, 'Python Quiz', CURDATE() + INTERVAL 3 DAY, 50),
(3, 3, 'AI Assignment', CURDATE() + INTERVAL 7 DAY, 100),
(4, 4, 'Website Build', CURDATE() + INTERVAL 10 DAY, 100),
(5, 5, 'ML Project', CURDATE() + INTERVAL 8 DAY, 100);

-- CourseInstructor
INSERT INTO CourseInstructor VALUES
(1, 1, 4),
(2, 2, 1),
(3, 3, 2),
(4, 4, 3),
(5, 5, 5);

-- Submissions
INSERT INTO Submissions VALUES
(1, 1, 1, 85, CURDATE()),
(2, 2, 2, 40, CURDATE()),
(3, 3, 3, 90, CURDATE()),
(4, 1, 3, 70, CURDATE() + INTERVAL 6 DAY), -- late
(5, 2, 1, 45, CURDATE());

--------------------------------------------------
-- QUERIES
--------------------------------------------------

-- 1 List courses in 'Data Science' category. 
SELECT * FROM Courses WHERE Category = 'Data Science';

-- 2 Show instructors specializing in 'Python'.
SELECT * FROM Instructors WHERE Specialty = 'Python';

-- 3 Find students from 'Mumbai'.
SELECT * FROM Students WHERE City = 'Mumbai';

-- 4 List enrollments in the last month.
SELECT * FROM Enrollments
WHERE EnrollDate >= CURDATE() - INTERVAL 1 MONTH;

-- 5 Show courses with duration more than 8 weeks.
SELECT * FROM Courses WHERE DurationWeeks > 8;

-- 6 Find top 3 most expensive courses.
SELECT * FROM Courses ORDER BY Price DESC LIMIT 3;

-- 7 Show students enrolled in a given course.
SELECT S.*
FROM Students S
JOIN Enrollments E ON S.StudentID = E.StudentID
WHERE E.CourseID = 1;

-- 8 List instructors teaching multiple courses.
SELECT InstructorID, COUNT(*) AS CoursesTaught
FROM CourseInstructor
GROUP BY InstructorID
HAVING COUNT(*) > 1;

-- 9 Show assignments with due date in next week.
SELECT * FROM Assignments
WHERE DueDate BETWEEN CURDATE() AND CURDATE() + INTERVAL 7 DAY;

-- 10 Find students who completed all assignments in a course.
SELECT StudentID
FROM Submissions
GROUP BY StudentID
HAVING COUNT(DISTINCT AssignmentID) = (SELECT COUNT(*) FROM Assignments WHERE CourseID = 1);

-- 11 Show average marks per course.
SELECT A.CourseID, AVG(S.Marks) AS AvgMarks
FROM Submissions S
JOIN Assignments A ON S.AssignmentID = A.AssignmentID
GROUP BY A.CourseID;

-- 12 Find students without enrollments.
SELECT * FROM Students
WHERE StudentID NOT IN (SELECT StudentID FROM Enrollments);

-- 13 Show total enrollments per course.
SELECT CourseID, COUNT(*) AS TotalEnrollments
FROM Enrollments
GROUP BY CourseID;

-- 14 Display instructors with no courses assigned. 
SELECT I.*
FROM Instructors I
LEFT JOIN CourseInstructor CI ON I.InstructorID = CI.InstructorID
WHERE CI.CourseID IS NULL;

-- 15 Show students with more than 3 enrollments.
SELECT StudentID, COUNT(*) AS TotalEnrollments
FROM Enrollments
GROUP BY StudentID
HAVING COUNT(*) > 3;

-- 16 Find courses with no students.
SELECT C.*
FROM Courses C
LEFT JOIN Enrollments E ON C.CourseID = E.CourseID
WHERE E.EnrollmentID IS NULL;

-- 17 Show most popular course.
SELECT CourseID, COUNT(*) AS Popularity
FROM Enrollments
GROUP BY CourseID
ORDER BY Popularity DESC
LIMIT 1;

-- 18 List assignments per course.
SELECT CourseID, COUNT(*) AS Assignments
FROM Assignments
GROUP BY CourseID;

-- 19 Show students who submitted assignments late.
SELECT S.*
FROM Submissions S
JOIN Assignments A ON S.AssignmentID = A.AssignmentID
WHERE S.SubmissionDate > A.DueDate;

-- 20 Display courses and their instructor names.
SELECT C.Title, I.Name
FROM Courses C
JOIN CourseInstructor CI ON C.CourseID = CI.CourseID
JOIN Instructors I ON CI.InstructorID = I.InstructorID;

-- 21 Find courses under 5000 in price.
SELECT * FROM Courses WHERE Price < 5000;

-- 22 Show courses with 'AI' in the title.
SELECT * FROM Courses WHERE Title LIKE '%AI%';

-- 23 Find students who enrolled in multiple categories. 
SELECT StudentID, COUNT(DISTINCT Category) AS Categories
FROM Enrollments E
JOIN Courses C ON E.CourseID = C.CourseID
GROUP BY StudentID
HAVING COUNT(DISTINCT Category) > 1;

-- 24 Show monthly enrollment counts. 
SELECT MONTH(EnrollDate) AS Month, COUNT(*) AS Total
FROM Enrollments
GROUP BY MONTH(EnrollDate);

-- 25 Find instructors teaching courses in multiple categories.
SELECT InstructorID, COUNT(DISTINCT C.Category) AS Categories
FROM CourseInstructor CI
JOIN Courses C ON CI.CourseID = C.CourseID
GROUP BY InstructorID
HAVING COUNT(DISTINCT C.Category) > 1;