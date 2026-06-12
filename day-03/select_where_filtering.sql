-- ============================================================
--  FILE             : select_where_filtering.sql
--  TOPIC            : SELECT Queries and WHERE Filtering
--  LEARNING OBJECTIVE: Understand how to retrieve data using
--                      SELECT, filter rows using WHERE,
--                      combine conditions using AND / OR,
--                      and select specific columns
--  COURSE           : CodeWithHarry SQL Masterclass
--  LEARNER          : Muhammad Ali
-- ============================================================


-- ============================================================
-- WHAT IS SELECT?
-- ============================================================
-- SELECT is how you READ data from a table.
-- It is the most used SQL command in any analyst job.
-- Every report, every dashboard, every analysis starts
-- with a SELECT query.
--
-- BASIC SYNTAX:
--   SELECT column1, column2 FROM table_name;
--
-- SELECT * means: give me ALL columns
-- SELECT name, salary means: give me only these two columns
--
-- REAL ANALYST RULE:
--   Never use SELECT * in production/real work
--   Always specify only the columns you actually need
--   Reason: faster queries, cleaner output, less confusion
-- ============================================================


-- ============================================================
-- WHAT IS WHERE?
-- ============================================================
-- WHERE filters which ROWS you want to see.
-- Without WHERE = all rows returned
-- With WHERE    = only matching rows returned
--
-- Think of WHERE as: "but only show me rows where..."
--
-- OPERATORS we can use in WHERE:
--   =        equal to
--   !=       not equal to
--   >        greater than
--   <        less than
--   >=       greater than or equal
--   <=       less than or equal
--   AND      both conditions must be true
--   OR       at least one condition must be true
--   BETWEEN  within a range
--   LIKE     pattern matching
--   IN       matches any value in a list
-- ============================================================


USE sql_learning;


-- ============================================================
-- STEP 1: CREATE THE EMPLOYEE TABLE
-- ============================================================
-- Design notes:
--   salary as DECIMAL(10,2) = correct for money fields
--   ENUM with capital letters = consistent with INSERT values
--   PRIMARY KEY already implies UNIQUE — no need to repeat

CREATE TABLE employee (
    id            INT           AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(50)   NOT NULL,
    email         VARCHAR(150)  UNIQUE NOT NULL,
    gender        ENUM('Male', 'Female', 'Other'),
    date_of_birth DATE,
    salary        DECIMAL(10,2)
);


-- ============================================================
-- STEP 2: INSERT 25 EMPLOYEES
-- ============================================================

INSERT INTO employee (name, email, gender, date_of_birth, salary)
VALUES
    ('Aarav',    'aarav@example.com',    'Male',   '1995-05-14', 65000.00),
    ('Ananya',   'ananya@example.com',   'Female', '1990-11-23', 72000.00),
    ('Raj',      'raj@example.com',      'Male',   '1988-02-17', 58000.00),
    ('Sneha',    'sneha@example.com',    'Female', '2000-08-09', 50000.00),
    ('Farhan',   'farhan@example.com',   'Male',   '1993-12-30', 61000.00),
    ('Priyanka', 'priyanka@example.com', 'Female', '1985-07-12', 84000.00),
    ('Aisha',    'aisha@example.com',    'Female', '1997-03-25', 56000.00),
    ('Aditya',   'aditya@example.com',   'Male',   '1992-06-17', 69000.00),
    ('Meera',    'meera@example.com',    'Female', '1989-09-05', 77000.00),
    ('Ishaan',   'ishaan@example.com',   'Male',   '2001-10-02', 45000.00),
    ('Tanvi',    'tanvi@example.com',    'Female', '1994-04-18', 62000.00),
    ('Rohan',    'rohan@example.com',    'Male',   '1986-12-01', 75000.00),
    ('Zoya',     'zoya@example.com',     'Female', '1998-01-15', 54000.00),
    ('Karan',    'karan@example.com',    'Male',   '1990-08-22', 68000.00),
    ('Nikita',   'nikita@example.com',   'Female', '1987-03-10', 71000.00),
    ('Manav',    'manav@example.com',    'Male',   '1996-11-29', 61000.00),
    ('Divya',    'divya@example.com',    'Female', '1991-02-28', 57000.00),
    ('Harshit',  'harshit@example.com',  'Male',   '1993-09-09', 65000.00),
    ('Ritika',   'ritika@example.com',   'Female', '1999-05-05', 52000.00),
    ('Imran',    'imran@example.com',    'Male',   '1995-07-30', 63000.00),
    ('Juhi',     'juhi@example.com',     'Female', '1992-10-14', 59000.00),
    ('Tushar',   'tushar@example.com',   'Male',   '1990-01-08', 73000.00),
    ('Lata',     'lata@example.com',     'Female', '1984-11-11', 78000.00),
    ('Yash',     'yash@example.com',     'Male',   '1997-06-06', 64000.00),
    ('Fatima',   'fatima@example.com',   'Female', '1993-03-03', 55000.00);


