-- code from Thursday, Aug 29, 2024
create database music;
use music;
show tables;
describe song;
CREATE TABLE song 
(
	artist varchar(32),
    title varchar(64),
    length_seconds int
);

INSERT INTO song
(artist, title, length_seconds)
VALUES
('Arctic Monkeys', '505', 240),
('MF Doom', 'Operation Doomsday', 180),
('Soundgarden', 'Spoonman', 185),
('Chief Keef', 'Kills', 126),
('New Jeans', 'Ditto', 310);

SELECT length_seconds, artist FROM song;

INSERT INTO song
(artist, title, length_seconds)
VALUES
('Arctic Monkeys', 'Old Yellow Bricks', 194);

INSERT INTO song
(artist, title, length_seconds)
VALUES
('Artic Monkeys', 'Flourescent Adolescents', 194);

SELECT artist, length_seconds, title FROM song;

SELECT
	artist,
    length_seconds,
    title
FROM
	song
WHERE
	artist = 'Arctic Monkeys';
    
SELECT
	artist,
    length_seconds,
    title
FROM
	song
WHERE
	length_seconds > 180
    AND
    artist = 'Arctic Monkeys';

SELECT
	artist,
    length_seconds,
    title
FROM
	song
WHERE
	artist = 'Chief Keef'
    OR
    artist = 'Arctic Monkeys';