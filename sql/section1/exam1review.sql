use course;
SELECT count(*)
FROM student JOIN takes;
SELECT count(*) FROM takes;

SELECT *
FROM student
	JOIN takes USING (ID)
;

SELECT *
FROM student
	JOIN takes ON student.ID = takes.ID
;

-- how many courses has a given student registered for
SELECT name, count(course_id)
FROM student
	INNER JOIN takes USING (ID)
GROUP BY ID;

select count(*) from student;

SELECT name, course_id
FROM student
	LEFT JOIN takes ON student.ID = takes.ID
;

SELECT name, COUNT(course_id)
FROM student
	LEFT JOIN takes ON student.ID = takes.ID
GROUP BY student.ID
;

SELECT course_id, student.ID
FROM student
	RIGHT JOIN takes ON student.ID = takes.ID
-- GROUP BY course_id
;

SELECT
	ID
FROM takes
WHERE course_id IN 
(SELECT course_id
FROM section
WHERE year = '2009' AND semester = 'Spring')
;

WITH course_count AS 
	(SELECT course_id, COUNT(ID) as count
	 FROM takes
	 GROUP BY course_id)
SELECT course_id
FROM course_count
WHERE count = 
 (SELECT max(count)
  FROM course_count)
;

SELECT course_id, sec_id, semester, year, name
FROM teaches
	JOIN instructor USING (ID)
WHERE ID in 
  (SELECT ID
   FROM instructor
   WHERE salary >= 85000)
;

SELECT t.course_id, i.ID
FROM instructor i
	JOIN teaches t USING (ID)
WHERE EXISTS (SELECT * FROM advisor a WHERE i.ID = a.i_ID)
;

SELECT t.course_id, i.ID
FROM instructor i
	JOIN teaches t USING (ID)
WHERE NOT EXISTS (SELECT * FROM advisor a WHERE i.ID = a.i_ID)
;

SELECT t.course_id, i.ID
FROM instructor i
	JOIN teaches t USING (ID)
WHERE ID NOT IN (SELECT DISTINCT i_ID FROM advisor)
;

SELECT ID, name
FROM instructor i 
WHERE NOT EXISTS (SELECT * FROM advisor a WHERE a.i_ID = i.ID)
; 