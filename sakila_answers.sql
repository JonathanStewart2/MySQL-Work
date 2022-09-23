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
SELECT title FROM film WHERE special_features LIKE "%Deleted Scenes%";   #Academy Dinosaur, Ace Goldfinger...

###QUESTION 11:	Using HAVING, reverse-alphabetically list the last names that are not repeated.
SELECT last_name FROM actor 
GROUP BY last_name
HAVING COUNT(last_name) = 1
ORDER BY last_name DESC;    #Wray, Witherspoon, Wilson...

###QUESTION 12:	Using HAVING, list the last names that appear more than once, 
# from highest to lowest frequency.
SELECT last_name, COUNT(last_name) AS Frequency FROM actor
GROUP BY last_name
HAVING Frequency >1
ORDER BY COUNT(last_name) DESC;    #Kilmer, Nolte, Temple

###QUESTION 13:	Which actor has appeared in the most films?

SELECT COUNT(actor_id) AS No_of_Movies FROM film_actor
GROUP BY actor_id 
ORDER BY No_of_movies DESC LIMIT 1;     #42


SELECT CONCAT(first_name," ",last_name) AS Actor, COUNT(fa.actor_id) AS No_of_movies FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id
GROUP BY fa.actor_id 
ORDER BY No_of_movies DESC LIMIT 1;       #Gina Degeneres

#######################################################
### QUESTION 14:	When is 'Academy Dinosaur' due?
SELECT * FROM film;
SELECT * FROM rental;
SELECT * FROM inventory;
SELECT * FROM store;
SELECT * FROM payment;

# Get film id first
SELECT film_id FROM film WHERE title = "Academy Dinosaur";  #returns 1

# Need inventory_id for inventory
SELECT i.inventory_id FROM inventory i
JOIN film f ON i.film_id = f.film_id
WHERE f.film_id = (
	SELECT film_id FROM film WHERE title = "Academy Dinosaur"
); 

#Get rental_id where inventory_id = 1-8
SELECT r.rental_id FROM rental r
JOIN inventory i ON i.inventory_id = r.inventory_id
WHERE r.inventory_id = (
	SELECT i.inventory_id FROM inventory i
	JOIN film f ON i.film_id = f.film_id
	WHERE f.film_id = (
		SELECT film_id FROM film WHERE title = "Academy Dinosaur"
        )
	)
;

SELECT i.inventory_id FROM inventory i
JOIN film f ON i.film_id = f.film_id
WHERE f.film_id = (
	SELECT film_id FROM film WHERE title = "Academy Dinosaur"
); 

#Get rental_id where inventory_id = 1-8
SELECT r.rental_id, r.return_date, i.inventory_id FROM rental r
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON i.film_id = f.film_id
	WHERE f.film_id = (
		SELECT film_id FROM film WHERE title = "Academy Dinosaur"
        )
ORDER BY r.return_date DESC
;

### ANSWER
SELECT f.title, r.rental_date, f.rental_duration, 
DATE_ADD(r.rental_date, INTERVAL f.rental_duration DAY) AS due_date 
FROM (rental r JOIN inventory i ON 
r.inventory_id=i.inventory_id)
JOIN film f ON f.film_id = i.film_id
WHERE f.title = "ACADEMY DINOSAUR" 
AND r.return_date IS NULL;

#######################################################


###QUESTION 15:	What is the average runtime of all films?
SELECT AVG(length) AS Average_runtime FROM film;     #115.2720

###QUESTION 16:	List the average runtime for every film category.
SELECT AVG(f.length) AS Average_runtime, fc.category_id AS Film_category FROM film f
JOIN film_category fc ON fc.film_id = f.film_id
GROUP BY fc.category_id
ORDER BY Film_category;        #1-111.6094, 2-111.0152, 3-109.8

### QUESTION 17: List all movies featuring a robot.
SELECT * FROM film_text WHERE description LIKE "%robot%";

###QUESTION 18:	How many movies were released in 2010?
SELECT * FROM film WHERE release_year = "2010";   #0 - all released in 2006?

###QUESTION 19:	Find the titles of all the horror movies.
SELECT * FROM film;
SELECT * FROM film_category;
SELECT * FROM film_text;
SELECT * FROM category;

SELECT category_id FROM category WHERE name = "Horror";    #11

SELECT fc.film_id FROM film_category fc
JOIN category c ON c.category_id = fc.category_id
JOIN film f ON f.film_id = fc.film_id
WHERE fc.category_id = (
	SELECT c.category_id FROM category c WHERE name = "Horror"
);        #2,4,8,9 etc

SELECT f.title FROM film f
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE fc.film_id = (
	SELECT fc.film_id FROM film_category fc
	WHERE fc.category_id = (
		SELECT c.category_id FROM category c WHERE name = "Horror"
	)  
);


### QUESTION 20: List the full name of the staff member with the ID of 2.
SELECT CONCAT(first_name, " ", last_name) AS Staff_ID_2 FROM staff WHERE staff_id = 2;

### QUESTION 21:List all the movies that Fred Costner has appeared in.
SELECT f.title FROM film f
JOIN film_actor fa ON fa.film_id = f.film_id
JOIN actor a ON a.actor_id = fa.actor_id
WHERE a.first_name = "Fred" AND a.last_name = "Costner";

### QUESTION 22: How many distinct countries are there?
SELECT COUNT(DISTINCT(country)) AS No_of_Countries FROM country;

### QUESTION 23: List the name of every language in reverse-alphabetical order.
SELECT l.name FROM language l ORDER BY l.name DESC;

## QUESTION 24:	List the full names of every actor whose surname ends with #'-son' 
# in alphabetical order by their forename.
SELECT CONCAT(first_name, " ", last_name) AS Actors FROM actor
WHERE last_name LIKE "%son"
ORDER BY first_name;

### QUESTION 25:	Which category contains the most films?
SELECT * FROM film_category ORDER BY category_id;
SELECT * FROM category;

SELECT c.name, COUNT(fc.category_id) AS Frequency FROM category c
JOIN film_category fc ON fc.category_id = c.category_id
GROUP BY fc.category_id
ORDER BY Frequency DESC
LIMIT 1
;           #Sports 74