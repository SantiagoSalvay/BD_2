use sakila;
DELIMITER //
CREATE FUNCTION GetFilmCopies(
    p_film_id INT,
    p_store_id INT
) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_copies INT;

    SELECT COUNT(i.inventory_id)
    INTO total_copies
    FROM inventory i
    WHERE i.film_id = p_film_id
      AND i.store_id = p_store_id;

    RETURN total_copies;
END //
DELIMITER ;

-- Uso con film_id:
SELECT GetFilmCopies(1,1);

-- Si se quisiera usar por nombre, se hace con subconsulta:
SELECT GetFilmCopies(
    (SELECT film_id FROM film WHERE title = 'ACADEMY DINOSAUR'),
    1
);


DELIMITER //
CREATE PROCEDURE GetCustomersByCountry(
    IN p_country VARCHAR(50),
    OUT p_customer_list TEXT
)
BEGIN
    DECLARE v_first VARCHAR(45);
    DECLARE v_last VARCHAR(45);
    DECLARE finished INT DEFAULT 0;

    DECLARE cur CURSOR FOR
        SELECT c.first_name, c.last_name
        FROM customer c
        JOIN address a ON c.address_id = a.address_id
        JOIN city ci ON a.city_id = ci.city_id
        JOIN country co ON ci.country_id = co.country_id
        WHERE co.country = p_country;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

    SET p_customer_list = '';

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO v_first, v_last;
        IF finished = 1 THEN
            LEAVE read_loop;
        END IF;

        -- concatenamos sin usar funciones de agregación
        IF p_customer_list = '' THEN
            SET p_customer_list = CONCAT(v_first, ' ', v_last);
        ELSE
            SET p_customer_list = CONCAT(p_customer_list, '; ', v_first, ' ', v_last);
        END IF;
    END LOOP;
    CLOSE cur;
END //
DELIMITER ;

-- Uso:
CALL GetCustomersByCountry('Canada', @customers);
SELECT @customers;

-- FUNCION: inventory_in_stock
-- Esta función recibe un inventory_id y devuelve 1 si esa copia de película está en stock
-- o 0 si no lo está. Usa EXISTS con rental para chequear devoluciones.

SELECT inventory_in_stock(1);

-- PROCEDURE: film_in_stock
-- Este procedimiento recibe film_id y store_id, y devuelve todos los inventory_id
-- que están disponibles en esa tienda.
-- Además, devuelve el número de filas encontradas (OUT).

CALL film_in_stock(1,1,@count);
SELECT @count;
