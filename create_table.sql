-- ============================================================
--  FILE             : create_table.sql
--  TOPIC            : Creating Tables with Datatypes
--  LEARNING OBJECTIVE: Understand how to design and create
--                      a table using correct MySQL datatypes
--                      and constraints
--  COURSE           : CodeWithHarry SQL Masterclass
--  LEARNER          : Muhammad Ali
-- ============================================================


-- ============================================================
-- WHAT IS A TABLE?
-- ============================================================
-- A table is where actual data lives inside a database.
-- It is organized in ROWS and COLUMNS — like a spreadsheet.
--
-- ANALOGY:
--   Table    = one sheet in Excel
--   Row      = one customer record
--   Column   = one piece of information (name, email, etc.)
--
-- One database can contain many tables.
-- Example: customer_management database →
--          customers table
--          orders table
--          products table
-- ============================================================


-- ============================================================
-- STEP 1: SELECT THE DATABASE FIRST
-- ============================================================

USE sql_learning;


-- ============================================================
-- STEP 2: UNDERSTAND DATATYPES BEFORE CREATING
-- ============================================================

-- INT
--   Stores whole numbers (no decimals)
--   Used for: id, age, quantity, count
--   Example: 1, 25, 1000

-- VARCHAR(n)
--   Stores variable-length text up to n characters
--   Saves space — only uses what it needs
--   Used for: name, email, city, phone
--   Example: VARCHAR(50) → max 50 characters

-- ENUM('val1','val2',...)
--   Only allows specific listed values
--   Acts like a dropdown menu — prevents garbage data
--   Used for: gender, status, category
--   Example: ENUM('male','female','other')

-- DATE
--   Stores date only in YYYY-MM-DD format
--   Used for: date_of_birth, hire_date, order_date
--   Example: '1995-03-15'

-- TIMESTAMP
--   Stores both date AND time
--   Used for: created_at, updated_at, login_time
--   Example: '2026-06-10 14:30:00'

-- BOOLEAN
--   Stores TRUE or FALSE
--   Internally MySQL stores as TINYINT(1): 1=TRUE, 0=FALSE
--   Used for: is_active, is_verified, is_deleted
--   Example: TRUE, FALSE, 1, 0


-- ============================================================
-- STEP 3: UNDERSTAND CONSTRAINTS
-- ============================================================

-- PRIMARY KEY
--   Uniquely identifies every row in the table
--   Cannot be NULL, cannot be duplicate
--   Every table should have one

-- AUTO_INCREMENT
--   MySQL automatically assigns next number (1,2,3,4...)
--   You never need to type the id value manually

-- NOT NULL
--   This field is MANDATORY — cannot be left empty
--   Use for fields that must always have a value

-- UNIQUE
--   No two rows can have the same value in this column
--   Use for: email, phone, username

-- DEFAULT value
--   If no value is provided during INSERT,
--   MySQL uses this default value automatically


-- ============================================================
-- STEP 4: CREATE THE CUSTOMERS TABLE
-- ============================================================

CREATE TABLE customers (

    -- id: unique identifier for every customer
    -- AUTO_INCREMENT handles numbering automatically
    id            INT           AUTO_INCREMENT PRIMARY KEY,

    -- name: customer full name
    -- NOT NULL = name is mandatory, cannot be skipped
    name          VARCHAR(50)   NOT NULL,

    -- email: customer email address
    -- UNIQUE = no two customers can share same email
    -- NOT NULL = email is mandatory
    email         VARCHAR(70)   UNIQUE NOT NULL,

    -- gender: only allows these three specific values
    -- ENUM prevents invalid entries like "mle" or "femal"
    gender        ENUM('male', 'female', 'other'),

    -- date_of_birth: stored as YYYY-MM-DD
    -- used for age calculation, birthday campaigns
    date_of_birth DATE,

    -- created_at: automatically records when row was inserted
    -- CURRENT_TIMESTAMP = MySQL grabs exact date+time
    -- you never type this value — it fills automatically
    created_at    TIMESTAMP     DEFAULT CURRENT_TIMESTAMP

);


-- ============================================================
-- STEP 5: VERIFY TABLE WAS CREATED
-- ============================================================

-- View table structure (columns, types, constraints)
DESCRIBE customers;
-- or shorthand:
DESC customers;

-- View all tables in current database
SHOW TABLES;


-- ============================================================
-- INTERVIEW QUESTIONS — CREATE TABLE
-- ============================================================

-- Q1: What is the difference between VARCHAR and CHAR?
-- A : VARCHAR = variable length, saves space, adjusts to content
--     CHAR     = fixed length, always uses full allocated space
--     VARCHAR(50) storing "Ali" uses 3 bytes
--     CHAR(50)    storing "Ali" uses 50 bytes

-- Q2: What is a PRIMARY KEY?
-- A : A column that uniquely identifies every row.
--     Cannot be NULL or duplicate. Every table should have one.

-- Q3: What is AUTO_INCREMENT?
-- A : MySQL automatically assigns incrementing numbers (1,2,3...)
--     to a column. You never manually insert the id value.

-- Q4: What is the difference between NOT NULL and UNIQUE?
-- A : NOT NULL = value must exist (cannot be empty)
--     UNIQUE   = value must not repeat across rows
--     Email uses BOTH — must exist AND must be unique

-- Q5: What is ENUM?
-- A : A datatype that restricts a column to specific allowed
--     values only. Like a dropdown. Prevents invalid data.

-- Q6: What is TIMESTAMP DEFAULT CURRENT_TIMESTAMP?
-- A : Automatically stores the exact date and time when a
--     row is inserted. Common for created_at, updated_at columns.