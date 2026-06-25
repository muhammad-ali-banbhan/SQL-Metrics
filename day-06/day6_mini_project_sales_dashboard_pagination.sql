-- ============================================================
--  FILE             : day6_mini_project_sales_dashboard_pagination.sql
--  PROJECT          : TradeMart Sales Dashboard — Pagination Build
--  COMPANY          : TradeMart Corporation
--  ROLE             : Data Analyst (supporting Web Dev team)
--  SKILLS USED      : LIMIT, OFFSET, pagination formula,
--                     ORDER BY ASC/DESC, multi-dashboard logic
--  ROADMAP          : Day 6 - programmingvalley.com 30-Day SQL Roadmap
--  LEARNER          : Muhammad Ali
-- ============================================================


USE sql_learning;


-- ============================================================
-- Report 1: Page 1 — Top 8 highest net sales orders
-- ============================================================

-- BUSINESS QUESTION:
-- Give me page 1 — top 8 highest net sales orders.
--  Customer name, region, net sales.
-- Page 1: OFFSET = (1-1) x 8 = 0

SELECT
    customer_name,
    region,
    net_sales
FROM sales_data
ORDER BY net_sales DESC
LIMIT 8 OFFSET 0;


-- ============================================================
-- Report 2: Page 2 — Next 8 orders
-- ============================================================

-- BUSINESS QUESTION:
-- Now give me page 2 — the next 8 orders in that same ranking.
-- Page 2: OFFSET = (2-1) x 8 = 8

SELECT
    customer_name,
    region,
    net_sales
FROM sales_data
ORDER BY net_sales DESC
LIMIT 8 OFFSET 8;


-- ============================================================
-- Report 3: Page 3 — Next 8 orders
-- ============================================================

-- BUSINESS QUESTION:
-- And page 3 — same pattern, next 8.
-- Page 3: OFFSET = (3-1) x 8 = 16

SELECT
    customer_name,
    region,
    net_sales
FROM sales_data
ORDER BY net_sales DESC
LIMIT 8 OFFSET 16;


-- ============================================================
-- Report 4: Page 5 — Using the formula directly
-- ============================================================

-- BUSINESS QUESTION:
-- I need page 5 directly — calculate the offset properly
--  using the pagination formula.
-- Page 5: OFFSET = (5-1) x 8 = 4 x 8 = 32

SELECT
    customer_name,
    region,
    net_sales
FROM sales_data
ORDER BY net_sales DESC
LIMIT 8 OFFSET 32;


-- ============================================================
-- Report 5: Loss Review Tab — Page 2, page size 5 
-- ============================================================

-- BUSINESS QUESTION:
-- "Loss Review tab. Page size is 5. Give me page 2 of orders
--  sorted by profit_loss, worst losses first."
--
-- This dashboard has its OWN page size (5) — separate from
-- the sales dashboard above (page size 8). Never reuse an
-- offset across dashboards with different page sizes.
--
-- Page 2: OFFSET = (2-1) x 5 = 5
--
-- "Worst losses first" = most negative profit_loss on top
-- = ORDER BY profit_loss ASC (not DESC)

SELECT
    customer_name,
    region,
    net_sales,
    profit_loss
FROM sales_data
ORDER BY profit_loss ASC
LIMIT 5 OFFSET 5;


-- ============================================================
-- Report 6: Skip top 3 best-sellers, show next 7 (CORRECTED)
-- ============================================================

-- BUSINESS QUESTION:
-- Skip the 3 best-selling orders entirely (already known),
--  then see the next 7 best ones after that.

-- "Best-selling" = highest net_sales — sort by net_sales,
-- not order_id. order_id only reflects creation sequence,
-- not sales performance.
--
-- This is page 2 in disguise: page_size 3 for "already seen,"
-- then a slice of 7 starting right after.
-- OFFSET = 3 (skip the known top 3)
-- LIMIT  = 7 (show the next 7)

SELECT
    customer_name,
    order_id,
    order_date,
    product_id,
    region,
    net_sales
FROM sales_data
ORDER BY net_sales DESC
LIMIT 7 OFFSET 3;


-- ============================================================
-- KEY LESSONS FROM THIS PROJECT
-- ============================================================
-- 1. "Worst/biggest loss first" = ORDER BY profit_loss ASC
--    The most negative number represents the biggest loss.
--
-- 2. Each dashboard/report has its OWN page size. Never carry
--    an offset calculated for one page size into a query using
--    a different page size.
--
-- 3. Always re-verify commas in multi-column SELECT statements
--    — one missing comma breaks the entire query.
--
-- 4. Match the ORDER BY column to the actual business meaning
--    of the word used in the question. "Best-selling" = sales
--    figures, not the row's internal ID or creation order.
-- ============================================================