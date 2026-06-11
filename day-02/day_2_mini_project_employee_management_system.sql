-- ============================================================
--  FILE             : day2_mini_project_employee_management.sql
--  PROJECT          : Employee Management System
--  COMPANY          : TechBridge Pvt. Ltd.
--  ROLE             : Junior Data Analyst
--  SKILLS USED      : CREATE TABLE, ENUM, DECIMAL, ALTER TABLE,
--                     INSERT, SELECT, UPDATE, CASE WHEN,
--                     BOOLEAN, Soft Delete
--  COURSE           : CodeWithHarry SQL Masterclass
--  LEARNER          : Muhammad Ali
-- ============================================================


-- ============================================================
-- LESSON LEARNED TODAY (Most Important)
-- ============================================================
-- Always follow this sequence:
--   STEP 1: CREATE TABLE (full structure)
--   STEP 2: ALTER TABLE (complete ALL structure changes)
--   STEP 3: INSERT data
--   STEP 4: SELECT / UPDATE / queries
--
-- Never query a column that does not exist yet.
-- Build the full structure first — then fill it with data.
-- ============================================================


-- ============================================================
-- STEP 1: SELECT DATABASE
-- ============================================================

USE sql_learning;


-- ============================================================
-- STEP 2: CREATE EMPLOYEES TABLE (Complete Structure)
-- ============================================================

-- DESIGN DECISIONS EXPLAINED:
--
-- id: AUTO_INCREMENT PRIMARY KEY
--     PRIMARY KEY already means UNIQUE + NOT NULL
--     No need to write UNIQUE separately
--
-- full_name: VARCHAR(100) NOT NULL
--     Increased to 100 — full names can be long
--     NOT NULL because name is mandatory
--
-- email: VARCHAR(150) UNIQUE NOT NULL
--        Must exist, must be unique per employee
--
-- department: ENUM — not VARCHAR
--     Manager said ONLY these 5 departments exist
--     ENUM prevents invalid entries like "Enginering" or "eng"
--     VARCHAR would accept anything — dangerous for HR data
--
-- salary: DECIMAL(10,2) not INT
--     Real salaries have decimals: 85000.50, 72000.75
--     DECIMAL(10,2) = up to 10 digits, 2 after decimal point
--
-- date_joined: DATE
--     Stores YYYY-MM-DD format
--
-- is_active: BOOLEAN DEFAULT TRUE
--     Added HERE in CREATE TABLE — not later with ALTER
--     All new hires are active by default

CREATE TABLE employees_data (
    id            INT               AUTO_INCREMENT PRIMARY KEY,
    full_name     VARCHAR(100)      NOT NULL,
    email         VARCHAR(150)      UNIQUE NOT NULL,
    department    ENUM('Engineering', 'Marketing', 'HR', 'Finance', 'Sales'),
    salary        DECIMAL(10,2),
    date_joined   DATE,
    is_active     BOOLEAN           DEFAULT TRUE
);

-- Verify structure before inserting anything
DESCRIBE employees_data;


-- ============================================================
-- STEP 3: INSERT ALL 5 EMPLOYEES
-- ============================================================
-- Names and emails match exactly what manager provided
-- is_active not mentioned — auto fills TRUE from DEFAULT

INSERT INTO employees_data (full_name, email, department, salary, date_joined)
VALUES
    ('Hamza Tariq', 'hamza@techbridge.com',  'Engineering', 85000.00, '2023-01-15'),
    ('Ayesha Noor', 'ayesha@techbridge.com', 'HR',          60000.00, '2022-06-01'),
    ('Bilal Ahmed', 'bilal@techbridge.com',  'Marketing',   55000.00, '2023-09-10'),
    ('Sana Malik',  'sana@techbridge.com',   'Finance',     72000.00, '2021-03-22'),
    ('Raza Khan',   'raza@techbridge.com',   'Sales',       50000.00, '2024-02-28');

-- Verify all rows inserted correctly
SELECT * FROM employees_data;


-- ============================================================
-- TASK 1: Show all active employees
-- ============================================================

SELECT *
FROM employees_data
WHERE is_active = TRUE;



-- ============================================================
-- TASK 2: Bilal Ahmed resigned — soft delete
-- ============================================================
-- Manager said: do NOT delete the record
-- Correct approach: set is_active = FALSE
-- This is called Soft Delete — industry standard

UPDATE employees_data
SET is_active = FALSE
WHERE id = 3;


-- Verify the update
SELECT id, full_name, is_active
FROM employees_data;


-- ============================================================
-- TASK 3: Clean report — name, department, salary, status
-- ============================================================

SELECT
    full_name         AS employee_name,
    department,
    salary,
    CASE
        WHEN is_active = 1 THEN 'Active'
        ELSE 'Inactive'
    END               AS employee_status
FROM employees_data;



-- ============================================================
-- BONUS: Active employees only with clean report
-- ============================================================

SELECT
    full_name         AS employee_name,
    department,
    salary,
    date_joined,
    CASE
        WHEN is_active = 1 THEN 'Active'
        ELSE 'Inactive'
    END               AS employee_status
FROM employees_data
WHERE is_active = TRUE;

