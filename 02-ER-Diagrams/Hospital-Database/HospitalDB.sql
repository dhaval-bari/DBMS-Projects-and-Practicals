CREATE DATABASE HospitalDB;
USE HospitalDB;

-- WARD
CREATE TABLE WARD (
    WardID INT PRIMARY KEY,
    WardName VARCHAR(100),
    FloorNo INT,
    Capacity INT,
    HeadNurseID INT
);

-- NURSE
CREATE TABLE NURSE (
    NurseID INT PRIMARY KEY,
    Name VARCHAR(100),
    WardID INT,
    FOREIGN KEY (WardID) REFERENCES WARD(WardID)
);

-- DOCTOR
CREATE TABLE DOCTOR (
    DoctorID INT PRIMARY KEY,
    Name VARCHAR(100),
    Specialization VARCHAR(100),
    Contact VARCHAR(50),
    Experience INT
);

-- PATIENT
CREATE TABLE PATIENT (
    PatientID INT PRIMARY KEY,
    Name VARCHAR(100),
    DOB DATE,
    BloodType VARCHAR(5),
    Street VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50)
);

-- MEDICATION
CREATE TABLE MEDICATION (
    DrugID INT PRIMARY KEY,
    Name VARCHAR(100),
    Manufacturer VARCHAR(100),
    Type VARCHAR(50)
);

-- NURSE_SHIFT (Multivalued)
CREATE TABLE NURSE_SHIFT (
    NurseID INT,
    Shift VARCHAR(20),
    PRIMARY KEY (NurseID, Shift),
    FOREIGN KEY (NurseID) REFERENCES NURSE(NurseID)
);

-- EMERGENCY_CONTACT (Weak Entity)
CREATE TABLE EMERGENCY_CONTACT (
    PatientID INT,
    ContactName VARCHAR(100),
    Relation VARCHAR(50),
    Phone VARCHAR(15),
    PRIMARY KEY (PatientID, ContactName),
    FOREIGN KEY (PatientID) REFERENCES PATIENT(PatientID)
);

-- LAB_TEST (Weak Entity)
CREATE TABLE LAB_TEST (
    TestID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    TestName VARCHAR(100),
    Date DATE,
    Result VARCHAR(100),
    Status VARCHAR(50),
    FOREIGN KEY (PatientID) REFERENCES PATIENT(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES DOCTOR(DoctorID)
);

-- ADMISSION (Associative Entity)
CREATE TABLE ADMISSION (
    AdmissionID INT PRIMARY KEY,
    PatientID INT,
    WardID INT,
    AdmitDate DATE,
    DischargeDate DATE,
    Reason VARCHAR(255),
    FOREIGN KEY (PatientID) REFERENCES PATIENT(PatientID),
    FOREIGN KEY (WardID) REFERENCES WARD(WardID)
);

-- TREATMENT
CREATE TABLE TREATMENT (
    TreatmentID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    Date DATE,
    Diagnosis VARCHAR(255),
    FOREIGN KEY (PatientID) REFERENCES PATIENT(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES DOCTOR(DoctorID)
);

-- PRESCRIPTION
CREATE TABLE PRESCRIPTION (
    TreatmentID INT,
    DrugID INT,
    Dosage VARCHAR(50),
    Frequency VARCHAR(50),
    Duration VARCHAR(50),
    PRIMARY KEY (TreatmentID, DrugID),
    FOREIGN KEY (TreatmentID) REFERENCES TREATMENT(TreatmentID),
    FOREIGN KEY (DrugID) REFERENCES MEDICATION(DrugID)
);

ALTER TABLE WARD
ADD CONSTRAINT fk_head_nurse
FOREIGN KEY (HeadNurseID) REFERENCES NURSE(NurseID);

SHOW TABLES;

-- 1. Patients currently admitted
SELECT p.Name, w.WardName, a.AdmitDate
FROM PATIENT p
JOIN ADMISSION a ON p.PatientID = a.PatientID
JOIN WARD w ON a.WardID = w.WardID
WHERE a.DischargeDate IS NULL;

-- 2. Doctors treating more than 10 patients
SELECT d.Name, COUNT(DISTINCT t.PatientID) AS PatientCount
FROM DOCTOR d
JOIN TREATMENT t ON d.DoctorID = t.DoctorID
GROUP BY d.DoctorID
HAVING COUNT(DISTINCT t.PatientID) > 10;

-- 3. Nurses working in Ward 2
SELECT n.Name
FROM NURSE n
WHERE n.WardID = 2;

-- 4. List all treatments with doctor and patient
SELECT p.Name AS Patient, d.Name AS Doctor, t.Diagnosis
FROM TREATMENT t
JOIN PATIENT p ON t.PatientID = p.PatientID
JOIN DOCTOR d ON t.DoctorID = d.DoctorID;

-- 5. Count patients per ward
SELECT w.WardName, COUNT(a.PatientID) AS TotalPatients
FROM WARD w
JOIN ADMISSION a ON w.WardID = a.WardID
GROUP BY w.WardID;