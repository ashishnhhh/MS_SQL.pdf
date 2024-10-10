use [Assignment - 2]

---------A. create userDetails Table------------------
CREATE TABLE UserDetails (
    UserId INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(255) NOT NULL,
    User_Type INT NOT NULL CHECK (User_Type IN (1, 2))
);

SELECT * FROM UserDetails;
---------A. create userDetails Table end ------------------

-----------B. insert values in userdetails table -------------
INSERT INTO UserDetails(username, User_Type)
VALUES('Sam', 1),
	  ('Mac', 2),
	  ('David', 2),
	  ('John', 1);

	  SELECT * FROM UserDetails;
-----------B. insert values in userdetails table End -------------

------------C. create table UserPersonalInfo table --------------
CREATE TABLE UserPersonalInfo (
    UserPersonalInfoId INT PRIMARY KEY IDENTITY,
    UserId INT FOREIGN KEY REFERENCES UserDetails(UserId),
    First_Name VARCHAR(255),
    Last_Name VARCHAR(255),
    Email_Id VARCHAR(255),
    DOB DATETIME,
    Address VARCHAR(MAX),
    City VARCHAR(MAX),
    State VARCHAR(MAX),
    Country VARCHAR(MAX),
    Salary DECIMAL(18,2),
    DOJ VARCHAR(MAX),
);

SELECT * FROM UserPersonalInfo;
------------C. create table UserPersonalInfo table end --------------

------------ D. Insert datainto user personal details -----------------
INSERT iNTO UserPersonalInfo (UserId, First_Name,Last_Name,Email_Id,DOB,Address,City,State,Country,Salary,DOJ)
VALUES(1,'Sam', 'Sameual', 'sam.m@gamil.com', '1995-06-12 08:26:04', '333, maxwell street', 'Bengaluru', 'Karnataka','Bharat', 20000.00, '2022-06-13'),
	  (2,'Mac', 'Jason', 'mac.j@gamil.com', '1998-10-01 02:13:02', '445, rosewell street', 'Hubballi', 'Karnataka','Bharat', 50000.00, '2021-11-03'),
	  (3,'David', 'Johnson', 'david.j@gamil.com', '1997-11-02 01:25:14', '335, haven street', 'Bengaluru', 'Karnataka','Bharat', 33000.00, '2020-12-09'),
	  (4,'John', 'Matthew', 'john.m@gamil.com', '1999-02-14 03:33:14', 'kalasipalya, G.G street', 'Bengaluru', 'Karnataka','Bharat', 40000.00, '2023-09-24');
------------ D. Insert datainto user personal details End -----------------


-----------------1. select all admin users --------------------------------------------
SELECT *
FROM UserDetails
WHERE User_Type = 1;

-----------------1. select all admin users End --------------------------------------------



-------------------------------------2. update salary of the employees who joined after 2008 ------------------------------------------------
UPDATE UserPersonalInfo
SET Salary = 60000
WHERE CAST(DOJ AS DATE) > '2008-01-01';


UPDATE UserPersonalInfo
SET Salary = 0;

UPDATE UserPersonalInfo
SET Salary = 20000.00
WHERE UserId = 1;

UPDATE UserPersonalInfo
SET Salary = 34000.00
WHERE UserId = 2;

UPDATE UserPersonalInfo
SET Salary = 55000.00
WHERE UserId = 3;

UPDATE UserPersonalInfo
SET Salary = 63000.00
WHERE UserId = 4;

-------------------------------------2. update salary of the employees who joined after 2008 end ------------------------------------------------

-----------------------------------3. insert User personal info table into other table ---------------------------------------------------
CREATE TABLE ArchivedUserPersonalInfo(
	UserPersonalInfoId INT PRIMARY KEY IDENTITY,
    UserId INT FOREIGN KEY REFERENCES UserDetails(UserId),
    First_Name VARCHAR(255),
    Last_Name VARCHAR(255),
    Email_Id VARCHAR(255),
    DOB DATETIME,
    Address VARCHAR(MAX),
    City VARCHAR(MAX),
    State VARCHAR(MAX),
    Country VARCHAR(MAX),
    Salary DECIMAL(18,2),
    DOJ VARCHAR(MAX),
);

