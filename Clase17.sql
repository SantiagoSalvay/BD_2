use sakila;
-- Consulta A: usando postal_code con IN
SELECT *
FROM address
WHERE postal_code IN ('52137', '85017', '10019');

-- Consulta B: usando postal_code con NOT IN
SELECT *
FROM address
WHERE postal_code NOT IN ('52137', '85017', '10019');

-- Consulta C: join con city y country
SELECT a.address_id, a.postal_code, c.city, co.country
FROM address a
JOIN city c ON a.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id
WHERE a.postal_code = '52137';

CREATE INDEX idx_postal_code ON address(postal_code);

-- Búsqueda por first_name
SELECT *
FROM actor
WHERE first_name = 'PENELOPE';

-- Búsqueda por last_name
SELECT *
FROM actor
WHERE last_name = 'GUINESS';

/*
Explicación:
- Sin índices, MySQL hace un escaneo completo.
- Si hay índices en esas columnas, la búsqueda por first_name o last_name usa el índice.
- Puede haber diferencia si solo una columna tiene índice definido.
*/
-- Usando LIKE en descripción
SELECT *
FROM film
WHERE description LIKE '%Drama%';

-- Usando FULLTEXT index con MATCH ... AGAINST
SELECT *
FROM film_text
WHERE MATCH(title, description) AGAINST('Drama');

/*
Explicación esperada:
- LIKE '%palabra%' recorre todas las filas y es más lento.
- MATCH ... AGAINST usa el índice FULLTEXT, mucho más rápido en búsquedas de texto grandes.
*
