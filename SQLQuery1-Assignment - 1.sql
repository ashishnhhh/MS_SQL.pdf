use [Assignment-1]
----------Department Query----------------
select * from Department_Master;

insert into Department_Master(department_code, department_Name, department_Location, department_Status)
values('IT','Information_Tech','Mysore',1),
	  ('MAR','Marketing','Mysore',1),
	  ('DEV','Development','Mysore',1),
	  ('HR','Human_Resource','Mysore',1);
----------Department Query End----------------

------create Employee_Details----------
create table Employee_details(
Staff_ID INT PRIMARY KEY IDENTITY(1,1),
First_Name VARCHAR(50),
Last_Name VARCHAR(50),
Mail_ID VARCHAR(100),
ReportingTo INT,
department_code INT,
Phone VARCHAR(50),
Mobile_Number VARCHAR(50),
Employed_Country VARCHAR(50),
Employment_Date DATETIME,
Date_Of_Joining DATETIME,
City VARCHAR(90),
Salary VARCHAR(90),

CONSTRAINT FK_Department FOREIGN KEY(department_code)
REFERENCES Department_Master(department_Id));

SELECT * FROM Employee_details;

--------------------insert to values & details----------------
insert into Employee_Details(First_Name, Last_Name, Mail_Id, ReportingTo, department_code, Phone, Mobile_Number, Employed_Country, Employment_Date
           ,Date_Of_Joining, City, Salary)
values('Arjun','Kumar','arjun.k@gmail.com',101, 2,'123-556-8888','904577956', 'INDIA','2019-03-15', '2002-01-16', 'Mysore', 45000.46),
	  ('John', 'Doe', 'john.doe@example.com', 102, 1, '123-456-7890', '987-654-3210','INDIA', '2022-01-15', '2008-10-30', 'Mysore', 65000.50),
	  ('Alice', 'Johnson', 'alice.j.j@gmail.com', 103, 1, '555-111-2222', '444-343-3322', 'INDIA', '2012-05-21', '2002-05-22', 'Mysore', 58000.75),
	  ('Abhishek', 'Jain', 'a.j@gmail.com', 104, 3, '534-190-2445', '404-303-2002', 'INDIA', '2022-07-21', '2009-05-22', 'London', 58000.75),
	('Nihar', 'Amte', 'nihar@gmail.com', 105, 2, '779-990-0000','666-886-8989','INDIA','2022-10-22','2001-12-17','Mysore',70000.90);

SELECT * FROM Employee_details;
--------------------insert to values & details end----------------



-------------------------1. employee details whose departmet_name is MARKETING------------------
SELECT e.Staff_ID, e.First_Name, e.Last_Name, e.Mail_ID, e.ReportingTo, e.department_code,e.Phone, e.Mobile_Number, 
       e.Employed_Country, e.Employment_Date, e.Date_Of_Joining, e.City, e.Salary
FROM Employee_Details e
JOIN Department_Master d
ON e.department_code = d.department_id
WHERE d.department_Name = 'Marketing';
-------------------------1. employee details whose departmet_name is MARKETING Ends------------------



------------------------2. updating employee details salary regarding to date of joining-------------------------
UPDATE Employee_Details
SET Salary = Salary * 1.1
WHERE Date_Of_Joining > '2008-01-01';

select * from Employee_Details;

ALTER TABLE Employee_Details
ALTER COLUMN Salary DECIMAL(18,2);

select * from Employee_Details;

select Staff_Id, First_Name, Last_Name, Salary
FROM Employee_Details;

select * from Employee_Details;
------------------------2. updating employee details salary regarding to date of joining Ends-------------------------




---------------------3. inserting data from employeedetails table to archived employee details--------------------------
CREATE TABLE Archived_Employee_Details (
	Staff_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Mail_ID VARCHAR(100),
    ReportingTo INT,
    Department_Code INT,
    Phone VARCHAR(50),
    Mobile_Number VARCHAR(50),
    Employed_Country VARCHAR(50),
    Employment_Date DATETIME,
    Date_Of_Joining DATETIME,
    City VARCHAR(50),
    Salary DECIMAL  -- or DECIMAL(18, 2) as per your choice
);

select * from Archived_Employee_Details;




