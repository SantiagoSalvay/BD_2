USE sakila;
--1
INSERT INTO staff (first_name, last_name, address_id, store_id, username, email, active, last_update)
VALUES ('Carlos', 'Pérez', 5, 1, 'cperez', NULL, 1, NOW());

SELECT * FROM staff;

--2
UPDATE staff SET staff_id = staff_id - 20;
UPDATE staff SET staff_id = staff_id + 20;




--3
ALTER TABLE staff
ADD COLUMN age INT CHECK (age BETWEEN 16 AND 70);

#4)
-- film tiene film_id (PK).

-- actor tiene actor_id (PK).

-- film_actor es tabla intermedia (N:M).

-- FK (film_id) → film(film_id)

-- FK (actor_id) → actor(actor_id)

-- PK compuesta (film_id, actor_id) asegura que un actor no se repita dos veces en la misma película.

--5

ALTER TABLE staff
ADD COLUMN lastUpdateUser VARCHAR(50);

DELIMITER $$

CREATE TRIGGER staff_before_insert
BEFORE INSERT ON staff
FOR EACH ROW
BEGIN
    SET NEW.lastUpdate = NOW();
    SET NEW.lastUpdateUser = USER();
END$$

CREATE TRIGGER staff_before_update
BEFORE UPDATE ON staff
FOR EACH ROW
BEGIN
    SET NEW.lastUpdate = NOW();
    SET NEW.lastUpdateUser = USER();
END$$

DELIMITER ;


--6
SHOW TRIGGERS LIKE 'film%';

