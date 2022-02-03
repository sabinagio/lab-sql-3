USE sakila;
# 1. How many distinct (different) actors' last names are there?
SELECT COUNT(DISTINCT last_name) FROM actor;

# 2. In how many different languages where the films originally produced? (Use the column language_id from the film table)
SELECT COUNT(DISTINCT language_id) FROM film;

# 3. How many movies were released with "PG-13" rating?
SELECT COUNT(film_id) FROM film WHERE rating="PG-13";

# 4. Get 10 the longest movies from 2006.
SELECT title FROM film WHERE release_year='2006' ORDER BY length DESC LIMIT 10;

# 5. How many days has been the company operating (check DATEDIFF() function)?

# 5.1. Based on the first rental date & the last rental date:
SELECT MIN(rental_date) FROM rental;
SELECT MAX(rental_date) FROM rental;
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) / 7 AS 'Number of Weeks' FROM rental; # 38

# 5.2. Based on the first rental date & the last update:
SELECT MAX(last_update) FROM rental;
SELECT DATEDIFF(MAX(last_update), MIN(rental_date)) / 7 AS 'Number of Weeks' FROM rental; # 39.28

# 6. Show rental info with additional columns month and weekday. Get 20.
SELECT *, date_format(rental_date, "%M") AS month, weekday(rental_date) AS weekday FROM rental LIMIT 20;

# 7. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT *, 
	date_format(rental_date, "%M") AS month,
    weekday(rental_date) AS weekday,
    (CASE
		WHEN weekday(rental_date) < 6 THEN 'workday'
        ELSE 'weekend'
	END) AS day_type
FROM rental;

# 8. How many rentals were in the last month of activity?
SELECT MAX(rental_date) FROM rental; # The last month of activity was February 2006

SELECT COUNT(rental_id) FROM rental WHERE rental_date REGEXP '^2006-02-[0-9][0-9]'; # 182

# Looking that the dates we selected were matching the REGEX expression
SELECT rental_id, rental_date FROM rental WHERE rental_date REGEXP '^2006-02-[0-9][0-9]'; # Only one date, 14 Feb 2006

# Checking that there was only one day in Feb 2006 when movies were rented
SELECT rental_id, rental_date FROM rental ORDER BY rental_date DESC; # The next date in descending order was 23 Aug 2005