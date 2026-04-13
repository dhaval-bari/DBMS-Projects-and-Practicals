CREATE DATABASE EcommerceDB;
USE EcommerceDB;

-- CATEGORY (Self-referencing)
CREATE TABLE CATEGORY (
    CatID INT PRIMARY KEY,
    CatName VARCHAR(100),
    ParentCatID INT,
    FOREIGN KEY (ParentCatID) REFERENCES CATEGORY(CatID)
);

-- PRODUCT
CREATE TABLE PRODUCT (
    ProductID INT PRIMARY KEY,
    Name VARCHAR(100),
    Description TEXT,
    BasePrice DECIMAL(10,2),
    StockQty INT,
    Weight DECIMAL(5,2),
    CatID INT,
    FOREIGN KEY (CatID) REFERENCES CATEGORY(CatID)
);

-- VENDOR
CREATE TABLE VENDOR (
    VendorID INT PRIMARY KEY,
    Name VARCHAR(100),
    Rating DECIMAL(2,1),
    Email VARCHAR(100),
    Phone VARCHAR(15)
);

-- CUSTOMER
CREATE TABLE CUSTOMER (
    CustID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateJoined DATE,
    LoyaltyPoints INT
);

-- CUSTOMER_EMAIL (Multivalued)
CREATE TABLE CUSTOMER_EMAIL (
    CustID INT,
    Email VARCHAR(100),
    PRIMARY KEY (CustID, Email),
    FOREIGN KEY (CustID) REFERENCES CUSTOMER(CustID)
);

-- PRODUCT_IMAGE (Multivalued)
CREATE TABLE PRODUCT_IMAGE (
    ProductID INT,
    ImageURL VARCHAR(255),
    PRIMARY KEY (ProductID, ImageURL),
    FOREIGN KEY (ProductID) REFERENCES PRODUCT(ProductID)
);

-- ADDRESS (Weak Entity)
CREATE TABLE ADDRESS (
    CustID INT,
    AddressID INT,
    Street VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    Country VARCHAR(50),
    Pincode VARCHAR(10),
    Type VARCHAR(20),
    PRIMARY KEY (CustID, AddressID),
    FOREIGN KEY (CustID) REFERENCES CUSTOMER(CustID)
);

-- VENDOR_PRODUCT (M:N)
CREATE TABLE VENDOR_PRODUCT (
    VendorID INT,
    ProductID INT,
    VendorPrice DECIMAL(10,2),
    DeliveryDays INT,
    PRIMARY KEY (VendorID, ProductID),
    FOREIGN KEY (VendorID) REFERENCES VENDOR(VendorID),
    FOREIGN KEY (ProductID) REFERENCES PRODUCT(ProductID)
);

CREATE TABLE CART (
    CartID INT PRIMARY KEY,
    CustID INT UNIQUE,
    CreatedAt DATETIME,
    FOREIGN KEY (CustID) REFERENCES CUSTOMER(CustID)
);

CREATE TABLE CART_ITEM (
    CartID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (CartID, ProductID),
    FOREIGN KEY (CartID) REFERENCES CART(CartID),
    FOREIGN KEY (ProductID) REFERENCES PRODUCT(ProductID)
);

-- ORDERS
CREATE TABLE ORDERS (
    OrderID INT PRIMARY KEY,
    CustID INT,
    OrderDate DATE,
    Status VARCHAR(50),
    ShipStreet VARCHAR(100),
    ShipCity VARCHAR(50),
    ShipState VARCHAR(50),
    FOREIGN KEY (CustID) REFERENCES CUSTOMER(CustID)
);

-- ORDER_ITEM (Weak Entity)
CREATE TABLE ORDER_ITEM (
    OrderID INT,
    ItemSeq INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    Discount DECIMAL(5,2),
    PRIMARY KEY (OrderID, ItemSeq),
    FOREIGN KEY (OrderID) REFERENCES ORDERS(OrderID),
    FOREIGN KEY (ProductID) REFERENCES PRODUCT(ProductID)
);

-- PAYMENT
CREATE TABLE PAYMENT (
    PaymentID INT PRIMARY KEY,
    OrderID INT UNIQUE,
    Method VARCHAR(50),
    Amount DECIMAL(10,2),
    TxnID VARCHAR(100),
    Status VARCHAR(50),
    PaidAt DATETIME,
    FOREIGN KEY (OrderID) REFERENCES ORDERS(OrderID)
);

-- REVIEW
CREATE TABLE REVIEW (
    ReviewID INT PRIMARY KEY,
    CustID INT,
    ProductID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT,
    ReviewDate DATE,
    UNIQUE (CustID, ProductID),
    FOREIGN KEY (CustID) REFERENCES CUSTOMER(CustID),
    FOREIGN KEY (ProductID) REFERENCES PRODUCT(ProductID)
);

SHOW TABLES;

-- Top 5 best-selling products
SELECT p.Name, SUM(oi.Quantity * oi.UnitPrice) AS Revenue
FROM PRODUCT p
JOIN ORDER_ITEM oi ON p.ProductID = oi.ProductID
JOIN ORDERS o ON oi.OrderID = o.OrderID
WHERE o.Status = 'DELIVERED'
GROUP BY p.ProductID
ORDER BY Revenue DESC
LIMIT 5;

-- Customers who never ordered
SELECT c.FirstName, c.LastName
FROM CUSTOMER c
LEFT JOIN ORDERS o ON c.CustID = o.CustID
WHERE o.OrderID IS NULL;

-- Average rating per category
SELECT cat.CatName, AVG(r.Rating) AS AvgRating
FROM CATEGORY cat
JOIN PRODUCT p ON cat.CatID = p.CatID
JOIN REVIEW r ON p.ProductID = r.ProductID
GROUP BY cat.CatID;