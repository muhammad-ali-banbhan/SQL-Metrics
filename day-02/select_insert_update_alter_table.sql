-- ============================================================
--  TOPIC   : Daily Practice Review — Corrected Script
--  LEARNER : Ali
-- ============================================================

USE sql_learning;

-- View all customers
SELECT * FROM customers;

-- View with readable status
SELECT
    id,
    name,
    email,
    gender,
    date_of_birth,
    CASE
        WHEN is_active = 1 THEN 'Active'
        ELSE 'Inactive'
    END AS account_status,
    created_at
FROM customers;

-- Extend name column size
ALTER TABLE customers MODIFY COLUMN name VARCHAR(100);

-- Add phone as VARCHAR (not INT) after name
ALTER TABLE customers ADD COLUMN phone VARCHAR(15) AFTER name;

-- Verify structure
DESCRIBE customers;

-- Insert new customers (with correct lowercase ENUM values)
INSERT INTO customers (name, email, gender, date_of_birth)
VALUES ('Zohaib Ali', 'zohaib@email.com', 'male', '2000-03-07');

-- Update existing row to add phone (UPDATE not INSERT)
UPDATE customers
SET phone = '03003322111'
WHERE id = 1;

-- Insert multiple rows — always specify column names
INSERT INTO customers (name, email, gender, date_of_birth)
VALUES
    ('Bob',     'bob@example.com',     'male',  '1990-11-23'),
    ('Charlie', 'charlie@example.com', 'other', '1988-02-17');

-- Final view
SELECT * FROM customers;