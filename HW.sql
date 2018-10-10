'# Homework Assignment

## Installation Instructions

* Refer to the [installation guide](Installation.md) to install the necessary files.

## Instructions

use sakila;

* 1a. Display the first and last names of all actors from the table `actor`.

SELECT first_name, last_name FROM actor;

* 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column `Actor Name`.

Select CONCAT(first_name,' ' ,last_name) AS 'Actor Name' FROM actor;

* 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?


SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name LIKE 'Joe%';

* 2b. Find all actors whose last name contain the letters `GEN`:

SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE '%gen%';


* 2c. Find all actors whose last names contain the letters `LI`. This time, order the rows by last name and first name, in that order:

SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE '%li%' ORDER BY last_name, first_name;

* 2d. Using `IN`, display the `country_id` and `country` columns of the following countries: Afghanistan, Bangladesh, and China:

SELECT country.country, country.country_id
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

* 3a. You want to keep a description of each actor. You don't think you will be performing queries on a description, so create a column in the table `actor` named `description` and use the data type `BLOB` (Make sure to research the type `BLOB`, as the difference between it and `VARCHAR` are significant).

ALTER table actor  add column description varbinary(20000);

* 3b. Very quickly you realize that entering descriptions for each actor is too much effort. Delete the `description` column.

ALTER table actor drop column description;

* 4a. List the last names of actors, as well as how many actors have that last name.

SELECT last_name, COUNT(last_name) FROM actor GROUP BY last_name;

* 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors

SELECT last_name, COUNT(last_name)
  FROM actor
 GROUP BY last_name
HAVING COUNT(last_name) >= 2;

* 4c. The actor `HARPO WILLIAMS` was accidentally entered in the `actor` table as `GROUCHO WILLIAMS`. Write a query to fix the record.

UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

* 4d. Perhaps we were too hasty in changing `GROUCHO` to `HARPO`. It turns out that `GROUCHO` was the correct name after all! In a single query, if the first name of the actor is currently `HARPO`, change it to `GROUCHO`.

UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO';


* 5a. You cannot locate the schema of the `address` table. Which query would you use to re-create it?

  
  DESCRIBE sakila.address;


* 6a. Use `JOIN` to display the first and last names, as well as the address, of each staff member. Use the tables `staff` and `address`:

SELECT staff.address_id, staff.first_name, staff.last_name, address.address, address.address2
FROM staff
LEFT JOIN address ON staff.address_id=address.address_id;

* 6b. Use `JOIN` to display the total amount rung up by each staff member in August of 2005. Use tables `staff` and `payment`.

SELECT staff.staff_id, staff.first_name, staff.last_name, SUM(payment.amount) AS PAY FROM staff
LEFT JOIN PAYMENT ON staff.staff_id = payment.staff_id
GROUP BY staff.staff_id;
DOES NOT HAVE CONDITIONAL FOR DATE
##############################################
* 6c. List each film and the number of actors who are listed for that film. Use tables `film_actor` and `film`. Use inner join.

SELECT film.title, count(fa.film_id) FROM film JOIN film_actor fa on fa.film_id=film.film_id GROUP BY film.title;

* 6d. How many copies of the film `Hunchback Impossible` exist in the inventory system?

Currently, unknown. 8 as per latest invenory update at 2006-02-15 05:09:17.

* 6e. Using the tables `payment` and `customer` and the `JOIN` command, list the total paid by each customer. List the customers alphabetically by last name:

SELECT payment.customer_id, sum(payment.amount), customer.first_name, customer.last_name
FROM payment
LEFT JOIN customer on customer.customer_id=payment.customer_id
GROUP BY last_name ASC;
  ```
  	![Total amount paid](Images/total_payment.png)
  ```

* 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters `K` and `Q` have also soared in popularity. Use subqueries to display the titles of movies starting with the letters `K` and `Q` whose language is English.

SELECT title FROM film WHERE title LIKE 'K%' OR title LIKE 'Q%' AND language_id = 1;

* 7b. Use subqueries to display all actors who appear in the film `Alone Trip`.
###########################
NEED TO USE SUBQUERIES
ADD ACTOR NAMES? SELECT * FROM film_actor WHERE film_id=17; 

* 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.

SELECT first_name, last_name, email FROM customer WHERE address_id=546 OR address_id=219;

* 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.

SELECT * FROM film WHERE rating = 'G' or rating LIKE 'P%';

* 7e. Display the most frequently rented movies in descending order.
###########################
SELECT film_id, 
FROM film 
GROUP BY working_area;


* 7f. Write a query to display how much business, in dollars, each store brought in.

SELECT p.staff_id, sum(p.amount) FROM payment p group by p.staff_id;
store_id is same as staff_id

* 7g. Write a query to display for each store its store ID, city, and country.

select s.store_id, city.city, o.country from (((address a join store s on
a.address_id = s.address_id) join city on city.city_id=a.city_id) join country o on o.country_id=city.country_id);

* 7h. List the top five genres in gross revenue in descending order. (**Hint**: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
################################
'SELECT * FROM top_five LIMIT 5
* 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.
###########################
CREATE VIEW [top_five] AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;

* 8b. How would you display the view that you created in 8a?

SELECT * FROM [top_five];

* 8c. You find that you no longer need the view `top_five_genres`. Write a query to delete it.

DROP VIEW top_five;

## Appendix: List of Tables in the Sakila DB

* A schema is also available as `sakila_schema.svg`. Open it with a browser to view.

```sql
	'actor'
	'actor_info'
	'address'
	'category'
	'city'
	'country'
	'customer'
	'customer_list'
	'film'
	'film_actor'
	'film_category'
	'film_list'
	'film_text'
	'inventory'
	'language'
	'nicer_but_slower_film_list'
	'payment'
	'rental'
	'sales_by_film_category'
	'sales_by_store'
	'staff'
	'staff_list'
	'store'
```

## Uploading Homework

* To submit this homework using BootCampSpot:

  * Create a GitHub repository.
  * Upload your .sql file with the completed queries.
  * Submit a link to your GitHub repo through BootCampSpot.'

