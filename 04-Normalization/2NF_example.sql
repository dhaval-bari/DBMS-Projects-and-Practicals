-- BEFORE (Not in 2NF)
-- Enrollment(StudentID, CourseID, StudentName)

-- StudentName depends only on StudentID ❌

-- AFTER (2NF)

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100)
);

CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100)
);

CREATE TABLE Enrollment (
    StudentID INT,
    CourseID INT,
    PRIMARY KEY (StudentID, CourseID)
);
