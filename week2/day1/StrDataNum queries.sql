-- Ques:1 Employee Compensation Classification
SELECT 
    emp_id,
    UPPER(emp_name) AS upper_name,
    LOWER(emp_name) AS lower_name,
    INITCAP(emp_name) AS proper_name,
    base_salary + COALESCE(bonus,0) AS total_income,
    ROUND(base_salary + COALESCE(bonus,0)) AS rounded_income,
    EXTRACT(YEAR FROM joining_date) AS joining_year,
    CASE
        WHEN joining_date <= '2018-01-01' THEN 'Senior'
        WHEN joining_date <= '2021-01-01' THEN 'Mid'
        ELSE 'Junior'
    END AS classification
FROM employee_payments;

-- QUESTION 2: Order Delivery Delay Analysis
SELECT 
    order_id,
    UPPER(customer_name) AS customer_name,
    COALESCE(delivery_date, CURRENT_DATE) - order_date 
    AS delivery_days,
    TRUNC(order_amount,1) AS order_amount,
    CASE
        WHEN delivery_date IS NULL THEN 'Pending'
        WHEN delivery_date = order_date THEN 'Same-day'
        WHEN delivery_date - order_date > 3 THEN 'Delayed'
        ELSE 'On Time'
    END AS status
FROM orders_delivery;

-- QUESTION 3: Customer Spending Pattern
SELECT 
    INITCAP(cust_name) AS customer_name,
    TO_CHAR(purchase_date, 'Month') AS purchase_month,
    ROUND(purchase_amount) AS rounded_amount,
    ABS(purchase_amount) AS absolute_amount,
    CASE
        WHEN purchase_amount > 15000 THEN 'High Spender'
        WHEN purchase_amount BETWEEN 8000 AND 15000 THEN 'Medium Spender'
        ELSE 'Low Spender'
    END AS spending_type
FROM customer_spending;

-- QUESTION 4: Subscription Validity Check
SELECT 
    user_id,
    SPLIT_PART(user_email, '@', 2) AS email_domain,
    EXTRACT(YEAR FROM AGE(end_date, start_date)) * 12 +
    EXTRACT(MONTH FROM AGE(end_date, start_date))
    AS duration_months,
    TO_CHAR(subscription_fee, '99,99,999.99') AS formatted_fee,
    end_date - CURRENT_DATE AS remaining_days,
    CASE
        WHEN end_date < CURRENT_DATE THEN 'Expired'
        WHEN end_date - CURRENT_DATE <= 30 THEN 'Expiring Soon'
        ELSE 'Active'
    END AS subscription_status
FROM subscriptions;

-- QUESTION 5: Loan EMI Risk Categorization
SELECT 
    loan_id,
    UPPER(customer_name) AS customer_name,
    POWER((1 + interest_rate / 100), 1.0/12) - 1 
    AS monthly_interest,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, loan_start)) 
    AS years_since_loan,
    ROUND(loan_amount / 12) AS emi,
    CASE
        WHEN interest_rate > 9 THEN 'High Risk'
        WHEN interest_rate BETWEEN 8 AND 9 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS risk_category
FROM loan_details;

-- QUESTION 6: Employee Attendance Evaluation
SELECT 
    LOWER(emp_name) AS employee_name,
    ROUND((present_days * 100.0) / total_days) 
    AS attendance_percentage,
    TO_CHAR(record_date, 'Month') AS month_name,
    total_days - present_days AS absent_days,
    CASE
        WHEN (present_days * 100.0) / total_days >= 90 
            THEN 'Excellent'
        WHEN (present_days * 100.0) / total_days 
             BETWEEN 75 AND 89 
            THEN 'Average'
        ELSE 'Poor'
    END AS attendance_status
FROM attendance;

-- QUESTION 7: Product Discount Validation
SELECT 
    INITCAP(product_name) AS product_name,
    ABS(mrp - selling_price) AS discount_amount,
    ROUND(((mrp - selling_price) * 100.0) / mrp, 2) 
    AS discount_percentage,
    TO_CHAR(sale_date, 'Day') AS sale_day,
    CASE
        WHEN selling_price < mrp THEN 'Valid Discount'
        WHEN selling_price > mrp THEN 'Overpriced'
        ELSE 'No Discount'
    END AS discount_status
FROM product_sales;