-- ============================================================
-- STEP 3: SELECT QUERIES — FROM BASIC TO PROFESSIONAL
-- ============================================================


-- QUERY 1: See all data (basic — use only for quick checks)
SELECT * FROM employee;


-- QUERY 2: Select only specific columns 
SELECT name, gender, salary
FROM employee;
-- Cleaner output, faster query, easier to read


-- ============================================================
-- STEP 4: WHERE FILTERING
-- ============================================================


-- QUERY 3: Filter by gender 
SELECT *
FROM employee
WHERE gender = 'Male';

-- Professional version (specific columns only):
SELECT name, gender, salary
FROM employee
WHERE gender = 'Male';


-- QUERY 4: Filter by salary (greater than)
SELECT name, salary
FROM employee
WHERE salary > 50000;


-- QUERY 5: AND — both conditions must be true 
SELECT *
FROM employee
WHERE salary > 50000
    AND gender = 'Male';

-- Professional version:
SELECT
    name,
    gender,
    salary
FROM employee
WHERE salary > 50000
    AND gender = 'Male';



-- QUERY 6: OR — at least one condition must be true
SELECT
    name,
    gender,
    salary
FROM employee
WHERE salary > 75000
    OR gender = 'Other';
-- Returns rows where salary > 75000 OR gender is Other
-- (either condition being true is enough)


-- QUERY 7: AND vs OR — understand the difference
-- AND = stricter (both must match = fewer results)
-- OR  = looser  (either can match = more results)

-- Example with AND (strict):
SELECT name, salary, gender
FROM employee
WHERE salary > 70000
    AND gender = 'Female';
-- Only females WITH salary above 70000

-- Same query with OR (loose):
SELECT name, salary, gender
FROM employee
WHERE salary > 70000
    OR gender = 'Female';
-- All females + anyone with salary above 70000


-- QUERY 8: NOT EQUAL TO
SELECT name, gender
FROM employee
WHERE gender != 'Male';
-- Returns Female and Other only


-- QUERY 9: BETWEEN — salary in a range
SELECT name, salary
FROM employee
WHERE salary BETWEEN 60000 AND 75000;
-- Includes both 60000 and 75000 (inclusive range)


-- QUERY 10: IN — match against a list of values
SELECT name, salary
FROM employee
WHERE salary IN (65000.00, 72000.00, 84000.00);
-- Returns only rows where salary exactly matches one of these


-- ============================================================
-- INTERVIEW QUESTIONS — SELECT AND WHERE
-- ============================================================

-- Q1: What is the difference between SELECT * and SELECT col?
-- A : SELECT * returns all columns — slow, messy in real work
--     SELECT col returns only named columns — faster, cleaner
--     Always prefer specific columns in professional queries

-- Q2: What does WHERE do?
-- A : Filters which rows are returned based on a condition
--     Without WHERE = all rows. With WHERE = matching rows only.

-- Q3: What is the difference between AND and OR?
-- A : AND = both conditions must be true (stricter, fewer rows)
--     OR  = at least one condition must be true (more rows)

-- Q4: What does BETWEEN do?
-- A : Filters rows within an inclusive range
--     WHERE salary BETWEEN 60000 AND 75000
--     includes both 60000 and 75000

-- Q5: What does IN do?
-- A : Matches a column against a list of values
--     Cleaner alternative to writing multiple OR conditions
--     WHERE salary IN (60000, 65000, 70000)
--     is same as: WHERE salary = 60000 OR salary = 65000...

-- Q6: As a Data Analyst, when do you use WHERE?
-- A : Every time you need a subset of data — which is always.
--     Filtering by date range, department, status, salary band
--     is the foundation of every business report.