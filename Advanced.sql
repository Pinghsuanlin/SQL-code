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

