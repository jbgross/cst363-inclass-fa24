CREATE DATABASE IF NOT EXISTS foo;
USE foo;

DROP TABLE IF EXISTS stock;
DROP TABLE IF EXISTS store;
DROP TABLE IF EXISTS bar;

CREATE TABLE bar
(
	barname varchar(16) primary key,
    price decimal(4,2) not null,
    calories int
);

INSERT INTO bar
(barname, price, calories)
VALUES
('Hershey\'s', 3.99, 110),
('Heath Bar', 1.99, 250),
('Milky Way', 99.99, 10000);


CREATE TABLE store
(
	storeid int AUTO_INCREMENT primary key,
	storename varchar(16) not null,
    address varchar(64)
);

INSERT INTO store
(storeid, storename)
VALUES
(1, 'Shell Station'),
(2, 'Target'),
(3, 'Lucky');

CREATE TABLE stock
(
	barname varchar(16) not null,
    storeid int not null,
    quantity int,
    PRIMARY KEY (barname, storeid),
    FOREIGN KEY fk_stock_bar (barname) REFERENCES bar(barname) ON UPDATE CASCADE,
    FOREIGN KEY fk_stock_store (storeid) REFERENCES store(storeid)
);

INSERT INTO stock
(barname, storeid, quantity)
VALUES
('Hershey\'s', 1, 10),
('Hershey\'s', 3, 10),
('Heath Bar', 2, 500);

SELECT *
FROM stock
	JOIN bar USING (barname)
    JOIN store USING (storeid)
-- WHERE
;
SELECT *
FROM bar
	JOIN store ON stock.storeid = store.storeid
    JOIN stock ON stock.barname = bar.barname
-- WHERE
;

UPDATE bar
SET barname = 'Hershies'
WHERE barname = 'Hershey\'s';