INSERT INTO Archived_Employee_Details 
    (Staff_ID, First_Name, Last_Name, Mail_ID, ReportingTo, Department_Code, Phone, Mobile_Number, Employed_Country, Employment_Date, Date_Of_Joining, City, Salary)
SELECT 
    e.Staff_ID, 
    e.First_Name, 
    e.Last_Name, 
    e.Mail_ID, 
    e.ReportingTo, 
    e.Department_Code, 
    e.Phone, 
    e.Mobile_Number, 
    e.Employed_Country, 
    e.Employment_Date, 
    e.Date_Of_Joining, 
    e.City, 
    e.Salary
FROM 
    Employee_Details e
WHERE 
    NOT EXISTS (
        SELECT 1 
        FROM Archived_Employee_Details a 
        WHERE a.Staff_ID = e.Staff_ID
    );

	select * from Archived_Employee_Details;

---------------------3. inserting data from employeedetails table to archived employee details--------------------------




---------------------------------4. select all employees where employee salary is greater than the maximum salary of department 'Marketing'------------------------
SELECT *
FROM Employee_Details
WHERE Salary > (
	Select MAX (Salary)
	FROM Employee_Details
	Where department_code=(SELECT department_Id
						   FROM Department_Master
						   WHERE department_Name = 'Marketing')
	);
	---------------------------------4. select all employees where employee salary is greater than the maximum salary of department 'Marketing' Ends------------------------



--------------------------------5.find the average salary of each department and display records----------------------------------------------------

SELECT 
e.Department_Code, 
d.Department_Name, 
AVG(e.Salary) AS Average_Salary

FROM 
    Employee_Details e
JOIN 
    Department_Master d
ON 
    e.Department_Code = d.Department_ID
GROUP BY 
    e.Department_Code, 
    d.Department_Name;

--------------------------------5.find the average salary of each department and display records----------------------------------------------------

-------------------------------6. find max and min salary & Display records -------------------------------------------------

SELECT Staff_ID, First_Name, Last_Name, Salary
FROM Employee_Details
WHERE Salary = (SELECT MAX(Salary) FROM Employee_Details)
UNION

SELECT Staff_ID, First_Name, Last_Name, Salary
FROM Employee_Details
WHERE Salary = (SELECT MIN(Salary) FROM Employee_Details);

-------------------------------6. find max and min salary & Display records ends -------------------------------------------------


------------------------------------- 7. Dearness Allowence & Professional Tax --------------------------------------------
SELECT 
Staff_Id,
First_Name,
Last_Name,
Salary,
(Salary * 0.50) AS Da,
(Salary * 0.05) AS Professional_Tax,
(Salary + (Salary * 0.50) - (Salary * 0.05)) AS Net_Salary

FROM
Employee_details;
------------------------------------- 7. Dearness Allowence & Professional Tax End  ---------------------------------------


---------------------------8. departments having more than 2 employees -----------------------------------
SELECT 
    e.Department_Code, 
    d.Department_Name, 
    COUNT(e.Staff_ID) AS Employee_Count
FROM 
    Employee_Details e
JOIN 
    Department_Master d
ON 
    e.Department_Code = d.Department_ID
GROUP BY 
    e.Department_Code, 
    d.Department_Name
HAVING 
    COUNT(e.Staff_ID) > 2;

---------------------------8. departments having more than 2 employees end -----------------------------------


 -------------------9. Alter table "Department_Master" to change the "department_Name" from varchar(20) to varchar(40) ------------------------ ALTER table Department_Master ALTER COLUMN department_Name VARCHAR(100); -------------------9. Alter table "Department_Master" to change the "department_Name" from varchar(20) to varchar(40) ------------------------ -----------------------------------10. Alter the table by adding the column department_manager to department_Master ------------------------------------ALTER TABLE Department_Master
ADD Department_Manager VARCHAR(50);Select * from Department_Master; -----------------------------------10. Alter the table by adding the column department_manager to department_Master ------------------------------------ ----------------------------------11. Alter the table by deleting the column--------------------------------- ALTER TABLE Department_Master
DROP column Department_Manager;
Select * from Department_Master;WITH CTE AS (
    SELECT 
        Department_ID, 
        Department_Name, 
        ROW_NUMBER() OVER (PARTITION BY Department_Name ORDER BY Department_ID) AS RowNum
    FROM 
        Department_Master
)
DELETE FROM CTE
WHERE RowNum > 1;

