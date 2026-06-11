-- ============================================================
--  FILE             : alter_table_add_column.sql
--  TOPIC            : ALTER TABLE — Adding Columns at Position
--  LEARNING OBJECTIVE: Understand how to add new columns to
--                      an existing table at specific positions
--                      using AFTER and FIRST keywords
--  COURSE           : CodeWithHarry SQL Masterclass
--  LEARNER          : Muhammad Ali
-- ============================================================


-- ============================================================
-- WHAT IS ALTER TABLE?
-- ============================================================
-- ALTER TABLE modifies the STRUCTURE of an existing table
-- without deleting any data already inside it.
--
-- You can:
--   ADD    a new column
--   DROP   an existing column
--   MODIFY a column's datatype or constraint
--   RENAME a column
--
--  focus: ADD COLUMN at a specific position
-- ============================================================


-- ============================================================
-- THE POSITIONING PROBLEM
-- ============================================================
-- When you ADD a column, MySQL puts it at the END by default.
-- But what if you want it at a specific position?
--
-- MySQL gives you two keywords:
--   AFTER column_name → place new column right after a specific column
--   FIRST             → place new column as the very first column
--
-- ⚠️  MySQL has NO "BEFORE" keyword.
-- Solution: use AFTER on the column that comes just before
--           your target position.
--
-- EXAMPLE — Current column order:
--   id → name → email → gender → date_of_birth → created_at
--    1     2      3        4            5               6
--
-- Goal: add is_active BEFORE created_at (position 6)
-- Logic: say AFTER date_of_birth (position 5)
--
-- Result:
--   id → name → email → gender → date_of_birth → is_active → created_at
--    1     2      3        4            5               6           7
-- ============================================================


USE sql_learning;


-- ============================================================
-- EXAMPLE 1: Add column BEFORE the last column
-- (achieved by AFTER on second-to-last column)
-- ============================================================

ALTER TABLE customers
ADD COLUMN is_active BOOLEAN DEFAULT TRUE
AFTER date_of_birth;
-- Result: is_active appears between date_of_birth and created_at


-- ============================================================
-- EXAMPLE 2: Add column as the VERY FIRST column
-- ============================================================

ALTER TABLE customers
ADD COLUMN serial_no INT
FIRST;
-- Result: serial_no becomes the first column in the table


-- ============================================================
-- EXAMPLE 3: Add column after the 2nd column (after name)
-- ============================================================

ALTER TABLE customers
ADD COLUMN phone VARCHAR(15)
AFTER name;
-- Result: phone appears right after name


-- ============================================================
-- EXAMPLE 4: Add column after email
-- ============================================================

ALTER TABLE customers
ADD COLUMN city VARCHAR(50)
AFTER email;
-- Result: city appears right after email


-- ============================================================
-- VERIFY STRUCTURE AFTER EACH ALTER
-- ============================================================

DESCRIBE customers;
-- Shows updated column order after all alterations


-- ============================================================
-- INTERVIEW QUESTIONS — ALTER TABLE ADD COLUMN
-- ============================================================

-- Q1: What does ALTER TABLE do?
-- A : Modifies the structure of an existing table.
--     Can add, drop, modify, or rename columns
--     without losing existing data.

-- Q2: How do you add a column at a specific position?
-- A : Use AFTER keyword:
--     ALTER TABLE table_name
--     ADD COLUMN col_name datatype
--     AFTER existing_column_name;

-- Q3: Does MySQL have a BEFORE keyword for column positioning?
-- A : No. MySQL only has AFTER and FIRST.
--     To place a column "before" something, use AFTER on
--     the column that comes just before your target.

-- Q4: Does ALTER TABLE ADD COLUMN delete existing data?
-- A : No. ALTER TABLE only changes structure.
--     Existing rows get NULL (or DEFAULT value) in new column.

-- Q5: What is the difference between ALTER TABLE and CREATE TABLE?
-- A : CREATE TABLE builds a new table from scratch.
--     ALTER TABLE modifies an existing table without data loss.