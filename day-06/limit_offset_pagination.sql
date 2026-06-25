-- ============================================================
--  FILE             : limit_offset_pagination.sql
--  TOPIC            : LIMIT, OFFSET, and Pagination
--  LEARNING OBJECTIVE: Understand how OFFSET skips rows,
--                      how LIMIT + OFFSET work together,
--                      and how real applications use this
--                      combination to build pagination
--  ROADMAP          : Day 6 - programmingvalley.com 30-Day SQL Roadmap
--  LEARNER          : Muhammad Ali
-- ============================================================


-- ============================================================
-- WHAT IS OFFSET?
-- ============================================================
-- OFFSET = SKIP
-- It tells MySQL how many rows to skip from the beginning
-- before it starts returning results.
--
-- ANALOGY:
--   Reading a 1000-page book, but only wanting pages 5-10:
--   OFFSET 4 = skip the first 4 pages
--   LIMIT 6  = then read the next 6 pages
--   Result   = pages 5, 6, 7, 8, 9, 10
-- ============================================================


-- ============================================================
-- WHAT IS PAGINATION?
-- ============================================================
-- Pagination = splitting a large dataset into smaller "pages"
-- so the database doesn't load everything at once.
--
-- REAL EXAMPLES:
--   Google search results  → Page 1, Page 2, Page 3...
--   Amazon product listings → 50 products per page
--   Instagram/LinkedIn feed → loads 10-20 posts, then more
--
-- Every "Next Page" button is powered by LIMIT + OFFSET
-- changing behind the scenes as you click through pages.
-- ============================================================


-- ============================================================
-- THE PAGINATION FORMULA 
-- ============================================================
--   OFFSET = (page_number - 1) x page_size
--   LIMIT  = page_size
--
-- Example with page_size = 10:
--   Page 1 → OFFSET = (1-1)x10 = 0   → LIMIT 10 OFFSET 0
--   Page 2 → OFFSET = (2-1)x10 = 10  → LIMIT 10 OFFSET 10
--   Page 3 → OFFSET = (3-1)x10 = 20  → LIMIT 10 OFFSET 20
-- ============================================================


USE sql_learning;


-- ============================================================
-- STEP 1: BASIC LIMIT (Recap from Day 5)
-- ============================================================

-- BUSINESS QUESTION:
-- "Show me just the first 10 orders."

SELECT order_id, customer_name, net_sales
FROM sales_data
ORDER BY order_id
LIMIT 10;


-- ============================================================
-- STEP 2: LIMIT + OFFSET — Skip Then Take
-- ============================================================

-- BUSINESS QUESTION:
-- "I want to see order details, but specifically rows
--  5 through 10 — not the whole table."

-- IMPORTANT: Always pair LIMIT/OFFSET with ORDER BY
-- Without ORDER BY, MySQL does not guarantee row order,
-- so "row 5 to 10" has no fixed, reliable meaning.

SELECT
    order_id,
    order_date,
    product_id,
    customer_name
FROM sales_data
ORDER BY order_id
LIMIT 6
OFFSET 4;
-- OFFSET 4 = skip rows 1,2,3,4
-- LIMIT 6  = return the next 6 rows
-- Result   = rows 5,6,7,8,9,10


-- ============================================================
-- STEP 3: ALTERNATE SYNTAX — LIMIT offset, count
-- ============================================================
-- This shorthand produces the SAME result as Step 2 above
-- Note the number order: offset comes FIRST, count comes SECOND
-- This is the opposite order of "LIMIT count OFFSET offset"

SELECT *
FROM sales_data
ORDER BY order_id
LIMIT 4, 6;
-- 4 = skip 4 rows (offset)
-- 6 = then return 6 rows (count)
-- Same result as: LIMIT 6 OFFSET 4

-- PROFESSIONAL RECOMMENDATION:
-- Always prefer the explicit "LIMIT x OFFSET y" syntax in
-- real projects and GitHub code. It is self-explanatory.
-- The shorthand "LIMIT y, x" is easy to misread since the
-- numbers are reversed from what most people expect.


-- ============================================================
-- STEP 4: BUILDING REAL PAGINATION (Page by Page)
-- ============================================================
-- Imagine a dashboard showing 10 orders per page

-- BUSINESS QUESTION:
-- "Show me Page 1 of the orders list, 10 orders per page."

SELECT order_id, customer_name, region, net_sales
FROM sales_data
ORDER BY order_id
LIMIT 10 OFFSET 0;
-- Page 1: OFFSET = (1-1) x 10 = 0

-- BUSINESS QUESTION:
-- "Now show me Page 2."

SELECT order_id, customer_name, region, net_sales
FROM sales_data
ORDER BY order_id
LIMIT 10 OFFSET 10;
-- Page 2: OFFSET = (2-1) x 10 = 10

-- BUSINESS QUESTION:
-- "Now show me Page 3."

SELECT order_id, customer_name, region, net_sales
FROM sales_data
ORDER BY order_id
LIMIT 10 OFFSET 20;
-- Page 3: OFFSET = (3-1) x 10 = 20


-- ============================================================
-- STEP 5: COMBINING WITH ORDER BY DESC (Real Use Case)
-- ============================================================

-- BUSINESS QUESTION:
-- "Show me the 2nd page of our highest net sales orders —
--  10 per page, skipping the top 10 we already reviewed."

SELECT
    customer_name,
    region,
    net_sales
FROM sales_data
ORDER BY net_sales DESC
LIMIT 10 OFFSET 10;
-- This skips the TOP 10 highest sales (already seen on page 1)
-- and shows the NEXT 10 highest (rank 11-20)


-- ============================================================
-- INTERVIEW QUESTIONS — LIMIT, OFFSET, PAGINATION
-- ============================================================

-- Q1: What does OFFSET do?
-- A : Skips a specified number of rows before returning
--     the result set. Used together with LIMIT to fetch a
--     specific "slice" of data.

-- Q2: What is pagination and why is it used?
-- A : Pagination splits large datasets into smaller pages
--     so applications don't load everything at once.
--     Improves performance and user experience. Powers every
--     "Next Page" button on real websites.

-- Q3: What is the pagination formula?
-- A : OFFSET = (page_number - 1) x page_size
--     LIMIT  = page_size

-- Q4: Why must LIMIT/OFFSET always be paired with ORDER BY?
-- A : Without ORDER BY, MySQL does not guarantee a consistent
--     row order. "Row 5 to 10" only has reliable meaning if
--     the rows are sorted in a defined, repeatable order.

-- Q5: What is the difference between LIMIT 6 OFFSET 4
--     and LIMIT 4, 6?
-- A : Both produce identical results, but the number order
--     is different. "LIMIT 6 OFFSET 4" is count-then-offset
--     (explicit and recommended). "LIMIT 4, 6" is offset-then-
--     count (shorthand, easy to misread). Always prefer the
--     explicit version in professional code.