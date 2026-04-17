-- View current isolation level
SELECT @@transaction_isolation;

-- Set isolation level
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Example transaction
START TRANSACTION;

SELECT * FROM Accounts;

COMMIT;
