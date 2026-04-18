-- SET 6 – Library Management System

-- Scenario: Manage books, members, loans, and fines.

-- Create Database
CREATE DATABASE LibraryDB;
USE LibraryDB;


-- Tables & Attributes: 
-- 1. Books (BookID, Title, AuthorID, Category, Price, Stock) 
-- 2. Authors (AuthorID, Name, Nationality) 
-- 3. Members (MemberID, Name, Email, Phone, Address) 
-- 4. Loans (LoanID, BookID, MemberID, IssueDate, ReturnDate, Status) 
-- 5. Fines (FineID, LoanID, Amount, PaymentStatus) 

--------------------------------------------------
-- TABLE CREATION
--------------------------------------------------

-- 1. Authors
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    Name VARCHAR(100),
    Nationality VARCHAR(50)
);

-- 2. Books
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(150),
    AuthorID INT,
    Category VARCHAR(100),
    Price DECIMAL(10,2),
    Stock INT,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

-- 3. Members
CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    Address VARCHAR(100)
);

-- 4. Loans
CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    IssueDate DATE,
    ReturnDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

-- 5. Fines
CREATE TABLE Fines (
    FineID INT PRIMARY KEY,
    LoanID INT,
    Amount DECIMAL(10,2),
    PaymentStatus VARCHAR(50),
    FOREIGN KEY (LoanID) REFERENCES Loans(LoanID)
);

--------------------------------------------------
-- INSERT DATA
--------------------------------------------------

-- Authors
INSERT INTO Authors VALUES
(1, 'Isaac Asimov', 'USA'),
(2, 'Chetan Bhagat', 'India'),
(3, 'J.K. Rowling', 'UK'),
(4, 'Yuval Noah Harari', 'Israel'),
(5, 'R.K. Narayan', 'India');

-- Books
INSERT INTO Books VALUES
(1, 'Foundation', 1, 'Science Fiction', 500, 3),
(2, '2 States', 2, 'Romance', 300, 10),
(3, 'Harry Potter', 3, 'Fantasy', 800, 2),
(4, 'Sapiens History', 4, 'History', 600, 6),
(5, 'Malgudi Days', 5, 'Fiction', 250, 8),
(6, 'I Robot', 1, 'Science Fiction', 450, 4);

-- Members
INSERT INTO Members VALUES
(1, 'Rahul Sharma', 'rahul@gmail.com', '9876543210', 'Mumbai'),
(2, 'Priya Mehta', 'priya@gmail.com', '9123456780', 'Delhi'),
(3, 'Amit Verma', 'amit@gmail.com', '9988776655', 'Pune'),
(4, 'Neha Singh', 'neha@gmail.com', '9090909090', 'Delhi'),
(5, 'Karan Patel', 'karan@gmail.com', '8888888888', 'Ahmedabad');

-- Loans
INSERT INTO Loans VALUES
(1, 1, 1, CURDATE() - INTERVAL 10 DAY, NULL, 'Issued'),
(2, 2, 2, CURDATE() - INTERVAL 20 DAY, CURDATE() - INTERVAL 5 DAY, 'Returned'),
(3, 3, 3, CURDATE() - INTERVAL 40 DAY, NULL, 'Overdue'),
(4, 4, 1, CURDATE() - INTERVAL 15 DAY, CURDATE() - INTERVAL 2 DAY, 'Returned'),
(5, 5, 4, CURDATE() - INTERVAL 5 DAY, NULL, 'Issued');

-- Fines
INSERT INTO Fines VALUES
(1, 3, 200, 'Unpaid'),
(2, 2, 50, 'Paid'),
(3, 4, 100, 'Paid'),
(4, 3, 150, 'Unpaid'),
(5, 1, 80, 'Paid');

--------------------------------------------------
-- QUERIES
--------------------------------------------------

-- 1 List books in 'Science Fiction' category.
SELECT * FROM Books WHERE Category = 'Science Fiction';

-- 2 Show books with stock less than 5.
SELECT * FROM Books WHERE Stock < 5;

