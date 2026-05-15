-- CMS QUESTIONS 41 - 50
-- Advanced Window Functions & Reporting

-- 41. Find the first student admitted in each department.

SELECT *
FROM (
    SELECT s.student_name,
           d.department_name,
           s.admission_year,
           ROW_NUMBER() OVER (
               PARTITION BY d.department_name
               ORDER BY s.admission_year
           ) AS row_num
    FROM Student s
    JOIN Department d
    ON s.department_id = d.department_id
) ranked_students
WHERE row_num = 1;


-- 42. Display the latest hired staff member in each department.

SELECT *
FROM (
    SELECT st.staff_name,
           d.department_name,
           st.hire_date,
           ROW_NUMBER() OVER (
               PARTITION BY d.department_name
               ORDER BY st.hire_date DESC
           ) AS row_num
    FROM Staff st
    JOIN Department d
    ON st.department_id = d.department_id
) ranked_staff
WHERE row_num = 1;


-- 43. Divide students into 4 CGPA quartiles using NTILE().

SELECT student_name,
       cgpa,
       NTILE(4) OVER (
           ORDER BY cgpa DESC
       ) AS cgpa_quartile
FROM Student;


-- 44. Find percentage rank of students based on CGPA.

SELECT student_name,
       cgpa,
       PERCENT_RANK() OVER (
           ORDER BY cgpa
       ) AS percentage_rank
FROM Student;


-- 45. Display cumulative distribution of salaries.

SELECT staff_name,
       salary,
       CUME_DIST() OVER (
           ORDER BY salary
       ) AS cumulative_distribution
FROM Staff;


-- 46. Find subjects where a student's marks
-- are above subject average.

SELECT *
FROM (
    SELECT s.student_name,
           sub.subject_name,
           m.marks,
           AVG(m.marks) OVER (
               PARTITION BY sub.subject_name
           ) AS subject_average
    FROM Student s
    JOIN Mark m
    ON s.student_id = m.student_id
    JOIN Subject sub
    ON m.subject_id = sub.subject_id
) subject_data
WHERE marks > subject_average;


-- 47. Find departments whose average staff salary
-- is higher than overall average salary.

SELECT d.department_name,
       AVG(st.salary) AS department_average_salary
FROM Department d
JOIN Staff st
ON d.department_id = st.department_id
GROUP BY d.department_name
HAVING AVG(st.salary) >
(
    SELECT AVG(salary)
    FROM Staff
);


-- 48. Display students who scored above
-- department average marks.

SELECT *
FROM (
    SELECT s.student_name,
           d.department_name,
           m.marks,
           AVG(m.marks) OVER (
               PARTITION BY d.department_name
           ) AS department_average
    FROM Student s
    JOIN Department d
    ON s.department_id = d.department_id
    JOIN Mark m
    ON s.student_id = m.student_id
) department_data
WHERE marks > department_average;


-- 49. Find the 3rd highest mark using DENSE_RANK().

SELECT *
FROM (
    SELECT s.student_name,
           m.marks,
           DENSE_RANK() OVER (
               ORDER BY m.marks DESC
           ) AS mark_rank
    FROM Student s
    JOIN Mark m
    ON s.student_id = m.student_id
) ranked_marks
WHERE mark_rank = 3;


-- 50. Generate report showing:
-- student name, department, subject,
-- exam type, marks, department average,
-- and overall rank.

SELECT s.student_name,
       d.department_name,
       sub.subject_name,
       m.exam_type,
       m.marks,

       AVG(m.marks) OVER (
           PARTITION BY d.department_name
       ) AS department_average,

       RANK() OVER (
           ORDER BY m.marks DESC
       ) AS overall_rank

FROM Student s

JOIN Department d
ON s.department_id = d.department_id

JOIN Mark m
ON s.student_id = m.student_id

JOIN Subject sub
ON m.subject_id = sub.subject_id;