--QUESTION 8: Insurance Policy Aging
SELECT 
    UPPER(holder_name) AS holder_name,
    EXTRACT(YEAR FROM AGE(policy_end, policy_start)) 
    AS policy_duration_years,
    policy_end - CURRENT_DATE AS remaining_days,
    ROUND(premium_amount) AS rounded_premium,
    CASE
        WHEN policy_end < CURRENT_DATE THEN 'Expired'
        WHEN EXTRACT(YEAR FROM AGE(policy_end, policy_start)) >= 3 
            THEN 'Long Term'
        ELSE 'Mid Term'
    END AS policy_status
FROM insurance_policies;

-- QUESTION 9: Salary Increment Simulation
SELECT 
    LOWER(emp_name) AS employee_name,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, last_hike)) 
    AS years_since_hike,
    CASE
        WHEN rating = 5 THEN current_salary * 0.20
        WHEN rating = 4 THEN current_salary * 0.10
        ELSE 0
    END AS increment_amount,
    ROUND(
        current_salary +
        CASE
            WHEN rating = 5 THEN current_salary * 0.20
            WHEN rating = 4 THEN current_salary * 0.10
            ELSE 0
        END
    ) AS new_salary,
    CASE
        WHEN rating = 5 THEN 'High Increment'
        WHEN rating = 4 THEN 'Moderate'
        ELSE 'No Increment'
    END AS increment_status
FROM salary_revision;

-- QUESTION 10: Customer Account Status Evaluation
SELECT 
    account_id,
    ABS(balance) AS absolute_balance,
    CURRENT_DATE - last_transaction 
    AS days_since_transaction,
    INITCAP(branch) AS branch_name,
    SIGN(balance) AS balance_sign,
    CASE
        WHEN balance < 0 THEN 'Overdrawn'
        WHEN CURRENT_DATE - last_transaction > 365 THEN 'Dormant'
        ELSE 'Active'
    END AS account_status
FROM bank_accounts;
--Level -1
-- QUESTION 1 – Salary Risk Flagging Based on Tax Shock
SELECT 
    LOWER(emp_name) AS employee_name,
    ROUND(salary - (salary * tax_percent / 100)) 
    AS net_salary,
    EXTRACT(YEAR FROM last_revision) 
    AS revision_year,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, last_revision)) * 12 +
    EXTRACT(MONTH FROM AGE(CURRENT_DATE, last_revision))
    AS months_since_revision,
    CASE
        WHEN tax_percent > 20 
             AND (
                 EXTRACT(YEAR FROM AGE(CURRENT_DATE, last_revision)) * 12 +
                 EXTRACT(MONTH FROM AGE(CURRENT_DATE, last_revision))
             ) > 24
        THEN 'Tax Shock'
        WHEN tax_percent BETWEEN 15 AND 20
        THEN 'Review Needed'
        ELSE 'Stable'
    END AS status
FROM salary_audit;

-- QUESTION 2 – Bonus Abuse Detection
SELECT 
INITCAP(emp_name) AS employee_name,
ROUND((bonus * 100.0) / base_salary,2) AS bonus_percentage,
TO_CHAR(bonus_date,'Day') AS bonus_day,
ABS(base_salary - bonus) AS salary_bonus_difference,
CASE
    WHEN ((bonus * 100.0) / base_salary) > 30
         AND TO_CHAR(bonus_date,'Day') IN ('Saturday ','Sunday   ')
    THEN 'Suspicious'
    WHEN ((bonus * 100.0) / base_salary) <= 20
    THEN 'Normal'
    ELSE 'Audit'
END AS status
FROM bonus_monitor;

-- QUESTION 3 – Experience Parity Validation
SELECT
UPPER(emp_name) AS employee_name,
EXTRACT(YEAR FROM AGE(CURRENT_DATE, joining_date)) AS actual_experience,
ABS(declared_experience - EXTRACT(YEAR FROM AGE(CURRENT_DATE, joining_date))) AS experience_difference,
FLOOR(salary) AS floor_salary,
CASE
    WHEN declared_experience > EXTRACT(YEAR FROM AGE(CURRENT_DATE, joining_date))
    THEN 'Overstated'
    WHEN declared_experience < EXTRACT(YEAR FROM AGE(CURRENT_DATE, joining_date))
    THEN 'Understated'
    ELSE 'Matched'
