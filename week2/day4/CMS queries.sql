-- CMS QUESTIONS 31 - 40
-- Window Functions

-- 31. Assign a row number to students ordered by CGPA.

SELECT student_name,
       cgpa,
       ROW_NUMBER() OVER (
           ORDER BY cgpa DESC
       ) AS row_number
FROM Student;


-- 32. Rank students based on their CGPA.

SELECT student_name,
       cgpa,
       RANK() OVER (
           ORDER BY cgpa DESC
       ) AS student_rank
FROM Student;


-- 33. Display dense rank of staff salaries.

SELECT staff_name,
       salary,
       DENSE_RANK() OVER (
           ORDER BY salary DESC
       ) AS dense_salary_rank
FROM Staff;


-- 34. Find the top 3 highest scoring students
-- using window functions.

SELECT *
FROM (
    SELECT s.student_name,
           SUM(m.marks) AS total_marks,
           ROW_NUMBER() OVER (
               ORDER BY SUM(m.marks) DESC
           ) AS row_num
    FROM Student s
    JOIN Mark m
    ON s.student_id = m.student_id
    GROUP BY s.student_name
) ranked_students
WHERE row_num <= 3;


-- 35. Display running total of marks for each student.

SELECT s.student_name,
       m.exam_date,
       m.marks,
       SUM(m.marks) OVER (
           PARTITION BY s.student_name
           ORDER BY m.exam_date
       ) AS running_total
FROM Student s
JOIN Mark m
ON s.student_id = m.student_id;


-- 36. Find average marks for each subject
-- using window functions.

SELECT sub.subject_name,
       m.marks,
       AVG(m.marks) OVER (
           PARTITION BY sub.subject_name
       ) AS average_marks
FROM Subject sub
JOIN Mark m
ON sub.subject_id = m.subject_id;


-- 37. Display previous exam marks for each student using LAG().

SELECT s.student_name,
       m.exam_date,
       m.marks,
       LAG(m.marks) OVER (
           PARTITION BY s.student_name
           ORDER BY m.exam_date
       ) AS previous_marks
FROM Student s
JOIN Mark m
ON s.student_id = m.student_id;


-- 38. Display next exam marks for each student using LEAD().

SELECT s.student_name,
       m.exam_date,
       m.marks,
       LEAD(m.marks) OVER (
           PARTITION BY s.student_name
           ORDER BY m.exam_date
       ) AS next_marks
FROM Student s
JOIN Mark m
ON s.student_id = m.student_id;


-- 39. Find highest marks within each subject
-- using MAX() OVER().

SELECT sub.subject_name,
       m.marks,
       MAX(m.marks) OVER (
           PARTITION BY sub.subject_name
       ) AS highest_marks
FROM Subject sub
JOIN Mark m
ON sub.subject_id = m.subject_id;


-- 40. Display cumulative average marks ordered by exam date.

SELECT exam_date,
       marks,
       AVG(marks) OVER (
           ORDER BY exam_date
       ) AS cumulative_average
FROM Mark;
