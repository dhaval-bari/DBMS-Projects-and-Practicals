-- SET 5 – Hotel Management System

-- Scenario: Manage hotel rooms, guests, and reservations.

-- Create Database
CREATE DATABASE HotelDB;
USE HotelDB;


-- Tables & Attributes: 
-- 1. Hotels (HotelID, HotelName, Location, Rating) 
-- 2. Rooms (RoomID, HotelID, RoomType, PricePerNight, Availability) 
-- 3. Guests (GuestID, Name, Phone, Email, Address) 
-- 4. Reservations (ReservationID, RoomID, GuestID, CheckInDate, CheckOutDate, Status) 
-- 5. Payments (PaymentID, ReservationID, Amount, PaymentDate, Method)

--------------------------------------------------
-- TABLE CREATION
--------------------------------------------------

-- 1. Hotels
CREATE TABLE Hotels (
    HotelID INT PRIMARY KEY,
    HotelName VARCHAR(100),
    Location VARCHAR(100),
    Rating DECIMAL(2,1)
);

-- 2. Rooms
CREATE TABLE Rooms (
    RoomID INT PRIMARY KEY,
    HotelID INT,
    RoomType VARCHAR(50),
    PricePerNight DECIMAL(10,2),
    Availability BOOLEAN,
    FOREIGN KEY (HotelID) REFERENCES Hotels(HotelID)
);

-- 3. Guests
CREATE TABLE Guests (
    GuestID INT PRIMARY KEY,
    Name VARCHAR(100),
    Phone VARCHAR(15),
    Email VARCHAR(100),
    Address VARCHAR(100)
);

-- 4. Reservations
CREATE TABLE Reservations (
    ReservationID INT PRIMARY KEY,
    RoomID INT,
    GuestID INT,
    CheckInDate DATE,
    CheckOutDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID),
    FOREIGN KEY (GuestID) REFERENCES Guests(GuestID)
);

-- 5. Payments
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    ReservationID INT,
    Amount DECIMAL(10,2),
    PaymentDate DATE,
    Method VARCHAR(50),
    FOREIGN KEY (ReservationID) REFERENCES Reservations(ReservationID)
);

--------------------------------------------------
-- INSERT DATA
--------------------------------------------------

-- Hotels
INSERT INTO Hotels VALUES
(1, 'Taj Hotel', 'Mumbai', 4.8),
(2, 'Oberoi', 'Delhi', 4.5),
(3, 'ITC Grand', 'Mumbai', 4.2),
(4, 'Leela Palace', 'Bangalore', 4.7),
(5, 'Radisson Blu', 'Delhi', 3.9);

-- Rooms
INSERT INTO Rooms VALUES
(1, 1, 'Suite', 8000, TRUE),
(2, 1, 'Deluxe', 5000, TRUE),
(3, 2, 'Standard', 3000, FALSE),
(4, 3, 'Suite', 9000, TRUE),
(5, 4, 'Deluxe', 6000, TRUE),
(6, 5, 'Standard', 2500, TRUE);

-- Guests
INSERT INTO Guests VALUES
(1, 'Rahul Sharma', '9876543210', 'rahul@gmail.com', 'Mumbai'),
(2, 'Priya Mehta', '9123456780', 'priya@gmail.com', 'Delhi'),
(3, 'Amit Verma', '9988776655', 'amit@gmail.com', 'Pune'),
(4, 'Neha Singh', '9090909090', 'neha@gmail.com', 'Delhi'),
(5, 'Karan Patel', '8888888888', 'karan@gmail.com', 'Ahmedabad');

-- Reservations
INSERT INTO Reservations VALUES
(1, 1, 1, '2026-03-10', '2026-03-15', 'checked-in'),
(2, 2, 2, '2026-03-01', '2026-03-03', 'completed'),
(3, 3, 3, '2026-02-20', '2026-02-25', 'cancelled'),
(4, 4, 1, '2026-03-05', '2026-03-12', 'checked-in'),
(5, 5, 4, '2026-03-18', '2026-03-20', 'checked-in');

-- Payments
INSERT INTO Payments VALUES
(1, 1, 40000, '2026-03-10', 'Card'),
(2, 2, 10000, '2026-03-01', 'UPI'),
(3, 3, 15000, '2026-02-20', 'Cash'),
(4, 4, 63000, '2026-03-05', 'NetBanking'),
(5, 5, 12000, '2026-03-18', 'Card');

--------------------------------------------------
-- QUERIES
--------------------------------------------------

-- 1 List all hotels in 'Mumbai'.
SELECT * FROM Hotels WHERE Location = 'Mumbai';

-- 2 Show rooms with price above 3000 per night.
SELECT * FROM Rooms WHERE PricePerNight > 3000;

-- 3 Find available rooms in a given hotel.
SELECT * FROM Rooms
WHERE HotelID = 1 AND Availability = TRUE;

