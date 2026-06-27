-- ============================================================
--  FILE             : day7_mini_project_quarterly_business_summary.sql
--  PROJECT          : TradeMart Quarterly Business Summary
--  COMPANY          : TradeMart Corporation
--  ROLE             : Data Analyst
--  SKILLS USED      : SUM, COUNT, AVG, MAX/MIN logic via
--                     ORDER BY + LIMIT, GROUP BY, multi-aggregate
--                     reports, exact-match COUNT
--  ROADMAP          : Day 7 - programmingvalley.com 30-Day SQL Roadmap
--                     (Closing Stage 1: Days 1-7)
--  LEARNER          : Muhammad Ali
-- ============================================================


USE sql_learning;


-- ============================================================
-- Report 1: Company-wide totals (no grouping)
-- ============================================================

-- BUSINESS QUESTION:
-- "Give me the total net sales and total profit/loss for the
--  ENTIRE company — just two single numbers, no grouping."
--
-- KEY CONCEPT: Without GROUP BY, the entire table is treated
-- as ONE single group. SUM() collapses all rows into one total.

SELECT
    SUM(net_sales)   AS total_sales,
    SUM(profit_loss) AS total_profit_loss
FROM sales_data;


-- ============================================================
-- Report 2: Region breakdown — orders, sales, profit
-- ============================================================

-- BUSINESS QUESTION:
-- "Break that down by region — for each region, show total
--  net sales, total profit, and how many orders came from there."

SELECT
    region,
    COUNT(*)         AS total_orders,
    SUM(net_sales)    AS total_sales,
    SUM(profit_loss)  AS total_profit
FROM sales_data
GROUP BY region;


-- ============================================================
-- Report 3: Average order value by segment
-- ============================================================

-- BUSINESS QUESTION:
-- "I want to know our average order value — average net sales
--  per order — broken down by segment."

SELECT
    segment,
    AVG(net_sales) AS avg_order_value
FROM sales_data
GROUP BY segment;


-- ============================================================
-- Report 4: Highest and lowest full order details
-- ============================================================

-- BUSINESS QUESTION:
-- "Show me the single highest net sales order in our ENTIRE
--  dataset, and the single lowest net sales order. Just one
--  row each, with full order details."
--
-- KEY CONCEPT: MAX()/MIN() only return a NUMBER, not the full
-- row that produced it. To get the complete row (customer,
-- region, product, etc.), use ORDER BY + LIMIT 1 instead.

-- Highest net sales order — full row
SELECT *
FROM sales_data
ORDER BY net_sales DESC
LIMIT 1;

-- Lowest net sales order — full row
SELECT *
FROM sales_data
ORDER BY net_sales ASC
LIMIT 1;


-- ============================================================
-- Report 5: Salesman ranking by total net sales
-- ============================================================

-- BUSINESS QUESTION:
-- "Which salesman has generated the most total net sales?
--  Show me every salesman ranked from highest to lowest
--  total sales."

SELECT
    salesman,
    SUM(net_sales) AS total_sales
FROM sales_data
GROUP BY salesman
ORDER BY total_sales DESC;


-- ============================================================
-- Report 6: Exact order count for a specific customer
-- ============================================================

-- BUSINESS QUESTION:
-- "How many orders has a specific customer placed — pick any
--  one customer and show me their exact order count. I want
--  to see this works correctly, not accidentally counting
--  the whole table."
--
-- This directly applies the Day 7 lesson: COUNT(*) combined
-- with WHERE filters correctly. COUNT('literal text') without
-- WHERE would incorrectly count every row in the table.

SELECT COUNT(*) AS total_orders
FROM sales_data
WHERE customer_name = 'James Murray';

-- WRONG APPROACH (yesterday's mistake — kept here as a
-- reminder, never run this in real work):
-- SELECT COUNT('James Murray') FROM sales_data;
-- This ignores the customer name entirely and counts ALL rows


-- ============================================================
-- Report 7: Final combined region summary
-- ============================================================

-- BUSINESS QUESTION:
-- "Give me one report — for every region, show total orders,
--  total net sales, total profit/loss, and average profit/loss
--  per order. Sort it so the most profitable region is on top."

SELECT
    region,
    COUNT(*)             AS total_orders,
    SUM(net_sales)        AS total_sales,
    SUM(profit_loss)      AS total_profit,
    AVG(profit_loss)      AS avg_profit_per_order
FROM sales_data
GROUP BY region
ORDER BY total_profit DESC;


-- ============================================================
-- KEY LESSONS FROM THIS PROJECT (CLOSING STAGE 1)
-- ============================================================
-- 1. Aggregates WITHOUT GROUP BY = one total for the entire
--    table, treated as a single group.
--
-- 2. MAX()/MIN() return only a number. To get the FULL ROW
--    behind that number, use ORDER BY + LIMIT 1 instead.
--
-- 3. SUM + GROUP BY + ORDER BY combine naturally to build
--    ranking reports (e.g., "who performs best?").
--
-- 4. COUNT(*) with WHERE is the correct way to count a
--    specific entity's occurrences — never COUNT('literal').
--
-- 5. A single query can combine COUNT, SUM, AVG, GROUP BY,
--    and ORDER BY together — this is what real business
--    summary reports look like.
-- ============================================================


-- ============================================================
-- STAGE 1 COMPLETE — DAYS 1-7 ✅
-- ============================================================
-- ✅ Day 1: Introduction to SQL
-- ✅ Day 2: Databases and Tables
-- ✅ Day 3: SELECT Statement
-- ✅ Day 4: WHERE Clause and Logical Operators
-- ✅ Day 5: Sorting Data with ORDER BY
-- ✅ Day 6: LIMIT & OFFSET (Pagination)
-- ✅ Day 7: Aggregate Functions (SUM, COUNT, AVG, MAX, MIN)
--
-- NEXT: Weekly Project (Sunday) — combining all of Week 1
-- Then Stage 2 begins: Day 8 — GROUP BY (formal deep-dive)
-- ============================================================