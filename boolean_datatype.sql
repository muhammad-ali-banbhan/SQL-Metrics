-- ============================================================
--  FILE             : boolean_datatype.sql
--  TOPIC            : BOOLEAN Datatype in MySQL
--  LEARNING OBJECTIVE: Understand how BOOLEAN works in MySQL,
--                      how DEFAULT TRUE/FALSE behaves,
--                      and why it cannot auto-decide like
--                      CURRENT_TIMESTAMP
--  COURSE           : CodeWithHarry SQL Masterclass
--  LEARNER          : Muhammad Ali
-- ============================================================


-- ============================================================
-- HOW BOOLEAN ACTUALLY WORKS IN MYSQL
-- ============================================================
-- MySQL does NOT have a true native BOOLEAN type.
-- BOOLEAN is an ALIAS (nickname) for TINYINT(1)
--
-- Storage:
--   TRUE  → stored as 1
--   FALSE → stored as 0
--
-- You can use either style — both work:
--   is_active = TRUE    same as    is_active = 1
--   is_active = FALSE   same as    is_active = 0
--
-- Output will always show 1 or 0 in MySQL results.
-- ============================================================


-- ============================================================
-- IMPORTANT QUESTION ANSWERED:
-- "Can is_active auto-decide TRUE/FALSE like
--  created_at auto-gets CURRENT_TIMESTAMP?"
-- ============================================================
--
-- SHORT ANSWER: No — and here is the exact reason:
--
-- created_at works automatically BECAUSE:
--   → The current time ALWAYS EXISTS at insert moment
--   → MySQL just reads the system clock
--   → There is only ONE correct possible value
--   → No decision needed — just grab the time
--
-- is_active CANNOT work the same way BECAUSE:
--   → Should a new user be active or inactive?
--   → MySQL has NO IDEA — this is a BUSINESS DECISION
--   → Sometimes TRUE  (normal signup)
--   → Sometimes FALSE (email not verified, banned user)
--   → There is no "system value" to grab like time
--   → Only your application or you can make this decision
--
-- MAXIMUM AUTOMATION MySQL CAN GIVE:
--   DEFAULT TRUE  → every new row gets TRUE automatically
--                   unless you explicitly say FALSE
--   This is the closest behavior to CURRENT_TIMESTAMP
--   for a BOOLEAN column.
--
-- REAL WORLD EXAMPLE:
--   Daraz new customer signs up  → App sets is_active = TRUE
--   Admin bans a customer        → App sets is_active = FALSE
--   Email not verified yet       → App sets is_active = FALSE
--   MySQL stores whatever the app sends — it cannot predict.
-- ============================================================


USE customer_management;


-- ============================================================
-- STEP 1: THE COLUMN DEFINITION
-- ============================================================

-- is_active column with DEFAULT TRUE
-- Every new row automatically gets TRUE
-- unless you explicitly provide FALSE

ALTER TABLE customers
ADD COLUMN is_active BOOLEAN DEFAULT TRUE
AFTER date_of_birth;


-- ============================================================
-- STEP 2: INSERT — TESTING DEFAULT BEHAVIOR
-- ============================================================

-- Active customer — is_active NOT mentioned
-- MySQL automatically fills TRUE from DEFAULT
INSERT INTO customers (name, email, gender, date_of_birth)
VALUES ('Ahmed Khan', 'ahmed@email.com', 'male', '1995-03-15');
-- is_active = 1 (TRUE) automatically ✅
-- created_at = current timestamp automatically ✅


-- Active customer — same automatic behavior
INSERT INTO customers (name, email, gender, date_of_birth)
VALUES ('Usman Raza', 'usman@email.com', 'male', '1990-11-05');
-- is_active = 1 (TRUE) automatically ✅


-- Inactive customer — explicitly set FALSE
-- This is a business decision — MySQL cannot make it
INSERT INTO customers (name, email, gender, date_of_birth, is_active)
VALUES ('Sara Ali', 'sara@email.com', 'female', '1998-07-22', FALSE);
-- is_active = 0 (FALSE) — we told MySQL explicitly


-- ============================================================
-- STEP 3: VIEW RAW DATA (shows 1 and 0)
-- ============================================================

