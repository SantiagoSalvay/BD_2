DROP DATABASE IF EXISTS imdb;
CREATE DATABASE imdb;
USE imdb;

#Crear tabla de actor
CREATE TABLE actor (
  actor_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (actor_id)
);

#Crear tabla de pelicula

CREATE TABLE film (
  film_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  title VARCHAR(255) NOT NULL,
  description TEXT DEFAULT NULL,
  release_year YEAR DEFAULT NULL,
  PRIMARY KEY (film_id)
);

#Crear la tabla de ACTORxPELICULA
CREATE TABLE film_actor (
  actor_id SMALLINT UNSIGNED NOT NULL,
  film_id SMALLINT UNSIGNED NOT NULL,
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (actor_id, film_id),
  CONSTRAINT fk_film_actor_actor FOREIGN KEY (actor_id) 
    REFERENCES actor (actor_id) ON DELETE RESTRICT ON UPDATE CASCADE
);


#Alterar tablas:

ALTER TABLE actor
  ADD COLUMN last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE film
  ADD COLUMN last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE film_actor
  ADD CONSTRAINT fk_film_actor_film FOREIGN KEY (film_id)
    REFERENCES film (film_id) ON DELETE RESTRICT ON UPDATE CASCADE;

#Insertar informacion

INSERT INTO actor (first_name, last_name)
VALUES ('Leonardo', 'DiCaprio'),
       ('Kate', 'Winslet'),
       ('Brad', 'Pitt');

INSERT INTO film (title, description, release_year)
VALUES ('Titanic', 'A film about a tragic ship sinking', 1997),
       ('Inception', 'A film about dreams within dreams', 2010);

INSERT INTO film_actor (actor_id, film_id)
VALUES (1, 1),  
       (2, 1),  
       (1, 2),  
       (3, 2); 

