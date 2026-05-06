-- 16. Average salary
SELECT AVG(salary) FROM Employee;

-- 17. Minimum salary
SELECT MIN(salary) FROM Employee;

-- 18. Number of employees per department
SELECT department_id, COUNT(*) 
FROM Employee 
GROUP BY department_id;

-- 19. Average salary per department
SELECT department_id, AVG(salary) 
FROM Employee 
GROUP BY department_id;

-- 20. Total salary per department
SELECT department_id, SUM(salary) 
FROM Employee 
GROUP BY department_id;

-- 21. Get all distinct department IDs
SELECT DISTINCT department_id FROM Employee;

-- 22. Get all employees sorted by salary (ascending)
SELECT * FROM Employee ORDER BY salary ASC;

-- 23. Get all employees sorted by salary (descending)
SELECT * FROM Employee ORDER BY salary DESC;

-- 24. Get top 5 highest paid employees
SELECT * FROM Employee ORDER BY salary DESC LIMIT 5;

-- 25. Get employees with salary between 30000 and 60000
SELECT * FROM Employee WHERE salary BETWEEN 30000 AND 60000;

-- 26. Get employees whose age is between 25 and 35
SELECT * FROM Employee WHERE age BETWEEN 25 AND 35;

-- 27. Count employees in each department having more than 2 employees
SELECT department_id, COUNT(*) 
FROM Employee 
GROUP BY department_id
HAVING COUNT(*) > 2;

-- 28. Get departments with average salary greater than 40000
SELECT department_id, AVG(salary) 
FROM Employee 
GROUP BY department_id
HAVING AVG(salary) > 40000;

-- 29. Get employee names along with department names
SELECT e.name, d.name AS department_name
FROM Employee e
JOIN Department d ON e.department_id = d.department_id;

-- 30. Get employees working in departments with salary > 50000
SELECT e.*
FROM Employee e
JOIN Department d ON e.department_id = d.department_id
WHERE e.salary > 50000;
