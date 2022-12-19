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