SELECT * FROM customers;

-- Output example:
-- +----+------------+------------------+--------+---------------+-----------+---------------------+
-- | id | name       | email            | gender | date_of_birth | is_active | created_at          |
-- +----+------------+------------------+--------+---------------+-----------+---------------------+
-- |  1 | Ahmed Khan | ahmed@email.com  | male   | 1995-03-15    |     1     | 2026-06-10 14:00:00 |
-- |  2 | Usman Raza | usman@email.com  | male   | 1990-11-05    |     1     | 2026-06-10 14:00:01 |
-- |  3 | Sara Ali   | sara@email.com   | female | 1998-07-22    |     0     | 2026-06-10 14:00:02 |
-- +----+------------+------------------+--------+---------------+-----------+---------------------+
-- 1 = TRUE (Active), 0 = FALSE (Inactive)


-- ============================================================
-- STEP 4: DISPLAY TRUE/FALSE AS READABLE TEXT
-- ============================================================
-- MySQL shows 1/0 by default.
-- Use CASE WHEN to convert to readable Active/Inactive.

SELECT
    id,
    name,
    email,
    gender,
    date_of_birth,
    CASE
        WHEN is_active = 1 THEN 'Active'
        ELSE 'Inactive'
    END AS account_status,
    created_at
FROM customers;

-- Output:
-- +----+------------+-----------------+--------+---------------+----------------+
-- | id | name       | email           | gender | date_of_birth | account_status |
-- +----+------------+-----------------+--------+---------------+----------------+
-- |  1 | Ahmed Khan | ahmed@email.com | male   | 1995-03-15    | Active         |
-- |  2 | Usman Raza | usman@email.com | male   | 1990-11-05    | Active         |
-- |  3 | Sara Ali   | sara@email.com  | female | 1998-07-22    | Inactive       |
-- +----+------------+-----------------+--------+---------------+----------------+


-- ============================================================
-- STEP 5: FILTER BY STATUS
-- ============================================================

-- Get only active customers
SELECT * FROM customers
WHERE is_active = TRUE;
-- Same as: WHERE is_active = 1

-- Get only inactive customers
SELECT * FROM customers
WHERE is_active = FALSE;
-- Same as: WHERE is_active = 0


-- ============================================================
-- STEP 6: SOFT DELETE PATTERN
-- ============================================================
-- WHAT IS SOFT DELETE?
--   In real companies you NEVER permanently delete a customer.
--   Reason: audit trails, legal compliance, data recovery.
--   Instead you mark them inactive — this is called Soft Delete.

-- Deactivate a customer (soft delete)
UPDATE customers
SET is_active = FALSE
WHERE id = 1;

-- Reactivate a customer
UPDATE customers
SET is_active = TRUE
WHERE id = 1;


-- ============================================================
-- INTERVIEW QUESTIONS — BOOLEAN DATATYPE
-- ============================================================

-- Q1: What is BOOLEAN in MySQL?
-- A : BOOLEAN is an alias for TINYINT(1).
--     Stores 1 for TRUE and 0 for FALSE.
--     MySQL has no true native BOOLEAN type.

-- Q2: What is DEFAULT TRUE used for?
-- A : Automatically assigns TRUE to a column when no value
--     is provided during INSERT. Common for is_active columns
--     where new records are active by default.

-- Q3: Can is_active automatically decide TRUE or FALSE
--     the way created_at gets CURRENT_TIMESTAMP?
-- A : No. CURRENT_TIMESTAMP works because the time always
--     exists — MySQL just reads the clock.
--     is_active requires a BUSINESS DECISION — should this
--     user be active or not? MySQL cannot make that decision.
--     DEFAULT TRUE is the maximum automation possible.

-- Q4: What is a soft delete?
-- A : Marking a record as inactive (is_active = FALSE)
--     instead of permanently deleting it.
--     Preserves data for audits, reporting, and recovery.
--     Industry standard in real applications.

-- Q5: What is CASE WHEN in SQL?
-- A : An if/else logic inside a SELECT query.
--     Used here to display 'Active'/'Inactive' instead of 1/0.