Select * from Department_Master; ----------------------------------11. Alter the table by deleting the column--------------------------------- ------------------------ 12. UPDATE SALARY -------------------- UPDATE Employee_Details
SET Salary = Salary + 1000
WHERE Date_Of_Joining BETWEEN '2005-01-01' AND '2010-01-01';

select * from Employee_details; ------------------------ UPDATE SALARY END -------------------------------------------------13.Delete records from Department_Master-----------------------------------DELETE FROM Department_Master
WHERE Department_Status = 2;
select * from Department_Master;----------------------------- 13. Delete records from Department_Master end ---------------------------------------Stored Procedures----
--------------------A. To get the details of the all the employees-------------------
Create Procedure GetAllEmployeeDetails
AS
BEGIN
SELECT * FROM Employee_details;
END;
exec GetAllEmployeeDetails;
--------------------A. To get the details of the all the employees end-------------------



---------------------B.GetAllTheDeatailsOfDepartment----------------------------------
CREATE PROCEDURE GETALLDETAILSOFDEPARTMENT
AS
BEGIN

SELECT * FROM Department_Master;

END;
EXEC GETALLDETAILSOFDEPARTMENT;
---------------------B.GetAllTheDeatailsOfDepartment End ----------------------------------



--------------------------C. adding new department into department master -----------------------------------
CREATE PROCEDURE AddNewDepartment
				@department_code VARCHAR(50),
				@department_Name VARCHAR(255),
				@department_Location VARCHAR(255),
				@department_Status BIT
AS
BEGIN

INSERT INTO Department_Master(department_Code, department_Name, department_Location, department_Status)
VALUES(@department_code, @department_Name, @department_Location, @department_Status);

SELECT 'Department added succcessfully' AS Message;
END;

EXEC AddNewDepartment 
    @department_Code = 'ADV', 
    @department_Name = 'Advertisment', 
    @department_Location = 'Banglore', 
    @department_Status = 0;

Select * from Department_Master;




CREATE PROCEDURE DeleteDepartmentByID
    @department_Id INT  -- The unique ID to identify the department
AS
BEGIN
    -- Delete the row where the ID matches the input parameter
    DELETE FROM Department_Master
    WHERE department_Id = @department_Id;

    -- Optionally, return a success message or code
    SELECT 'Department deleted successfully' AS Message;
END;

EXEC DeleteDepartmentByID @department_Id = 29;

SELECT * FROM Department_Master
--------------------------C. adding new department into department master End -----------------------------------




----------------------------D. Adding new employee row to the employee details table --------------------------------
CREATE PROCEDURE AddNewEmployment
				@First_Name VARCHAR(255),
				@Last_Name VARCHAR(255),
				@Mail_Id VARCHAR(50),
				@ReportingTo INT,
				@department_code INT,
				@Phone VARCHAR(50),
				@Mobile_Number VARCHAR(50),
				@Employed_Country VARCHAR(50),
				@Employment_Date DATETIME,
				@Date_Of_Joining DATETIME,
				@City VARCHAR(90),
				@Salary VARCHAR(90)

AS
BEGIN
		INSERT INTO Employee_details (First_Name, Last_Name, Mail_ID, ReportingTo, department_code, Phone ,Mobile_Number, Employed_Country, Employment_Date, Date_Of_Joining, City, Salary)
		VALUES (@First_Name, @Last_Name, @Mail_Id, @ReportingTo, @department_code, @Phone, @Mobile_Number, @Employed_Country, @Employment_Date
				,@Date_Of_Joining, @City, @Salary)

SELECT 'Department added succcessfully' AS Message;
END;

EXEC AddNewEmployment 
				@First_Name = 'Ashish',
				@Last_Name = 'Hansbhavi',
				@Mail_Id = 'ashish.h@gmail.com',
				@ReportingTo = '2',
				@department_code = '3',
				@Phone = '9980457824',
				@Mobile_Number = '9035143951',
				@Employed_Country = 'India',
				@Employment_Date = '2024-09-13',
				@Date_Of_Joining = '2024-07-17',
				@City =  'Mysore',
				@Salary = '10000.00'

	SELECT * FROM Employee_details;





