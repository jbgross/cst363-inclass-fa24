-- Lab 2
-- use the file courses-small.sql to create tables.

-- 1. insert a new student with ID 12399, name "Fred Brooks", majoring in Comp. Sci., total credits 0.
insert 1;

-- 2. change the tot_cred for student 12399 to 100
update 2;

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