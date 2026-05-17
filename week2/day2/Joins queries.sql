-- 1. Retrieve the names of employees and their corresponding managers from the employees table, ensuring that even employees without managers are included.

SELECT e.emp_name AS employee_name,
       m.emp_name AS manager_name
FROM employees e
LEFT JOIN employees m
ON e.manager_id = m.emp_id;


-- 2. Display all employees and their corresponding departments from the employees and departments tables, showing employees even if they don't belong to any department.

SELECT e.emp_name,
       d.dept_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id;


-- 3. List the names of employees who report to a manager, along with their manager's name.

SELECT e.emp_name AS employee_name,
       m.emp_name AS manager_name
FROM employees e
INNER JOIN employees m
ON e.manager_id = m.emp_id;


-- 4. Find the total salary paid to each employee and their respective department, including departments with no employees.

SELECT e.emp_name,
       d.dept_name
FROM departments d
LEFT JOIN employees e
ON d.dept_id = e.dept_id;


-- 5. Display a list of employees who do not belong to any department.

SELECT emp_name
FROM employees
WHERE dept_id IS NULL;


-- 6. Fetch the names of employees and the projects they are assigned to.

SELECT e.emp_name,
       p.project_name
FROM employees e
LEFT JOIN projects p
ON e.emp_id = p.emp_id;


-- 7. List all employees who have completed at least one project.

SELECT e.emp_name,
       p.project_name
FROM employees e
INNER JOIN projects p
ON e.emp_id = p.emp_id;


-- 8. Show the names of employees and their projects, ensuring that no project is omitted.

SELECT e.emp_name,
       p.project_name
FROM employees e
RIGHT JOIN projects p
ON e.emp_id = p.emp_id;


-- 9. Find all employees and their corresponding salaries.

SELECT emp_name,
       NULL AS salary
FROM employees;


-- 10. Retrieve employee names and department names including employees not in any department.

SELECT e.emp_name,
       d.dept_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id;


-- 11. Find names of all departments and employees, including departments with no employees.

SELECT d.dept_name,
       e.emp_name
FROM departments d
LEFT JOIN employees e
ON d.dept_id = e.dept_id;


-- 12. List all employees with their contact information.

SELECT emp_name,
       NULL AS contact_info
FROM employees;


-- 13. Show employees and department names including unmatched records.

SELECT e.emp_name,
       d.dept_name
FROM employees e
FULL OUTER JOIN departments d
ON e.dept_id = d.dept_id;


-- 14. Find employees who have not completed any project.

SELECT e.emp_name,
       p.project_name
FROM employees e
LEFT JOIN projects p
ON e.emp_id = p.emp_id
WHERE p.project_id IS NULL;


-- 15. Retrieve employee names and project names including employees without projects.

SELECT e.emp_name,
       p.project_name
FROM employees e
LEFT JOIN projects p
ON e.emp_id = p.emp_id;


-- 16. List all projects and employees assigned to them.

SELECT p.project_name,
       e.emp_name
FROM projects p
LEFT JOIN employees e
ON p.emp_id = e.emp_id;


-- 17. Show employees who have both a manager and at least one project.

SELECT e.emp_name AS employee_name,
       m.emp_name AS manager_name,
       p.project_name
FROM employees e
INNER JOIN employees m
ON e.manager_id = m.emp_id
INNER JOIN projects p
ON e.emp_id = p.emp_id;


-- 18. List employees and departments excluding employees without departments.

SELECT e.emp_name,
       d.dept_name
FROM employees e
INNER JOIN departments d
ON e.dept_id = d.dept_id;


-- 19. Display employees who belong to multiple departments.

SELECT 'Current table structure supports only one department per employee'
AS message;


-- 20. List all departments and employees including empty departments.

SELECT d.dept_name,
       e.emp_name
FROM departments d
LEFT JOIN employees e
ON d.dept_id = e.dept_id;


-- 21. Retrieve employees who worked on at least one project and do not belong to a department.

SELECT e.emp_name,
       p.project_name
FROM employees e
INNER JOIN projects p
ON e.emp_id = p.emp_id
WHERE e.dept_id IS NULL;


-- 22. Find total number of employees in each department.

SELECT d.dept_name,
       COUNT(e.emp_id) AS total_employees
FROM departments d
LEFT JOIN employees e
ON d.dept_id = e.dept_id
GROUP BY d.dept_name;


-- 23. Show employees and their managers excluding employees without managers.

SELECT e.emp_name AS employee_name,
       m.emp_name AS manager_name
FROM employees e
INNER JOIN employees m
ON e.manager_id = m.emp_id;


-- 24. Display all employee names with corresponding managers including employees without managers.

SELECT e.emp_name AS employee_name,
       m.emp_name AS manager_name
FROM employees e
LEFT JOIN employees m
ON e.manager_id = m.emp_id;


-- 25. Find department names and employee count including empty departments.

SELECT d.dept_name,
       COUNT(e.emp_id) AS employee_count
FROM departments d
LEFT JOIN employees e
ON d.dept_id = e.dept_id
GROUP BY d.dept_name;


-- 26. List employees and the departments they belong to including empty departments.

SELECT e.emp_name,
       d.dept_name
FROM departments d
LEFT JOIN employees e
ON d.dept_id = e.dept_id;


-- 27. Show employees who do not have salary records.

SELECT emp_name
FROM employees;


-- 28. Retrieve employee names and project assignments including employees without projects.

SELECT e.emp_name,
       p.project_name
FROM employees e
LEFT JOIN projects p
ON e.emp_id = p.emp_id;


-- 29. List employee names with department and project assignments.

SELECT e.emp_name,
       d.dept_name,
       p.project_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id
LEFT JOIN projects p
ON e.emp_id = p.emp_id;


-- 30. Display employee names with department names including employees without departments.

SELECT e.emp_name,
       d.dept_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id;
