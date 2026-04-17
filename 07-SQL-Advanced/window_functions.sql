-- Rank customers based on spending
SELECT CustomerID,
       SUM(Amount) AS TotalSpent,
       RANK() OVER (ORDER BY SUM(Amount) DESC) AS Rank
FROM Orders
GROUP BY CustomerID;

-- Running total of orders
SELECT OrderID,
       Amount,
       SUM(Amount) OVER (ORDER BY OrderID) AS RunningTotal
FROM Orders;
