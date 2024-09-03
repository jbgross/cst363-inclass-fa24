DROP DATABASE IF EXISTS restaurant;
CREATE DATABASE IF NOT EXISTS restaurant;
USE restaurant;
-- SHOW TABLES;
-- DESCRIBE food; 
CREATE TABLE food
(
	food_name varchar(32),
    price decimal(5,2),
    calories int,
    is_deleted boolean
);

INSERT INTO food
(food_name, price, calories, is_deleted) 
VALUES
('Broccoli', 1.994, 20, false),
('Torta', 7.25, 1000, false),
('Fries', 7.25, 380, false),
('Cheese', .60, 160, false),
('Ranch', 200.05, 1, false);

UPDATE
	food
SET
	calories = 100
WHERE
	food_name = 'Ranch'
;

-- DELETE
-- FROM
-- 	food
-- WHERE
-- 	food_name = 'Broccoli'
-- ;
UPDATE 
	food
SET
	is_deleted = true
WHERE
	food_name = 'Broccoli';
    
SELECT
	*
FROM
	food;
    
SELECT
	price,
    calories,
    food_name
FROM
	food
WHERE
	is_deleted = false
ORDER BY
	price DESC,
    calories ASC
;