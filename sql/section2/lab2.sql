-- Lab 2
-- use the file courses-small.sql to create tables.
use course;
-- 1. insert a new student with ID 12399, name "Fred Brooks", 
-- majoring in Comp. Sci., total credits 0.
INSERT INTO student
	(ID, name, dept_name, tot_cred)
VALUES
	(12399, 'Fred Brooks', 'Comp. Sci.', 0);
SELECT * FROM student WHERE ID = 12399;
-- Error Code: 1452. Cannot add or update a child row: 
-- a foreign key constraint fails (`course`.`student`, 
-- CONSTRAINT `student1` FOREIGN KEY (`dept_name`) 
-- REFERENCES `department` (`dept_name`) ON DELETE SET NULL)

-- 2. change the tot_cred for student 12399 to 100
UPDATE
	student
SET
	tot_cred = 100
WHERE
	ID = 12399;

-- 3. Give all faculty a 4% increase in salary
UPDATE
	instructor
SET
	-- salary = salary + salary * 0.04
	salary = salary * 1.04
WHERE
	1=1;
select name, salary from instructor;
-- 4. Give all faculty in the Physics department a $3,500 salary increase
UPDATE
	instructor
SET
	salary = salary + 3500
WHERE
	dept_name = 'Physics';

-- 5. try to delete the course 'PHY-101'
DELETE
FROM
	course
WHERE
	course_id = 'PHY-101';
    
-- 6. delete the course 'CS-315'
DELETE
FROM
	course
WHERE
	course_id = 'CS-315';

-- 7. Why does the delete in #5 fail while #6 works?
--     
--   

-- 8. Student 12399 enrolls into section 
--    course_id 'CS-101', section 1, semester 'Fall', year 2009, grade null
--    insert a row into the takes table for the enrollment
INSERT INTO takes
	(ID, course_id, sec_id, semester, year, grade)
VALUES
	(12399, 'CS-101', 1, 'Fall', 2009, null);
select * from section where course_id = 'CS-101';
select * from takes where ID = 12399;
-- 9.  Find all the rows in the takes table with a null grade.
--      The answer should have 2 rows.
SELECT
	*
FROM
	takes
WHERE
	grade is null;

-- 10.  Update the grade for student 12399 in 'CS-101' to 'A'. 
UPDATE
	takes
SET
	grade = 'A'
WHERE
-- 	ID = 12399 AND course_id = 'CS-101' AND semester = 'Fall' AND year = 2009;
	(ID, course_id, semester, year) = (12399, 'CS-101', 'Fall', 2009);

-- reset the course tables by rerunning the script file courses-small.sql 