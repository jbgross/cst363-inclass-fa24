USE course;
SELECT * FROM takes WHERE ID = 70557;
SELECT *
FROM takes
WHERE grade IS NULL;

-- 
SELECT 
    student.ID, count(course_id)
FROM student
	LEFT JOIN takes 
		ON student.ID = takes.ID
 		AND grade IS NOT NULL
-- WHERE grade IS NOT NULL
 GROUP BY student.ID 
;

SELECT 
    -- student.ID, count(course_id)
    student.ID, course_id, grade
FROM student
	LEFT JOIN takes 
		ON student.ID = takes.ID
-- 		AND grade IS NOT NULL
WHERE grade IS NOT NULL
-- GROUP BY student.ID 
;

SELECT distinct course_id, year, semester
FROM section
WHERE semester NOT IN ('Fall', 'Spring');

SELECT course_id
FROM section
WHERE (semester, year) = ('Spring', 2010);

SELECT course_id
FROM section
WHERE (semester, year) = ('Fall', 2009);

SELECT course_id
FROM section
WHERE (semester, year) = ('Fall', 2009)
AND course_id NOT IN
(
	SELECT course_id
	FROM section
	WHERE (semester, year) = ('Spring', 2010) 
);

SELECT COUNT(DISTINCT ID)
FROM takes
WHERE (course_id, semester, year, sec_id) IN
( 
	SELECT course_id, semester, year, sec_id
	FROM teaches
	WHERE ID = 10101
);

SELECT
	COUNT(DISTINCT ta.ID)
FROM teaches te
    JOIN takes ta USING (course_id, semester, year, sec_id)
WHERE
	te.ID = 10101;
    
SELECT 1; -- non-empty relation - EXISTS will be true, NOT EXISTS will be false
SELECT 1 WHERE 1 = 2; -- empty relation - EXISTS will be false, NOT EXISTS will be true
SELECT COUNT(*) FROM student WHERE EXISTS (SELECT 1 );
SELECT COUNT(*) FROM student WHERE EXISTS (SELECT 1 WHERE 1 = 2);

SELECT DISTINCT ID
FROM takes t1
	JOIN course c1 ON t1.course_id = c1.course_id
WHERE 
	c1.dept_name = 'Comp. Sci.';
    
SELECT DISTINCT ID
FROM takes t1
	JOIN course c1 ON t1.course_id = c1.course_id
WHERE 
	c1.dept_name = 'Biology';

SELECT DISTINCT t1.ID
FROM takes t1
	JOIN course c1 ON t1.course_id = c1.course_id
WHERE 
	c1.dept_name = 'Comp. Sci.'
    AND NOT EXISTS
(
	SELECT DISTINCT ID
	FROM takes t2
		JOIN course c2 ON t2.course_id = c2.course_id
	WHERE 
		c2.dept_name = 'Biology'
        AND t1.ID = t2.ID
);

SELECT * FROM takes WHERE course_id LIKE 'BIO%';
SELECT * FROM student WHERE ID = '00128';
INSERT INTO takes
(ID, course_id, sec_id, semester, year, grade)
VALUES ('00128', 'BIO-101', '1', 'Summer', '2009', 'B');

WITH summer_schedule AS
(SELECT * FROM section WHERE semester = 'Summer')
SELECT * 
FROM summer_schedule
WHERE year = 2009;

