-- ============================================================
--  FILE             : group_by_hospital_dataset.sql
--  TOPIC            : GROUP BY — Formal Deep-Dive (New Dataset)
--  LEARNING OBJECTIVE: Apply GROUP BY rules confidently on a
--                      brand-new relational dataset; understand
--                      the difference between "highest individual
--                      value" (ORDER BY + LIMIT) and "highest
--                      group average" (GROUP BY + AVG + ORDER BY);
--                      recognize and handle ambiguous business
--                      questions that mix individual and group
--                      concepts
--  ROADMAP          : Day 8 - programmingvalley.com 30-Day SQL Roadmap
--  DATASET          : hospital_db (5 tables: patients, doctors,
--                     appointments, billing, hospitals)
--  LEARNER          : Muhammad Ali
-- ============================================================


--
--   RULE TO MEMORIZE:
--     "Highest INDIVIDUAL value, full row details"
--       → ORDER BY column DESC + LIMIT 1 (no GROUP BY)
--     "Highest GROUP AVERAGE/TOTAL, one row per group"
--       → GROUP BY + aggregate + ORDER BY + LIMIT
--     Never mix ungrouped row-level columns into a GROUP BY
--     query unless those columns are part of the GROUP BY
--     clause itself.
-- ============================================================


USE hospital_db;


-- ============================================================
-- Q1: Patients per department
-- ============================================================

-- BUSINESS QUESTION:
-- How many patients are in each department?

SELECT
    Department,
    COUNT(*) AS total_patients
FROM patients
GROUP BY Department;


-- ============================================================
-- Q2: Average treatment cost per department
-- ============================================================

-- BUSINESS QUESTION:
-- What is the average treatment cost per department?

SELECT
    Department,
    AVG(Treatment_Cost) AS avg_treatment_cost
FROM patients
GROUP BY Department;


-- ============================================================
-- Q3: Appointments by status
-- ============================================================

-- BUSINESS QUESTION:
-- How many appointments fall under each status (Scheduled,
--  Completed, Cancelled)?

SELECT
    Status,
    COUNT(*) AS total_appointments
FROM appointments
GROUP BY Status;


-- ============================================================
-- Q4: Doctors per city
-- ============================================================

-- BUSINESS QUESTION:
-- How many doctors are there in each city?

SELECT
    City,
    COUNT(*) AS total_doctors
FROM doctors
GROUP BY City;


-- ============================================================
-- Q5: Billing totals by payment status
-- ============================================================

-- BUSINESS QUESTION:
-- What is the total Total_Cost and total Patient_Payable
--  from billing, grouped by Payment_Status?

SELECT
    Payment_Status,
    SUM(Total_Cost)        AS overall_total_cost,
    SUM(Patient_Payable)   AS overall_patient_payable
FROM billing
GROUP BY Payment_Status;


-- ============================================================
-- Q6: Average cost and count per outcome
-- ============================================================

-- BUSINESS QUESTION:
-- For each Outcome, what is the average Treatment_Cost and
--  how many patients fall into that outcome?

SELECT
    Outcome,
    AVG(Treatment_Cost)  AS avg_treatment_cost,
    COUNT(*)              AS total_patients
FROM patients
GROUP BY Outcome;


-- ============================================================
-- Q7: Two-column GROUP BY — Department + Outcome
-- ============================================================

-- BUSINESS QUESTION:
-- For each combination of Department and Outcome, how many
--  patients are there?

SELECT
    Department,
    Outcome,
    COUNT(*) AS total_patients
FROM patients
GROUP BY Department, Outcome;


-- ============================================================
-- Q8: "Highest experience" — TWO interpretations
-- ============================================================

-- BUSINESS QUESTION 
-- Which single doctor has the highest average Experience_Years
--  in their department?

-- INTERPRETATION A: Which INDIVIDUAL doctor has the most
-- personal experience? (No averaging — one specific doctor)
SELECT
    Doctor_ID,
    Doctor_Name,
    Department,
    Experience_Years
FROM doctors
ORDER BY Experience_Years DESC
LIMIT 1;

-- INTERPRETATION B: Which DEPARTMENT has the highest average
-- experience among all its doctors? (Group-level answer)
SELECT
    Department,
    AVG(Experience_Years) AS avg_experience
FROM doctors
GROUP BY Department
ORDER BY avg_experience DESC
LIMIT 1;

-- REAL ANALYST PRACTICE: When a question mixes "one doctor"
-- with "department average" like this, the correct first move
-- in a real job is to clarify with the stakeholder rather than
-- silently guessing. Both interpretations above are provided
-- here because the original question supports either reading.


-- ============================================================
-- INTERVIEW QUESTIONS — GROUP BY DEEP DIVE
-- ============================================================

-- Q1: What is the GROUP BY rule for SELECT columns?
-- A : Every column must be either in the GROUP BY clause or
--     inside an aggregate function (COUNT, SUM, AVG, MAX, MIN).

-- Q2: How do you find the row with the highest individual
--     value and see its full details?
-- A : Use ORDER BY column DESC with LIMIT 1 — never MAX() for
--     this, since MAX() only returns the number, not the row.

-- Q3: How do you find which GROUP has the highest average
--     of some value?
-- A : GROUP BY the grouping column, use AVG() on the value
--     column, then ORDER BY that average DESC with LIMIT 1.

-- Q4: What should you do when a business question mixes an
--     individual-level concept with a group-level concept
--     (e.g., "which doctor has the highest department average")?
-- A : Recognize the ambiguity. In a real job, clarify with the
--     stakeholder. If clarification isn't possible immediately,
--     answer both reasonable interpretations and label them
--     clearly so the reader understands the distinction.

-- Q5: Why can't you combine GROUP BY Department with selecting
--     individual Doctor_Name in the same query without an
--     aggregate?
-- A : Each department contains multiple doctors with different
--     names. GROUP BY collapses all doctors in a department
--     into one row, and MySQL has no rule for which doctor's
--     name to display — the column must either be grouped or
--     aggregated.