-- 3 Find members with overdue books. 
SELECT DISTINCT M.*
FROM Members M
JOIN Loans L ON M.MemberID = L.MemberID
WHERE L.Status = 'Overdue';

-- 4 Show top 3 most expensive books.
SELECT * FROM Books ORDER BY Price DESC LIMIT 3;

-- 5 List all authors from 'India'.
SELECT * FROM Authors WHERE Nationality = 'India';

-- 6 Show books written by a given author.
SELECT B.*
FROM Books B
JOIN Authors A ON B.AuthorID = A.AuthorID
WHERE A.Name = 'Isaac Asimov';

-- 7 Count total books per category. 
SELECT Category, COUNT(*) AS TotalBooks
FROM Books
GROUP BY Category;

-- 8 Find members who borrowed more than 5 books.
SELECT MemberID, COUNT(*) AS TotalBorrowed
FROM Loans
GROUP BY MemberID
HAVING COUNT(*) > 5;

-- 9 Show loans with status 'Returned'.
SELECT * FROM Loans WHERE Status = 'Returned';

-- 10 Display members who never borrowed any book.
SELECT * FROM Members
WHERE MemberID NOT IN (SELECT MemberID FROM Loans);

-- 11 List all unpaid fines.
SELECT * FROM Fines WHERE PaymentStatus = 'Unpaid';

-- 12 Show total fines paid per member.
SELECT L.MemberID, SUM(F.Amount) AS TotalFines
FROM Fines F
JOIN Loans L ON F.LoanID = L.LoanID
WHERE F.PaymentStatus = 'Paid'
GROUP BY L.MemberID;

-- 13 Find books issued in the last month.
SELECT * FROM Loans
WHERE IssueDate >= CURDATE() - INTERVAL 1 MONTH;

-- 14 Show members who borrowed books in a specific category.
SELECT DISTINCT M.*
FROM Members M
JOIN Loans L ON M.MemberID = L.MemberID
JOIN Books B ON L.BookID = B.BookID
WHERE B.Category = 'Science Fiction';

-- 15 Find authors who wrote more than 3 books.
SELECT AuthorID, COUNT(*) AS TotalBooks
FROM Books
GROUP BY AuthorID
HAVING COUNT(*) > 3;

-- 16 List books with price between 200 and 500.
SELECT * FROM Books WHERE Price BETWEEN 200 AND 500;

-- 17 Show average fine amount.
SELECT AVG(Amount) AS AvgFine FROM Fines;

-- 18 Find members with phone numbers starting with '9'.
SELECT * FROM Members WHERE Phone LIKE '9%';

-- 19 Display all loans with book and member details.
SELECT L.LoanID, B.Title, M.Name
FROM Loans L
JOIN Books B ON L.BookID = B.BookID
JOIN Members M ON L.MemberID = M.MemberID;

-- 20 Show books whose title contains 'History'.
SELECT * FROM Books WHERE Title LIKE '%History%';

-- 21 List members with more than one unpaid fine.
SELECT L.MemberID, COUNT(*) AS UnpaidFines
FROM Fines F
JOIN Loans L ON F.LoanID = L.LoanID
WHERE F.PaymentStatus = 'Unpaid'
GROUP BY L.MemberID
HAVING COUNT(*) > 1;

-- 22 Find books with no loans.
SELECT B.*
FROM Books B
LEFT JOIN Loans L ON B.BookID = L.BookID
WHERE L.LoanID IS NULL;

-- 23 Show most borrowed book.
SELECT BookID, COUNT(*) AS BorrowCount
FROM Loans
GROUP BY BookID
ORDER BY BorrowCount DESC
LIMIT 1;

-- 24 Display top 5 members by total borrowings.
SELECT MemberID, COUNT(*) AS TotalLoans
FROM Loans
GROUP BY MemberID
ORDER BY TotalLoans DESC
LIMIT 5;

-- 25 Show all categories of books available.
SELECT DISTINCT Category FROM Books;