END AS status
FROM employee_experience;

-- QUESTION 4 – Salary Digit Pattern Analysis
SELECT
RIGHT(emp_name,2) AS last_two_characters,
EXTRACT(DAY FROM credit_date) AS day_of_month,
TRUNC(salary) AS truncated_salary,
MOD(TRUNC(salary),10) AS salary_mod,
CASE
    WHEN MOD(TRUNC(salary),10) = EXTRACT(DAY FROM credit_date)
    THEN 'Pattern Match'
    ELSE 'No Match'
END AS status
FROM salary_digits;

-- QUESTION 5 – Odd–Even Salary Compliance
SELECT
LOWER(emp_name) AS employee_name,
TO_CHAR(payment_date,'Day') AS weekday,
ROUND(salary) AS rounded_salary,
MOD(ROUND(salary),2) AS salary_mod,
CASE
    WHEN MOD(ROUND(salary),2) = 0
         AND MOD(CAST(EXTRACT(DAY FROM payment_date) AS INT),2) <> 0
    THEN 'Violation'
    ELSE 'Compliant'
END AS status
FROM payroll_control;

-- QUESTION 6 – Salary Inflation Drift
SELECT
INITCAP(emp_name) AS employee_name,
EXTRACT(YEAR FROM AGE(CURRENT_DATE,last_hike)) AS years_since_hike,
POWER(EXTRACT(YEAR FROM AGE(CURRENT_DATE,last_hike)),2) AS power_value,
ROUND(salary * POWER(1.05,EXTRACT(YEAR FROM AGE(CURRENT_DATE,last_hike)))) AS salary_impact,
CASE
    WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE,last_hike)) > 5
    THEN 'High Inflation Risk'
    WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE,last_hike)) BETWEEN 3 AND 5
    THEN 'Moderate'
    ELSE 'Low'
END AS status
FROM inflation_watch;

-- QUESTION 7 – Salary Sign Integrity Check
SELECT
UPPER(emp_name) AS employee_name,
EXTRACT(YEAR FROM record_date) AS record_year,
SIGN(salary) AS salary_sign,
ABS(salary) AS absolute_salary,
CASE
    WHEN salary < 0
    THEN 'Negative Error'
    WHEN salary = 0
    THEN 'Zero Salary'
    ELSE 'Valid'
END AS status
FROM salary_integrity;

-- QUESTION 8 – Name Length vs Salary Correlation
SELECT
LENGTH(emp_name) AS name_length,
EXTRACT(YEAR FROM AGE(CURRENT_DATE,join_date)) AS years_of_service,
ROUND(salary) AS rounded_salary,
ABS(LENGTH(emp_name) - EXTRACT(YEAR FROM AGE(CURRENT_DATE,join_date))) AS difference,
CASE
    WHEN LENGTH(emp_name) > EXTRACT(YEAR FROM AGE(CURRENT_DATE,join_date))
    THEN 'Name Bias'
    ELSE 'Neutral'
END AS status
FROM name_salary;

-- QUESTION 9 – Salary Spike Detection by Month
SELECT
TO_CHAR(paid_date,'Month') AS month_name,
CEIL(salary) AS ceil_salary,
CASE
    WHEN paid_date = (DATE_TRUNC('MONTH',paid_date) + INTERVAL '1 MONTH - 1 day')
    THEN 'Yes'
    ELSE 'No'
END AS last_day_of_month,
CASE
    WHEN paid_date = (DATE_TRUNC('MONTH',paid_date) + INTERVAL '1 MONTH - 1 day')
    THEN 'End Month Spike'
    ELSE 'Regular'
END AS status
FROM salary_monthly;

-- QUESTION 10 – Salary Digit Sum Audit
SELECT
LEFT(emp_name,1) AS first_character,
TRUNC(salary) AS truncated_salary,
(
    MOD(TRUNC(salary),10) +
    MOD(TRUNC(salary/10),10) +
    MOD(TRUNC(salary/100),10) +
    MOD(TRUNC(salary/1000),10) +
    MOD(TRUNC(salary/10000),10)
) AS digit_sum,
EXTRACT(DAY FROM audit_date) AS audit_day,
CASE
    WHEN (
        MOD(TRUNC(salary),10) +
        MOD(TRUNC(salary/10),10) +
        MOD(TRUNC(salary/100),10) +
        MOD(TRUNC(salary/1000),10) +
        MOD(TRUNC(salary/10000),10)
    ) > EXTRACT(DAY FROM audit_date)
    THEN 'Digit Alert'
    ELSE 'Normal'
