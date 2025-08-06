
#1
INSERT INTO customer (store_id, first_name, last_name, email, address_id, active, create_date)
SELECT 1,'John','Doe','john.doe@example.com',
    (SELECT address_id FROM address WHERE city_id = (SELECT city_id FROM city WHERE city = 'London') ORDER BY address_id DESC LIMIT 1),
    1,
    NOW();

#2

INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id)
VALUES (
    NOW(),
    (SELECT inventory_id FROM inventory ORDER BY inventory_id DESC LIMIT 1),
    (SELECT customer_id FROM customer WHERE first_name = 'John' AND last_name = 'Doe' LIMIT 1),
    (SELECT staff_id FROM staff WHERE store_id = 2 LIMIT 1)
);

#3

UPDATE film
SET release_year = CASE
    WHEN rating = 'G' THEN 2001
    WHEN rating = 'PG' THEN 2005
    WHEN rating = 'PG-13' THEN 2008
    WHEN rating = 'R' THEN 2010
    ELSE release_year
END
WHERE film_id = (SELECT film_id FROM film WHERE title = 'ACADEMY DINOSAUR');


#4
SELECT rental_id
FROM rental
WHERE inventory_id IN (SELECT inventory_id FROM inventory WHERE film_id = (SELECT film_id FROM film WHERE title = 'ACADEMY DINOSAUR'))
AND return_date IS NULL
ORDER BY rental_date DESC
LIMIT 1;

UPDATE rental
SET return_date = NOW()
WHERE rental_id = (SELECT rental_id
FROM rental
WHERE inventory_id IN (SELECT inventory_id FROM inventory WHERE film_id = (SELECT film_id FROM film WHERE title = 'ACADEMY DINOSAUR'))
AND return_date IS NULL
ORDER BY rental_date DESC
LIMIT 1);

#5

DELETE FROM film WHERE title = 'ACADEMY DINOSAUR';

DELETE FROM inventory
WHERE film_id = (SELECT film_id FROM film WHERE title = 'ACADEMY DINOSAUR');

DELETE FROM film_actor
WHERE film_id = (SELECT film_id FROM film WHERE title = 'ACADEMY DINOSAUR');

DELETE FROM film_category
WHERE film_id = (SELECT film_id FROM film WHERE title = 'ACADEMY DINOSAUR');

DELETE FROM film WHERE title = 'ACADEMY DINOSAUR';


#6

SELECT inventory_id
FROM inventory
WHERE film_id = (SELECT film_id FROM film WHERE title = 'ACADEMY DINOSAUR')
AND inventory_id NOT IN (SELECT inventory_id FROM rental WHERE return_date IS NULL)
LIMIT 1;

INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id)
VALUES (
    NOW(),
    (SELECT inventory_id
    FROM inventory
    WHERE film_id = (SELECT film_id FROM film WHERE title = 'ACADEMY DINOSAUR')
    AND inventory_id NOT IN (SELECT inventory_id FROM rental WHERE return_date IS NULL)
    LIMIT 1),
    (SELECT customer_id FROM customer WHERE first_name = 'John' AND last_name = 'Doe' LIMIT 1),
    (SELECT staff_id FROM staff WHERE store_id = 2 LIMIT 1)
);

INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date)
VALUES (
    (SELECT customer_id FROM customer WHERE first_name = 'John' AND last_name = 'Doe' LIMIT 1),
    (SELECT staff_id FROM staff WHERE store_id = 2 LIMIT 1),
    (SELECT rental_id FROM rental ORDER BY rental_id DESC LIMIT 1),
    2.99,
    NOW()
);

