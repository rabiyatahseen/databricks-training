-- SQL JOINS ASSIGNMENT

-- 1. Display all students and the courses they are enrolled in.
-- Include students who are not enrolled in any course.

SELECT s.student_name, c.course_name
FROM students s
LEFT JOIN enrollments e
ON s.student_id = e.student_id
LEFT JOIN courses c
ON e.course_id = c.course_id;


-- 2. Find all courses that currently have no students enrolled.

SELECT c.course_name
FROM courses c
LEFT JOIN enrollments e
ON c.course_id = e.course_id
WHERE e.course_id IS NULL;


-- 3. Display all instructors and the courses they teach,
-- including instructors who are not assigned to any course.

SELECT i.instructor_name, c.course_name
FROM instructors i
LEFT JOIN courses c
ON i.instructor_id = c.instructor_id;


-- 4. Find all courses that do not have an instructor assigned.

SELECT course_name
FROM courses
WHERE instructor_id IS NULL;


-- 5. Display all students and enrollment information using RIGHT JOIN.

SELECT s.student_name,
       e.enrollment_id,
       e.course_id,
       e.enrollment_date
FROM students s
RIGHT JOIN enrollments e
ON s.student_id = e.student_id;


-- 6. Find students who are not enrolled in any course.

SELECT s.student_name
FROM students s
LEFT JOIN enrollments e
ON s.student_id = e.student_id
WHERE e.student_id IS NULL;


-- 7. FULL OUTER JOIN simulation using UNION

SELECT s.student_name,
       e.enrollment_id,
       e.course_id
FROM students s
LEFT JOIN enrollments e
ON s.student_id = e.student_id

UNION

SELECT s.student_name,
       e.enrollment_id,
       e.course_id
FROM students s
RIGHT JOIN enrollments e
ON s.student_id = e.student_id;


-- 8. Find all courses that never appeared in enrollments table.

SELECT c.course_name
FROM courses c
LEFT JOIN enrollments e
ON c.course_id = e.course_id
WHERE e.course_id IS NULL;


-- 9. FULL OUTER JOIN simulation for instructors and courses

SELECT i.instructor_name,
       c.course_name
FROM instructors i
LEFT JOIN courses c
ON i.instructor_id = c.instructor_id

UNION

SELECT i.instructor_name,
       c.course_name
FROM instructors i
RIGHT JOIN courses c
ON i.instructor_id = c.instructor_id;


-- 10. Report showing student name, course name, instructor name

SELECT s.student_name,
       c.course_name,
       i.instructor_name
FROM students s
LEFT JOIN enrollments e
ON s.student_id = e.student_id
LEFT JOIN courses c
ON e.course_id = c.course_id
LEFT JOIN instructors i
ON c.instructor_id = i.instructor_id;


-- BONUS CHALLENGE
-- List every student and every course

SELECT s.student_name,
       c.course_name
FROM students s
CROSS JOIN courses c;