INSERT INTO ArchivedUserPersonalInfo (UserId, First_Name, Last_Name, Email_Id, DOB, Address, City, State, Country, Salary, DOJ)
VALUES (1,'Sam', 'Sameual', 'sam.m@gamil.com', '1995-06-12 08:26:04', '333, maxwell street', 'Bengaluru', 'Karnataka','Bharat', 20000.00, '2022-06-13'),
	  (2,'Mac', 'Jason', 'mac.j@gamil.com', '1998-10-01 02:13:02', '445, rosewell street', 'Hubballi', 'Karnataka','Bharat', 50000.00, '2021-11-03'),
	  (3,'David', 'Johnson', 'david.j@gamil.com', '1997-11-02 01:25:14', '335, haven street', 'Bengaluru', 'Karnataka','Bharat', 33000.00, '2020-12-09'),
	  (4,'John', 'Matthew', 'john.m@gamil.com', '1999-02-14 03:33:14', 'kalasipalya, G.G street', 'Bengaluru', 'Karnataka','Bharat', 40000.00, '2023-09-24');

 SELECT * FROM ArchivedUserPersonalInfo;
-----------------------------------3. insert User personal info table into other table End ---------------------------------------------------



-----------------------------------4. admin user type whose salary is greater than the maximum-----------------------------------------------
SELECT *
FROM UserPersonalInfo
WHERE Salary > (SELECT MAX(Salary) 
                FROM UserPersonalInfo upi
                JOIN UserDetails ud ON upi.UserId = ud.UserId
                WHERE ud.User_Type = 2);

SELECT *
FROM UserPersonalInfo
WHERE Salary > (SELECT MAX(Salary) 
                FROM UserPersonalInfo upi
                JOIN UserDetails ud ON upi.UserId = ud.UserId
                WHERE ud.User_Type = 1);
-----------------------------------4. admin user type whose salary is greater than the maximum End -----------------------------------------------


-----------------------------------5.select max and min salary and display -------------------------------------------------------

SELECT UserPersonalInfoId, First_Name, Last_Name, Salary
FROM UserPersonalInfo
WHERE Salary = (SELECT MAX(Salary) FROM UserPersonalInfo)
UNION
SELECT UserPersonalInfoId, First_Name, Last_Name, Salary
FROM UserPersonalInfo
WHERE Salary = (SELECT MIN(Salary) FROM UserPersonalInfo);

-----------------------------------5.select max and min salary and display  END-------------------------------------------------------


--------------------------------- 6. da professional Tax net salary-------------------------------------
SELECT UserPersonalInfoId, First_Name, Last_Name, Salary,
(0.50 * Salary) AS DA,
(0.05 * Salary) AS Professional_Tax,
(Salary + (0.50 * Salary) - (0.05 * Salary)) AS Net_Salary
FROM UserPersonalInfo;
--------------------------------- 6. da professional Tax net salary End -------------------------------------


---------------------------------- 7. Display the avg salary of the user refering to user_type --------------------------------------
SELECT 
    ud.User_Type, 
    AVG(upi.Salary) AS Average_Salary
FROM 
    UserPersonalInfo upi
JOIN 
    UserDetails ud ON upi.UserId = ud.UserId
GROUP BY 
    ud.User_Type;

---------------------------------- 7. Display the avg salary of the user refering to user_type End --------------------------------------

-------------------------------8. alter the table datatype value of iseerdetails -----------------------------------------
ALTER TABLE UserDetails
ALTER COLUMN username varchar(50);
-------------------------------8. alter the table datatype value of iseerdetails end -----------------------------------------

