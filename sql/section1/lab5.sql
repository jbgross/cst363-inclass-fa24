-- Lab 5
-- use schema from files  'courses-small.sql';
use course;
-- 1. Show the names of all students who have taken course "CS-190" as well as the year they took the course.
--    use a join of the student and takes tables.
--    Answer:  Shankar and Williams took the course in 2009.
SELECT
	name, year -- , ID
FROM student
    JOIN takes ON student.ID = takes.ID
	AND takes.course_id = 'CS-190';
-- WHERE
-- 	takes.course_id = 'CS-190';

-- 2. For every Comp. Sci. course taught, show the instructor's name, 
--    the course_id and the course_title.
--    Do not show duplicates.
--    Sort the result by instructor name and then course_id.
--    Join the instructor, teaches and course tables.
--    Answer has 7 rows.
SELECT
	DISTINCT i.name, t.course_id, c.title
FROM instructor i
    JOIN teaches t ON i.ID = t.ID
    JOIN course c ON t.course_id = c.course_id
WHERE
    c.dept_name = 'Comp. Sci.' ;

-- 3.  Do a natural join on student and takes tables
--     for students in the 'Physics' department.
--     Answer has 4 rows.
SELECT
   *
FROM
   student NATURAL JOIN takes
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
	dept_name = 'Physics' ;

-- 5. What difference do you observe in the results of #3 compared to #4
--    Includes Snow, who has not taken any courses

-- 6. Return the names of students who have not taken any classes. 
--    Hint:  use "is null" 
--    Answer:  One row, name = 'Snow'   
SELECT
	name
FROM student
	LEFT JOIN takes ON student.id = takes.id
WHERE
	course_id IS NULL;
select name from student where tot_cred = 0;
-- 7. Give the course_id for courses that have never been taught. 
--    Answer:  BIO-399 
SELECT
	c.course_id
    -- *
FROM course c
    LEFT JOIN teaches t ON c.course_id = t.course_id
WHERE 
    t.course_id IS NULL;

-- 8. Give the student ID, name and the count of number of courses taken.  
--    If a student has not taken any course, show the student ID, name and a count of 0.
--    Answer:  13 rows.  Student 70557, Snow is listed with a count of 0
SELECT
	s.ID, s.name, count(t.course_id)
FROM takes t
    RIGHT JOIN student s ON s.ID = t.ID
GROUP BY
	s.ID
 ;

-- 9.  List the departments and the number of students 
--     for departments with less than 4 students.
--     Answer:  Biology, Finance, History and Music have 1 student.
--              Elec. Eng. has 2, and Physics has 3.
SELECT
	d.dept_name, count(ID) AS count
FROM student s
    RIGHT JOIN department d ON s.dept_name = d.dept_name
GROUP BY
    d.dept_name
HAVING
   count < 4;

