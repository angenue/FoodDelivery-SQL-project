-- Angelica Nuesi, Tai Dang
-- CIS 205 Final Project

-- create and USE the DATABASE
DROP DATABASE IF EXISTS FoodDeliveryApp;
CREATE DATABASE IF NOT EXISTS FoodDeliveryApp;
USE FoodDeliveryApp;

DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Menu;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Driver;
DROP TABLE IF EXISTS Vendor;

-- Customer Table
CREATE TABLE IF NOT EXISTS Customer
(
    customerID INT NOT NULL,
    customerAddress VARCHAR(100) NOT NULL,
    customerName VARCHAR(100) NOT NULL,
    customerPhone CHAR(10) NOT NULL,
    creditCard CHAR(16) NOT NULL,

    CONSTRAINT Customer_PK PRIMARY KEY (customerID)
);

-- Driver Table
CREATE TABLE IF NOT EXISTS Driver
(
    driverName VARCHAR(100) NOT NULL,
    driverPhone CHAR(10) NOT NULL,
    driverID INT NOT NULL,

    CONSTRAINT Driver_PK PRIMARY KEY (driverID)
);

-- Store Table
CREATE TABLE IF NOT EXISTS Vendor
(
    storeNum INT NOT NULL,
    storeName VARCHAR(100) NOT NULL,
    storeAddress VARCHAR(100) NOT NULL,
    storePhone CHAR(10) NOT NULL,

    CONSTRAINT Vendor_PK PRIMARY KEY (storeNum)
);

-- Menu Table
CREATE TABLE IF NOT EXISTS Menu
(
    itemID INT NOT NULL,
    storeNum_FK INT NOT NULL,
    itemPrice FLOAT NOT NULL,
    itemName VARCHAR(100) NOT NULL,

    CONSTRAINT Menu_PK PRIMARY KEY (itemID),

    CONSTRAINT Menu_FK1 FOREIGN KEY (storeNum_FK)
    REFERENCES Vendor (storeNum)
);

-- Order Table
CREATE TABLE IF NOT EXISTS Orders
(
    orderNum INT NOT NULL,
    orderDate DATE NOT NULL,
    customerID_FK INT NOT NULL,
    driverID_FK INT NOT NULL,
    storeNum_FK INT NOT NULL,
    itemID_FK INT NOT NULL,
    customerAddress VARCHAR(100) NOT NULL,
    totalAmount FLOAT NOT NULL,

    CONSTRAINT Orders_PK PRIMARY KEY (orderNum),

    CONSTRAINT Orders_FK1 FOREIGN KEY (customerID_FK)
    REFERENCES Customer (customerID),

    CONSTRAINT Orders_FK2 FOREIGN KEY (driverID_FK)
    REFERENCES Driver (driverID),

    CONSTRAINT Orders_FK3 FOREIGN KEY (storeNum_FK)
    REFERENCES Vendor (storeNum),

    CONSTRAINT Orders_FK4 FOREIGN KEY (itemID_FK)
    REFERENCES Menu (itemID)
);


INSERT INTO Customer (customerID, customerName, customerPhone, customerAddress, creditCard)
VALUES (610000, "John Doe", "2153333333", "123 main st", "4846369700256380"),
        (620000, "Ryan Gosling", "2151111111", "456 random st", "4305487767092250"),
        (630000, "Kanye West", "2152222222", "789 okay st", "4019505292476090"),
        (640000, "Michael Scott", "2154444444", "345 hello st", "4475859588062520"),
        (650000, "Yuri Nate", "2156666666", "678 deez st", "3767784705719190");

INSERT INTO Driver (driverID, driverName, driverPhone)
VALUES (200000,"Ben Ten","2152000000"),
        (220000,"Sven Greg","2152200000"),
        (222000	,"George Fred",	"2152220000"),
        (222200,"Freddy Kuger",	"2152222000"),
        (222220,"Kevin Unicornbreath","2152222200");

INSERT INTO Vendor (storeNum, storeName, storeAddress, storePhone)
VALUES (100000, "Pho Saigon", "123 street", "2151110000"),
        (110000, "Sky Cafe", "124 street", "2151112222"),
        (111000, "Wendy", "125 Street", "2151113333"),
        (111100, "Five Guys", "126 street", "2151115555"),
        (111110, "Diicks", "127 street", "2151114444");

INSERT INTO Menu (itemID, itemName, itemPrice, storeNum_FK)
VALUES (111, "Pho", 2.99, 100000),
        (121, "Soup", 7.45, 100000),
        (112, "Rice", 2.99, 110000),
        (113, "Chicken", 4.50, 111000),
        (123, "Burger", 1.99, 111000),
        (114, "Beef", 5.99, 111100),
        (124, "fries", 1.75, 111100),
        (115, "Balls", 6.90, 111110);

