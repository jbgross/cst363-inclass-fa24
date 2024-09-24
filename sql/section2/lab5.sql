-- Lab 5
-- use schema from files  'courses-small.sql';
use course;
-- 1. Show the names of all students who have taken course "CS-190" as well as the year they took the course.
--    use a join of the student and takes tables.
--    Answer:  Shankar and Williams took the course in 2009.
SELECT
	name, year
FROM student
    JOIN takes USING (ID)
WHERE
	course_id = 'CS-190';

-- 2. For every Comp. Sci. course taught, show the instructor's name, 
--    the course_id and the course_title.
--    Do not show duplicates.
--    Sort the result by instructor name and then course_id.
--    Join the instructor, teaches and course tables.
--    Answer has 7 rows.
SELECT
	DISTINCT name, course.course_id, title
FROM instructor
    JOIN teaches ON instructor.ID = teaches.ID
    JOIN course ON teaches.course_id = course.course_id
WHERE
	course.dept_name = 'Comp. Sci.'
;

-- 3.  Do a natural join on student and takes tables
--     for students in the 'Physics' department.
--     Answer has 4 rows.
SELECT
	*
FROM student
     JOIN takes ON student.ID = takes.ID
WHERE
    dept_name = 'Physics';

-- 4. Do a  left outer join on student and takes tables
--    for students in the 'Physics' department.
--    Answer has 5 rows.
SELECT
    *
FROM student
    LEFT JOIN takes ON student.ID = takes.ID
WHERE
    dept_name = 'Physics';
;

-- 5. What difference do you observe in the results of #3 compared to #4
--    

-- 6. Return the names of students who have not taken any classes. 
--    Hint:  use "is null" 
--    Answer:  One row, name = 'Snow'   
select ;

-- 7. Give the course_id for courses that have never been taught. 
--    Answer:  BIO-399 
-- DWIM
-- RPM
SELECT
	s.course_id
	-- c.course_id
	-- COUNT(c.course_id)
FROM course c
    LEFT JOIN section s ON c.course_id = s.course_id
WHERE
    s.course_id IS NULL
 ;

-- 8. Give the student ID, name and the count of number of courses taken.  
--    If a student has not taken any course, show the student ID, name and a count of 0.
--    Answer:  13 rows.  Student 70557, Snow is listed with a count of 0
SELECT
	student.ID, name, count(takes.course_id)
FROM takes
    RIGHT JOIN student ON student.ID = takes.ID
GROUP BY
	student.ID;

-- 9.  List the departments and the number of students 
--     for departments with less than 4 students.
--     Answer:  Biology, Finance, History and Music have 1 student.
--              Elec. Eng. has 2, and Physics has 3.
SELECT
	department.dept_name, COUNT(ID) AS count
FROM student
	RIGHT JOIN department ON student.dept_name = department.dept_name
GROUP BY
    department.dept_name
HAVING
	count < 4;
INSERT INTO department VALUES ("CD", "BIT", 5);
