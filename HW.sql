use sakila;

SELECT first_name, last_name FROM actor;

Select CONCAT(first_name,' ' ,last_name) AS 'Actor Name' FROM actor;

SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name LIKE 'joe%';

SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE '%gen%';

SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE '%li%' ORDER BY last_name, first_name;

SELECT country.country, country.country_id
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

ALTER table actor  add column description varbinary(20000);


ALTER table actor drop column description;



SELECT last_name, COUNT(last_name)
  FROM actor
 GROUP BY last_name
HAVING COUNT(last_name) >= 2;

UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO';

DESCRIBE sakila.address;

SELECT staff.address_id, staff.first_name, staff.last_name, address.address, address.address2
FROM staff
LEFT JOIN address ON staff.address_id=address.address_id;

#SELECT p.staff_id, p.sum(amount)
#From payment as p
#RIGHT JOIN staff as s
#on p.staff_id=s.staff_id;

#SELECT p.staff_id,
#SUM(p.amount) AS total_amount
#FROM payment pcustomer_id
#JOIN (SELECT
	#			s.staff_id,
    #             s.first_name,
   #              s.last_name,
  #               Fcustomer_idROM staff s) x ON x.staff_id = p.staff_id
 #GROUP BY p.staff_id;
SELECT * FROM language;

SELECT payment.customer_id, sum(payment.amount), customer.first_name, customer.last_name
FROM payment
LEFT JOIN customer on customer.customer_id=payment.customer_id
GROUP BY customer_id, last_name;


SELECT count(*) FROM film WHERE title LIKE 'K%' OR 'Q%' AND language_id = 1;
