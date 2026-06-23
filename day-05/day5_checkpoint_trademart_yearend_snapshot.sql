-- ============================================================
--  FILE             : day5_checkpoint_trademart_yearend_snapshot.sql
--  PROJECT          : TradeMart Year-End Snapshot
--  CHECKPOINT       : Roadmap Day 1-5 Consolidation
--                     (Intro, Databases/Tables, SELECT, WHERE, ORDER BY)
--  COMPANY          : TradeMart Corporation
--  ROLE             : Data Analyst
--  SKILLS USED      : SELECT, WHERE (=, >, AND, IN, BETWEEN),
--                     ORDER BY (ASC/DESC), LIMIT, combined filters
--  ROADMAP          : programmingvalley.com 30-Day SQL Roadmap
--  LEARNER          : Muhammad Ali
-- ============================================================


USE sql_learning;


-- ============================================================
-- Report 1: Confirm database and table structure
-- ============================================================

-- BUSINESS QUESTION:
-- Confirm which database and table you're working in,
--  then show me the full table structure.

SELECT * FROM sales_data;

DESCRIBE sales_data;


-- ============================================================
-- Report 2: Specific columns only
-- ============================================================

-- BUSINESS QUESTION:
-- "Give me just customer name, region, and net sales —
--  nothing else. No full table dumps."

SELECT
    customer_name,
    region,
    net_sales
FROM sales_data;


-- ============================================================
-- Report 3: West region orders
-- ============================================================

-- BUSINESS QUESTION:
-- "Show me every order from the West region only."

-- CORRECTED: original version had only order_id + region —
-- not enough detail to be useful. Added customer, product,
-- and net_sales so each row is actually meaningful.

SELECT
    order_id,
    customer_name,
    region,
    product,
    net_sales
FROM sales_data
WHERE region = 'West';


-- ============================================================
-- Report 4: Corporate segment, high value
-- ============================================================

-- BUSINESS QUESTION:
-- Show me orders where the segment is Corporate AND the
--  net sales are above 6000.

SELECT
    order_date,
    order_id,
    segment,
    net_sales
FROM sales_data
WHERE segment = 'Corporate'
    AND net_sales > 6000;


-- ============================================================
-- Report 5: First Class or Same Day shipments
-- ============================================================

-- BUSINESS QUESTION:
-- "Show me only orders shipped using First Class or Same Day —
--  cleanest possible query."

SELECT
    order_id,
    order_date,
    ship_date,
    ship_mode
FROM sales_data
WHERE ship_mode IN ('First Class', 'Same Day');


-- ============================================================
-- Report 6: Net sales in a range
-- ============================================================

-- BUSINESS QUESTION:
-- "Show me orders with net sales between 4000 and 9000."

SELECT
    order_id,
    net_sales
FROM sales_data
WHERE net_sales BETWEEN 4000 AND 9000;


-- ============================================================
-- Report 7: Highest net sales first
-- ============================================================

-- BUSINESS QUESTION:
-- "Sort all orders by net sales, highest first. Show me only
--  customer name, region, and net sales."

SELECT
    customer_name,
    region,
    net_sales
FROM sales_data
ORDER BY net_sales DESC;


-- ============================================================
-- Report 8: Worst 5 orders by profit/loss
-- ============================================================

-- BUSINESS QUESTION:
-- "Give me the 5 orders with the worst profit/loss — the
--  actual losses, not the profits."

-- CORRECTED: original version had only order_id — added
-- customer, region, and profit_loss so the Director can
-- actually see who and where the losses are happening.
-- ASC written explicitly for clarity even though it's default.

SELECT
    order_id,
    customer_name,
    region,
    profit_loss
FROM sales_data
ORDER BY profit_loss ASC
LIMIT 5;


-- ============================================================
-- Report 9: Combined multi-condition report
-- ============================================================

-- BUSINESS QUESTION:
-- Show me Consumer segment orders from the North or West
--  region, with net sales above 5000, sorted by net sales
--  descending. Customer name, region, segment, net sales only.

SELECT
    customer_name,
    region,
    segment,
    net_sales
FROM sales_data
WHERE segment = 'Consumer'
    AND net_sales > 5000
    AND region IN ('North', 'West')
ORDER BY net_sales DESC;


-- ============================================================
-- CHECKPOINT SUMMARY — ROADMAP DAY 1-5 CONFIRMED
-- ============================================================
-- ✅ Day 1: Introduction to SQL
-- ✅ Day 2: Databases and Tables (USE, DESCRIBE)
-- ✅ Day 3: SELECT — specific columns, no SELECT * habit
-- ✅ Day 4: WHERE — =, >, AND, IN, BETWEEN all demonstrated
-- ✅ Day 5: ORDER BY — ASC and DESC, combined with LIMIT
--
-- KEY LESSON LOCKED IN TODAY:
-- Every report column choice must answer: "Can someone act
-- on this information with only what I've given them?"
-- ============================================================