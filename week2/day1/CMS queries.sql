-- CMS PRACTICE QUESTIONS (1 - 10)

-- 1. List all students along with their department names.

SELECT s.student_name,
       d.department_name
FROM students s
JOIN departments d
ON s.department_id = d.department_id;


-- 2. Display all staff members and their department names,
-- including staff without departments.

SELECT st.staff_name,
       d.department_name
FROM staff st
LEFT JOIN departments d
ON st.department_id = d.department_id;


-- 3. Find all departments that currently have no students assigned.

SELECT d.department_name
FROM departments d
LEFT JOIN students s
ON d.department_id = s.department_id
WHERE s.student_id IS NULL;


-- 4. Show students who do not have any marks recorded.

SELECT s.student_name
FROM students s
LEFT JOIN marks m
ON s.student_id = m.student_id
WHERE m.student_id IS NULL;


-- 5. Display subjects that are not assigned to any staff member.

SELECT sub.subject_name
FROM subjects sub
LEFT JOIN staff st
ON sub.staff_id = st.staff_id
WHERE st.staff_id IS NULL;


-- 6. Find the average CGPA department-wise.

SELECT d.department_name,
       AVG(s.cgpa) AS average_cgpa
FROM students s
JOIN departments d
ON s.department_id = d.department_id
GROUP BY d.department_name;


-- 7. Display departments where the average CGPA is greater than 8.0.

SELECT d.department_name,
       AVG(s.cgpa) AS average_cgpa
FROM students s
JOIN departments d
ON s.department_id = d.department_id
GROUP BY d.department_name
HAVING AVG(s.cgpa) > 8.0;


-- 8. Find the total number of students in each department.

SELECT d.department_name,
       COUNT(s.student_id) AS total_students
FROM departments d
LEFT JOIN students s
ON d.department_id = s.department_id
GROUP BY d.department_name;


-- 9. Display the highest and lowest marks scored in each subject.

SELECT sub.subject_name,
       MAX(m.marks) AS highest_marks,
       MIN(m.marks) AS lowest_marks
FROM marks m
JOIN subjects sub
ON m.subject_id = sub.subject_id
GROUP BY sub.subject_name;


-- 10. Find students who scored more than 90 in any exam.

SELECT DISTINCT s.student_name,
       m.marks
FROM students s
JOIN marks m
ON s.student_id = m.student_id
WHERE m.marks > 90;
