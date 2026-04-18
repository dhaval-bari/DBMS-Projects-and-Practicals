-- SET 2 – Hospital Management System

-- Scenario: Create a database for hospital operations.

-- Create Database
CREATE DATABASE HospitalDB;
USE HospitalDB;


-- Tables & Attributes: 
-- 1. Doctors (DoctorID, Name, Specialization, Phone, JoiningDate) 
-- 2. Patients (PatientID, Name, DOB, Gender, Phone) 
-- 3. Appointments (AppointmentID, PatientID, DoctorID, Date, Time, Status) 
-- 4. Departments (DeptID, DeptName, Location) 
-- 5. Bills (BillID, PatientID, Amount, BillDate, PaymentStatus)

--------------------------------------------------
-- TABLE CREATION
--------------------------------------------------

-- 1. Departments
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(100),
    Location VARCHAR(100)
);

-- 2. Doctors
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY,
    Name VARCHAR(100),
    Specialization VARCHAR(100),
    Phone VARCHAR(15),
    JoiningDate DATE,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

-- 3. Patients
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    Name VARCHAR(100),
    DOB DATE,
    Gender VARCHAR(10),
    Phone VARCHAR(15)
);

-- 4. Appointments
CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    Date DATE,
    Time TIME,
    Status VARCHAR(50),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- 5. Bills