END AS status
FROM digit_audit;

-- QUESTION 11 – Weekend Salary Credit Fraud Detection
SELECT
LEFT(bank_code,4) AS bank_prefix,
TO_CHAR(credit_date,'Day') AS weekday_name,
ROUND(salary) AS rounded_salary,
MOD(CAST(ROUND(salary) AS INT),5) AS salary_mod,
CASE
    WHEN TO_CHAR(credit_date,'Day') IN ('Saturday ','Sunday   ')
         AND MOD(CAST(ROUND(salary) AS INT),5) = 0
    THEN 'Weekend Fraud'
    WHEN LEFT(bank_code,4) = 'HDFC'
    THEN 'Bank Review'
    ELSE 'Normal'
END AS status
FROM salary_credit_audit;

--QUESTION 12 – Salary Credit Time Drift Analysis
SELECT
EXTRACT(HOUR FROM credit_ts) AS credit_hour,
LOWER(emp_name) AS employee_name,
FLOOR(salary) AS floor_salary,
ABS(FLOOR(salary) - EXTRACT(HOUR FROM credit_ts)) AS difference_value,
CASE
    WHEN EXTRACT(HOUR FROM credit_ts) BETWEEN 0 AND 3
    THEN 'Midnight Drift'
    WHEN EXTRACT(HOUR FROM credit_ts) > 18
    THEN 'After Hours'
    ELSE 'Business Hours'
END AS status
FROM salary_time_drift;

--QUESTION 13 – Salary Decimal Precision Audit
SELECT
TRUNC(salary,2) AS truncated_salary,
ABS(ROUND(salary,2) - TRUNC(salary,2)) AS difference_value,
TO_CHAR(record_date,'Day') AS day_name,
LENGTH(emp_name) AS name_length,
CASE
    WHEN ABS(ROUND(salary,2) - TRUNC(salary,2)) > 0.01
    THEN 'Precision Loss'
    ELSE 'Safe'
END AS status
FROM salary_precision;

--QUESTION 14 – Salary Growth Power Index
SELECT
EXTRACT(YEAR FROM AGE(CURRENT_DATE,last_hike)) AS years_since_hike,
POWER(growth_rate,EXTRACT(YEAR FROM AGE(CURRENT_DATE,last_hike))) AS growth_power,
ROUND(base_salary * POWER(growth_rate,EXTRACT(YEAR FROM AGE(CURRENT_DATE,last_hike)))) AS projected_salary,
UPPER(emp_name) AS employee_name,
CASE
    WHEN ROUND(base_salary * POWER(growth_rate,EXTRACT(YEAR FROM AGE(CURRENT_DATE,last_hike)))) > 150000
    THEN 'Explosive Growth'
    WHEN ROUND(base_salary * POWER(growth_rate,EXTRACT(YEAR FROM AGE(CURRENT_DATE,last_hike)))) > 80000
    THEN 'Controlled'
    ELSE 'Stagnant'
END AS status
FROM salary_growth;

-- QUESTION 15 – Salary Symmetry Check
SELECT
TRUNC(salary) AS salary_without_decimal,
REVERSE(CAST(TRUNC(salary) AS TEXT)) AS reversed_salary,
TO_CHAR(processed_date,'Day') AS weekday_name,
INITCAP(emp_name) AS employee_name,
CASE
    WHEN CAST(TRUNC(salary) AS TEXT) = REVERSE(CAST(TRUNC(salary) AS TEXT))
    THEN 'Symmetric Pay'
    ELSE 'Asymmetric'
END AS status
FROM salary_symmetry;

-- QUESTION 16 – Leap Year Salary Adjustment Audit
SELECT
EXTRACT(YEAR FROM credit_date) AS credit_year,
CASE
    WHEN MOD(CAST(EXTRACT(YEAR FROM credit_date) AS INT),4) = 0
    THEN 'Leap Year'
    ELSE 'Non Leap Year'
END AS leap_check,
CEIL(salary) AS ceil_salary,
EXTRACT(DOY FROM credit_date) AS day_of_year,
CASE
    WHEN EXTRACT(MONTH FROM credit_date) = 2
         AND EXTRACT(DAY FROM credit_date) = 29
    THEN 'Leap Credit'
    ELSE 'Non-Leap Credit'