-- 4 List guests with reservations in a specific hotel.
SELECT DISTINCT G.*
FROM Guests G
JOIN Reservations R ON G.GuestID = R.GuestID
JOIN Rooms RM ON R.RoomID = RM.RoomID
WHERE RM.HotelID = 1;

-- 5 Show reservations with status 'Checked-In'.
SELECT * FROM Reservations WHERE Status = 'checked-in';

-- 6 Count rooms by type for each hotel.
SELECT HotelID, RoomType, COUNT(*) AS CountRooms
FROM Rooms
GROUP BY HotelID, RoomType;

-- 7 Find guests who stayed more than 5 nights.
SELECT G.Name, DATEDIFF(CheckOutDate, CheckInDate) AS Nights
FROM Reservations R
JOIN Guests G ON R.GuestID = G.GuestID
WHERE DATEDIFF(CheckOutDate, CheckInDate) > 5;

-- 8 Show top 3 most expensive room types.
SELECT RoomType, PricePerNight
FROM Rooms
ORDER BY PricePerNight DESC
LIMIT 3;

-- 9 List all reservations in the last month.
SELECT * FROM Reservations
WHERE CheckInDate >= CURDATE() - INTERVAL 1 MONTH;

-- 10 Display guests who made more than 2 reservations.
SELECT GuestID, COUNT(*) AS TotalReservations
FROM Reservations
GROUP BY GuestID
HAVING COUNT(*) > 2;

-- 11 Show hotels with average room price above 4000.
SELECT H.HotelName, AVG(R.PricePerNight) AS AvgPrice
FROM Hotels H
JOIN Rooms R ON H.HotelID = R.HotelID
GROUP BY H.HotelName
HAVING AVG(R.PricePerNight) > 4000;

-- 12 List guests from a specific city.
SELECT * FROM Guests WHERE Address = 'Delhi';

-- 13 Find hotels without any reservations.
SELECT H.*
FROM Hotels H
LEFT JOIN Rooms R ON H.HotelID = R.HotelID
LEFT JOIN Reservations RS ON R.RoomID = RS.RoomID
WHERE RS.ReservationID IS NULL;

-- 14 Show reservations with guest name, hotel name, and room type.
SELECT RS.ReservationID, G.Name, H.HotelName, R.RoomType
FROM Reservations RS
JOIN Guests G ON RS.GuestID = G.GuestID
JOIN Rooms R ON RS.RoomID = R.RoomID
JOIN Hotels H ON R.HotelID = H.HotelID;

-- 15 Find total revenue for each hotel.
SELECT H.HotelName, SUM(P.Amount) AS Revenue
FROM Payments P
JOIN Reservations R ON P.ReservationID = R.ReservationID
JOIN Rooms RM ON R.RoomID = RM.RoomID
JOIN Hotels H ON RM.HotelID = H.HotelID
GROUP BY H.HotelName;

-- 16 List reservations where check-out date is before check-in date (data check).
SELECT * FROM Reservations
WHERE CheckOutDate < CheckInDate;

-- 17 Show payment methods used.
SELECT DISTINCT Method FROM Payments;

-- 18 Find guests who haven’t made any payments.
SELECT * FROM Guests
WHERE GuestID NOT IN (
    SELECT R.GuestID
    FROM Reservations R
    JOIN Payments P ON R.ReservationID = P.ReservationID
);

-- 19 Display reservations sorted by check-in date.
SELECT * FROM Reservations
ORDER BY CheckInDate;

-- 20 Find hotels with rating above 4.
SELECT * FROM Hotels WHERE Rating > 4;

-- 21 Show guests who booked suites.
SELECT DISTINCT G.*
FROM Guests G
JOIN Reservations R ON G.GuestID = R.GuestID
JOIN Rooms RM ON R.RoomID = RM.RoomID
WHERE RM.RoomType = 'Suite';

-- 22 List available rooms in 'Delhi'.
SELECT RM.*
FROM Rooms RM
JOIN Hotels H ON RM.HotelID = H.HotelID
WHERE H.Location = 'Delhi' AND RM.Availability = TRUE;

-- 23 Show total nights stayed per guest. 
SELECT GuestID, SUM(DATEDIFF(CheckOutDate, CheckInDate)) AS TotalNights
FROM Reservations
GROUP BY GuestID;

-- 24 Find reservations with overlapping dates for the same room.
SELECT R1.ReservationID, R2.ReservationID
FROM Reservations R1
JOIN Reservations R2
ON R1.RoomID = R2.RoomID
AND R1.ReservationID <> R2.ReservationID
AND R1.CheckInDate < R2.CheckOutDate
AND R1.CheckOutDate > R2.CheckInDate;

-- 25 List all distinct cities where hotels are located. 
SELECT DISTINCT Location FROM Hotels;