use sakila;


   #1) Crear usuario data_analyst

CREATE USER 'data_analyst'@'localhost' IDENTIFIED BY 'password123';


   #2) Conceder permisos SELECT, UPDATE, DELETE en sakila

GRANT USAGE ON *.* TO `data_analyst`@`localhost`;
GRANT SELECT, UPDATE, DELETE ON `sakila`.* TO `data_analyst`@`localhost`;

SHOW GRANTS FOR 'data_analyst'@'localhost';

   #3) Iniciar sesión como data_analyst y probar crear tabla

CREATE TABLE test_table (id INT);

   #4) Probar actualización de título de una película

UPDATE film
SET title = 'ACADEMY DINOSAUR REMAKE'
WHERE film_id = 1;

   #5) Revocar permiso UPDATE con usuario root/admin

REVOKE UPDATE ON sakila.* FROM 'data_analyst'@'localhost';

-- Verificar cambios:
SHOW GRANTS FOR 'data_analyst'@'localhost';



   #6) Intentar actualizar de nuevo con data_analyst


UPDATE film
SET title = 'ACADEMY DINOSAUR TEST'
WHERE film_id = 1;

-- Resultado esperado: ERROR 1142 (42000): UPDATE command denied to user 'data_analyst'@'localhost'
