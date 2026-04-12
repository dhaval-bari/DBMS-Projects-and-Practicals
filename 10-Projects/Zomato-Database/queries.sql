-- 1. Get all orders with customer and restaurant names
SELECT c.Name AS Customer, r.Name AS Restaurant, o.Amount, o.OrderDate
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Restaurants r ON o.RestaurantID = r.RestaurantID;

-- 2. Total spending by each customer
SELECT c.Name, SUM(o.Amount) AS TotalSpent
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.Name;

-- 3. Find top 2 highest spending customers
SELECT c.Name, SUM(o.Amount) AS TotalSpent
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.Name
ORDER BY TotalSpent DESC
LIMIT 2;

-- 4. Find restaurants with rating above average
SELECT Name, Rating
FROM Restaurants
WHERE Rating > (SELECT AVG(Rating) FROM Restaurants);

-- 5. Total orders per city
SELECT c.City, COUNT(o.OrderID) AS TotalOrders
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.City;

-- 6. Customers who ordered more than once
SELECT c.Name, COUNT(o.OrderID) AS OrderCount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.Name
HAVING COUNT(o.OrderID) > 1;

-- 7. Highest order amount
SELECT MAX(Amount) AS HighestOrder
FROM Orders;

-- 8. Average order amount per restaurant
SELECT r.Name, AVG(o.Amount) AS AvgOrder
FROM Orders o
JOIN Restaurants r ON o.RestaurantID = r.RestaurantID
GROUP BY r.Name;