---------------------------------------9. add alter the table userpersonaldetails ---------------------------------------
ALTER TABLE UserPersonalInfo
ADD Age INT;

select * from UserPersonalInfo;
---------------------------------------9. add alter the table userpersonaldetails end ---------------------------------------

-----------------------------------10. alter the table add column user-status, Alter the tablen to drop the column user-status--------------------------------
ALTER TABLE UserPersonalInfo
ADD user_status VARCHAR(50);

ALTER TABLE UserPersonalInfo
DROP column user_status;

-----------------------------------10. alter the table add column user-status, Alter the tablen to drop the column user-status End --------------------------------


----------------------------------11. updaTE UserPersonal------------------------------------------

UPDATE UserPersonalInfo
SET Age = DATEDIFF(YEAR, DOB, GETDATE());

select * from UserPersonalInfo;
----------------------------------11. updaTE UserPersonal END------------------------------------------

------------------------------------12. delete the data for status in 2 ---------------------------------------------------
ALTER TABLE UserPersonalInfo
ADD user_status VARCHAR(225);

UPDATE UserPersonalInfo
SET user_status = CASE 
    WHEN UserId = 1 THEN 5
    WHEN UserId = 2 THEN 10
    WHEN UserId = 3 THEN 15
    WHEN UserId = 4 THEN 20
    -- Add more UserId cases as needed
    ELSE user_status -- Keep current status if UserId doesn't match
END
WHERE UserId IN (1, 2, 3, 4); -- Include all UserIds you want to update


DELETE FROM UserPersonalInfo
WHERE User_status = 5;
------------------------------------12. delete the data for status in 2 end ---------------------------------------------------






--------------------STORED PROCEDURE-------------------------

--------------------- A. get details of all users---------------
CREATE PROCEDURE GetAllUserUserDetails
AS
BEGIN

SELECT * FROM UserDetails;

END;

EXEC GetAllUserUserDetails;
--------------------- A. get details of all users End---------------

------------------------------B. get details from user personal info -------------------------------
CREATE PROCEDURE Get_All_PersonalInfo
AS
BEGIN

SELECT * FROM UserPersonalInfo;

END;

EXEC Get_All_PersonalInfo;
------------------------------B. get details from user personal info -------------------------------

----------------------------C. Add new user to user details-------------------------
CREATE PROCEDURE Add_User_UserDetails
				@UserName VARCHAR(255),
				@User_Type INT 
AS
BEGIN
		INSERT INTO UserDetails(username, User_Type)
		VALUES(@UserName, @User_Type);
END;

EXEC Add_User_UserDetails
	 @UserName = 'Ram',
	 @User_Type = 2

SELECT * FROM UserDetails;
----------------------------C. Add new user to user details End -------------------------

--------------------------------D. add new user to user personal details------------------------------------
CREATE PROCEDURE Add_user_PersonalDetails
								        @UserId INT,
										@First_Name VARCHAR(255),
										@Last_Name VARCHAR(255),
										@Email_Id VARCHAR(255),
										@DOB DATETIME,
										@Address VARCHAR(MAX),
										@City VARCHAR(MAX),
										@State VARCHAR(MAX),
										@Country VARCHAR(MAX),
										@Salary DECIMAL(18,2),
										@DOJ VARCHAR(MAX)

AS
BEGIN
	 INSERT INTO UserPersonalInfo (UserId, First_Name, Last_Name, Email_Id, DOB, Address, City, State, Country, Salary, DOJ)
	 VALUES(@UserId, @First_Name, @Last_Name, @Email_Id, @DOB, @Address, @City, @State, @Country, @Salary, @DOJ);

	 SELECT 'user added successfully' AS MESSAGE;
END;

EXEC Add_user_PersonalDetails
								@UserId =  5,
								@First_Name = 'Ram',
								@Last_Name = 'sundar',
								@Email_Id = 'ram.s@gmail.com',
								@DOB = '1998-03-17',
								@Address = 'Indraprastha 3 main',
								@City = 'Hubballi',
								@State = 'Karnataka',
								@Country = 'Bharat',
								@Salary = 60000.00,
								@DOJ = '2024-07-13';

