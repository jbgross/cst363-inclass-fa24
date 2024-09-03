DROP DATABASE IF EXISTS restaurant2;
CREATE SCHEMA IF NOT EXISTS restaurant2;
USE restaurant2;
-- SHOW TABLES;
-- DESCRIBE food_item;
CREATE TABLE food_item
(
	food_name varchar(64),
	price decimal(5, 2),
	calories int
);

INSERT INTO food_item
(food_name, price, calories)
VALUES
('Milk', 50, 900),
('Eggs', 100, 10),
('Bread', 85.909, 10)
;

SELECT
	*
FROM
	food_item;

UPDATE food_item
SET
	calories = 30
WHERE
	food_name = 'Milk'
;

SELECT
	calories, price, food_name
FROM
	food_item
-- WHERE
ORDER BY
	calories DESC,
    price ASC
;