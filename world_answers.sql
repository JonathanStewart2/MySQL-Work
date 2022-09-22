USE world;

SHOW tables;
DESCRIBE city;

### QUESTION 1- 1.	Using COUNT, get the number of cities in the USA.
SELECT * FROM city;
SELECT DISTINCT CountryCode FROM city;
SELECT COUNT(id) FROM city WHERE CountryCode = "USA";  #274


### QUESTION 2- 2.	Find out the population and life expectancy for people in Argentina.
SELECT Population, LifeExpectancy FROM country WHERE Code = "ARG";   #37032000   75.1


### QUESTION 3- 3.	Using IS NOT NULL, ORDER BY, and LIMIT,
# which country has the highest life expectancy?
SELECT * FROM country;
SELECT Name, LifeExpectancy FROM country ORDER BY LifeExpectancy DESC LIMIT 1;


### QUESTION 4.	Using JOIN ... ON, find the capital city of Spain.
SELECT * FROM country;
SELECT * FROM city;

SELECT Name FROM city  WHERE ID=(
	SELECT Capital FROM country WHERE Name="Spain");
    
SELECT c.Name FROM city c
JOIN country ON c.ID=country.Capital
WHERE ID=(
	SELECT Capital FROM country WHERE Name="Spain");


### QUESTION 5: 5.	Using JOIN ... ON, list all the languages spoken in the Southeast Asia region.
SELECT c.Code FROM country c WHERE Region="Southeast Asia";

SELECT DISTINCT cl.Language FROM countrylanguage cl
JOIN country c ON c.Code = cl.CountryCode
WHERE c.Region="Southeast Asia";


### QUESTION 6: Using a single query, list 25 cities around the world that start with the letter F.
SELECT c.Name FROM city c WHERE c.Name LIKE "F%" LIMIT 25;


### QUESTION 7: Using COUNT and JOIN ... ON, get the number of cities in China.
SELECT * FROM countrylanguage;
SELECT * FROM city;
SELECT * FROM country;