END AS status
FROM leap_salary;

-- QUESTION 17 – Fiscal Year Boundary Salary Check
SELECT
CASE
    WHEN EXTRACT(MONTH FROM credit_date) >= 4
    THEN CONCAT(EXTRACT(YEAR FROM credit_date),'-',EXTRACT(YEAR FROM credit_date)+1)
    ELSE CONCAT(EXTRACT(YEAR FROM credit_date)-1,'-',EXTRACT(YEAR FROM credit_date))
END AS fiscal_year,
TO_CHAR(credit_date,'Month') AS month_name,
TO_CHAR(salary,'99,99,999.99') AS formatted_salary,
LOWER(emp_name) AS employee_name,
CASE
    WHEN EXTRACT(MONTH FROM credit_date) = 3
    THEN 'Year End Credit'
    WHEN EXTRACT(MONTH FROM credit_date) = 4
    THEN 'Year Start Credit'
    ELSE 'Mid Year'
END AS status
FROM fiscal_salary;

-- QUESTION 18 – Salary Random Sampling for Audit
SELECT
RANDOM() AS random_value,
ROUND(salary) AS rounded_salary,
TO_CHAR(record_date,'Day') AS day_name,
LEFT(emp_name,1) AS first_character,
CASE
    WHEN RANDOM() > 0.7
    THEN 'Sampled'
    ELSE 'Skipped'
END AS status
FROM salary_sampling;

-- QUESTION 19 – Salary ASCII Integrity Check
SELECT
ASCII(LEFT(emp_name,1)) AS ascii_value,
EXTRACT(YEAR FROM AGE(CURRENT_DATE,join_date)) AS years_since_joining,
FLOOR(salary) AS floor_salary,
ABS(ASCII(LEFT(emp_name,1)) - EXTRACT(YEAR FROM AGE(CURRENT_DATE,join_date))) AS difference_value,
CASE
    WHEN ASCII(LEFT(emp_name,1)) > EXTRACT(YEAR FROM AGE(CURRENT_DATE,join_date))
    THEN 'Name Dominates'
    ELSE 'Experience Dominates'
END AS status
FROM salary_ascii;

-- QUESTION 20 – Salary vs Calendar Symmetry Logic
SELECT
EXTRACT(DAY FROM credit_date) AS day_value,
EXTRACT(MONTH FROM credit_date) AS month_value,
RIGHT(CAST(TRUNC(salary) AS TEXT),2) AS last_two_digits,
UPPER(emp_name) AS employee_name,
ABS(
CAST(EXTRACT(DAY FROM credit_date) AS INT) -
CAST(EXTRACT(MONTH FROM credit_date) AS INT)
) AS difference_value,
CASE
    WHEN EXTRACT(DAY FROM credit_date) = EXTRACT(MONTH FROM credit_date)
         OR RIGHT(CAST(TRUNC(salary) AS TEXT),2) =
            LPAD(CAST(EXTRACT(MONTH FROM credit_date) AS TEXT),2,'0')
    THEN 'Calendar Match'
    ELSE 'Calendar Drift'
END AS status
FROM salary_calendar;

--Level-2
--QUESTION 1 – Employee Login Discipline & Performance Classification
SELECT
INITCAP(emp_name) AS employee_name,
CASE
    WHEN TO_CHAR(login_time,'Day') IN ('Saturday ','Sunday   ')
    THEN 'Weekend'
    ELSE 'Weekday'
END AS day_type,
ROUND(CAST(EXTRACT(EPOCH FROM (logout_time - login_time))/3600 AS NUMERIC),2) AS working_hours,
CASE
    WHEN TO_CHAR(login_time,'Day') NOT IN ('Saturday ','Sunday   ')
         AND ROUND(CAST(EXTRACT(EPOCH FROM (logout_time - login_time))/3600 AS NUMERIC),2) >= 8
    THEN 'Good Performer'
    WHEN TO_CHAR(login_time,'Day') NOT IN ('Saturday ','Sunday   ')
         AND ROUND(CAST(EXTRACT(EPOCH FROM (logout_time - login_time))/3600 AS NUMERIC),2) < 6
    THEN 'Bad Performer'
    ELSE 'Weekend Login'
