-- homework 1.sql
-- use courses-small.sql to create tables.
select * from department;
use course;
-- select * from movies.actor;
-- 1. Show the name and salary of all instructors sorted by name.
SELECT
	name, salary
FROM 
	instructor
ORDER BY 
	name;

-- 2. Show all columns for instructors in the 'Comp. Sci.' department in order by name.
--    Answer:  has 3 rows: Brandt, Katz, Srinivasan
SELECT
	*
FROM 
	instructor
WHERE
	dept_name = 'Comp. Sci.'
ORDER BY 
	name;

-- 3. Show name, salary, department for instructors with salaries less than $50,000 in order by name.
--    Answer:  1 row for Mozart
SELECT
	name, salary, dept_name
FROM 
	instructor
WHERE
	salary < 50000
ORDER BY 
	name;

-- 4. Show the student name, major department and total credits for 
--    students with at least 98 credits.  Sort the list by total credits.
--    Answer: 4 rows
SELECT
	name, dept_name, tot_cred
FROM 
	student
WHERE
	tot_cred >= 98
ORDER BY 
	tot_cred;

-- 5. Show the student ID and name for students who are majoring in  
--    'Elec. Eng.' or 'Comp. Sci.'  and have at least 90 credits.  Sort the list by ID.
--    Answer:  2 rows. Zhang, Bourikas
SELECT
	ID, name
FROM 
	student
WHERE
	tot_cred >= 90
    AND
    dept_name IN ('Elec. Eng.', 'Comp. Sci.')
ORDER BY 
	ID;

-- 6. Show all columns of the student table with rows listed in order by student name.
SELECT
	*
FROM 
	student
ORDER BY 
	name;

-- 7. Show the  ID, name and salary for all instructors.
--    Order by salary highest to lowest.
SELECT
	ID, name, salary
FROM 
	instructor
ORDER BY 
	salary DESC;

-- 8. Show all the student majors (the dept_name column in the student table) without duplicates.
--    Label the dept_name column as 'major'.  List the majors in alphabetical order.
--    Answer: 7 rows
SELECT
	DISTINCT dept_name major
FROM 
	student
ORDER BY 
	major;
