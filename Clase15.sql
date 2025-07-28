use sakila;

-- 1. 
CREATE VIEW list_of_customers AS
SELECT
  customer.customer_id,
  CONCAT(customer.first_name, ' ', customer.last_name) AS customer_full_name,
  address.address,
  address.postal_code AS zip_code,
  address.phone,
  city.city,
  country.country,
  CASE
    WHEN customer.active = 1 THEN 'active'
    ELSE 'inactive'
  END AS status,
  customer.store_id
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id;

-- 2.
CREATE VIEW film_details AS
SELECT
  film.film_id,
  film.title,
  film.description,
  category.name AS category,
  film.rental_rate AS price,
  film.length,
  film.rating,
  GROUP_CONCAT(CONCAT(actor.first_name, ' ', actor.last_name) SEPARATOR ', ') AS actors
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
GROUP BY film.film_id;

-- 3. 
CREATE VIEW sales_by_film_category AS
SELECT
  category.name AS category,
  COUNT(rental.rental_id) AS total_rental
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name;

-- 4. 
CREATE VIEW actor_information AS
SELECT
  actor.actor_id,
  actor.first_name,
  actor.last_name,
  COUNT(film_actor.film_id) AS film_count
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id;

-- 5. 
-- 5.1 Esta consulta muestra cómo contar películas por actor incluyendo a los que no tienen ninguna
SELECT
  a.actor_id,
  a.first_name,
  a.last_name,
  COUNT(fa.film_id) AS film_count
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id;

-- 5.2 Usando Subquery
SELECT
  actor.actor_id,
  actor.first_name,
  actor.last_name,
  (
    SELECT COUNT(*)
    FROM film_actor fa
    WHERE fa.actor_id = actor.actor_id
  ) AS film_count
FROM actor;

-- 6. Descripcion
-- Las vistas materializadas guardan físicamente los datos de una consulta.
-- Mejora el rendimiento de consultas complejas.
-- No son soportadas nativamente por MySQL, pero sí por Oracle, PostgreSQL y parcialmente por MariaDB.
-- Se actualizan manual o automáticamente según configuración del SGBD.
