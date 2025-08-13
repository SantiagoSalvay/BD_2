USE sakila;

-- #1 
SELECT CONCAT(c.first_name, ' ', c.last_name) AS full_name, 
       a.address, 
       ci.city
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
WHERE ci.country_id = (
    SELECT country_id 
    FROM country 
    WHERE country = 'Argentina'
);

-- #2 
SELECT 
    f.title,
    l.name AS language,
    CASE
        WHEN f.rating = 'G' THEN 'General audience'
        WHEN f.rating = 'PG' THEN 'Parental guidance suggested'
        WHEN f.rating = 'PG-13' THEN 'Parents strongly cautioned'
        WHEN f.rating = 'R' THEN 'Restricted'
        WHEN f.rating = 'NC-17' THEN 'Adults only'
    END AS rating_description
FROM film f
JOIN language l ON f.language_id = l.language_id;

-- #3 
SET @actor_name = "penelope guiness"; 

SELECT f.title, f.release_year
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
WHERE LOWER(CONCAT(a.first_name, ' ', a.last_name)) 
      LIKE LOWER(CONCAT('%', @actor_name, '%'));

-- #4 
SELECT 
    f.title,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    CASE 
        WHEN r.return_date IS NOT NULL THEN 'Yes'
        ELSE 'No'
    END AS returned
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN customer c ON r.customer_id = c.customer_id
WHERE MONTH(r.rental_date) IN (5, 6);

-- #5 CAST vs CONVERT
-- CAST: Sirve para cambiar un dato de un tipo a otro. Es la forma "estándar" y anda en casi todas las bases de datos.
-- CONVERT: Hace lo mismo que CAST, pero en MySQL y SQL Server además te deja elegir un formato para mostrar el resultado.

-- #6 NVL, ISNULL, IFNULL, COALESCE
-- NVL: Si encuentra un dato en NULL, lo reemplaza por otro que vos le digas. En MySQL no existe.
-- ISNULL: Te devuelve 1 si el valor está en NULL, y 0 si tiene algo.
-- IFNULL: Muestra el primer valor si tiene algo; si está en NULL, muestra el segundo valor que le pongas.
-- COALESCE: Va revisando una lista de valores y te devuelve el primero que no esté en NULL.
