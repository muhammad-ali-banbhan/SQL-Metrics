-- ============================================================
--  FILE             : real_dataset_sales_data_filtering.sql
--  TOPIC            : SELECT and WHERE on Real Sales Dataset
--  LEARNING OBJECTIVE: Practice SELECT filtering on imported
--                      real-world data. Understand correct
--                      PRIMARY KEY design, date quoting,
--                      and GROUP BY basics
--  COURSE           : CodeWithHarry SQL Masterclass
--  LEARNER          : Muhammad Ali
-- ============================================================


USE sql_learning;


-- ============================================================
-- STEP 1: CREATE SALES TABLE
-- ============================================================

CREATE TABLE sales_data (
  
    order_date    DATE,
    order_id      VARCHAR(50)     UNIQUE,
    ship_date     DATE,
    ship_mode     VARCHAR(50),
    customer_id   VARCHAR(50),
    customer_name VARCHAR(100),
    segment       VARCHAR(50),
    product       VARCHAR(255),
    product_id    VARCHAR(50),
    salesman      VARCHAR(100),
    designation   VARCHAR(100),
    region        VARCHAR(50),
    no_customers  INT,
    net_sales     DECIMAL(12,2),
    profit_loss   DECIMAL(12,2)
);

DROP TABLE sales_data;
-- ============================================================
-- STEP 2: VIEW ALL DATA
-- ============================================================

SELECT * FROM sales_data;


-- ============================================================
-- STEP 3: FILTER ORDERS AFTER A DATE
-- ============================================================
-- WRONG : WHERE order_date > 2013-12-31
--         MySQL reads as math: 2013 - 12 - 31 = 1970
--         Returns everything — silent wrong result
--
-- CORRECT: Always wrap dates in single quotes

SELECT
    customer_name,
    product_id,
    product,
    ship_date,
    ship_mode
FROM sales_data
WHERE order_date > '2013-12-31';


-- ============================================================
-- STEP 4: SAME DAY SHIPMENTS
-- ============================================================

SELECT
    customer_name,
    customer_id,
    product,
    order_date,
    ship_date,
    ship_mode
FROM sales_data
WHERE ship_mode = 'Same Day';


-- ============================================================
-- STEP 5: GROUP BY REGION (Corrected)
-- ============================================================
-- Only include columns that are grouped or aggregated
-- Remove customer_name — it has many values per region

SELECT
    region,
    SUM(no_customers)   AS total_customers
FROM sales_data
GROUP BY region;

-- Want more aggregations? Add them:
SELECT
    region,
    SUM(no_customers)   AS total_customers,
    SUM(net_sales)      AS total_sales,
    SUM(profit_loss)    AS total_profit,
    COUNT(order_id)     AS total_orders
FROM sales_data
GROUP BY region;


-- ============================================================
-- STEP 6: BETWEEN — ORDERS IN 2012
-- ============================================================

SELECT
    customer_id,
    customer_name,
    segment,
    order_date,
    ship_date
FROM sales_data
WHERE order_date BETWEEN '2012-01-01' AND '2012-12-31';


-- ============================================================
-- EXTRA PRACTICE ON REAL DATASET
-- ============================================================

-- Profitable orders only (profit_loss > 0)
SELECT
    customer_name,
    product,
    net_sales,
    profit_loss
FROM sales_data
WHERE profit_loss > 0;


-- Loss-making orders (profit_loss < 0)
SELECT
    customer_name,
    product,
    net_sales,
    profit_loss
FROM sales_data
WHERE profit_loss < 0;


-- Orders from North region only
SELECT
    customer_name,
    region,
    net_sales,
    profit_loss
FROM sales_data
WHERE region = 'North';


-- High value sales above 9000
SELECT
    customer_name,
    product,
    net_sales
FROM sales_data
WHERE net_sales > 9000;


-- Consumer segment in North region
SELECT
    customer_name,
    segment,
    region,
    net_sales
FROM sales_data
WHERE segment = 'Consumer'
    AND region = 'North';


-- Orders by specific salesman
SELECT
    customer_name,
    salesman,gh
    product,
    net_sales
FROM sales_data
WHERE salesman = 'Adam';


-- Label orders as Profit or Loss using CASE WHEN
SELECT
    customer_name,
    product,
    net_sales,
    profit_loss,
    CASE
        WHEN profit_loss > 0 THEN 'Profit'
        ELSE 'Loss'
    END AS order_status
FROM sales_data;


-- ============================================================
-- KEY RULES LEARNED TODAY
-- ============================================================
-- 1. PRIMARY KEY must be unique in every single row
--    customer_id repeats (one customer, many orders) = wrong PK
--    Use auto-increment id or order_id as PRIMARY KEY
--
-- 2. Dates always need quotes in SQL
--    '2013-12-31' = correct date string
--    2013-12-31   = math expression (2013 - 12 - 31 = 1970)
--    Silent mistakes are the most dangerous — no error shown
--
-- 3. GROUP BY rule:
--    Every column in SELECT must either be:
--    a) In the GROUP BY clause
--    b) Inside an aggregate function (SUM, COUNT, AVG, MAX, MIN)
--    Anything else = unpredictable or error
--
-- 4. Working on real datasets is different from practice tables:
--    Data is messy, columns have real business meaning,
--    and every query must make business sense
-- ============================================================