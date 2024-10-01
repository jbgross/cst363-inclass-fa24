use course;
DROP VIEW IF EXISTS transcript;
CREATE VIEW transcript AS
SELECT s.name, s.ID, c.dept_name, t.course_id, t.semester, t.year, t.grade
FROM student s
    JOIN takes t ON s.ID = t.ID
    JOIN course c ON t.course_id = c.course_id
WHERE grade IS NOT NULL
    AND grade != 'F'
ORDER BY
	s.name, t.semester, t.year
;
select * from transcript;
SELECT *
FROM transcript t
    JOIN student s ON t.ID = s.ID
    AND s.dept_name = t.dept_name
;