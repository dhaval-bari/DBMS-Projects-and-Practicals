-- =====================================
-- TRANSACTION BASICS
-- =====================================
START TRANSACTION;

UPDATE Accounts
SET Balance = Balance - 500
WHERE AccountID = 1;

UPDATE Accounts
SET Balance = Balance + 500
WHERE AccountID = 2;

COMMIT;

-- =====================================
-- ROLLBACK EXAMPLE
-- =====================================
START TRANSACTION;

UPDATE Accounts
SET Balance = Balance - 1000
WHERE AccountID = 1;

ROLLBACK;

-- =====================================
-- SAVEPOINT EXAMPLE
-- =====================================
START TRANSACTION;

UPDATE Accounts SET Balance = Balance - 200 WHERE AccountID = 1;

SAVEPOINT sp1;

UPDATE Accounts SET Balance = Balance + 200 WHERE AccountID = 2;

ROLLBACK TO sp1;

COMMIT;

-- =====================================
-- LOCKING (SIMULATION)
-- =====================================
-- Shared Lock (Read)
SELECT * FROM Accounts LOCK IN SHARE MODE;

-- Exclusive Lock (Write)
SELECT * FROM Accounts FOR UPDATE;

-- =====================================
-- DEADLOCK SIMULATION (CONCEPTUAL)
-- =====================================
-- Transaction 1
-- UPDATE Accounts SET Balance = Balance - 100 WHERE AccountID = 1;

-- Transaction 2
-- UPDATE Accounts SET Balance = Balance - 200 WHERE AccountID = 2;

-- =====================================
-- ISOLATION LEVELS
-- =====================================
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

START TRANSACTION;
SELECT * FROM Accounts;
COMMIT;

-- =====================================
-- RECOVERY (CONCEPT)
-- =====================================
-- REDO / UNDO handled internally by DBMS

-- =====================================
-- TWO PHASE COMMIT (CONCEPT)
-- =====================================
-- Phase 1: Prepare
-- Phase 2: Commit

-- =====================================
-- END OF FILE
-- =====================================
