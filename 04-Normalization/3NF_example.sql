-- BEFORE (Not in 3NF)
-- Employee(EmpID, DeptID, DeptName)

-- DeptName depends on DeptID, not EmpID ❌

-- AFTER (3NF)

CREATE TABLE Department (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(100)
);

CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);
