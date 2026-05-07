-- 31. Employees sorted by salary ASC
SELECT * FROM Employee
ORDER BY salary ASC;

-- 32. Employees sorted by age DESC
SELECT * FROM Employee
ORDER BY age DESC;

-- 33. Employees sorted by hire date ASC
SELECT * FROM Employee
ORDER BY hire_date ASC;

-- 34. Employees sorted by department then salary
SELECT * FROM Employee
ORDER BY department_id, salary;

-- 35. Departments ordered by total salary of employees
SELECT department_id, SUM(salary) AS total_salary
FROM Employee
GROUP BY department_id
ORDER BY total_salary;

-- 36. Employee names with department names
SELECT e.name, d.name
FROM Employee e
JOIN Department d ON e.department_id = d.department_id;

-- 37. Project names with department names
SELECT p.name, d.name
FROM Project p
JOIN Department d ON p.department_id = d.department_id;

-- 38. Employee names with project names
SELECT e.name, p.name
FROM Employee e
JOIN Project p ON e.department_id = p.department_id;

-- 39. All employees with departments (including no dept)
SELECT e.name, d.name
FROM Employee e
LEFT JOIN Department d ON e.department_id = d.department_id;

-- 40. All departments with employees (including empty)
SELECT d.name, e.name
FROM Department d
LEFT JOIN Employee e ON d.department_id = e.department_id;

-- 41. Employees not assigned to any project
SELECT e.*
FROM Employee e
LEFT JOIN Project p ON e.department_id = p.department_id
WHERE p.project_id IS NULL;

-- 42. Employees + number of projects their dept has
SELECT e.name, COUNT(p.project_id)
FROM Employee e
JOIN Project p ON e.department_id = p.department_id
GROUP BY e.name;

-- 43. Departments with no employees
SELECT d.name
FROM Department d
LEFT JOIN Employee e ON d.department_id = e.department_id
WHERE e.emp_id IS NULL;

-- 44. Employees in same dept as 'John Doe'
SELECT name
FROM Employee
WHERE department_id = (
    SELECT department_id FROM Employee WHERE name = 'John Doe'
);

-- 45. Department with highest average salary
SELECT d.name
FROM Employee e
JOIN Department d ON e.department_id = d.department_id
GROUP BY d.name
ORDER BY AVG(e.salary) DESC
LIMIT 1;

-- 46. Employee with highest salary
SELECT * FROM Employee
WHERE salary = (SELECT MAX(salary) FROM Employee);

-- 47. Employees with salary above average
SELECT * FROM Employee
WHERE salary > (SELECT AVG(salary) FROM Employee);

-- 48. Second highest salary
SELECT MAX(salary)
FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee);

-- 49. Department with most employees
SELECT department_id
FROM Employee
GROUP BY department_id
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 50. Employees earning more than dept average
SELECT *
FROM Employee e
WHERE salary > (
    SELECT AVG(salary)
    FROM Employee
    WHERE department_id = e.department_id
);

-- 51. nth highest salary (example: 3rd)
SELECT DISTINCT salary
FROM Employee
ORDER BY salary DESC
LIMIT 1 OFFSET 2;

-- 52. Employees older than all HR employees
SELECT *
FROM Employee
WHERE age > ALL (
    SELECT age FROM Employee
    WHERE department_id = (
        SELECT department_id FROM Department WHERE name = 'HR'
    )
);

-- 53. Departments where avg salary > 55000
SELECT department_id
FROM Employee
GROUP BY department_id
HAVING AVG(salary) > 55000;

-- 54. Employees in dept with at least 2 projects
SELECT *
FROM Employee
WHERE department_id IN (
    SELECT department_id
    FROM Project
    GROUP BY department_id
    HAVING COUNT(*) >= 2
);

-- 55. Employees hired same date as Jane Smith
SELECT *
FROM Employee
WHERE hire_date = (
    SELECT hire_date FROM Employee WHERE name = 'Jane Smith'
);

-- 56. Total salary of employees hired in 2020
SELECT SUM(salary)
FROM Employee
WHERE YEAR(hire_date) = 2020;

-- 57. Avg salary per dept ordered desc
SELECT department_id, AVG(salary)
FROM Employee
GROUP BY department_id
ORDER BY AVG(salary) DESC;

-- 58. Departments with >1 employee and avg salary > 55000
SELECT department_id
FROM Employee
GROUP BY department_id
HAVING COUNT(*) > 1 AND AVG(salary) > 55000;

-- 59. Employees hired in last 2 years
SELECT *
FROM Employee
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR)
ORDER BY hire_date;

-- 60. Total employees & avg salary for depts with >2 employees
SELECT department_id, COUNT(*), AVG(salary)
FROM Employee
GROUP BY department_id
HAVING COUNT(*) > 2;

-- 61. Employees with salary above dept average
SELECT name, salary
FROM Employee e
WHERE salary > (
    SELECT AVG(salary)
    FROM Employee
    WHERE department_id = e.department_id
);

-- 62. Employees hired on same date as oldest employee
SELECT name
FROM Employee
WHERE hire_date = (
    SELECT hire_date
    FROM Employee
    ORDER BY age DESC
    LIMIT 1
);

-- 63. Dept names with number of projects
SELECT d.name, COUNT(p.project_id)
FROM Department d
LEFT JOIN Project p ON d.department_id = p.department_id
GROUP BY d.name
ORDER BY COUNT(p.project_id);

-- 64. Employee with highest salary in each department
SELECT *
FROM Employee e
WHERE salary = (
    SELECT MAX(salary)
    FROM Employee
    WHERE department_id = e.department_id
);

-- 65. Employees older than avg age in their department
SELECT name, salary
FROM Employee e
WHERE age > (
    SELECT AVG(age)
    FROM Employee
    WHERE department_id = e.department_id
);

