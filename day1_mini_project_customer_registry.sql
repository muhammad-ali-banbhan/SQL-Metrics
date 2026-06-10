-- ============================================================
--  FILE             : day1_mini_project_customer_registry.sql
--  PROJECT          : Customer Registry System
--  BUSINESS SCENARIO: A small e-commerce startup needs a
--                     database to manage their customer records
--                     from day one of operations.
--  SKILLS USED      : CREATE DATABASE, CREATE TABLE, datatypes,
--                     constraints, ALTER TABLE, BOOLEAN,
--                     INSERT, SELECT, UPDATE, soft delete
--  COURSE           : CodeWithHarry SQL Masterclass
--  LEARNER          : Muhammad Ali
-- ============================================================


-- ============================================================
-- BUSINESS SCENARIO
-- ============================================================
-- You are a junior Data Analyst at a startup called "ShopEase"
-- The business just launched and needs a customer database.
-- Your manager gives you these requirements:
--
--   1. Store customer personal information
--   2. Each customer must have a unique email
--   3. Track when each customer registered
--   4. Be able to mark customers as active or inactive
--   5. Never permanently delete a customer record
--   6. Be able to view active customers separately
--
-- Your job: Design and build this from scratch.
-- ============================================================


-- ============================================================
-- TASK 1: SET UP THE DATABASE
-- ============================================================

CREATE DATABASE IF NOT EXISTS shopease;
USE shopease;

-- Confirm we are inside the right database
SELECT DATABASE();


-- ============================================================
-- TASK 2: DESIGN AND CREATE THE CUSTOMERS TABLE
-- ============================================================
-- Requirements translated into columns:
--   Personal info   → name, email, gender, date_of_birth
--   Unique email    → UNIQUE constraint on email
--   Registration    → created_at with CURRENT_TIMESTAMP
--   Active/Inactive → is_active BOOLEAN DEFAULT TRUE

CREATE TABLE customers (
    id            INT           AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(50)   NOT NULL,
    email         VARCHAR(70)   UNIQUE NOT NULL,
    gender        ENUM('male', 'female', 'other'),
    date_of_birth DATE,
    is_active     BOOLEAN       DEFAULT TRUE,
    created_at    TIMESTAMP     DEFAULT CURRENT_TIMESTAMP
);

-- Verify structure was created correctly
DESCRIBE customers;


-- ============================================================
-- TASK 3: ADD PHONE COLUMN (New requirement from manager)
-- ============================================================
-- After creating the table, manager says:
-- "We also need to store customer phone numbers
--  after the name column."

ALTER TABLE customers
ADD COLUMN phone VARCHAR(15)
AFTER name;

-- Verify updated structure
DESCRIBE customers;


-- ============================================================
-- TASK 4: REGISTER FIRST BATCH OF CUSTOMERS
-- ============================================================

-- Customer 1: Normal signup — is_active auto TRUE
INSERT INTO customers (name, phone, email, gender, date_of_birth)
VALUES ('Ahmed Khan', '03001234567', 'ahmed@shopease.com', 'male', '1995-03-15');

-- Customer 2: Normal signup — is_active auto TRUE
INSERT INTO customers (name, phone, email, gender, date_of_birth)
VALUES ('Sara Ali', '03121234567', 'sara@shopease.com', 'female', '1998-07-22');

-- Customer 3: Normal signup — is_active auto TRUE
INSERT INTO customers (name, phone, email, gender, date_of_birth)
VALUES ('Usman Raza', '03451234567', 'usman@shopease.com', 'male', '1990-11-05');

-- Customer 4: Imported from old system — account inactive
INSERT INTO customers (name, phone, email, gender, date_of_birth, is_active)
VALUES ('Fatima Malik', '03331234567', 'fatima@shopease.com', 'female', '1993-05-18', FALSE);

-- Customer 5: Normal signup — is_active auto TRUE
INSERT INTO customers (name, phone, email, gender, date_of_birth)
VALUES ('Ali Hassan', '03211234567', 'ali@shopease.com', 'male', '2000-01-30');


