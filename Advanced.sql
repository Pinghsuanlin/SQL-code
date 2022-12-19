/*CTE: act as subquery but doen't store in memory*/
WITH CTE_Employee AS (
SELECT FirstName, LastName, Gender, Salary
, COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender
, AVG(Salary) OVER (PARTITION BY Gender) AS AvgSalary
FROM SQLTutorial..Employee dem
JOIN SQLTutorial..EmployeeSalary sal
ON dem.EmployeeID=sal.EmployeeID
WHERE Salary > '45000'
)
SELECT FirstName, AvgSalary
FROM CTE_Employee
--we need to run with the entire cte everytime, and must be directly used after the cte is created.



/*
Temp table=temporary table but we can use it multiple times
*/

CREATE TABLE #temp_employee
(
EmployeeID int,
JobTitle varchar(100),
Salary int
)

Select * From #temp_employee--empty

INSERT INTO #temp_employee VALUES(
'1001', 'HR', '45000'
)

--or insert a whole table right away
INSERT INTO #temp_employee
SELECT * From SQLTutorial..EmployeeSalary

Select * From #temp_employee



DROP TABLE IF EXISTS #temp_employee2--to avoid we run into error after we created the table already
Create table #temp_employee2 (
JobTitle varchar(100),
EmployeesPerJob int ,
AvgAge int,
AvgSalary int
)


Insert into #temp_employee2
SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(salary)
FROM SQLTutorial..Employee emp
JOIN SQLTutorial..EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
group by JobTitle

Select * 
From #temp_employee2
--by placing the table in the temp table, we could save lots of computing time

SELECT AvgAge, AvgSalary
from #temp_employee2



/*String function*/

--Drop Table EmployeeErrors;
CREATE TABLE EmployeeErrors (
EmployeeID varchar(50)
,FirstName varchar(50)
,LastName varchar(50)
)

Insert into EmployeeErrors Values 
('1001  ', 'Jimbo', 'Halbert')
,('  1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired')

Select *
From EmployeeErrors
--we see that there's some whitespace or naming error

/*Using 
Trim: remove all whitespace, 
LTRIM: remove whitespace in the left side only, 
RTRIM: remove whitespace in the right side only*/
Select EmployeeID, TRIM(employeeID) AS IDTRIM --so that we could compare the difference
FROM EmployeeErrors 

Select EmployeeID, RTRIM(employeeID) as IDRTRIM
FROM EmployeeErrors 

Select EmployeeID, LTRIM(employeeID) as IDLTRIM
FROM EmployeeErrors 


/*Replace*/
Select LastName, REPLACE(LastName, '- Fired', '') as LastNameFixed--replace the -Fired to empty
FROM EmployeeErrors


/*Substring*/
Select Substring(err.FirstName,1,3), Substring(dem.FirstName,1,3), Substring(err.LastName,1,3), Substring(dem.LastName,1,3)
--select the first digit, and in total 3 digit
FROM EmployeeErrors err
JOIN EmployeeDemographics dem
	on Substring(err.FirstName,1,3) = Substring(dem.FirstName,1,3)
	and Substring(err.LastName,1,3) = Substring(dem.LastName,1,3)

/*UPPER and lower*/
Select firstname, LOWER(firstname)
from EmployeeErrors

Select Firstname, UPPER(FirstName)
from EmployeeErrors




