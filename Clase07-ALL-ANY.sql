Use sakila;
#1 --
SELECT title, rating
  FROM film
 WHERE length = (SELECT MIN(length) FROM film);
 
 #2 --
SELECT length, COUNT(*) AS cantidad
  FROM film
 GROUP BY length
 ORDER BY length ASC
 LIMIT 1;
 
 #3 --
 
 SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    a.address,
    MIN(p.amount) AS lowest_payment
FROM 
    customer c
JOIN 
    payment p ON c.customer_id = p.customer_id
JOIN 
    address a ON c.address_id = a.address_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name, a.address;
    
#4 --
SELECT customer.customer_id,
       customer.first_name,
       customer.last_name,
       address.address,
       (SELECT amount
          FROM payment p2
         WHERE p2.customer_id = customer.customer_id
           AND amount <= ALL (SELECT amount
                                FROM payment
                               WHERE customer_id = customer.customer_id)
         LIMIT 1) AS min_payment
  FROM customer
       JOIN address ON customer.address_id = address.address_id;
