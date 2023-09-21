-- List all customers who live in Texas (use JOINs)
SELECT customer.customer_id, customer.first_name, customer.last_name
FROM customer
INNER JOIN address ON customer.address_id = address.address_id
WHERE address = 'Texas'

-- Get all payments above $6.99 with the Customer's FullName
SELECT CONCAT(customer.first_name, ' ', customer.last_name) AS full_name, payment.amount
FROM customer
INNER JOIN payment ON customer.customer_id = payment.customer_id
WHERE  payment.amount > 6.99

--Show all customers names who have made payments over $175(usesubqueries)
SELECT CONCAT(first_name, ' ', last_name) AS customer_name
FROM customer
WHERE customer_id IN(
    SELECT customer_id
    FROM payment
    WHERE amount > 175
)

-- List all customers that live in Nepal (use the citytable)
SELECT customer.first_name, customer.last_name
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN citytable ON address.city_id = citytable.city_id
WHERE citytable = 'Nepal'

--Which staff member had the most transactions?
SELECT staff.staff_id, CONCAT(staff.first_name, '',staff.last_name) AS staff_name, COUNT(payment.payment_id) AS payment_count
FROM staff
LEFT JOIN payment ON staff.staff_id = payment.staff_id
GROUP BY staff.staff_id, staff.first_name, staff.last_name
ORDER BY payment_count DESC


-- How many movies of each rating are there?
SELECT rating, Count(film_id) AS film_count
FROM film
GROUP BY rating

--Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name
FROM customer c
WHERE c.customer_id IN (
    SELECT p.customer_id
    FROM payment p
    WHERE p.amount > 6.99
    GROUP BY p.customer_id
    HAVING COUNT(*) = 1
)

--How many free rentals did our stores give away?
SELECT COUNT(*) AS free_rental_count
FROM rental
WHERE rental_date IS NULL
