-- 16. Total salary of all employees
SELECT SUM(salary) FROM Employee;

-- 17. Average salary of employees
SELECT AVG(salary) FROM Employee;

-- 18. Minimum salary in Employee table
SELECT MIN(salary) FROM Employee;

-- 19. Number of employees in each department
SELECT department_id, COUNT(*) 
FROM Employee 
GROUP BY department_id;

-- 20. Average salary in each department
SELECT department_id, AVG(salary) 
FROM Employee 
GROUP BY department_id;

-- 21. Total salary for each department
SELECT department_id, SUM(salary)
FROM Employee
GROUP BY department_id;

-- 22. Average age in each department
SELECT department_id, AVG(age)
FROM Employee
GROUP BY department_id;

-- 23. Number of employees hired each year
SELECT YEAR(hire_date) AS year, COUNT(*)
FROM Employee
GROUP BY YEAR(hire_date);

-- 24. Highest salary in each department
SELECT department_id, MAX(salary)
FROM Employee
GROUP BY department_id;

-- 25. Department with highest average salary
SELECT department_id
FROM Employee
GROUP BY department_id
ORDER BY AVG(salary) DESC
LIMIT 1;

-- 26. Departments with more than 2 employees
SELECT department_id
FROM Employee
GROUP BY department_id
HAVING COUNT(*) > 2;

-- 27. Departments with avg salary > 55000
SELECT department_id
FROM Employee
GROUP BY department_id
HAVING AVG(salary) > 55000;

-- 28. Years with more than 1 employee hired
SELECT YEAR(hire_date)
FROM Employee
GROUP BY YEAR(hire_date)
HAVING COUNT(*) > 1;

-- 29. Departments with total salary < 100000
SELECT department_id
FROM Employee
GROUP BY department_id
HAVING SUM(salary) < 100000;

-- 30. Departments with max salary > 75000
SELECT department_id
FROM Employee
GROUP BY department_id
HAVING MAX(salary) > 75000;
