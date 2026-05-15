-- =========================================
-- CMS QUESTIONS 11 - 20
-- =========================================


-- 11. Display names of students
-- who belong to Computer Science department.

SELECT s.student_name
FROM Student s
JOIN Department d
ON s.department_id = d.department_id
WHERE d.department_name = 'Computer Science';


-- 12. Find number of subjects handled by each staff member.

SELECT st.staff_name,
       COUNT(sub.subject_id) AS total_subjects
FROM Staff st
LEFT JOIN Subject sub
ON st.staff_id = sub.staff_id
GROUP BY st.staff_name;


-- 13. Display students along with total marks
-- obtained across all subjects.

SELECT s.student_name,
       SUM(m.marks) AS total_marks
FROM Student s
JOIN Mark m
ON s.student_id = m.student_id
GROUP BY s.student_name;


-- 14. Find departments with more than 2 staff members.

SELECT d.department_name,
       COUNT(st.staff_id) AS total_staff
FROM Department d
JOIN Staff st
ON d.department_id = st.department_id
GROUP BY d.department_name
HAVING COUNT(st.staff_id) > 2;


-- 15. Display students whose CGPA
-- is above average CGPA.

SELECT student_name,
       cgpa
FROM Student
WHERE cgpa >
(
    SELECT AVG(cgpa)
    FROM Student
);


-- 16. Find staff members earning more than
-- average salary of their department.

SELECT st.staff_name,
       st.salary,
       st.department_id
FROM Staff st
WHERE st.salary >
(
    SELECT AVG(salary)
    FROM Staff
    WHERE department_id = st.department_id
);


-- 17. Display second highest salary among staff members.

SELECT MAX(salary) AS second_highest_salary
FROM Staff
WHERE salary <
(
    SELECT MAX(salary)
    FROM Staff
);


-- 18. Find students who scored highest marks
-- in each subject.

SELECT s.student_name,
       sub.subject_name,
       m.marks
FROM Mark m
JOIN Student s
ON m.student_id = s.student_id
JOIN Subject sub
ON m.subject_id = sub.subject_id
WHERE m.marks =
(
    SELECT MAX(m2.marks)
    FROM Mark m2
    WHERE m2.subject_id = m.subject_id
);


-- 19. Display all students and their marks,
-- including students without marks.

SELECT s.student_name,
       m.marks
FROM Student s
LEFT JOIN Mark m
ON s.student_id = m.student_id;


-- 20. Find subjects where average marks are below 70.

SELECT sub.subject_name,
       AVG(m.marks) AS average_marks
FROM Mark m
JOIN Subject sub
ON m.subject_id = sub.subject_id
GROUP BY sub.subject_name
HAVING AVG(m.marks) < 70;