SELECT * FROM UserPersonalInfo;
--------------------------------D. add new user to user personal details end ------------------------------------


--------------------------------E. Updating the personal details table ---------------------------------------
CREATE PROCEDURE UpdateUserPersonalInfo
    @UserPersonalInfoId INT,
    @UserId INT,
    @First_Name VARCHAR(255),
    @Last_Name VARCHAR(255),
    @Email_Id VARCHAR(255),
    @DOB DATETIME,
    @Address VARCHAR(MAX),
    @City VARCHAR(MAX),
    @State VARCHAR(MAX),
    @Country VARCHAR(MAX),
    @Salary DECIMAL(18,2),
    @DOJ VARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    -- Update the UserPersonalInfo record
    UPDATE UserPersonalInfo
    SET 
        UserId = @UserId,
        First_Name = @First_Name,
        Last_Name = @Last_Name,
        Email_Id = @Email_Id,
        DOB = @DOB,
        Address = @Address,
        City = @City,
        State = @State,
        Country = @Country,
        Salary = @Salary,
        DOJ = @DOJ
    WHERE 
        UserPersonalInfoId = @UserPersonalInfoId;
END;

EXEC UpdateUserPersonalInfo 
    @UserPersonalInfoId = 2, -- ID of the record to update
    @UserId = 2,
    @First_Name = 'shyam',
    @Last_Name = 'sundar',
    @Email_Id = 'shyam.s@gmail.com',
    @DOB = '2000-08-15',
    @Address = 'Anand Nagar 2 main',
    @City = 'Hubballi',
    @State = 'Karnataka',
    @Country = 'Bharat',
    @Salary = 65000.00,
    @DOJ = '2022-10-01';

	SELECT * FROM UserPersonalInfo;
--------------------------------E. Updating the personal details table End ---------------------------------------

--------------------------------F. To update the salary of User Personnal Info with UserPersonalInfoId is 1.condition for updating is If work experience is greater than 3 year, then give a hike of 20% Else if less than 3 years, then give a hike of 10% (Use if – else statement) -------------------------------------------------------------
CREATE PROCEDURE Updating_Salary_Hike @UserPersonalInfoId INT
AS
DECLARE @DOJ DATETIME;
DECLARE @currentSalary NUMERIC(10, 2);
DECLARE @newSalary NUMERIC(10, 2);
DECLARE @workExperience INT;
DECLARE @hikePercent FLOAT;

SELECT @DOJ = DOJ, @currentSalary = Salary FROM UserPersonalInfo
WHERE UserPersonalInfoId = @UserPersonalInfoId;

SET @workExperience = DATEDIFF(YEAR, @DOJ, GETDATE());

IF @workExperience > 3
	SET @hikePercent = 0.20;
ELSE
    SET @hikePercent = 0.10;

SET @newSalary = @currentSalary * (1 + @hikePercent);

UPDATE UserPersonalInfo
SET Salary = @newSalary
WHERE UserPersonalInfoId = @UserPersonalInfoId;
GO

EXEC Updating_Salary_Hike @UserPersonalInfoId = 5;


select * from UserPersonalInfo;

--------------------------------F. To update the salary of User Personnal Info with UserPersonalInfoId is 1.condition for updating is If work experience is greater than 3 year, then give a hike of 20% Else if less than 3 years, then give a hike of 10% (Use if – else statement) End -------------------------------------------------------------

------------------------------------------------G. Display work experience --------------------------------------------------
SELECT 
    CONCAT(First_Name, ' ', Last_Name) AS UserName,
    DATEDIFF(YEAR, CAST(DOJ AS DATE), GETDATE()) AS YearsOfExperience
FROM 
    UserPersonalInfo;

------------------------------------------------G. Display work experience End --------------------------------------------------