CREATE PROCEDURE GetEmployeeIDByStaffID
    @Staff_ID INT 
AS
BEGIN
    
    SELECT First_name
    FROM Employee_details
    WHERE Staff_ID = @Staff_ID

	SELECT 'Department added succcessfully' AS Message;

END;

exec  GetEmployeeIDByStaffID @Staff_ID = 6;
----------------------------D. Adding new employee row to the employee details table End --------------------------------

----------------------------E. Update the employee deatils from Employee_details ---------------------------
CREATE PROCEDURE UpdateEmployeeDetails
    @staff_ID INT,                     
	@First_Name VARCHAR(255),
	@Last_Name VARCHAR(255),
	@Mail_Id VARCHAR(50),
	@ReportingTo INT,
	@department_code INT,
	@Phone VARCHAR(50),
	@Mobile_Number VARCHAR(50),
	@Employed_Country VARCHAR(50),
	@Employment_Date DATETIME,
	@Date_Of_Joining DATETIME,
	@City VARCHAR(90),
	@Salary VARCHAR(90)         
AS
BEGIN
    -- Update the employee details for the specified staff ID
    UPDATE Employee_details
    SET 
        First_Name = @First_Name,
        Last_Name = @Last_Name,
        Mail_Id = @Mail_Id,
        ReportingTo = @ReportingTo,
        department_code = @department_code,
        Phone = @phone,
        Mobile_Number = @Mobile_Number,
        Employed_Country = @Employed_Country,
        Date_Of_Joining = @Date_Of_Joining,
        City = @city,
        Salary = @salary
    WHERE Staff_ID = @staff_ID;

    -- Optionally, return a success message or confirmation
    SELECT 'Employee details updated successfully' AS Message;
END;


EXEC UpdateEmployeeDetails 
    @Staff_ID = 6, 
    @First_Name = 'John', 
    @Last_Name = 'Doe', 
    @Mail_Id = 'john.doe@example.com', 
    @reportingto = 2, 
    @department_code = 101, 
    @phone = '123-456-7890', 
    @Mobile_Number = '987-654-3210', 
    @Employed_Country = 'USA', 
    @Date_Of_Joining = '2024-01-01',
	@Employment_Date = '2018-09-23',
    @city = 'San-Fransisco', 
    @salary = 90000.00;

	Select * from Employee_details;
----------------------------E. Update the employee deatils from Employee_details End ---------------------------

-------------------------------------F. update salary on work experience ----------------------------------------
CREATE PROCEDURE UpdateEmployeeSalary
    @staffid INT  -- Staff ID of the employee to update
AS
BEGIN
    DECLARE @currentSalary DECIMAL(18, 2);
    DECLARE @workExperience INT;
    DECLARE @dateOfJoining DATETIME;
	DECLARE @NewSalary NUMERIC(10, 2);
	DECLARE @HikePercent FLOAT;

    -- Get the current salary and date of joining of the employee
    SELECT @currentSalary = Salary, @dateOfJoining = Date_Of_Joining
    FROM Employee_details
    WHERE staff_Id = @staffid;

    -- Calculate work experience in years
    SET @workExperience = DATEDIFF(YEAR, @dateOfJoining, GETDATE());

    -- Check if work experience is greater than 3 years and update salary accordingly
    IF @workExperience > 3
		SET @HikePercent = 0.20;
	ELSE
		SET @HikePercent = 0.10;

	SET @NewSalary = @currentSalary * (1 + @HikePercent);

	UPDATE Employee_details
	SET Salary = @NewSalary
	WHERE Staff_ID = @staffid;
END;

	EXEC UpdateEmployeeSalary @staffid = 2;
	select * from Employee_details;

-------------------------------------F. update salary on work experience Ends ----------------------------------------

------------------------------------ G. Display employee work experience ----------------------------------------
CREATE PROCEDURE DisplayEmployeeWorkExperice
AS
BEGIN

SELECT
	CONCAT(First_Name, '' ,Last_Name) AS EmployeeName,
	DATEDIFF(YEAR, Date_Of_Joining, GETDATE()) AS YearsOfExperience

	FROM
	Employee_details;

END;

exec DisplayEmployeeWorkExperice;
------------------------------------ G. Display employee work experience End ----------------------------------------