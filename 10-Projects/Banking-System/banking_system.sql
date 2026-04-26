-- =========================================
-- DATABASE
-- =========================================
CREATE DATABASE BesantBank;
USE BesantBank;

-- =========================================
-- TABLES
-- =========================================
CREATE TABLE Accountdetails(
    AccountID INT PRIMARY KEY,
    Name CHAR(30) NOT NULL,
    Age TINYINT CHECK(Age >18),
    Accounttype VARCHAR(20),
    Currentbalance INT
);

CREATE TABLE Transactiondetails(
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    AccountID INT,
    Transactiontype VARCHAR(10) CHECK(Transactiontype IN ('Credit','Debit')),
    Transactionamount INT,
    Transactiontime DATETIME DEFAULT NOW(),
    FOREIGN KEY(AccountID) REFERENCES Accountdetails(AccountID) ON DELETE CASCADE
);

-- =========================================
-- DATA INSERTION
-- =========================================
INSERT INTO Accountdetails VALUES
(1,'Ram',21,'Saving',2000),
(2,'Sana',23,'Current',500),
(3,'John',27,'Saving',1000),
(4,'Peter',25,'Saving',1500),
(5,'Kiran',27,'Current',5200),
(6,'Priya',21,'Saving',5500),
(7,'Varun',28,'Current',500),
(8,'Sonu',29,'Saving',2500),
(9,'Kumar',28,'Saving',2000),
(10,'Jathin',27,'Current',5000),
(11,'Suma',22,'Saving',1500);

INSERT INTO Transactiondetails (AccountID, Transactiontype, Transactionamount) VALUES
(1,'Credit',1000),
(1,'Debit',500),
(7,'Credit',1000),
(2,'Credit',1000);

-- =========================================
-- BASIC QUERIES
-- =========================================
SELECT DISTINCT AccountID FROM Transactiondetails;

SELECT * FROM Accountdetails
WHERE AccountID IN (SELECT DISTINCT AccountID FROM Transactiondetails);

-- TOP BALANCES
SELECT MIN(Currentbalance) FROM (
    SELECT Currentbalance FROM Accountdetails
    ORDER BY Currentbalance DESC LIMIT 5
) AS Topbalance;

-- =========================================
-- VIEWS
-- =========================================
CREATE VIEW AccountsOfTransactions AS
SELECT * FROM Accountdetails
WHERE AccountID IN (SELECT DISTINCT AccountID FROM Transactiondetails);

SELECT * FROM AccountsOfTransactions;

-- NON-UPDATABLE VIEW
CREATE VIEW BalanceInBank AS
SELECT SUM(Currentbalance) AS TotalBalance FROM Accountdetails;

-- =========================================
-- STORED PROCEDURE (BANK MINI STATEMENT)
-- =========================================
DELIMITER $$

CREATE PROCEDURE BankStatement(IN acc_id INT)
BEGIN
    SELECT * FROM Transactiondetails
    WHERE AccountID = acc_id;
END $$

DELIMITER ;

CALL BankStatement(1);

-- =========================================
-- UPDATE ACCOUNT STATUS
-- =========================================
ALTER TABLE Accountdetails ADD Status VARCHAR(10);

UPDATE Accountdetails a
SET Status =
CASE
    WHEN EXISTS (
        SELECT 1 FROM Transactiondetails t
        WHERE t.AccountID = a.AccountID
        AND t.Transactiontime >= NOW() - INTERVAL 6 MONTH
    )
    THEN 'ACTIVE'
    ELSE 'INACTIVE'
END;

-- =========================================
-- INDEX
-- =========================================
CREATE INDEX idx_accountid
ON Transactiondetails(AccountID);

-- =========================================
-- UPDATE BALANCE USING TRANSACTIONS
-- =========================================
UPDATE Accountdetails a
JOIN (
    SELECT AccountID,
    SUM(CASE WHEN Transactiontype='Credit' THEN Transactionamount ELSE -Transactionamount END) AS Net
    FROM Transactiondetails
    GROUP BY AccountID
) t ON a.AccountID = t.AccountID
SET a.Currentbalance = a.Currentbalance + t.Net;

-- =========================================
-- ERROR HANDLING (INSUFFICIENT BALANCE)
-- =========================================
DELIMITER $$

CREATE PROCEDURE TransferMoney(
    IN sender INT,
    IN receiver INT,
    IN amount INT
)
BEGIN
    DECLARE balance INT;

    SELECT Currentbalance INTO balance
    FROM Accountdetails WHERE AccountID = sender;

    IF balance < amount THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient Balance';
    ELSE
        START TRANSACTION;

        UPDATE Accountdetails
        SET Currentbalance = Currentbalance - amount
        WHERE AccountID = sender;

        UPDATE Accountdetails
        SET Currentbalance = Currentbalance + amount
        WHERE AccountID = receiver;

        COMMIT;
    END IF;
END $$

DELIMITER ;

-- =========================================
-- CURSOR (PROCESS ALL ACCOUNTS)
-- =========================================
DELIMITER $$

CREATE PROCEDURE ProcessAccounts()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE acc_id INT;

    DECLARE cur CURSOR FOR SELECT AccountID FROM Accountdetails;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO acc_id;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SELECT acc_id;

    END LOOP;

    CLOSE cur;
END $$

DELIMITER ;

-- =========================================
-- WILDCARD
-- =========================================
SELECT * FROM Accountdetails
WHERE Name LIKE 'R%';

-- =========================================
-- CTE (COMMON TABLE EXPRESSION)
-- =========================================
WITH HighBalance AS (
    SELECT * FROM Accountdetails WHERE Currentbalance > 2000
)
SELECT * FROM HighBalance;

-- =========================================
-- CASCADE DELETE TEST
-- =========================================
DELETE FROM Accountdetails WHERE AccountID = 1;
-- Related transactions auto deleted
