-- SELECT
-- 1.Display all employee details.
select * 
from Employees;

-- 2.Display only employee names and salaries.
select emp_name,salary
from Employees;

-- 3.Display employee names and departments.
select emp_name, department
from Employees;

-- 4.Display all employees from the IT department.
select *
from Employees
where department='IT';

-- 5.Display employee names and experience.
select emp_name,experience
from Employees;

-- WHERE
-- 1.Find employees with salary greater than 70000.
SELECT * FROM Employees
WHERE salary > 70000;

-- 2.Find employees working in Hyderabad.
SELECT * FROM Employees
WHERE city = 'Hyderabad';

-- 3.Find employees with experience less than 4 years.
SELECT * FROM Employees
WHERE experience < 4;

-- 4.Find employees from Finance department.
SELECT * FROM Employees
WHERE department = 'Finance';

-- 5.Find employees whose salary is equal to 52000.
SELECT * FROM Employees
WHERE salary = 52000;

-- GROUP BY
-- 1.Find total salary department-wise.
SELECT department, SUM(salary) AS total_salary
FROM Employees
GROUP BY department;

-- 2.Find average salary in each department.
SELECT department, AVG(salary) AS average_salary
FROM Employees
GROUP BY department;

-- 3.Count employees in each city.
SELECT city, COUNT(*) AS employee_count
FROM Employees
GROUP BY city;

-- 4.Find maximum salary in each department.
SELECT department, MAX(salary) AS maximum_salary
FROM Employees
GROUP BY department;

-- 5.Find minimum experience department-wise.
SELECT department, MIN(experience) AS minimum_experience
FROM Employees
GROUP BY department;

-- HAVING
-- 1.Find departments having more than 3 employees.
SELECT department, COUNT(*) AS employee_count
FROM Employees
GROUP BY department
HAVING COUNT(*) > 3;

-- 2.Find departments where average salary is greater than 60000.
SELECT department, AVG(salary) AS average_salary
FROM Employees
GROUP BY department
HAVING AVG(salary) > 60000;

-- 3.Find cities having more than 2 employees.
SELECT city, COUNT(*) AS employee_count
FROM Employees
GROUP BY city
HAVING COUNT(*) > 2;

-- 4.Find departments where total salary is greater than 200000.
SELECT department, SUM(salary) AS total_salary
FROM Employees
GROUP BY department
HAVING SUM(salary) > 200000;

-- 5.Find departments where maximum salary is above 90000.
SELECT department, MAX(salary) AS maximum_salary
FROM Employees
GROUP BY department
HAVING MAX(salary) > 90000;

-- TOP
-- 1.Display top 5 highest paid employees.
SELECT * FROM Employees
ORDER BY salary DESC
LIMIT 5;

-- 2.Display top 3 employees with highest experience.
SELECT * FROM Employees
ORDER BY experience DESC
LIMIT 3;

-- 3.Display top 2 salaries from Finance department.
SELECT * FROM Employees
WHERE department = 'Finance'
ORDER BY salary DESC
LIMIT 2;

-- 4.Display top 4 employees from Hyderabad.
SELECT * FROM Employees
WHERE city = 'Hyderabad'
LIMIT 4;

-- 5.Display top 1 highest salary employee.
SELECT * FROM Employees
ORDER BY salary DESC
LIMIT 1;


-- DISTINCT
-- 1. Display distinct department names
SELECT DISTINCT department
FROM Employees;

-- 2. Display distinct city names
SELECT DISTINCT city
FROM Employees;

-- 3. Display distinct salary values
SELECT DISTINCT salary
FROM Employees;

-- 4. Display distinct combinations of department and city
SELECT DISTINCT department, city
FROM Employees;

-- 5. Display distinct experience values
SELECT DISTINCT experience
FROM Employees;


-- COMPARISON OPERATORS
-- 1. Find employees with salary >= 80000
SELECT *
FROM Employees
WHERE salary >= 80000;

-- 2. Find employees with experience <= 3
SELECT *
FROM Employees
WHERE experience <= 3;

-- 3. Find employees whose salary <> 45000
SELECT *
FROM Employees
WHERE salary <> 45000;

-- 4. Find employees with salary < 50000
SELECT *
FROM Employees
WHERE salary < 50000;

-- 5. Find employees with experience > 5
SELECT *
FROM Employees
WHERE experience > 5;


-- LOGICAL OPERATORS
-- 1. Find employees from IT department AND salary greater than 70000
SELECT *
FROM Employees
WHERE department = 'IT' AND salary > 70000;

-- 2. Find employees from Hyderabad OR Bangalore
SELECT *
FROM Employees
WHERE city = 'Hyderabad' OR city = 'Bangalore';

-- 3. Find employees from HR department AND experience less than 3
SELECT *
FROM Employees
WHERE department = 'HR' AND experience < 3;

-- 4. Find employees with salary greater than 60000 OR experience greater than 6
SELECT *
FROM Employees
WHERE salary > 60000 OR experience > 6;

-- 5. Find employees NOT from Sales department
SELECT *
FROM Employees
WHERE department != 'Sales';


-- IN AND NOT IN
-- 1. Find employees working in Hyderabad and Mumbai
SELECT *
FROM Employees
WHERE city IN ('Hyderabad', 'Mumbai');

-- 2. Find employees whose department IN ('IT', 'Finance')
SELECT *
FROM Employees
WHERE department IN ('IT', 'Finance');

-- 3. Find employees whose city NOT IN ('Chennai', 'Pune')
SELECT *
FROM Employees
WHERE city NOT IN ('Chennai', 'Pune');

-- 4. Find employees whose salary IN (45000, 75000, 91000)
SELECT *
FROM Employees
WHERE salary IN (45000, 75000, 91000);

-- 5. Find employees whose department NOT IN ('HR', 'Sales')
SELECT *
FROM Employees
WHERE department NOT IN ('HR', 'Sales');


-- BETWEEN
-- 1. Find employees with salary BETWEEN 50000 AND 80000
SELECT *
FROM Employees
WHERE salary BETWEEN 50000 AND 80000;

-- 2. Find employees with experience BETWEEN 3 AND 6
SELECT *
FROM Employees
WHERE experience BETWEEN 3 AND 6;

-- 3. Find employees whose emp_id BETWEEN 105 AND 112
SELECT *
FROM Employees
WHERE emp_id BETWEEN 105 AND 112;

-- 4. Find employees with salary NOT BETWEEN 40000 AND 60000
SELECT *
FROM Employees
WHERE salary NOT BETWEEN 40000 AND 60000;

-- 5. Find employees with experience BETWEEN 2 AND 4
SELECT *
FROM Employees
WHERE experience BETWEEN 2 AND 4;

-- LIKE OPERATOR
-- 1. Find employees whose names start with 'R'
SELECT *
FROM Employees
WHERE emp_name LIKE 'R%';

-- 2. Find employees whose names end with 'a'
SELECT *
FROM Employees
WHERE emp_name LIKE '%a';

-- 3. Find employees whose names contain 'v'
SELECT *
FROM Employees
WHERE emp_name LIKE '%v%';

-- 4. Find employees whose city starts with 'B'
SELECT *
FROM Employees
WHERE city LIKE 'B%';

-- 5. Find employees whose department ends with 's'
SELECT *
FROM Employees
WHERE department LIKE '%s';
