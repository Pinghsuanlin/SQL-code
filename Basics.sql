
--create tables & insert values
CREATE TABLE company (ID_number SERIAL PRIMARY KEY, compName VARCHAR, HQCity VARCHAR, CEO VARCHAR, foundingYear INTEGER);
INSERT INTO company VALUES (1, 'Apple, Inc', 'Cupertino', 'Tim Cook', 1976);
INSERT INTO company VALUES (2, 'IBM', 'Armonk', 'Arvind Krishna', 1911);
INSERT INTO company VALUES (3, 'Amazon', 'Seattle',	'Andy Jassy', 1994);
INSERT INTO company VALUES (4, 'General Motors', 'Detroit',	'Mary Barra', 1908);
INSERT INTO company VALUES (5, 'Sony Corporation', 'Tokyo', 'Kenichiro Yoshida', 1946);
INSERT INTO company VALUES (6, 'Alibaba Group',	'Hangzhou',	'Daniel Zhang',	1999);
INSERT INTO company VALUES (7, 'Kering SA', 'Paris', 'François-Henri Pinault', 1963);

CREATE TABLE CEO (ID SERIAL PRIMARY KEY NOT NULL, firstName VARCHAR, lastName VARCHAR, birthYear INTEGER, birthPlace VARCHAR, yeartoCEO INTEGER);
INSERT INTO CEO VALUES (a1, 'Tim', 'Cook', 1960, 'Mobile', 2011);
INSERT INTO CEO VALUES (a2, 'Arvind', 'Krishna', 1962, 'West Godavari', 2020);
INSERT INTO CEO VALUES (a3, 'Andy', 'Jassy', 1968, 'Scarsdale', 2021);
INSERT INTO CEO VALUES (a4, 'Mary', 'Barra', 1961, 'Royal Oak', 2014);
INSERT INTO CEO VALUES (a5, 'Kenichiro', 'Yoshida', 1959, 'Kumamoto', 2018);
INSERT INTO CEO VALUES (a6, 'Daniel', 'Zhang',	1972, 'Shanghai', 2015);
INSERT INTO CEO VALUES (a7, 'François-Henri', 'Pinault', 1962, 'Rennes', 2005);


CREATE TABLE city (city CHAR PRIMARY KEY NOT NULL, state CHAR DEFAULT NULL, country CHAR);
INSERT INTO city VALUES ('Mobile', 'AL', 'USA');
INSERT INTO city VALUES ('Cupertino', 'CA', 'USA');
INSERT INTO city VALUES ('West Godavari', 'Andhra-Pradesh', 'India');
INSERT INTO city VALUES ('Armonk', 'NY', 'USA');
INSERT INTO city VALUES ('Scarsdale', 'NY', 'USA');
INSERT INTO city VALUES ('Seattle', 'WA', 'USA');
INSERT INTO city VALUES ('Royal Oak', 'MI', 'USA');
INSERT INTO city VALUES ('Detroit', 'MI', 'USA');
INSERT INTO city (city, country) VALUES ('Kumamoto', 'Japan');
INSERT INTO city (city, country) VALUES ('Shanghai', 'China');
INSERT INTO city VALUES ('Hangzhou', 'Zhejiang', 'China');
INSERT INTO city VALUES ('Rennes', 'Illes-et-Villaine', 'France');
INSERT INTO city (city, country) VALUES ('Paris', 'France');

--select top 5 rows from city table
SELECT TOP 5 *
FROM city

--select the distinct value
SELECT DISTINCT(city)
FROM city

--count all non-null value in the column 
--AS give it a column name
SELECT COUNT(compName) AS compNameCount
FROM company

--basic calculation
SELECT MAX(yeartoCEO) --MIN, AVG
FROM CEO

--if we switch to master databases, we need to specify the path
SELECT *
FROM SQLTutorial.dbo.company
ORDER BY compName DESC, foundingYear --order by multiple columns, and only compName is ordered descendingly

--which will be the same as specifying by column number
SELECT *
FROM SQLTutorial.dbo.company
ORDER BY 2 DESC, 5 

/*
Where Statement: helps limit or specify what kind of data you want to return
=, <>, <, >, <=, >=, And, Or, Like, Null, Not Null, In
*/
SELECT * FROM CEO
WHERE yeartoCEO >2000 AND birthPlace = 'Shanghai'

--where lastName starts with C
SELECT * FROM CEO
WHERE lastName like 'C%'
--where lastName has C
SELECT * FROM CEO
WHERE lastName like '%C%'
--where firstName end with y and has n in it
SELECT * FROM CEO
WHERE firstName like '%n%y'


SELECT * FROM CEO
WHERE lastName IS NULL --return nothing
SELECT * FROM CEO
WHERE lastName IS NOT NULL --return everything

--in is like a multiple equal statement
SELECT * FROM CEO
WHERE firstName IN ('Tim', 'Andy')


/*Group by, Order by*/
SELECT country, count(country) AS CountCountry
FROM city
WHERE city like 'S%'
GROUP BY country
ORDER BY CountCountry DESC --default as ASC


/*What is the first name of the CEO of the company headquartered in Paris?*/
SELECT CEO.firstName FROM CEO, company AS c
    WHERE c.HQCity = 'Paris'

/*Which city hosts the headquarters of the company whose CEO is Daniel Zhang?*/
SELECT c.HQCity FROM company AS c
    WHERE c.CEO = 'Daniel Zhang'

/*What are the founding years of the companies whose CEOs were born between 1959 and 1962?*/
SELECT c.foundingYear FROM CEO, company AS c
    WHERE 1959 < CEO.birthYear < 1962

