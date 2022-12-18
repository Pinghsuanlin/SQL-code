/*JOIN is a way to combine multiple tables to a single output

INNER JOIN: only return rows that are in common
FULL OUTER JOIN: join all rows in both tables, some column may be in NULL
LEFT OUTER JOIN: everything in the left table, though there may be no much in the right table, but discard everything in the right but not in the left table (vs. RIGHT OUTER JOIN)
*/

SELECT *
FROM SQLTutorial.dbo.city
INNER JOIN city.EmployeeID = comapny.EmployeeID 

SELECT *
FROM SQLTutorial.dbo.city
FULL OUTER JOIN city.EmployeeID = comapny.EmployeeID 

SELECT *
FROM SQLTutorial.dbo.city
LEFT OUTER JOIN city.EmployeeID = comapny.EmployeeID 

--we need to specify which table to collect overlapping column value from; otherwise, it will return error (specify with different table will return different results). But this doesn't apply to INNER JOIN, as INNER JOIN only take data that are in both table
SELECT employee.EmployeeID, FirstName, LastName, JobTitle, Salary
FROM SQLTutorial.dbo.city
RIGHT OUTER JOIN employee.EmployeeID = comapny.EmployeeID 
