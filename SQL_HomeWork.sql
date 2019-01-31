USE sakila;

-- Question 1a
SELECT first_name, last_name FROM actor;

-- Question 1b
SELECT concat(first_name," ", last_name) AS Actor_Name FROM actor;

-- QUestion 2a
SELECT actor_id, first_name, last_name FROM actor WHERE first_name = 'Joe';

-- Question 2b
SELECT last_name FROM actor WHERE last_name Like '%GEN%';

-- Question 2c 
SELECT last_name, first_name FROM actor WHERE last_name Like '%Li%' ORDER BY last_name, first_name;

-- Question 2d
SELECT country_id, country from country where country in ('Afghanistan', 'Bangladesh', 'China');

-- Question 3a
ALTER TABLE actor
ADD COLUMN middle_name VARCHAR(45);

ALTER TABLE actor
MODIFY middle_name BLOB;
-- Question 3b
ALTER TABLE actor
DROP COLUMN middle_name;

SELECT*FROM actor;

-- Question 4a
SELECT last_name, COUNT(last_name) as "Count of Last Name"
FROM actor
GROUP BY last_name;

-- Question 4b
select last_name, count(last_name) as "Count of Last Name"
from actor
group by last_name;
having count(last_name) >=2;

-- Question 4c
update actor set first_name = 'Harpo'
where first_name = 'GROUCHO' and last_name = 'WILLIAMS'

-- Question 4d 
update actor set first_name =
case
when first_name = 'HARPO'
then 'GROUCHO'
else 'MUCHO GROUCHO'
end
where actor_id =172;

-- Question 5a 
show create table sakila.address;

create table 'address' (
		'address_id' smallint(5) unsigned not null auto_increment,
        'address' varchar(50) not null,
        'address2' varchar(50) DEFAULT NULL,
		'district' varchar(20) NOT NULL,
		'city_id' smallint(5) unsigned NOT NULL,
		'postal_code' varchar(10) DEFAULT NULL,
		'phone' varchar(20) NOT NULL,
		'location' geometry NOT NULL,
		'last_update' timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
		PRIMARY KEY ('address_id'),
		KEY 'idx_fk_city_id' ('city_id'),
		SPATIAL KEY 'idx_location' ('location'),
		CONSTRAINT 'fk_address_city' FOREIGN KEY ('city_id') REFERENCES 'city' ('city_id') ON UPDATE CASCADE
		) ENGINE=InnoDB AUTO_INCREMENT=606 DEFAULT CHARSET=utf8
	
-- Question 6a
select first_name, last_name, address
from staff s
inner join address a
on s.address_id = a.address_id;

-- Question 6b
select first_name, last_name, sum(amount)
from staff s
inner join payment p
on s.staff_id = p.staff_id
group by p.staff_id
order by last_name ASC;

-- Question 6c
select title, count(actor_id)
from film f
inner join film_actor fa
on f.film_id = fa.film_id
group by title;

-- Question 6d
select title, count(inventory_id)
from film f
inner join inventory i 
on f.film_id = i.film_id
where title = "Hunchback Impossible";

-- Question 6e
Select last_name, first_name, sum(amount)
from payment p
inner join customer c
on p.customer_id = c.customer_id
group by p.customer_id
order by last_name ASC;

-- Question 7a
SELECT title FROM film
WHERE language_id in
	(SELECT language_id 
	FROM language
	WHERE name = "English" )
    
-- Question 7b
SELECT last_name, first_name
FROM actor
WHERE actor_id in
	(SELECT actor_id FROM film_actor
	WHERE film_id in 
		(SELECT film_id FROM film
		WHERE title = "Alone Trip"));

-- Question 7c
SELECT country, last_name, first_name, email
FROM country c
LEFT JOIN customer cu
ON c.country_id = cu.customer_id
WHERE country = 'Canada';

-- Question 7d
SELECT title, category
FROM film_list
WHERE category = 'Family';

-- Question 7e
SELECT i.film_id, f.title, COUNT(r.inventory_id)
FROM inventory i
INNER JOIN rental r
ON i.inventory_id = r.inventory_id
INNER JOIN film_text f 
ON i.film_id = f.film_id
GROUP BY r.inventory_id
ORDER BY COUNT(r.inventory_id) DESC;

-- Question 7f
SELECT store.store_id, SUM(amount)
FROM store
INNER JOIN staff
ON store.store_id = staff.store_id
INNER JOIN payment p 
ON p.staff_id = staff.staff_id
GROUP BY store.store_id
ORDER BY SUM(amount);

-- Question 7g
SELECT s.store_id, city, country
FROM store s
INNER JOIN customer cu
ON s.store_id = cu.store_id
INNER JOIN staff st
ON s.store_id = st.store_id
INNER JOIN address a
ON cu.address_id = a.address_id
INNER JOIN city ci
ON a.city_id = ci.city_id
INNER JOIN country coun
ON ci.country_id = coun.country_id;
WHERE country = 'CANADA' AND country = 'AUSTRAILA';

-- Question 7h
SELECT name, SUM(p.amount)
FROM category c
INNER JOIN film_category fc
INNER JOIN inventory i
ON i.film_id = fc.film_id
INNER JOIN rental r
ON r.inventory_id = i.inventory_id
INNER JOIN payment p
GROUP BY name
LIMIT 5;

-- Question 8a
USE sakila;
CREATE VIEW top_five_grossing_genres AS

SELECT name, SUM(p.amount)
FROM category c
INNER JOIN film_category fc
INNER JOIN inventory i
ON i.film_id = fc.film_id
INNER JOIN rental r
ON r.inventory_id = i.inventory_id
INNER JOIN payment p
GROUP BY name
LIMIT 5;

-- Question 8b
SELECT * FROM top_five_grossing_genres;

-- Question 8c
DROP VIEW top_five_grossing_genres;
