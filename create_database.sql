-- ============================================================
--  FILE             : create_database.sql
--  TOPIC            : Creating and Managing Databases
--  LEARNING OBJECTIVE: Understand how to create, select,
--                      verify and drop databases in MySQL
--  COURSE           : CodeWithHarry SQL Masterclass
--  LEARNER          : Muhammad Ali
-- ============================================================


-- ============================================================
-- WHAT IS A DATABASE?
-- ============================================================
-- A database is an organized digital storage system where
-- you store, manage, and retrieve data easily.
--
-- ANALOGY:
--   Library Building = Database
--   Each Bookshelf   = Table
--   Each Book        = Row (one record)
--   Book Details     = Columns (id, title, author)
--   The Librarian    = SQL (finds what you need)
--
-- REAL USAGE:
--   Daraz/Amazon  → stores orders, products, payments
--   Banks         → stores accounts, transactions
--   Hospitals     → stores patients, prescriptions
-- ============================================================


-- ============================================================
-- WHAT IS SQL?
-- ============================================================
-- SQL = Structured Query Language
-- It is the language you use to communicate with a database.
--
-- SQL CATEGORIES:
--   DDL (Data Definition Language)     → CREATE, ALTER, DROP
--   DML (Data Manipulation Language)   → INSERT, UPDATE, DELETE
--   DQL (Data Query Language)          → SELECT
--   DCL (Data Control Language)        → GRANT, REVOKE
--   TCL (Transaction Control Language) → COMMIT, ROLLBACK
--
-- SQL vs MySQL:
--   SQL   = the LANGUAGE
--   MySQL = the SOFTWARE that understands SQL
--   Others: PostgreSQL, SQL Server, Oracle, SQLite
-- ============================================================


-- ============================================================
-- STEP 1: VIEW ALL EXISTING DATABASES
-- ============================================================
-- Good habit — always check what exists before creating

SHOW DATABASES;

-- Output includes MySQL system databases:
-- information_schema, mysql, performance_schema, sys
-- DO NOT delete these — they are MySQL's own system databases


-- ============================================================
-- STEP 2: CREATE A DATABASE
-- ============================================================

-- NAMING RULES (Industry Standard):
--   ✅ lowercase letters only
--   ✅ underscores between words
--   ✅ name describes the PURPOSE of the database
--   ❌ no spaces
--   ❌ no personal names (like "Ali")
--   ❌ no special characters

-- Basic version:
CREATE DATABASE sql_learning;

-- Professional version (safe — no error if already exists):
CREATE DATABASE IF NOT EXISTS sql_learning;
--                          ^^^^^^^^^^
--                          Safety check — skip if exists


-- ============================================================
-- STEP 3: SELECT / USE THE DATABASE
-- ============================================================
-- Tells MySQL: "Run all my queries inside this database"
-- Like opening a specific drawer in a filing cabinet

USE sql_learning;


-- ============================================================
-- STEP 4: CONFIRM ACTIVE DATABASE
-- ============================================================

SELECT DATABASE();


-- ============================================================
-- STEP 5: VERIFY DATABASE WAS CREATED
-- ============================================================

SHOW DATABASES;
-- sql_learning should now appear in the list


-- ============================================================
-- STEP 6: DROP (DELETE) A DATABASE
-- ============================================================
-- WARNING: Permanently deletes database + ALL tables + ALL data
-- WARNING: Cannot be undone — no recycle bin in SQL
-- KEPT AS COMMENT — only run when 100% sure

-- DROP DATABASE IF EXISTS sql_learning;

-- INTERVIEW NOTE:
--   DROP DATABASE = deletes entire structure + data
--   DELETE        = removes only rows from a table


-- ============================================================
-- INTERVIEW QUESTIONS — CREATE DATABASE
-- ============================================================

-- Q1: What is a database?
-- A : Organized digital system for storing and managing data,
--     managed by a DBMS. Example: bank stores all accounts.

-- Q2: Difference between Database and Table?
-- A : Database = container. Table = dataset inside container.
--     One database can hold many tables.

-- Q3: What is SQL?
-- A : Structured Query Language — used to interact with
--     relational databases (create, read, update, delete).

-- Q4: SQL vs MySQL difference?
-- A : SQL = language. MySQL = software that understands SQL.

-- Q5: What does USE do?
-- A : Selects a database so all queries run inside it.

-- Q6: What happens when you DROP a database?
-- A : Everything is permanently deleted — tables, data,
--     structure. Cannot be undone.

-- Q7: What is IF NOT EXISTS?
-- A : Safety check — skips creation if database already exists
--     instead of throwing an error.