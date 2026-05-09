-- WINDOW FUNCTIONS ASSIGNMENT (11–20)
-- PostgreSQL Compatible

-- 11. Find the difference between current order amount
-- and previous order amount.

SELECT order_id,
       customer_id,
       total_amount,
       total_amount -
       LAG(total_amount) OVER (
           PARTITION BY customer_id
           ORDER BY order_date
       ) AS difference_from_previous
FROM orders;


-- 12. Calculate a moving average of the last 3 orders.

SELECT order_id,
       order_date,
       total_amount,
       AVG(total_amount) OVER (
           ORDER BY order_date
           ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
       ) AS moving_average
FROM orders;


-- 13. Use NTILE(4) to divide employees into salary quartiles.

SELECT employee_name,
       salary,
       NTILE(4) OVER (
           ORDER BY salary DESC
       ) AS salary_quartile
FROM employees;


-- 14. Find the first order placed by each customer
-- using ROW_NUMBER().

SELECT *
FROM (
    SELECT customer_id,
           order_id,
           order_date,
           ROW_NUMBER() OVER (
               PARTITION BY customer_id
               ORDER BY order_date
           ) AS row_num
    FROM orders
) first_orders
WHERE row_num = 1;


-- 15. Find the latest order placed by each customer.

SELECT *
FROM (
    SELECT customer_id,
           order_id,
           order_date,
           ROW_NUMBER() OVER (
               PARTITION BY customer_id
               ORDER BY order_date DESC
           ) AS row_num
    FROM orders
) latest_orders
WHERE row_num = 1;


-- 16. Display employee salaries along with
-- department average salary.

SELECT employee_name,
       department,
       salary,
       AVG(salary) OVER (
           PARTITION BY department
       ) AS department_average_salary
FROM employees;


-- 17. Find employees earning above
-- their department average salary.

SELECT *
FROM (
    SELECT employee_name,
           department,
           salary,
           AVG(salary) OVER (
               PARTITION BY department
           ) AS department_avg_salary
    FROM employees
) avg_data
WHERE salary > department_avg_salary;


-- 18. Use SUM() OVER(PARTITION BY department)
-- to calculate department payroll.

SELECT employee_name,
       department,
       salary,
       SUM(salary) OVER (
           PARTITION BY department
       ) AS department_payroll
FROM employees;


-- 19. Find percentage contribution of each employee salary
-- within their department.

SELECT employee_name,
       department,
       salary,
       ROUND(
           (salary * 100.0) /
           SUM(salary) OVER (
               PARTITION BY department
           ),
           2
       ) AS salary_percentage
FROM employees;


-- 20. Use COUNT() OVER() to show total employees
-- alongside each row.

SELECT employee_name,
       department,
       salary,
       COUNT(*) OVER () AS total_employee_count
FROM employees;
