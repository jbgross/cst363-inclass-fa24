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
update 3;

-- 4. Give all faculty in the Physics department a $3,500 salary increase
update 4;

-- 5. try to delete the course 'PHY-101'
delete 5;

-- 6. delete the course 'CS-315'
delete 6;

-- 7. Why does the delete in #5 fail while #6 works?
--     
--   

-- 8. Student 12399 enrolls into section 
--    course_id 'CS-101', section 1, semester 'Fall', year 2009, grade null
--    insert a row into the takes table for the enrollment
insert 8;

-- 9.  Find all the rows in the takes table with a null grade.
--      The answer should have 2 rows.
select 9;

-- 10.  Update the grade for student 12399 in 'CS-101' to 'A'. 
update 10;

-- reset the course tables by rerunning the script file courses-small.sql 