-- ============================================================
--  FILE             : day5_mini_project_regional_performance_audit.sql
--  PROJECT          : Regional Performance & Customer Update Audit
--  COMPANY          : TradeMart Corporation
--  ROLE             : Data Analyst
--  SKILLS USED      : GROUP BY (single + multi-column),
--                     SUM, COUNT, ORDER BY ASC/DESC, LIMIT,
--                     WHERE with negative numbers, safe UPDATE
--  COURSE           : CodeWithHarry SQL Masterclass
--  LEARNER          : Muhammad Ali
-- ============================================================


USE sql_learning;


-- ============================================================
-- Report 1: Orders per segment
-- ============================================================

-- BUSINESS QUESTION:
-- How many total orders came from each segment —
--  Consumer, Corporate, Home Office?

SELECT
    segment,
    COUNT(*) AS total_orders
FROM sales_data
GROUP BY segment;


-- ============================================================
-- Report 2: Net sales and profit/loss per region
-- ============================================================

-- BUSINESS QUESTION:
-- For each region, give me total net sales AND total
--  profit/loss together in one report — I want to compare
--  which regions make money and which ones don't.

SELECT
    region,
    SUM(net_sales)   AS total_sales,
    SUM(profit_loss) AS total_profit
FROM sales_data
GROUP BY region
ORDER BY total_profit DESC;


-- ============================================================
-- Report 3: Orders per salesman, broken down by ship mode
-- ============================================================

-- BUSINESS QUESTION:
-- How many orders did each salesman handle, broken down
--  by ship mode? For example, how many Same Day orders did Adam handle versus First Class?

SELECT
    salesman,
    ship_mode,
    COUNT(*) AS total_orders
FROM sales_data
GROUP BY salesman, ship_mode;


-- ============================================================
-- Report 4: Top 10 Consumer segment orders by net sales
-- ============================================================

-- BUSINESS QUESTION:
-- Give me the Top 10 orders by net sales — only from the
--  Consumer segment. Customer name, region, product, net sales.

SELECT
    customer_name,
    region,
    product,
    net_sales
FROM sales_data
WHERE segment = 'Consumer'
ORDER BY net_sales DESC
LIMIT 10;


-- ============================================================
-- Report 5: Worst 10 loss-making orders (loss below -1000)
-- ============================================================

-- BUSINESS QUESTION:
-- Show me the 10 worst loss-making orders overall — only
--  if the loss is below -1000. Sort with the biggest loss first.

SELECT
    customer_name,
    region,
    product,
    profit_loss
FROM sales_data
WHERE profit_loss < -1000
ORDER BY profit_loss ASC
LIMIT 10;


-- ============================================================
-- Report 6: Region with the lowest total profit
-- ============================================================

-- BUSINESS QUESTION:
-- Find which region has the lowest total profit. Just give
--  me that one number with the region name — ranked, worst on top.

SELECT
    region,
    SUM(profit_loss) AS total_profit
FROM sales_data
GROUP BY region
ORDER BY total_profit ASC
LIMIT 1;


-- ============================================================
-- Report 7: Customer name correction (with safety check)
-- ============================================================

-- BUSINESS QUESTION:
-- Customer ID 'TO-RE-01' has their name misspelled — it
--  should be 'Tom Reiter'. Show me the current record first
--  to confirm it's the right one, then update it, then show
--  the result to confirm the fix worked.

-- STEP A: Check the current record before touching anything
SELECT *
FROM sales_data
WHERE customer_id = 'TO-RE-01';
-- ANALYST NOTE: Current name on file is "Tom Alter Reiter"
-- not an exact match to what the Director described.
-- In a real job: confirm with the Director whether "Alter"
-- should be removed, or whether this might be a different
-- person before proceeding. Flagging this is good practice —
-- never silently assume and overwrite real business data.

-- STEP B: Proceeding with the correction as instructed
UPDATE sales_data
SET customer_name = 'Tom Reiter'
WHERE customer_id = 'TO-RE-01';

-- STEP C: Verify the update worked as expected
SELECT *
FROM sales_data
WHERE customer_id = 'TO-RE-01';


-- ============================================================
-- KEY LESSONS FROM THIS PROJECT
-- ============================================================
-- 1. "Broken down by X" in a business question = GROUP BY
--    must include that column X, not just the main entity.
--
-- 2. Negative number filters need the negative sign —
--    < -1000 and < 1000 are completely different filters.
--
-- 3. To find "biggest loss," sort profit_loss ASCENDING.
--    The most negative number is mathematically smallest,
--    but represents the largest loss.
--
-- 4. When asked to update a record, ALWAYS check the current
--    data first. If something looks off or doesn't match
--    exactly — flag it before silently overwriting real data.
--    This is the difference between a query-runner and an analyst.
-- ============================================================