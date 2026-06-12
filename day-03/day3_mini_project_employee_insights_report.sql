-- ============================================================
--  FILE             : day3_mini_project_employee_insights_report.sql
--  PROJECT          : Employee Insights Report
--  COMPANY          : PeopleFirst HR Consultancy
--  ROLE             : Data Analyst
--  SKILLS USED      : SELECT specific columns, WHERE filtering,
--                     AND, BETWEEN, IN, !=, CASE WHEN
--  COURSE           : CodeWithHarry SQL Masterclass
--  LEARNER          : Muhammad Ali
-- ============================================================



USE sql_learning;


-- ============================================================
-- Report 1: Names and salaries of all employees
-- ============================================================

SELECT
    name,
    salary
FROM employee;


-- ============================================================
-- Report 2: Female employees — name, gender, salary
-- ============================================================

SELECT
    name,
    gender,
    salary
FROM employee
WHERE gender = 'Female';


-- ============================================================
-- Report 3: Employees earning more than 60,000
-- ============================================================

SELECT
    name,
    salary
FROM employee
WHERE salary > 60000;


-- ============================================================
-- Report 4: Male employees earning more than 60,000
-- ============================================================

SELECT
    name,
    gender,
    salary
FROM employee
WHERE salary > 60000
    AND gender = 'Male';


-- ============================================================
-- Report 5: Salary between 55,000 and 72,000
-- ============================================================
-- RULE: Numbers never need quotes
-- BETWEEN is inclusive — includes 55000 and 72000

SELECT
    name,
    salary
FROM employee
WHERE salary BETWEEN 55000 AND 72000;


-- ============================================================
-- Report 6: Salary exactly 65,000 or 72,000 or 84,000
-- ============================================================
-- LIKE = text pattern matching — wrong tool for this
-- IN   = match from a list of values — correct tool

SELECT
    name,
    salary
FROM employee
WHERE salary IN (65000, 72000, 84000);


-- ============================================================
-- Report 7: Employees who are NOT male
-- ============================================================

SELECT
    name,
    gender
FROM employee
WHERE gender != 'Male';


-- ============================================================
-- Report 8: Full list with salary_band label
-- ============================================================
-- CASE WHEN = if/else logic inside SELECT

SELECT
    name,
    gender,
    salary,
    CASE
        WHEN salary > 70000 THEN 'High Earner'
        ELSE 'Standard'
    END AS salary_band
FROM employee;



-- ============================================================
-- BONUS: Extended salary_band with 3 categories
-- ============================================================
-- Real analyst work often needs more than 2 bands
-- CASE WHEN can handle multiple conditions

SELECT
    name,
    gender,
    salary,
    CASE
        WHEN salary > 75000 THEN 'Top Earner'
        WHEN salary BETWEEN 60000 AND 75000 THEN 'Mid Earner'
        ELSE 'Standard'
    END AS salary_band
FROM employee;


-- ============================================================
-- KEY RULES LEARNED TODAY
-- ============================================================
-- 1. Never use SELECT * in professional/analyst work
--    Always name specific columns you need
--
-- 2. Numbers never need quotes
--    Text/string values always need quotes
--    RIGHT: WHERE salary > 60000
--    RIGHT: WHERE gender = 'Male'
--    WRONG: WHERE salary > '60000'
--
-- 3. LIKE = text pattern matching
--    IN   = matching from a list of values
--    Never confuse these two
--
-- 4. Alias quotes only needed when alias has spaces
--    AS salary_band    → no quotes needed
--    AS 'salary band'  → quotes needed (has space)
--
-- 5. BETWEEN is always inclusive on both ends
--    BETWEEN 55000 AND 72000 includes 55000 and 72000
-- ============================================================