CREATE TABLE Bills (
    BillID INT PRIMARY KEY,
    PatientID INT,
    Amount DECIMAL(10,2),
    BillDate DATE,
    PaymentStatus VARCHAR(50),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

--------------------------------------------------
-- INSERT DATA
--------------------------------------------------

-- Departments
INSERT INTO Departments VALUES
(1, 'Cardiology', 'Block A'),
(2, 'Neurology', 'Block B'),
(3, 'Orthopedics', 'Block C'),
(4, 'Pediatrics', 'Block D'),
(5, 'General', 'Block E');

-- Doctors
INSERT INTO Doctors VALUES
(1, 'Dr. Mehta', 'Cardiology', '9876543210', '2019-06-10', 1),
(2, 'Dr. Shah', 'Neurology', '9812345678', '2021-03-15', 2),
(3, 'Dr. Patel', 'Orthopedics', '9823456789', '2018-07-20', 3),
(4, 'Dr. Rao', 'Cardiology', '9898989898', '2022-01-10', 1),
(5, 'Dr. Iyer', 'General', '9712345678', '2023-05-12', 5);

-- Patients
INSERT INTO Patients VALUES
(1, 'Amit Sharma', '1955-05-10', 'Male', '9000000001'),
(2, 'Anita Desai', '1995-08-15', 'Female', '9000000002'),
(3, 'Rohit Verma', '1980-02-20', 'Male', '9000000003'),
(4, 'Ayesha Khan', '2000-11-25', 'Female', '9000000004'),
(5, 'Karan Singh', '1960-01-01', 'Male', '9000000005');

-- Appointments
INSERT INTO Appointments VALUES
(1, 1, 1, CURDATE(), '10:00:00', 'Completed'),
(2, 2, 2, CURDATE(), '11:00:00', 'Cancelled'),
(3, 3, 1, CURDATE() - INTERVAL 2 DAY, '09:30:00', 'Completed'),
(4, 1, 1, CURDATE() - INTERVAL 5 DAY, '10:30:00', 'Completed'),
(5, 1, 1, CURDATE() - INTERVAL 7 DAY, '11:30:00', 'Completed'),
(6, 1, 1, CURDATE() - INTERVAL 9 DAY, '12:30:00', 'Completed');

-- Bills
INSERT INTO Bills VALUES
(1, 1, 6000, CURDATE(), 'Paid'),
(2, 2, 3000, CURDATE(), 'Unpaid'),
(3, 3, 8000, CURDATE(), 'Paid'),
(4, 4, 2000, CURDATE(), 'Unpaid'),
(5, 5, 10000, CURDATE(), 'Paid');

--------------------------------------------------
-- QUERIES
--------------------------------------------------

-- 1 List doctors with specialization 'Cardiology'.
SELECT * FROM Doctors WHERE Specialization = 'Cardiology';

-- 2 Show all patients above 60 years old.
SELECT * FROM Patients
WHERE TIMESTAMPDIFF(YEAR, DOB, CURDATE()) > 60;

-- 3 Find appointments scheduled for today. 
SELECT * FROM Appointments WHERE Date = CURDATE();

-- 4 Count total patients per department. 
SELECT D.DeptName, COUNT(P.PatientID) AS TotalPatients
FROM Departments D
LEFT JOIN Doctors Doc ON D.DeptID = Doc.DeptID
LEFT JOIN Appointments A ON Doc.DoctorID = A.DoctorID
LEFT JOIN Patients P ON A.PatientID = P.PatientID
GROUP BY D.DeptName;

-- 5 Show patients assigned to a specific doctor.
SELECT P.* FROM Patients P
JOIN Appointments A ON P.PatientID = A.PatientID
WHERE A.DoctorID = 1;

-- 6 List bills with amount greater than 5000.
SELECT * FROM Bills WHERE Amount > 5000;

-- 7 Display unpaid bills.
SELECT * FROM Bills WHERE PaymentStatus = 'Unpaid';

-- 8 Show the doctor with the maximum appointments.
SELECT DoctorID, COUNT(*) AS TotalAppointments
FROM Appointments
GROUP BY DoctorID
ORDER BY TotalAppointments DESC
LIMIT 1;

-- 9 List patients without appointments.
SELECT * FROM Patients
WHERE PatientID NOT IN (SELECT PatientID FROM Appointments);

-- 10 Find oldest patient.
SELECT * FROM Patients
ORDER BY DOB ASC LIMIT 1;

-- 11 Show average bill amount per department. 
SELECT D.DeptName, AVG(B.Amount) AS AvgBill
FROM Bills B
JOIN Patients P ON B.PatientID = P.PatientID
JOIN Appointments A ON P.PatientID = A.PatientID
JOIN Doctors Doc ON A.DoctorID = Doc.DoctorID
JOIN Departments D ON Doc.DeptID = D.DeptID
GROUP BY D.DeptName;

-- 12 List doctors joined after 2020. 
SELECT * FROM Doctors WHERE JoiningDate > '2020-01-01';

-- 13 Find patients whose name starts with 'A'. 
SELECT * FROM Patients WHERE Name LIKE 'A%';

-- 14 Show all cancelled appointments. 
SELECT * FROM Appointments WHERE Status = 'Cancelled';

-- 15 Count appointments per day.
SELECT Date, COUNT(*) AS TotalAppointments
FROM Appointments
GROUP BY Date;

-- 16 Find patients who visited more than 3 times.
SELECT PatientID, COUNT(*) AS Visits
FROM Appointments
GROUP BY PatientID
HAVING COUNT(*) > 3;

-- 17 Show department names with their doctors. 
SELECT D.DeptName, Doc.Name
FROM Departments D
JOIN Doctors Doc ON D.DeptID = Doc.DeptID;

-- 18 Find doctors working in 'Neurology'. 
SELECT * FROM Doctors WHERE Specialization = 'Neurology';

-- 19 Display total bills for each patient. 
SELECT PatientID, SUM(Amount) AS TotalBills
FROM Bills
GROUP BY PatientID;

-- 20 Show top 5 highest billing patients. 
SELECT PatientID, SUM(Amount) AS TotalBills
FROM Bills
GROUP BY PatientID
ORDER BY TotalBills DESC
LIMIT 5;

-- 21 List appointments with doctor and patient names.
SELECT A.AppointmentID, P.Name AS Patient, Doc.Name AS Doctor
FROM Appointments A
JOIN Patients P ON A.PatientID = P.PatientID
JOIN Doctors Doc ON A.DoctorID = Doc.DoctorID;

-- 22 Find departments without doctors.
SELECT D.DeptName
FROM Departments D
LEFT JOIN Doctors Doc ON D.DeptID = Doc.DeptID
WHERE Doc.DoctorID IS NULL;

-- 23 List doctors with phone starting with '98'.
SELECT * FROM Doctors WHERE Phone LIKE '98%';

-- 24 Show patients admitted in last 7 days. 
SELECT * FROM Patients
WHERE PatientID IN (
    SELECT PatientID FROM Appointments
    WHERE Date >= CURDATE() - INTERVAL 7 DAY
);

-- 25 Display doctors and their total billing amounts. 
SELECT Doc.Name, SUM(B.Amount) AS TotalBilling
FROM Doctors Doc
JOIN Appointments A ON Doc.DoctorID = A.DoctorID
JOIN Bills B ON A.PatientID = B.PatientID
GROUP BY Doc.Name;