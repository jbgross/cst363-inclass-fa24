drop database IF EXISTS music2;
create database IF NOT EXISTS music2;
use music2;
DROP TABLE song;
CREATE TABLE IF NOT EXISTS song
(
	title varchar(64),
    artist varchar(64),
    length_seconds int,
    release_date date
);
DESCRIBE song;

INSERT INTO song
(title, artist, length_seconds)
VALUES
('Blue', 'Eiffel65', 286),
('Hotel California', 'The Eagles', 353),
('Blinding Lights', 'The Weeknd', 500),
('One Love', 'Bob Marley', 420);

SELECT
    artist,
	title,
    release_date
FROM
	song;
    
INSERT INTO song
(title, artist, length_seconds)
VALUES
('After Hours', 'The Weeknd', 360);

INSERT INTO song
(title, artist, length_seconds)
VALUES
('Starboy', 'The Weekend', 360);
SELECT
	title, artist, length_seconds
FROM
	song
WHERE
	(artist = 'The Weeknd'
    OR
    artist = 'The Weekend')
    AND 
    -- this is a comment
	-- this is also a comment
    length_seconds < 500
    ;