USE sakila;
SHOW tables;

### QUESTION 1:	List all actors.
SELECT CONCAT(first_name, " ", last_name) AS Actors FROM actor;

### QUESTION 2:	Find the surname of the actor with the forename 'John'.
SELECT last_name AS Actor_Surname_with_Firstname_John FROM actor WHERE first_name="John";  #Suvari

### QUESTION 3:	Find all actors with surname 'Neeson'.
SELECT * FROM actor WHERE last_name="Neeson";     #Christian, Jayne

### QUESTION 4:	Find all actors with ID numbers divisible by 10.
SELECT * FROM actor;