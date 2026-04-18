CREATE DATABASE UniversityDB;
USE UniversityDB;

-- DEPARTMENT
CREATE TABLE DEPARTMENT (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(100),
    Location VARCHAR(100),
    ManagerEmpID INT
);

-- INSTRUCTOR
CREATE TABLE INSTRUCTOR (
    EmpID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Title VARCHAR(50),
    Salary DECIMAL(10,2),
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES DEPARTMENT(DeptID)
);

-- COURSE
CREATE TABLE COURSE (
    CourseCode VARCHAR(10) PRIMARY KEY,
    Title VARCHAR(100),
    Credits INT,
    Description TEXT,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES DEPARTMENT(DeptID)
);

-- SECTION (Weak Entity)
CREATE TABLE SECTION (
    CourseCode VARCHAR(10),
    SectionNo INT,
    Semester VARCHAR(20),
    Year INT,
    Time VARCHAR(20),
    Room VARCHAR(20),
    EmpID INT,
    PRIMARY KEY (CourseCode, SectionNo),
    FOREIGN KEY (CourseCode) REFERENCES COURSE(CourseCode),
    FOREIGN KEY (EmpID) REFERENCES INSTRUCTOR(EmpID)
);

-- STUDENT
CREATE TABLE STUDENT (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DOB DATE,
    Gender VARCHAR(10),
    GPA DECIMAL(3,2)
);

-- STUDENT_EMAIL (Multivalued Attribute)
CREATE TABLE STUDENT_EMAIL (
    StudentID INT,
    Email VARCHAR(100),
    PRIMARY KEY (StudentID, Email),
    FOREIGN KEY (StudentID) REFERENCES STUDENT(StudentID)
);

-- INSTRUCTOR_PHONE (Multivalued Attribute)
CREATE TABLE INSTRUCTOR_PHONE (
    EmpID INT,
    PhoneNo VARCHAR(15),
    PRIMARY KEY (EmpID, PhoneNo),
    FOREIGN KEY (EmpID) REFERENCES INSTRUCTOR(EmpID)
);

-- ENROLLMENT (M:N Relationship)
CREATE TABLE ENROLLMENT (
    StudentID INT,
    CourseCode VARCHAR(10),
    SectionNo INT,
    Grade VARCHAR(5),
    PRIMARY KEY (StudentID, CourseCode, SectionNo),
    FOREIGN KEY (StudentID) REFERENCES STUDENT(StudentID),
    FOREIGN KEY (CourseCode, SectionNo) REFERENCES SECTION(CourseCode, SectionNo)
);

SHOW TABLES;

-- 1. Find all students enrolled in a specific course (CS101)
SELECT s.FirstName, s.LastName, e.Grade
FROM STUDENT s
JOIN ENROLLMENT e ON s.StudentID = e.StudentID
WHERE e.CourseCode = 'CS101';

-- 2. Find instructors who teach more than 3 sections
SELECT i.FirstName, i.LastName, COUNT(*) AS SectionsCount
FROM INSTRUCTOR i
JOIN SECTION s ON i.EmpID = s.EmpID
GROUP BY i.EmpID
HAVING COUNT(*) > 3;

-- 3. Average GPA per department
SELECT d.DeptName, AVG(s.GPA) AS AvgGPA
FROM DEPARTMENT d
JOIN COURSE c ON d.DeptID = c.DeptID
JOIN ENROLLMENT e ON c.CourseCode = e.CourseCode
JOIN STUDENT s ON e.StudentID = s.StudentID
GROUP BY d.DeptID
ORDER BY AvgGPA DESC;

-- 4. List all courses offered by each department
SELECT d.DeptName, c.Title
FROM DEPARTMENT d
JOIN COURSE c ON d.DeptID = c.DeptID;

-- 5. Find students with GPA above average
SELECT FirstName, LastName, GPA
FROM STUDENT
WHERE GPA > (SELECT AVG(GPA) FROM STUDENT);

-- 6. Count number of students per course
SELECT c.Title, COUNT(e.StudentID) AS TotalStudents
FROM COURSE c
LEFT JOIN ENROLLMENT e ON c.CourseCode = e.CourseCode
GROUP BY c.CourseCode;

--
