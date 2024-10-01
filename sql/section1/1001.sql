use course;
DROP VIEW IF EXISTS transcript;
CREATE VIEW transcript AS
SELECT
     s.name, t.course_id, t.grade, t.year, t.semester
FROM student s
    JOIN takes t ON s.ID = t.ID
WHERE
    grade IS NOT NULL
    AND grade != 'F'
;

SELECT * 
FROM transcript
WHERE name = 'Zhang' AND year = 2009;
-- Error Code: 1140. In aggregated query without GROUP BY, expression #1 of SELECT list 
-- contains nonaggregated column 'course.s.name'; this is incompatible with sql_mode=only_full_group_by

SELECT s.name,
    s.ID,
	sum(c.credits)
FROM student s
    JOIN takes t USING (ID)
    JOIN course c USING (course_id)
WHERE t.grade IS NOT NULL
      AND t.grade != 'F'
GROUP BY 
-- s.name, 
s.ID;