END AS status
FROM employee_login;

--QUESTION 2 – Past 7 Days Attendance & Productivity Check
SELECT
UPPER(emp_name) AS employee_name,
CASE
    WHEN login_date >= CURRENT_DATE - INTERVAL '7 days'
    THEN 'Last 7 Days'
    ELSE 'Old Record'
END AS record_status,
CASE
    WHEN TO_CHAR(login_date,'Day') IN ('Saturday ','Sunday   ')
    THEN 'Weekend'
    ELSE 'Weekday'
END AS day_type,
ROUND(CAST(EXTRACT(EPOCH FROM (logout_time - login_time))/3600 AS NUMERIC),2) AS working_hours,
CASE
    WHEN login_date >= CURRENT_DATE - INTERVAL '7 days'
         AND ROUND(CAST(EXTRACT(EPOCH FROM (logout_time - login_time))/3600 AS NUMERIC),2) >= 8
    THEN 'Active & Productive'
    WHEN login_date >= CURRENT_DATE - INTERVAL '7 days'
         AND ROUND(CAST(EXTRACT(EPOCH FROM (logout_time - login_time))/3600 AS NUMERIC),2) < 8
    THEN 'Active but Low Hours'
    ELSE 'Absent from Last 7 Days'
END AS status
FROM attendance_log;

--QUESTION 3 – Weekend Work Abuse Detection
SELECT
TO_CHAR(work_date,'Day') AS day_name,
LOWER(emp_name) AS employee_name,
CEIL(EXTRACT(EPOCH FROM (logout_time - login_time))/3600) AS working_hours,
CASE
    WHEN TO_CHAR(work_date,'Day') IN ('Saturday ','Sunday   ')
         AND CEIL(EXTRACT(EPOCH FROM (logout_time - login_time))/3600) >= 8
    THEN 'Weekend Overtime'
    WHEN TO_CHAR(work_date,'Day') IN ('Saturday ','Sunday   ')
         AND CEIL(EXTRACT(EPOCH FROM (logout_time - login_time))/3600) < 4
    THEN 'Suspicious Login'
    ELSE 'Normal Working Day'
END AS status
FROM weekend_monitor;

--QUESTION 4 – Login Time Deviation & Discipline Score
SELECT
EXTRACT(HOUR FROM login_datetime) AS login_hour,
TRUNC(CAST(EXTRACT(EPOCH FROM (logout_datetime - login_datetime))/3600 AS NUMERIC),1) AS working_hours,
TO_CHAR(login_datetime,'Day') AS weekday_name,
CASE
    WHEN TO_CHAR(login_datetime,'Day') NOT IN ('Saturday ','Sunday   ')
         AND EXTRACT(HOUR FROM login_datetime) < 9
         AND TRUNC(CAST(EXTRACT(EPOCH FROM (logout_datetime - login_datetime))/3600 AS NUMERIC),1) >= 8
    THEN 'Disciplined'
    WHEN TO_CHAR(login_datetime,'Day') NOT IN ('Saturday ','Sunday   ')
         AND EXTRACT(HOUR FROM login_datetime) > 10
    THEN 'Late Comer'
    ELSE 'Poor Discipline'
END AS status
FROM login_discipline;

--QUESTION 5 – Absenteeism vs Performance Correlation
SELECT
CASE
    WHEN work_date >= CURRENT_DATE - INTERVAL '7 days'
    THEN 'Recent'
    ELSE 'Old'
END AS record_type,
CASE
    WHEN TO_CHAR(work_date,'Day') IN ('Saturday ','Sunday   ')
    THEN 'Weekend'
    ELSE 'Weekday'
END AS day_type,
FLOOR(EXTRACT(EPOCH FROM (logout_time - login_time))/3600) AS working_hours,
CASE
    WHEN work_date >= CURRENT_DATE - INTERVAL '7 days'
         AND TO_CHAR(work_date,'Day') NOT IN ('Saturday ','Sunday   ')
         AND FLOOR(EXTRACT(EPOCH FROM (logout_time - login_time))/3600) >= 8
    THEN 'Consistent Performer'
    WHEN FLOOR(EXTRACT(EPOCH FROM (logout_time - login_time))/3600) < 6
    THEN 'Irregular Performer'
    ELSE 'Absent / Old Record'
END AS status
FROM performance_tracker;
