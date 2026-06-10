-- ============================================
-- Day 1: Introduction to SQL & Databases
-- Date: June 10, 2026
-- Learning Objective: Understand databases,
--                     create and drop databases
-- ============================================

-- View all existing databases
SHOW DATABASES;

-- Create your first database
CREATE DATABASE sql_learning;

-- Select/use the database
USE sql_learning;

-- Confirm which database is active
SELECT DATABASE();

-- Drop (delete) a database — use carefully!
DROP DATABASE sql_learning;