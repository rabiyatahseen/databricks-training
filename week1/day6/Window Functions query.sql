-- WINDOW FUNCTIONS & CTE ASSIGNMENT

-- 21. Create a CTE to calculate total sales per employee.

WITH employee_sales AS (
    SELECT employee_id,
           SUM(total_amount) AS total_sales
    FROM orders
    GROUP BY employee_id
)

SELECT *
FROM employee_sales;


-- 22. Use a CTE to find employees whose sales
-- exceed the company average.

WITH employee_sales AS (
    SELECT employee_id,
           SUM(total_amount) AS total_sales
    FROM orders
    GROUP BY employee_id
),

average_sales AS (
    SELECT AVG(total_sales) AS avg_sales
    FROM employee_sales
)

SELECT *
FROM employee_sales
WHERE total_sales >
      (SELECT avg_sales FROM average_sales);


-- 23. Create multiple CTEs to calculate customer
-- total spending and rankings.

WITH customer_spending AS (
    SELECT customer_id,
           SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)

SELECT customer_id,
       total_spent,
       RANK() OVER (
           ORDER BY total_spent DESC
       ) AS spending_rank
FROM customer_spending;


-- 24. Write a recursive CTE to generate numbers
-- from 1 to 10.

WITH RECURSIVE numbers AS (
    SELECT 1 AS num

    UNION ALL

    SELECT num + 1
    FROM numbers
    WHERE num < 10
)

SELECT *
FROM numbers;


-- 25. Use a recursive CTE to display employee hierarchy data.

WITH RECURSIVE employee_hierarchy AS (
    SELECT employee_id,
           employee_name,
           manager_id,
           1 AS level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT e.employee_id,
           e.employee_name,
           e.manager_id,
           eh.level + 1
    FROM employees e
    JOIN employee_hierarchy eh
    ON e.manager_id = eh.employee_id
)

SELECT *
FROM employee_hierarchy;


-- 26. Create a CTE that filters orders
-- above the average order amount.

WITH average_order AS (
    SELECT AVG(total_amount) AS avg_amount
    FROM orders
)

SELECT *
FROM orders
WHERE total_amount >
      (SELECT avg_amount FROM average_order);


-- 27. Use a CTE and window function together
-- to rank customers by total spending.

WITH customer_totals AS (
    SELECT customer_id,
           SUM(total_amount) AS total_spending
    FROM orders
    GROUP BY customer_id
)

SELECT customer_id,
       total_spending,
       DENSE_RANK() OVER (
           ORDER BY total_spending DESC
       ) AS spending_rank
FROM customer_totals;


-- 28. Find the second-highest salary in each department.

WITH ranked_salaries AS (
    SELECT employee_name,
           department,
           salary,
           DENSE_RANK() OVER (
               PARTITION BY department
               ORDER BY salary DESC
           ) AS salary_rank
    FROM employees
)

SELECT *
FROM ranked_salaries
WHERE salary_rank = 2;


-- 29. Display difference between employee salary
-- and department maximum salary.

SELECT employee_name,
       department,
       salary,
       MAX(salary) OVER (
           PARTITION BY department
       ) - salary AS salary_difference
FROM employees;


-- 30. Find the top-performing employee in each department
-- based on total sales.

WITH employee_sales AS (
    SELECT e.employee_id,
           e.employee_name,
           e.department,
           SUM(o.total_amount) AS total_sales
    FROM employees e
    JOIN orders o
    ON e.employee_id = o.employee_id
    GROUP BY e.employee_id,
             e.employee_name,
             e.department
),

ranked_employees AS (
    SELECT *,
           RANK() OVER (
               PARTITION BY department
               ORDER BY total_sales DESC
           ) AS department_rank
    FROM employee_sales
)

SELECT *
FROM ranked_employees
WHERE department_rank = 1;