INSERT INTO Orders (orderNum, orderDate, customerID_FK, driverID_FK, storeNum_FK, itemID_FK, customerAddress, totalAmount)
VALUES (666, "2021-12-05", 620000, 222000, 111000, 123, "456 random st", 10.75),
        (777, "2021-12-05", 650000, 220000, 100000, 121, "678 deez st", 13.12),
        (888, "2021-12-06", 610000, 200000, 111110, 115, "123 main st", 12.50),
        (999, "2021-12-07", 620000, 222200, 111100, 114, "456 random st", 11.89),
        (444, "2021-12-07", 630000, 200000, 110000, 112, "789 okay st", 7.99),
        (222, "2021-12-08", 640000, 222220, 100000, 121, "345 hello st", 13.12),
        (333, "2021-12-08", 610000, 220000, 110000, 112, "123 main st", 7.99),
        (555, "2021-12-10", 620000, 222220, 111100, 124, "456 random st", 5.89);


-- Angelica Part 2 (Customer and Order)

-- 1. Write a query that performs a Union on one of your main tables and another table
SELECT customerName
FROM Customer
    UNION
SELECT orderNum
FROM Orders;

-- 2. Write a query that performs an intersection on one of your main tables and another table.
SELECT customerID
FROM Customer
    INTERSECT
SELECT customerID_FK
FROM Orders;

-- 3. Write two separate queries that perform a Difference Operation on your main tables and another table.
SELECT DISTINCT customerID
FROM Customer
WHERE (customerID) NOT IN
(SELECT orderNum
FROM Orders);

SELECT DISTINCT orderNum
FROM Orders
WHERE (orderNum) NOT IN
(SELECT customerID
FROM Customer);

-- 4. You are to write a JOIN Query using two or more of your tables.
SELECT customerName, Orders.orderNum, Orders.customerAddress
FROM Customer
INNER JOIN Orders ON Customer.customerAddress = Orders.customerAddress
GROUP BY Orders.customerAddress;

-- 5. Create two queries that will alter the structure of your entity table.
DESCRIBE Customer;

ALTER TABLE Customer 
MODIFY customerAddress VARCHAR(500) NOT NULL;

DESCRIBE Customer;

---------------------------------------------

ALTER TABLE Customer 
MODIFY customerAddress VARCHAR(100) NOT NULL;

DESCRIBE Customer;

-- 6. Write two queries that will update two different categories of rows in the tables of the set of tables that you have chosen.
SELECT customerAddress
FROM Customer
WHERE customerID = '630000';

UPDATE Customer 
SET customerAddress = '666 yeezy st'
WHERE customerID = '630000';

SELECT customerAddress
FROM Customer
WHERE customerID = '630000';

-----------------------------

SELECT customerPhone
FROM Customer
WHERE customerID = '630000';

UPDATE Customer 
SET customerPhone = '2155555555'
WHERE customerID = '630000';

SELECT customerPhone
FROM Customer
WHERE customerID = '630000';

-- 7. Write two queries that will delete two different categories of rows in your tables.
SELECT * FROM Orders;

DELETE FROM Orders
WHERE orderNum = 444;

SELECT * FROM Orders;

----------------------------

SELECT * FROM Orders;

DELETE FROM Orders
WHERE orderNum = 999;

SELECT * FROM Orders;

-- 8. Write two queries that perform aggregate functions on at least your Primary Tables in your set of individual tables
SELECT COUNT(orderNum)
FROM Orders;

SELECT MAX(totalAmount) highestPrice
FROM Orders;

-- 9. Write two queries that use a HAVING clause on different categories of rows in your set of tables chosen. 
SELECT MIN(orderNum)
FROM Orders
HAVING MIN(orderNum);

SELECT itemID_FK, MAX(totalAmount)
FROM Orders
HAVING MAX(totalAmount) > 9.99;

-- 10. Write two queries that use both a GROUP BY and HAVING clause on different categories of rows in your entity tables or a combination of the set of tables chosen
SELECT orderNum, totalAmount, customerID_FK
FROM Orders 
GROUP BY customerID_FK;

SELECT orderDate, customerAddress
FROM Orders
GROUP BY orderDate;

SELECT Customer.customerName, COUNT(Orders.orderNum) AS NumberOfOrders
FROM (Orders
INNER JOIN Customer ON Orders.customerID_FK = Customer.customerID)
GROUP BY customerName
HAVING COUNT(Orders.OrderNum) > 1;

SELECT itemID_FK, MAX(totalAmount)
FROM Orders
GROUP BY itemID_FK
HAVING MAX(totalAmount) > 9.99;

-- 11. Write two queries that sort the results in Ascending and Descending order of the set of tables chosen.  
SELECT customerName, customerAddress
FROM Customer 
ORDER BY customerName DESC;

SELECT orderDate, customerAddress
FROM Orders
ORDER BY orderDate ASC;


