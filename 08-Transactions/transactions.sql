-- Start Transaction
START TRANSACTION;

-- Deduct from Account A
UPDATE Accounts
SET Balance = Balance - 500
WHERE AccountID = 1;

-- Add to Account B
UPDATE Accounts
SET Balance = Balance + 500
WHERE AccountID = 2;

-- Commit changes
COMMIT;

-- Rollback Example
START TRANSACTION;

UPDATE Accounts
SET Balance = Balance - 1000
WHERE AccountID = 1;

-- Error occurs → undo changes
ROLLBACK;
