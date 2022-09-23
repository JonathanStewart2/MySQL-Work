USE sakila;
SHOW tables;

### QUESTION 1:	List all actors.
SELECT CONCAT(first_name, " ", last_name) AS Actors FROM actor;

### QUESTION 2:	Find the surname of the actor with the forename 'John'.
SELECT last_name AS Actor_Surname_with_Firstname_John FROM actor WHERE first_name="John";  #Suvari

### QUESTION 3:	Find all actors with surname 'Neeson'.
SELECT * FROM actor WHERE last_name="Neeson";     #Christian, Jayne

### QUESTION 4:	Find all actors with ID numbers divisible by 10.
SELECT CONCAT(first_name," ",last_name) AS Actor_With_ID_Divisable_by_10 FROM actor
WHERE actor_id%10=0;       #Christian Gable, Lucille Tracy, Sandra Peck...alter

###QUESTION 5:	What is the description of the movie with an ID of 100?
SELECT description FROM film WHERE film_id = 100;    #A beautiful drama of a dentist...

### QUESTION 6:	Find every R-rated movie
SELECT title FROM film WHERE rating="R";     #Airport Pollock, Alone Trip

###QUESTION 7:	Find every non-R-rated movie.
SELECT title FROM film WHERE rating!="R";     #Academy Dinosaur, Ace Goldfinger...

###QUESTION 8:	Find the ten shortest movies.
SELECT title FROM film ORDER BY length ASC LIMIT 10; #Ridgemont Submarine, Iron Moon...

###QUESTION 9: Find the movies with the longest runtime, without using LIMIT.
SELECT title FROM film ORDER BY length DESC;   #Chicago North, Control Anthem...

###QUESTION 10:	Find all movies that have deleted scenes.
SELECT * FROM actor;
SELECT * FROM film;
