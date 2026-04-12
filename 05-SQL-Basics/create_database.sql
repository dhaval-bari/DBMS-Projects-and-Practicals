-- Create Database
CREATE DATABASE CollegeDataBase;

-- Use Database
USE CollegeDataBase;

-- Create Table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Course VARCHAR(50)
);

-- Insert Data
INSERT INTO Students VALUES
(1, 'Rahul', 21, 'FinTech'),
(2, 'Priya', 22, 'Marketing'),
(3, 'Amit', 23, 'Finance');

-- View Data
SELECT * FROM Students;