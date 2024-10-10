USE [Assignment - 3]

---------------------------------1. create table for products --------------------------------
CREATE TABLE Product(

	Product_id INT PRIMARY KEY IDENTITY(1,1),
	Product_code VARCHAR(10),
	Product_Name VARCHAR(255),
	Product_Desc VARCHAR(255),
	Manufacturer VARCHAR(255),
	Unit_Price DECIMAL(9, 2),
	Units_In_Stock INT
);
---------------------------------1. create table for products --------------------------------

----------------------------------2. create table for customer ----------------------------------------
create table Customer(
Customer_id INT PRIMARY KEY IDENTITY(1,2),
CustomerName VARCHAR(255),
Address VARCHAR(255),
ContactNumber VARCHAR(255),
CompanyName VARCHAR(255)
);
----------------------------------2. create table for customer END ----------------------------------------

------------------------------------3. Create table for order -----------------------------------------
create table Orders(
Orders_id INT PRIMARY KEY IDENTITY(1,1),
Customer_id INT FOREIGN KEY REFERENCES Customer(Customer_id),
Product_id INT FOREIGN KEY REFERENCES Product(Product_id),
Units_Ordered INT,
Order_Date DATETIME
);
------------------------------------3. Create table for order End -----------------------------------------

------------------------------------4. Insert the data for products ---------------------------------------------
insert into Product(Product_code, Product_Name, Product_Desc, Manufacturer, Unit_Price, Units_In_Stock)
values('P001', 'Laptop', '1TB RAM , 560gb DISK,', 'DELL', 1200.00, 50),
	  ('P002', 'Tablet', '2TB RAM , 620gb DISK,', 'LENOVO', 1500.00, 70),
	  ('P003', 'SmartPhone', '12GB RAM , 280gb ROM,', 'NOTHING_2', 120000.00, 20),
	  ('P004', 'Monitor', '32 inc Display', 'ASUS', 15000.00, 25),
	  ('P005', 'Mouse', '1000dpi, 3 buttons', 'Logitech', 8000.00, 88);

Select * FROM Product;

insert into Customer (CustomerName, Address, ContactNumber,CompanyName)
values('John doe', 'Hubli', '222-555-8989', 'Hindustan Lever Limited'),
	  ('Mac Matthew', 'Belgavi', '244-994-6868', 'ITC'),
	  ('Sam Shaw', 'Mangaluru', '556-558-5757', 'JSW'),
	  ('Alice robson', 'Banglauru', '464-686-2244', 'Texas Instruments'),
	  ('Robin Cincinnatti', 'Mysore', '231-084-0909', 'Seimens');

Select * from Customer;

insert into Orders (Customer_id, Product_id, Units_Ordered, Order_Date)
values(1, 1, 10, '2021-01-22 01:33:04'),
	  (3, 2, 3, '2021-04-02 05:23:00'),
	  (5, 3, 44, '2021-03-21 01:12:04'),
	  (7, 4, 1, '2021-04-12 01:34:04'),
	  (9, 5, 15, '2021-05-30 01:56:04');

Select * From Orders;
------------------------------------4. Insert the data for products End ---------------------------------------------

--------------------------------------5. select all products whose manufacture is hidustan lever limited -----------------------------------------------
--------------------------B. select manufacturer -------------------------
Select * from Customer Where CompanyName = 'Hindustan Lever Limited';
--------------------------B. select manufacturer End -------------------------


--------------------------C.Select all orders done in last one month and display in the format : Product_Name, Customer_Name, Company_Name, Order_Date.------------------------

SELECT p.Product_Name, c.CustomerName, c.CompanyName, o.Order_Date FROM ORDERS o
JOIN Product p ON o.Product_id = P.Product_id
JOIN Customer c ON o.Customer_id = c.Customer_id
WHERE o.Order_Date >= DATEADD(MONTH, -1, GETDATE());

--------------------------C.Select all orders done in last one month and display in the format : Product_Name, Customer_Name, Company_Name, Order_Date.End ------------------------

-----------------------------------D. Select all customer who have ordered for more than 10 items --------------------------------
SELECT c. Customer_id, 

SUM(o.Units_Ordered) AS Total_Units_Ordered 

FROM Customer c

JOIN Orders o ON c.Customer_id = o.Customer_id

GROUP BY c.Customer_id

