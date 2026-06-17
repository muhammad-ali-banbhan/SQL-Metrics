-- ============================================================
--  FILE             : group_by_order_by_limit_update.sql
--  TOPIC            : GROUP BY, ORDER BY, LIMIT, UPDATE Safety
--  LEARNING OBJECTIVE: Understand correct GROUP BY rules,
--                      sorting with ORDER BY (ASC/DESC),
--                      Top-N queries with LIMIT, and safe
--                      UPDATE practices on real data
--  COURSE           : CodeWithHarry SQL Masterclass
--  LEARNER          : Muhammad Ali
-- ============================================================


USE sql_learning;


-- ============================================================
-- STEP 1: VIEW DATA
-- ============================================================

-- BUSINESS QUESTION:
-- "Show me everything in the sales table so I know what
--  data we are working with before building any reports."

SELECT * FROM sales_data;


-- ============================================================
-- STEP 2: GROUP BY 

-- ============================================================

-- BUSINESS QUESTION:
-- "How many total orders have come from each region?"

SELECT
    region,
    COUNT(*) AS total_orders
FROM sales_data
GROUP BY region;


-- BUSINESS QUESTION:
-- "For each region, what is the total order count, total
--  sales revenue, total profit/loss, and total customers
--  served? I want one combined performance snapshot per region."

SELECT
    region,
    COUNT(*)             AS total_orders,
    SUM(net_sales)        AS total_sales,
    SUM(profit_loss)      AS total_profit,
    SUM(no_customers)     AS total_customers
FROM sales_data
GROUP BY region;


-- BUSINESS QUESTION:
-- "Within each region, how many orders did each salesman
--  handle? I want to see individual salesman performance
--  broken down by region."

SELECT
    region,
    salesman,
    COUNT(*) AS total_orders
FROM sales_data
GROUP BY region, salesman;
-- Each row now = one unique region + salesman combination


-- ============================================================
-- STEP 3: ORDER BY — SORTING RESULTS
-- ============================================================
-- ORDER BY DESC = highest to lowest
-- ORDER BY ASC  = lowest to highest (this is the default)
-- Always write ASC/DESC explicitly — clearer for anyone reading


-- BUSINESS QUESTION:
-- "What are our top 20 highest-value orders? I want to see
--  which customers and products are driving the most revenue."

SELECT
    customer_name,
    segment,
    region,
    product,
    net_sales
FROM sales_data
ORDER BY net_sales DESC
LIMIT 20;


-- BUSINESS QUESTION:
-- "What are our 20 worst-performing orders by profit/loss?
--  I need to investigate where we are losing the most money."

SELECT
    customer_name,
    segment,
    region,
    product,
    profit_loss
FROM sales_data
ORDER BY profit_loss ASC
LIMIT 20;


-- ============================================================
-- STEP 4: UPDATE — THE SAFE WAY (Always Follow This Pattern)
-- ============================================================

-- BUSINESS QUESTION:
-- "Customer DA-RI-01 got married and changed their name to
--  James Coles. Update their record — but first confirm how
--  many of their order rows exist, since one customer can
--  have multiple orders."

-- STEP A: ALWAYS check first — how many rows match this condition?
SELECT *
FROM sales_data
WHERE customer_id = 'DA-RI-01';
-- Look at the row count before proceeding
-- If customer_id repeats, ALL matching rows will be updated

-- STEP B: Only after confirming row count is what you expect,
--         run the UPDATE
UPDATE sales_data
SET customer_name = 'James Coles'
WHERE customer_id = 'DA-RI-01';

-- STEP C: Always verify the change worked correctly
SELECT *
FROM sales_data
WHERE customer_id = 'DA-RI-01';


-- ============================================================
-- BONUS: ORDER BY with GROUP BY together (common analyst combo)
-- ============================================================

-- BUSINESS QUESTION:
-- "Rank our regions from most profitable to least profitable.
--  I want to know exactly where we make the most and least money."

SELECT
    region,
    SUM(profit_loss) AS total_profit
FROM sales_data
GROUP BY region
ORDER BY total_profit DESC;


-- ============================================================
-- INTERVIEW QUESTIONS — GROUP BY, ORDER BY, LIMIT
-- ============================================================

-- Q1: What is the rule for columns in a GROUP BY query?
-- A : Every SELECT column must be in GROUP BY or inside an
--     aggregate function (COUNT, SUM, AVG, MAX, MIN).

-- Q2: What is the default sort order in ORDER BY?
-- A : ASC (ascending — lowest to highest). DESC must be
--     written explicitly for highest to lowest.

-- Q3: What does LIMIT do?
-- A : Restricts the number of rows returned. Commonly combined
--     with ORDER BY to get "Top N" or "Bottom N" results.

-- Q4: Why should you SELECT before UPDATE?
-- A : To confirm exactly which and how many rows will be
--     affected before making permanent changes. Prevents
--     accidental mass updates, especially on non-unique columns.

-- Q5: Can you combine GROUP BY and ORDER BY in one query?
-- A : Yes. GROUP BY aggregates data first, then ORDER BY sorts
--     the aggregated results. Very common in business reporting,
--     e.g., "Which region has highest total profit?"