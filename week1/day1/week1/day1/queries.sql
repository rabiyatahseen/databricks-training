-- 1. Select all columns
SELECT * FROM Employee;

-- 2. Select name and salary
SELECT name, salary FROM Employee;

-- 3. Employees older than 30
SELECT * FROM Employee WHERE age > 30;

-- 4. Names of all departments
SELECT name FROM Department;

-- 5. Employees in IT department
SELECT e.* 
FROM Employee e
JOIN Department d ON e.department_id = d.department_id
WHERE d.name = 'IT';

-- 6. Names starting with 'J'
SELECT * FROM Employee WHERE name LIKE 'J%';

-- 7. Names ending with 'e'
SELECT * FROM Employee WHERE name LIKE '%e';

-- 8. Names containing 'a'
SELECT * FROM Employee WHERE name LIKE '%a%';

-- 9. Names with exactly 9 characters
SELECT * FROM Employee WHERE LENGTH(name) = 9;

-- 10. Names with 'o' as second character
SELECT * FROM Employee WHERE name LIKE '_o%';

-- 11. Employees hired in 2020
SELECT * FROM Employee WHERE YEAR(hire_date) = 2020;

-- 12. Employees hired in January
SELECT * FROM Employee WHERE MONTH(hire_date) = 1;

-- 13. Employees hired before 2019
SELECT * FROM Employee WHERE hire_date < '2019-01-01';

-- 14. Employees hired on or after March 1, 2021
SELECT * FROM Employee WHERE hire_date >= '2021-03-01';

-- 15. Total salary
SELECT SUM(salary) FROM Employee;

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
