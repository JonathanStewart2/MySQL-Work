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
SELECT c.Code FROM country c WHERE c.Name = "China";  #CHN

SELECT COUNT(cc.ID) FROM city cc
JOIN country c ON cc.CountryCode = c.Code
WHERE CountryCode = (
	SELECT c.Code FROM country c WHERE c.Name = "China"
);


### QUESTION 8:	Using IS NOT NULL, ORDER BY, and LIMIT, which country has the lowest population? 
# Discard non-zero populations.
SELECT c.Name, c.Population FROM country c 
WHERE c.Population IS NOT NULL AND c.Population > 0 
ORDER BY c.Population ASC LIMIT 1;


### QUESTION 9:	Using aggregate functions, return the number of countries the database contains.
SELECT COUNT(Code) FROM country;


### QUESTION 10: 10.	What are the top ten largest countries by area?
SELECT c.Name, c.SurfaceArea FROM country c ORDER BY SurfaceArea DESC LIMIT 10;


### QUESTION 11:	List the five largest cities by population in Japan.
SELECT c.Code FROM country c WHERE c.Name="Japan";   #JPN

SELECT cc.Name, cc.Population FROM city cc
JOIN country c ON cc.CountryCode = c.Code
WHERE CountryCode = (
	SELECT c.Code FROM country c WHERE c.Name="Japan"
)
ORDER BY Population DESC 
LIMIT 5;


### QUESTION 12: List the names and country codes of every country with Elizabeth II as its 
# Head of State. You will need to fix the mistake first!

UPDATE country
SET HeadOfState = "Elizabeth II"
WHERE HeadOfState = "Elisabeth II"; #SAFE MODE STOPPAGE

SELECT c.Code, c.Name FROM country c WHERE HeadOfState LIKE "Elisabeth%"; #not edited spelling


### QUESTION 13: List the top ten countries with the smallest population-to-area ratio. 
# Discard any countries with a ratio of 0.

SELECT c.Name FROM country c
WHERE Population > 0
ORDER BY c.SurfaceArea/c.Population
LIMIT 10;            #Macao


### QUESTION 14: List every unique world language.
SELECT DISTINCT(Language) FROM countrylanguage;


### QUESTION 15:	List the names and GNP of the world's top 10 richest countries.
SELECT Name, GNP FROM country ORDER BY GNP DESC LIMIT 10;      #USA, Japan, Germany...


### QUESTION 16: List the names of, and number of languages spoken by, the top ten most 
# multilingual countries.
SELECT COUNT(CountryCode) AS Number_of_languages, c.Name AS Country FROM countrylanguage cl
JOIN country c ON c.Code = cl.CountryCode
GROUP BY cl.CountryCode
ORDER BY Number_of_languages DESC
LIMIT 10;


### QUESTION 17: List every country where over 50% of its population can speak German.
SELECT c.Name AS Country FROM country c
JOIN countrylanguage cl ON cl.CountryCode = c.Code
WHERE Language="German" AND Percentage>50;


### QUESTION 18: Which country has the worst life expectancy? Discard zero or null values.
SELECT c.Name, c.LifeExpectancy FROM country c 
WHERE c.LifeExpectancy IS NOT NULL 
ORDER BY LifeExpectancy
LIMIT 1;     #Zambia


### QUESTION 19: List the top three most common government forms.
SELECT COUNT(GovernmentForm) AS Number_using_this_Government, GovernmentForm FROM country
GROUP BY GovernmentForm
ORDER BY Number_using_this_Government DESC
LIMIT 3;


### QUESTION 20:	How many countries have gained independence since records began?
SELECT * FROM city;
SELECT * FROM country;
SELECT * FROM countrylanguage;