HAVING SUM(o.Units_Ordered) > 10
ORDER BY Total_Units_Ordered DESC;
-----------------------------------D. Select all customer who have ordered for more than 10 items end --------------------------------

-------------------------------------------- E. insert order, customer, company, product names into another table -----------------------------------------
CREATE TABLE Order_summary(Product_Name VARCHAR(255), CustomerName VARCHAR(255), CompanyName VARCHAR(225), Order_Date DATETIME);
INSERT INTO Order_summary (Product_Name, CustomerName, CompanyName, Order_Date)
SELECT 
    p.Product_Name, 
    c.CustomerName, 
    c.CompanyName, 
    o.order_date
FROM orders o
JOIN Product p ON o.Product_id = p.Product_id
JOIN Customer c ON o.Customer_id = c.Customer_id;

SELECT * FROM Order_summary;
-------------------------------------------- E. insert order, customer, company, product names into another table end -----------------------------------------

---------------------------------------F. Find Average Unit_price for product of Hindustan Lever Limited-----------------------------------------------
SELECT AVG(Unit_Price) AS [Average unit price] FROM Product
WHERE Manufacturer = 'Hindustan Lever Limited';
---------------------------------------F. Find Average Unit_price for product of Hindustan Lever Limited End -----------------------------------------------

---------------------------------------G. Find the maximum and minimum Unit_Price for product of ‘Hindustan Lever Limited’...---------------------------
SELECT 
    MAX(Unit_Price) AS max_unit_price,
    MIN(Unit_Price) AS min_unit_price
FROM Product
WHERE Manufacturer = 'Hindustan Lever Limited';
---------------------------------------G.Find the maximum and minimum Unit_Price for product of ‘Hindustan Lever Limited’...End ---------------------------

---------------------------------------H.Alter Table to add column Total_Price to Orders table... ---------------------------------------

SELECT * 
FROM Product
WHERE Manufacturer = 'Hindustan Lever Limited';

WITH CTE AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY product_name, manufacturer ORDER BY product_id) AS row_num
    FROM Product
)
DELETE FROM CTE
WHERE row_num > 1;


SELECT * FROM Product;


ALTER TABLE Orders
ADD Total_Price DECIMAL(9,2);
---------------------------------------H. Alter Table to add column Total_Price to Orders table... END ---------------------------------------

-----------------------------I. Update Orders table to calculate the Total_Price......-------------------------
UPDATE Orders
SET Total_Price = ( SELECT o.Units_Ordered * p.Unit_Price FROM Product p
					WHERE o.Product_id = p.Product_id )
FROM Orders o;

Select * from Orders;
-----------------------------I. Update Orders table to calculate the Total_Price...... END-------------------------

------------------------------j. Alter Table to drop column Total_Price from Orders table---------------------
ALTER TABLE Orders
DROP COLUMN Total_Price;
------------------------------j. Alter Table to drop column Total_Price from Orders table END---------------------


---------------------------------K. Delete records from Product table where Unit in stock is 0.. -----------------------------------
DELETE FROM Product
WHERE Units_In_Stock = 0;
---------------------------------K. Delete records from Product table where Unit in stock is 0.. End-----------------------------------


-------------------------------------L. Alter table to change CompanyName from varchar(255) to varchar(125)..-------------------------------------
ALTER TABLE Customer
ALTER COLUMN CompanyName VARCHAR(125);
-------------------------------------L. Alter table to change CompanyName from varchar(255) to varchar(125).. End -------------------------------------


----------------------M. Select all customers having a total order of less than 5000 rupees and display in the format Customer_Name, Company_Name, Total_Order_Amount..--------------
SELECT c.CustomerName, c.CompanyName, o.Total_Price AS Total_Order_Amount FROM Customer c
JOIN Orders o ON c.Customer_id = o.Customer_id
WHERE o.Total_Price > 5000.00;

----------------------M. Select all customers having a total order of less than 5000 rupees and display in the format Customer_Name, Company_Name, Total_Order_Amount..End --------------


-----------------------------------N. Select all customers and display their total number of order. (Should display as 0 if a customer has not made any orders). ----------------------------
SELECT c.*, COALESCE(COUNT(o.Orders_id), 0) AS Total_Orders FROM Customer c
LEFT JOIN Orders o ON c.Customer_id = o.Customer_id
GROUP BY c.Customer_id, c.CustomerName, c.Address, c.ContactNumber, c.CompanyName
ORDER BY c.Customer_id;
-----------------------------------N. Select all customers and display their total number of order. (Should display as 0 if a customer has not made any orders). End ----------------------------

