/*JOIN is a way to combine multiple tables to a single output

INNER JOIN: only return rows that are in common
FULL OUTER JOIN: join all rows in both tables, some column may be in NULL
LEFT OUTER JOIN: everything in the left table, though there may be no much in the right table, but discard everything in the right but not in the left table 
(vs. RIGHT OUTER JOIN)
*/

SELECT *
FROM SQLTutorial.dbo.city
INNER JOIN SQLTutorial.dbo.company 
ON city.EmployeeID = comapny.EmployeeID 

SELECT *
FROM SQLTutorial.dbo.city
FULL OUTER JOIN SQLTutorial.dbo.company
ON city.EmployeeID = comapny.EmployeeID 

SELECT *
FROM SQLTutorial.dbo.city
LEFT OUTER JOIN SQLTutorial.dbo.company
ON city.EmployeeID = comapny.EmployeeID 

--we need to specify which table to collect overlapping column value from; otherwise, it will return error 
--(specify with different table will return different results). But this doesn't apply to INNER JOIN, as INNER JOIN only take data that are in both table
SELECT employee.EmployeeID, FirstName, LastName, JobTitle, Salary
FROM SQLTutorial.dbo.city
RIGHT OUTER JOIN SQLTutorial.dbo.company
ON employee.EmployeeID = comapny.EmployeeID 

--add WHERE, GROUP BY, ORDER BY statement
SELECT employee.EmployeeID, FirstName, LastName, JobTitle, Salary
FROM SQLTutorial.dbo.city
INNER JOIN SQLTutorial.dbo.company
ON employee.EmployeeID = comapny.EmployeeID 
WHERE FirstName <> 'Jim'
ORDER BY Salary DESC


SELECT JobTitle, AVG(Salary) AS AvgSalary
FROM SQLTutorial.dbo.city
INNER JOIN SQLTutorial.dbo.company
ON employee.EmployeeID = comapny.EmployeeID 
WHERE JobTitle = 'Sales'
GROUP BY JobTitle



/*
Union, Union All: Also is to combine different tables, but putting common column into one column, rather than separate ones. 
UNION removes duplicates; UNION ALL doesn't remove duplicates
JOING combine tables based on common column (one or many) into separate columns 
*/

SELECT *
FROM SQLTutorial.dbo.Employee
UNION--UNION ALL
SELECT *
FROM SQLTutorial.dbo.WareHouseEmployee


SELECT EmployeeID, FirstName, Age
FROM SQLTutorial.dbo.Employee
UNION
SELECT EmployeeID, JobTitle, Salary
FROM SQLTutorial.dbo.EmployeeSalary
ORDER BY EmployeeID
--this is still working even the columns are not in common bc the columns are in the same data types



/*
CASE WHEN: to specify the conditions. We can do many CASE statements.
*/
SELECT FirstName, LastName, Age
CASE 
  WHEN Age > 30 THEN 'Old'
  WHEN Age BETWEEN 27 AND 30 THEN 'Young'
  ELSE 'Baby'
END
FROM SQLTutorial.dbo.Employee
WHERE Age IS NOT NULL
ORDER BY Age


--if the conditions have been met, the output will go with the first criteria
SELECT FirstName, LastName, Age
CASE 
  WHEN Age > 30 THEN 'Old'
  WHEN Age = 38 THEN 'Target' --this wont return, unless we move this criteria before above 30
  WHEN Age BETWEEN 27 AND 30 THEN 'Young'
  ELSE 'Baby'
END
FROM SQLTutorial.dbo.Employee
WHERE Age IS NOT NULL
ORDER BY Age


SELECT FirstName, LastName, JobTitle, Salary
CASE 
  WHEN JobTitle = 'Sales' THEN Salary + (Salary * .10)
  WHEN JobTitle 'Accountant' THEN Salary + (Salary * .05)
  WHEN JobTitle 'HR' THEN Salary + (Salary * .000001)
  ELSE Salary + (Salary * .03)
END AS SalaryAfterRaise
FROM SQLTutorial.dbo.Employee
JOIN SQLTutorial.dbo.EmployeeSalary
ON Employee.EmployeeID = EmployeeSalary.EmployeeID 



/*HAVING*/
SELECT JobTitle, COUNT(JobTitle)
FROM SQLTutorial.dbo.Employee
JOIN SQLTutorial.dbo.EmployeeSalary
  ON Employee.EmployeeID = EmployeeSalary.EmployeeID 
--aggregate first before we add the condition. 
GROUP BY JobTitle
HAVING AVG(Salary) >45000 --we cannot use aggregation in WHERE clause
ORDER BY AVG(Salary)


/*Update Delete data
UPDATE SET is to change existing data, while INSERT VALUES is to insert a new row of value
DELETE: delete an entire row from the data
*/

SELECT *
FROM SQLTutorial.dbo.Employee
UPDATE SQLTutorial.dbo.Employee
SET EmployeeID = 1012, Gender = 'Female', Age= 31
WHERE FirstName = 'Jim' AND LastName = 'Chen' 

--SELECT * --to ensure that you are not removing the wrong data as no where to reverse once done
DELETE FROM SQLTutorial.dbo.Employee
WHERE EmployeeID = 1005



/* Aliasing: Change column name in the script to increase readability*/
SELECT FirstName + ' ' + LaseName AS FullName--FirstName and LastName values will be joined
from SQLTutorial.dbo.Employee 

--give alias to table
SELECT Demo.EmployeeID, Sal.Salary
FROM SQLTutorial.dbo.Employee AS Demo
JOIN SQLTutorial.dbo.EmployeeSalary AS Sal
ON Demo.EmployeeID = Sal.EmployeeID


/*
Partition By: group those row of values into partition and change how the window partition; dont actually change the number of row returned in the output. 
Group By: reduce the number of rows in output by covering the aggregation of each group
*/

SELECT FirstName, LastName, Gender, Salary, COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender
FROM SQLTutorial..Employee dem
JOIN SQLTutorial..EmployeeSalary sal
ON dem.EmployeeID=sal.EmployeeID
--every rows will return but with a new column as TotalGender with COUNT(Gender) of fixed number for Female and Male

--cf.GROUP BY
SELECT Gender, COUNT(Gender)
FROM SQLTutorial..Employee dem
JOIN SQLTutorial..EmployeeSalary sal
ON dem.EmployeeID=sal.EmployeeID
GROUP BY Gender
