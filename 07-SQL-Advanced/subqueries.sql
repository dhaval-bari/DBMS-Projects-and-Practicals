-- Customers who placed orders above average amount
SELECT Name
FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Orders
    WHERE Amount > (SELECT AVG(Amount) FROM Orders)
);

-- Products with highest price
SELECT *
FROM Products
WHERE Price = (SELECT MAX(Price) FROM Products);
