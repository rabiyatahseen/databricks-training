-- CMS QUESTIONS 21 - 30

-- 21. Display students ordered by CGPA
-- in descending order.

SELECT student_name,
       cgpa
FROM Student
ORDER BY cgpa DESC;


-- 22. Find total salary expenditure department-wise.

SELECT d.department_name,
       SUM(st.salary) AS total_salary
FROM Department d
JOIN Staff st
ON d.department_id = st.department_id
GROUP BY d.department_name;


-- 23. Display departments where total salary
-- exceeds 200000.

SELECT d.department_name,
       SUM(st.salary) AS total_salary
FROM Department d
JOIN Staff st
ON d.department_id = st.department_id
GROUP BY d.department_name
HAVING SUM(st.salary) > 200000;


-- 24. Find students admitted after 2021
-- and having CGPA above 7.5.

SELECT student_name,
       admission_year,
       cgpa
FROM Student
WHERE admission_year > 2021
AND cgpa > 7.5;


-- 25. Display number of students admitted each year.

SELECT admission_year,
       COUNT(student_id) AS total_students
FROM Student
GROUP BY admission_year
ORDER BY admission_year;


-- 26. Find city with maximum number of students.

SELECT city,
       COUNT(student_id) AS total_students
FROM Student
GROUP BY city
ORDER BY total_students DESC
LIMIT 1;


-- 27. Display all departments and their staff count,
-- including empty departments.

SELECT d.department_name,
       COUNT(st.staff_id) AS total_staff
FROM Department d
LEFT JOIN Staff st
ON d.department_id = st.department_id
GROUP BY d.department_name;


-- 28. Find students who failed
-- in at least one subject (marks < 50).

SELECT DISTINCT s.student_name,
       m.marks
FROM Student s
JOIN Mark m
ON s.student_id = m.student_id
WHERE m.marks < 50;


-- 29. Display staff hired before 2018.

SELECT staff_name,
       hire_date
FROM Staff
WHERE hire_date < '2018-01-01';


-- 30. Find departments where no staff salary
-- is recorded as NULL.

SELECT d.department_name
FROM Department d
JOIN Staff st
ON d.department_id = st.department_id
GROUP BY d.department_name
HAVING COUNT(CASE WHEN st.salary IS NULL THEN 1 END) = 0;
