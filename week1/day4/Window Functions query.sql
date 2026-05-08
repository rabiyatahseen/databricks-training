-- SQL WINDOW FUNCTIONS & CTE ASSIGNMENT
-- PostgreSQL Compatible

-- 1. Use ROW_NUMBER() to assign a row number
-- to employees ordered by salary descending.

SELECT employee_name,
       salary,
       ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num
FROM employees;


-- 2. Use RANK() to rank employees by salary.

SELECT employee_name,
       salary,
       RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;


-- 3. Use DENSE_RANK() to rank employees by salary.

SELECT employee_name,
       salary,
       DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_salary_rank
FROM employees;


-- 4. Find the top 3 highest-paid employees
-- using a window function.

SELECT *
FROM (
    SELECT employee_name,
           salary,
           ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num
    FROM employees
) ranked_employees
WHERE row_num <= 3;


-- 5. Rank employees within each department
-- using PARTITION BY.

SELECT employee_name,
       department,
       salary,
       RANK() OVER (
           PARTITION BY department
           ORDER BY salary DESC
       ) AS department_rank
FROM employees;


-- 6. Display the highest salary in each department
-- using a window function.

SELECT employee_name,
       department,
       salary,
       MAX(salary) OVER (
           PARTITION BY department
       ) AS highest_department_salary
FROM employees;


-- 7. Calculate the running total of order amounts
-- ordered by order_date.

SELECT order_id,
       order_date,
       total_amount,
       SUM(total_amount) OVER (
           ORDER BY order_date
       ) AS running_total
FROM orders;


-- 8. Calculate the cumulative sales amount
-- for each employee.

SELECT employee_id,
       order_id,
       total_amount,
       SUM(total_amount) OVER (
           PARTITION BY employee_id
           ORDER BY order_date
       ) AS cumulative_sales
FROM orders;


-- 9. Use LAG() to show the previous order amount
-- for each customer.

SELECT customer_id,
       order_id,
       total_amount,
       LAG(total_amount) OVER (
           PARTITION BY customer_id
           ORDER BY order_date
       ) AS previous_order_amount
FROM orders;


-- 10. Use LEAD() to show the next order amount
-- for each customer.

SELECT customer_id,
       order_id,
       total_amount,
       LEAD(total_amount) OVER (
           PARTITION BY customer_id
           ORDER BY order_date
       ) AS next_order_amount
FROM orders;