-- ============================================================
-- TASK 5: VIEW ALL CUSTOMERS
-- ============================================================

-- Raw view (is_active shows 1 and 0)
SELECT * FROM customers;


-- ============================================================
-- TASK 6: BUSINESS REPORT — READABLE STATUS VIEW
-- ============================================================
-- Manager asks: "Give me a clean customer list with
--                Active/Inactive labels not 1/0"

SELECT
    id,
    name,
    phone,
    email,
    gender,
    date_of_birth,
    CASE
        WHEN is_active = 1 THEN 'Active'
        ELSE 'Inactive'
    END AS account_status,
    created_at
FROM customers;

-- Expected Output:
-- +----+--------------+-------------+---------------------+--------+---------------+----------------+
-- | id | name         | phone       | email               | gender | date_of_birth | account_status |
-- +----+--------------+-------------+---------------------+--------+---------------+----------------+
-- |  1 | Ahmed Khan   | 03001234567 | ahmed@shopease.com  | male   | 1995-03-15    | Active         |
-- |  2 | Sara Ali     | 03121234567 | sara@shopease.com   | female | 1998-07-22    | Active         |
-- |  3 | Usman Raza   | 03451234567 | usman@shopease.com  | male   | 1990-11-05    | Active         |
-- |  4 | Fatima Malik | 03331234567 | fatima@shopease.com | female | 1993-05-18    | Inactive       |
-- |  5 | Ali Hassan   | 03211234567 | ali@shopease.com    | male   | 2000-01-30    | Active         |
-- +----+--------------+-------------+---------------------+--------+---------------+----------------+


-- ============================================================
-- TASK 7: FILTER ACTIVE CUSTOMERS ONLY
-- ============================================================
-- Manager asks: "Show me only customers we can contact"

SELECT id, name, phone, email
FROM customers
WHERE is_active = TRUE;


-- ============================================================
-- TASK 8: SOFT DELETE — DEACTIVATE A CUSTOMER
-- ============================================================
-- Manager says: "Customer Ahmed Khan requested account closure.
--                Do NOT delete the record — just deactivate."
-- This is SOFT DELETE — industry standard

UPDATE customers
SET is_active = FALSE
WHERE id = 1;

-- Verify the change
SELECT id, name,
    CASE WHEN is_active = 1 THEN 'Active' ELSE 'Inactive' END AS status
FROM customers;


-- ============================================================
-- TASK 9: REACTIVATE A CUSTOMER
-- ============================================================
-- Ahmed Khan called back — he wants his account reactivated.

UPDATE customers
SET is_active = TRUE
WHERE id = 1;


-- ============================================================
-- TASK 10: FINAL SUMMARY REPORT
-- ============================================================
-- Count total, active, and inactive customers

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN is_active = 1 THEN 1 ELSE 0 END) AS active_customers,
    SUM(CASE WHEN is_active = 0 THEN 1 ELSE 0 END) AS inactive_customers
FROM customers;

-- Expected Output:
-- +-----------------+-----------------+--------------------+
-- | total_customers | active_customers | inactive_customers |
-- +-----------------+-----------------+--------------------+
-- |               5 |               4 |                  1 |
-- +-----------------+-----------------+--------------------+


-- ============================================================
-- SKILLS DEMONSTRATED IN THIS PROJECT
-- ============================================================
-- ✅ CREATE DATABASE with IF NOT EXISTS
-- ✅ USE database
-- ✅ CREATE TABLE with 6 datatypes
-- ✅ Constraints: PRIMARY KEY, AUTO_INCREMENT, NOT NULL,
--                UNIQUE, DEFAULT, ENUM
-- ✅ ALTER TABLE ADD COLUMN with AFTER positioning
-- ✅ INSERT with and without optional columns
-- ✅ DEFAULT TRUE behavior for BOOLEAN
-- ✅ SELECT all data
-- ✅ CASE WHEN for readable output
-- ✅ WHERE filter by BOOLEAN status
-- ✅ UPDATE for soft delete and reactivation
-- ✅ Aggregate summary report (COUNT, SUM, CASE WHEN)

