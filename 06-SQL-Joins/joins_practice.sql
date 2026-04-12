-- Create Tables
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    Amount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Insert Data
INSERT INTO Customers VALUES
(1, 'Rahul'),
(2, 'Priya'),
(3, 'Amit');

INSERT INTO Orders VALUES
(101, 1, 500),
(102, 2, 700),
(103, 1, 300);

-- INNER JOIN
SELECT Customers.Name, Orders.Amount
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;