--------------------------------------5. select all products whose manufacture is hidustan lever limited END -----------------------------------------------


 ---------------------------------- 6. STORED PROCEDURES --------------------------------
 ------------A.Select all Product_Name, Customer_Name, Company_Name, Order_Date----------
 CREATE PROCEDURE SelectAll 

	AS
BEGIN
    SELECT 
        p.Product_Name AS Product_Name,
        c.CustomerName AS Customer_Name,
        c.CompanyName AS Company_Name,
        o.Order_Date AS Order_Date
    FROM orders o
    JOIN Product p ON o.product_id = p.Product_id
    JOIN Customer c ON o.Customer_id = c.Customer_id;
END;

EXEC SelectAll;
 ------------A.Select all Product_Name, Customer_Name, Company_Name, Order_Date End ----------


 -----------------------B. Insert all Order----------------
 
CREATE PROCEDURE InsertRowOrder
    @customerid INT,
    @productid INT,
    @unitsordered INT,
    @orderdate DATETIME
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Customer WHERE Customer_id = @customerid)
    BEGIN
        PRINT 'Error: Customer ID does not exist.';
        RETURN;  -- Exit the procedure if the customer does not exist
    END

    IF NOT EXISTS (SELECT 1 FROM Product WHERE Product_id = @productid)
    BEGIN
        PRINT 'Error: Product ID does not exist.';
        RETURN;  -- Exit the procedure if the product does not exist
    END

    INSERT INTO Orders (Customer_id, Product_id, Units_Ordered, Order_Date)
    VALUES (@customerid, @productid, @unitsordered, @orderdate);
    
    PRINT 'Order inserted successfully.';
END;
EXEC InsertRowOrder @customerid = 11, @productid = 6, @unitsordered = 5, @orderdate = '2024-10-10';





CREATE PROCEDURE DeleteOrdersWithNullValues
AS
BEGIN
    DELETE FROM Orders
    WHERE customer_id IS NULL OR
          product_id IS NULL OR
          units_ordered IS NULL OR
          order_date IS NULL;
END;
EXEC DeleteOrdersWithNullValues;

Select * from Orders;
 -----------------------B. Insert all Order End ----------------

 ---------------------C.Update data in product table. SP should except params @productid, , @unitsinstock-----------------------------------

 CREATE PROCEDURE UpdateProductUnitsInStocks
    @productid INT,
    @unitsinstock INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Product WHERE Product_id = @productid)
    BEGIN
        PRINT 'Error: Product ID does not exist.';
        RETURN;  -- Exit the procedure if the product does not exist
    END

    UPDATE Product
    SET Units_In_Stock = @unitsinstock
    WHERE Product_id = @productid;

    PRINT 'Product units in stock updated successfully.';
END;
EXEC UpdateProductUnitsInStocks @productid = 1, @unitsinstock = 50;

Select * FROM Product;
 ---------------------C.Update data in product table. SP should except params @productid, , @unitsinstock End -----------------------------------

 ---------------------------D. To update the unit_price of the product whose product_id is 1. If Unit_in_stock is greater than 1000, then decrease by 10% else decrease by 5% --------------------
 CREATE PROCEDURE UpdateProductUnitPrice
    @productid INT
AS
BEGIN
    DECLARE @current_price DECIMAL(10, 2);
    DECLARE @units_in_stock INT;

    SELECT @current_price = unit_price, @units_in_stock = units_in_stock
    FROM Product
    WHERE Product_id = @productid;

    IF @current_price IS NULL
    BEGIN
        PRINT 'Error: Product ID does not exist.';
    END

    IF @units_in_stock > 1000
    BEGIN
        SET @current_price = @current_price * 0.90;  -- Decrease by 10%
    END
    ELSE
    BEGIN
        SET @current_price = @current_price * 0.95;  -- Decrease by 5%
    END

    UPDATE Product
    SET Unit_Price = @current_price
    WHERE Product_id = @productid;

    PRINT 'Product unit price updated successfully.';
END;
EXEC UpdateProductUnitPrice @productid = 1;

 ---------------------------D.To update the unit_price of the product whose product_id is 1. If Unit_in_stock is greater than 1000, then decrease by 10% else decrease by 5% End --------------------