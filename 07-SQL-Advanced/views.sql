-- Create View
CREATE VIEW CustomerSummary AS
SELECT CustomerID, SUM(Amount) AS TotalSpent
FROM Orders
GROUP BY CustomerID;

-- Use View
SELECT * FROM CustomerSummary;
