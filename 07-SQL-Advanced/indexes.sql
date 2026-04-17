-- Create Index
CREATE INDEX idx_customer_name
ON Customers(Name);

-- Create Composite Index
CREATE INDEX idx_order_customer
ON Orders(CustomerID, Amount);