-- 12. Write statements that create two SQL VIEWS.  The set of view statements should also include the SELECT Statements to execute them.
CREATE VIEW Persons AS
SELECT customerName, 'Customer' AS status
FROM Customer
    UNION
SELECT driverName, 'Driver' AS status
FROM Driver;

--------------------------
CREATE VIEW customerInfo AS
SELECT customerName, customerAddress, customerPhone
FROM Customer;

SELECT *
FROM customerInfo;

-- 13. Write two Stored Procedures
DELIMITER //

CREATE PROCEDURE OrdersAndCust()
BEGIN
	DESCRIBE Orders;
    DESCRIBE Customer;
    SELECT *
    FROM Orders;
    SELECT *
    FROM Customer;
END //

DELIMITER ;

CALL OrdersAndCust();

DROP PROCEDURE OrdersAndCust;

--------------------------------------------

DELIMITER //

CREATE PROCEDURE GetMenuByStore(
	IN storeName VARCHAR(100)
)
BEGIN
	SELECT itemName, Vendor.storeName 
 	FROM Menu
     INNER JOIN Vendor ON Vendor.storeNum = Menu.storeNum_FK
	WHERE storeName = storeName
    ORDER BY Vendor.storeName;
END //

DELIMITER ;

CALL GetMenuByStore('Five Guys');

DROP PROCEDURE GetMenuByStore;

-- 14. Write Stored Triggers
CREATE TABLE Customer_audit
(
    customerID INT NOT NULL,
    customerAddress VARCHAR(100) NOT NULL,
    customerName VARCHAR(100) NOT NULL,
    customerPhone CHAR(10) NOT NULL,
    creditCard CHAR(16) NOT NULL,
    changedat DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);

DELIMITER $$

CREATE TRIGGER before_Customer_UPDATE 
    BEFORE UPDATE ON Customer
    FOR EACH ROW 
BEGIN
 INSERT INTO Customer_audit
 SET action = 'update',
     customerID = OLD.customerID,
     customerAddress = OLD.customerAddress,
     customerName = OLD.customerName,
     customerPhone = OLD.customerPhone,
     creditCard = OLD.creditCard,
     changedat = NOW();
     END $$

DELIMITER ;

SELECT customerName
FROM Customer
WHERE customerID = 610000;

UPDATE Customer 
SET 
    customerName = "sharkeisha"
WHERE
    customerID = 610000;

SELECT *
FROM Customer_audit;

SELECT customerName
FROM Customer
WHERE customerID = 610000;

--------------------------------------------
DELIMITER $$

CREATE TRIGGER before_Customer_DELETE 
    BEFORE DELETE ON Customer
    FOR EACH ROW 
BEGIN
 INSERT INTO Customer_audit
 SET action = 'delete',
     customerID = OLD.customerID,
     customerAddress = OLD.customerAddress,
     customerName = OLD.customerName,
     customerPhone = OLD.customerPhone,
     creditCard = OLD.creditCard,
     changedat = NOW();
     END $$

DELIMITER ;

SELECT customerName
FROM Customer
WHERE customerID = 630000;

DELETE FROM Customer 
WHERE customerID = 630000;

SELECT *
FROM Customer_audit;

SELECT customerName
FROM Customer
WHERE customerID = 630000;

-- 15. Create New Users 
CREATE USER Sonny
IDENTIFIED BY 'Secure1pass!';

SELECT user
FROM mysql.user;

-- EXIT;

SHOW GRANTS FOR Sonny;

GRANT SELECT
ON FoodDeliveryApp.Customer
TO Sonny;

SHOW GRANTS FOR Sonny;

GRANT INSERT, UPDATE, DELETE
ON FoodDeliveryApp.Customer
TO Sonny;

SHOW GRANTS FOR Sonny;

REVOKE SELECT
ON FoodDeliveryApp.Customer
FROM Sonny;

SHOW GRANTS FOR Sonny;

REVOKE INSERT, UPDATE, DELETE
ON FoodDeliveryApp.Customer
FROM Sonny;

SHOW GRANTS FOR Sonny;

-- 2nd user


CREATE USER Cher
IDENTIFIED BY 'Secure1pass!';

SELECT user
FROM mysql.user;

-- EXIT;

SHOW GRANTS FOR Cher;

GRANT SELECT
ON FoodDeliveryApp.Orders
TO Cher;

SHOW GRANTS FOR Cher;

GRANT INSERT, UPDATE, DELETE
ON FoodDeliveryApp.Orders
TO Cher;

SHOW GRANTS FOR Cher;

REVOKE SELECT
ON FoodDeliveryApp.Orders
FROM Cher;

SHOW GRANTS FOR Cher;

REVOKE INSERT, UPDATE, DELETE
ON FoodDeliveryApp.Orders
FROM Cher;

SHOW GRANTS FOR Cher;





