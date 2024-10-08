USE course;
SELECT student.ID, course_id, teaches.ID, instructor.name
FROM student
	INNER JOIN takes USING (ID)
    -- INNER JOIN teaches USING (course_id, sec_id, year, semester)
    INNER JOIN teaches ON takes.course_id = teaches.course_id
				AND takes.sec_id = teaches.sec_id
                AND takes.year = teaches.year
                AND takes.semester = teaches.semester
    INNER JOIN instructor ON teaches.ID = instructor.ID
;

-- list student ID and names with > 90 credits or have taken more than 2 courses
SELECT ID, name
FROM student
WHERE tot_cred > 90
UNION
SELECT student.ID, name
FROM student
	JOIN takes ON student.ID = takes.ID
GROUP BY student.ID
HAVING COUNT(course_id) > 2;

SELECT ID, name
FROM student
WHERE EXISTS (SELECT 1 WHERE 1 = 2);

SELECT ID, name
FROM student AS s1
-- WHERE EXISTS (SELECT * FROM student s2 WHERE s1.ID = s2.ID);
WHERE EXISTS (SELECT * FROM takes WHERE s1.ID = takes.ID AND semester = 'Spring');

