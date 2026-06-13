-- ============================================================
--  FILE             : day4_mini_project_sales_performance_analysis.sql
--  PROJECT          : Sales Performance Analysis
--  COMPANY          : TradeMart Corporation
--  ROLE             : Data Analyst
--  SKILLS USED      : SELECT, WHERE, BETWEEN, AND, IN,
--                     CASE WHEN, ELSE, profit/loss filtering
--  COURSE           : CodeWithHarry SQL Masterclass
--  LEARNER          : Muhammad Ali
-- ============================================================


USE sql_learning;


-- ============================================================
-- Report 1: All orders from year 2012
-- ============================================================

SELECT
    customer_name,
    region,
    order_date,
    net_sales
FROM sales_data
WHERE order_date BETWEEN '2012-01-01' AND '2012-12-31';


-- ============================================================
-- Report 2: Same Day shipments
-- ============================================================

SELECT
    customer_name,
    order_date,
    ship_date,
    ship_mode
FROM sales_data
WHERE ship_mode = 'Same Day';


-- ============================================================
-- Report 3: Orders with net sales above 8,000
-- ============================================================

SELECT
    customer_name,
    product,
    net_sales,
    region
FROM sales_data
WHERE net_sales > 8000;


-- ============================================================
-- Report 4: North region profitable orders
-- ============================================================

SELECT
    customer_name,
    region,
    net_sales,
    profit_loss
FROM sales_data
WHERE profit_loss > 0
    AND region = 'North';


-- ============================================================
-- Report 5: Net sales between 5,000 and 10,000
-- ============================================================

SELECT
    customer_name,
    net_sales,
    segment
FROM sales_data
WHERE net_sales BETWEEN 5000 AND 10000;


-- ============================================================
-- Report 6: Corporate and Home Office customers
-- ============================================================
-- IN used for clean multi-value matching
-- Cleaner than: WHERE segment = 'Corporate' OR segment = 'Home Office'

SELECT
    customer_name,
    segment
FROM sales_data
WHERE segment IN ('Corporate', 'Home Office');


-- ============================================================
-- Report 7: Full report with Profit/Loss label
-- ============================================================
-- ELSE used instead of second WHEN — cleaner when only 2 outcomes
-- CASE WHEN indented professionally for readability

SELECT
    customer_name,
    region,
    net_sales,
    profit_loss,
    CASE
        WHEN profit_loss > 0 THEN 'Profit'
        ELSE 'Loss'
    END AS order_result
FROM sales_data;


-- ============================================================
-- Report 8: Loss orders only
-- ============================================================
-- Filter on profit_loss directly in WHERE
-- Cannot filter on alias (order_result) in WHERE clause
-- MySQL processes WHERE before CASE WHEN alias is created

SELECT
    customer_name,
    region,
    net_sales,
    profit_loss,
    CASE
        WHEN profit_loss > 0 THEN 'Profit'
        ELSE 'Loss'
    END AS order_result
FROM sales_data
WHERE profit_loss <= 0;


-- ============================================================
-- IMPORTANT NOTE — WHY YOU CANNOT FILTER ON ALIAS IN WHERE
-- ============================================================
-- This would FAIL:
--   WHERE order_result = 'Loss'   ← alias does not exist yet
--
-- SQL execution order:
--   1. FROM       ← get the table
--   2. WHERE      ← filter rows (alias not created yet here)
--   3. SELECT     ← build columns including CASE WHEN alias
--   4. ORDER BY   ← sort (alias available here)
--
-- WHERE runs BEFORE SELECT creates the alias
-- So always filter on the real column not the alias


-- ============================================================
-- KEY LESSONS FROM THIS PROJECT
-- ============================================================
-- 1. BETWEEN on dates always needs quoted dates '2012-01-01'
-- 2. IN is cleaner than multiple OR conditions for value lists
-- 3. ELSE simplifies CASE WHEN when only 2 outcomes exist
-- 4. Cannot use SELECT alias in WHERE — filter real column
-- 5. SQL has a fixed execution order — understanding it
--    prevents many common mistakes
-- ============================================================