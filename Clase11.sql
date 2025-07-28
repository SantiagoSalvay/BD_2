use sakila;

-- 1.
SELECT title
FROM film
LEFT JOIN inventory ON film.film_id = inventory.film_id
WHERE inventory.film_id IS NULL;

-- 2. 
SELECT f.title, i.inventory_id
FROM film f
JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.rental_id IS NULL;

-- 3. 
SELECT 
    c.first_name,
    c.last_name,
    c.store_id,
    f.title,
    r.rental_date,
    r.return_date
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
ORDER BY c.store_id, c.last_name;

-- 4. 
SELECT 
    s.store_id,
    SUM(p.amount) AS total_sales
FROM store s
JOIN staff st ON s.manager_staff_id = st.staff_id
JOIN payment p ON p.staff_id = st.staff_id
GROUP BY s.store_id;

-- 5.
SELECT 
    s.store_id,
    CONCAT(ci.city, ', ', co.country) AS location,
    CONCAT(st.first_name, ' ', st.last_name) AS manager_name,
    SUM(p.amount) AS total_sales
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
JOIN staff st ON s.manager_staff_id = st.staff_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id, location, manager_name;

-- 6. 
SELECT 
    a.actor_id,
    CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
    COUNT(fa.film_id) AS film_count
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
ORDER BY film_count DESC
LIMIT 1;
