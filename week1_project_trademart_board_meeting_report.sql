-- ============================================================
--  FILE             : week1_project_trademart_board_meeting_report.sql
--  PROJECT          : TradeMart Board Meeting Report
--  COMPANY          : TradeMart Corporation
--  ROLE             : Data Analyst
--  SKILLS USED      : SELECT, WHERE, ORDER BY, LIMIT/OFFSET,
--                     GROUP BY (single + multi-column),
--                     SUM/COUNT/AVG, MAX/MIN-via-ORDER BY
--  ROADMAP          : Week 1 Project - covers Days 1-7
--                     programmingvalley.com 30-Day SQL Roadmap
--  LEARNER          : Muhammad Ali
-- ============================================================




USE sql_learning;


-- ============================================================
-- Report 1: Company-wide snapshot
-- ============================================================

-- BUSINESS QUESTION:
-- Total orders, total net sales, and total profit/loss for
--  the whole company. One row.

SELECT
    COUNT(*)         AS total_orders,
    SUM(net_sales)    AS total_sales,
    SUM(profit_loss)  AS total_profit_loss
FROM sales_data;


-- ============================================================
-- Report 2: Regional health check
-- ============================================================

-- BUSINESS QUESTION:
-- For each region: total orders, total sales, total profit,
--  and average profit per order. Sort the most profitable
--  region first.

SELECT
    region,
    COUNT(*)            AS total_orders,
    SUM(net_sales)       AS total_sales,
    SUM(profit_loss)     AS total_profit,
    AVG(profit_loss)     AS avg_profit_per_order
FROM sales_data
GROUP BY region
ORDER BY total_profit DESC;


-- ============================================================
-- Report 3: Segment performance
-- ============================================================

-- BUSINESS QUESTION:
-- For each segment, show average order value and total
--  profit. Sort by total profit, highest first.

SELECT
    segment,
    AVG(net_sales)    AS avg_order_value,
    SUM(profit_loss)  AS total_profit
FROM sales_data
GROUP BY segment
ORDER BY total_profit DESC;


-- ============================================================
-- Report 4: Best and worst order — full details (corrected)
-- ============================================================

-- BUSINESS QUESTION:
-- Show me the single best order (highest net sales) and
--  single worst order (lowest net sales) — full details for
--  both, not just the numbers.

-- Best order (highest net sales) — full row
SELECT *
FROM sales_data
ORDER BY net_sales DESC
LIMIT 1;

-- Worst order (lowest net sales) — full row
SELECT *
FROM sales_data
ORDER BY net_sales ASC
LIMIT 1;


-- ============================================================
-- Report 5: Salesman leaderboard
-- ============================================================

-- BUSINESS QUESTION:
-- Rank every salesman by total net sales generated, highest
--  to lowest.

SELECT
    salesman,
    SUM(net_sales) AS total_sales
FROM sales_data
GROUP BY salesman
ORDER BY total_sales DESC;


-- ============================================================
-- Report 6: Shipping analysis
-- ============================================================

-- BUSINESS QUESTION:
-- How many orders were shipped using each shipping mode?

SELECT
    ship_mode,
    COUNT(*) AS total_orders
FROM sales_data
GROUP BY ship_mode;


-- ============================================================
-- Report 7: High-value Consumer orders 
-- ============================================================

-- BUSINESS QUESTION:
-- Show me all Consumer segment orders with net sales above
--  7000, sorted highest to lowest. Customer name, region,
--  net sales only.

SELECT
    customer_name,
    region,
    net_sales
FROM sales_data
WHERE segment = 'Consumer'
    AND net_sales > 7000
ORDER BY net_sales DESC;


-- ============================================================
-- Report 8: Worst 10 loss-making orders 
-- ============================================================

-- BUSINESS QUESTION:
-- Give me the worst 10 loss-making orders company-wide.
--  Full context — customer, region, product, salesman, and
--  the actual loss amount.

SELECT
    customer_name,
    region,
    product,
    salesman,
    profit_loss
FROM sales_data
ORDER BY profit_loss ASC
LIMIT 10;


-- ============================================================
-- Report 9: Specific customer deep dive
-- ============================================================

-- BUSINESS QUESTION:
-- Pick any one customer. Show their exact number of orders
--  AND their total net sales — correctly, not accidentally
--  counting the whole table.

SELECT
    COUNT(*)        AS total_orders,
    SUM(net_sales)  AS total_net_sales
FROM sales_data
WHERE customer_name = 'James Murray';


-- ============================================================
-- Report 10: Pagination — Page 2 using the formula 
-- ============================================================

-- BUSINESS QUESTION:
-- Give me page 2 of all orders, sorted by order date, 10
--  orders per page. Calculate the offset using the formula.

-- Page 2: OFFSET = (page_number - 1) x page_size
--                = (2 - 1) x 10 = 10

SELECT *
FROM sales_data
ORDER BY order_date
LIMIT 10 OFFSET 10;


-- ============================================================
-- Report 11: Final boardroom summary — region + segment
-- ============================================================

-- BUSINESS QUESTION:
-- Combine region and segment together. For every region +
--  segment combination, show total orders and total net sales.

SELECT
    region,
    segment,
    COUNT(*)        AS total_orders,
    SUM(net_sales)  AS total_sales
FROM sales_data
GROUP BY region, segment;


-- ============================================================
-- KEY LESSONS FROM WEEK 1 PROJECT
-- ============================================================
-- 1. THE BIG ONE: MAX()/MIN() = number only. ORDER BY + LIMIT 1
--    = full row behind that number. Never combine MAX()/MIN()
--    with individual row columns in the same SELECT.
--
-- 2. "Most profitable" = sort by total_profit, not total_sales.
--    High sales does not always mean high profit — match the
--    sort column to the EXACT word used in the question.
--
-- 3. profit_loss is already a complete per-order figure —
--    never recalculate it by subtracting from net_sales.
--
-- 4. Pagination requires: (a) a consistent page size across
--    all pages, (b) ORDER BY on a meaningful column, and
--    (c) the formula OFFSET = (page-1) x page_size — never guessed.
--
-- 5. When a stakeholder lists exact columns they want, match
--    that list exactly — don't add extra columns "just in case."
-- ============================================================


-- ============================================================
-- WEEK 1 COMPLETE — STAGE 1 FULLY CLOSED ✅
-- ============================================================