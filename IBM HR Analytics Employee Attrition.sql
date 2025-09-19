CREATE DATABASE IF NOT EXISTS hr_analytics;
USE hr_analytics;

SELECT *
FROM hr_employee;

-- Data cleaning

ALTER TABLE hr_employee
CHANGE COLUMN ï»¿Age Age INT;

DESCRIBE hr_employee;


SELECT COUNT(*) AS total_rows FROM hr_employee;

SHOW COLUMNS FROM hr_employee;


-- check for duplication

SELECT EmployeeNumber, COUNT(*) 
FROM hr_employee
GROUP BY EmployeeNumber
HAVING COUNT(*) > 1;


-- Null/missing values per column (example for Attrition, JobRole, MonthlyIncome)
SELECT
  SUM(CASE WHEN Attrition IS NULL OR TRIM(Attrition) = '' THEN 1 ELSE 0 END) AS null_attrition,
  SUM(CASE WHEN JobRole IS NULL OR TRIM(JobRole) = '' THEN 1 ELSE 0 END) AS null_jobrole,
  SUM(CASE WHEN MonthlyIncome IS NULL THEN 1 ELSE 0 END) AS null_income
FROM hr_employee;


-- Attrition count & percentage
SELECT 
    Attrition,
    COUNT(*) AS count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct
FROM hr_employee
GROUP BY Attrition;


SELECT *
FROM hr_employee;


-- Gender distribution
SELECT Gender, COUNT(*) AS count
FROM hr_employee
GROUP BY Gender;


-- Average age, tenure, income
SELECT ROUND(AVG(Age),1) AS avg_age,
       ROUND(AVG(YearsAtCompany),1) AS avg_tenure,
       ROUND(AVG(MonthlyIncome),1) AS avg_income
FROM hr_employee;

-- Attrition Breakdown By Department
SELECT Department,
       COUNT(*) AS total,
       SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS attrition_count,
       ROUND(100.0*SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)/COUNT(*),2) AS attrition_pct
FROM hr_employee
GROUP BY Department
ORDER BY attrition_pct DESC;

-- Attrition Breakdown By JobRole
SELECT JobRole,
       COUNT(*) AS total,
       SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS attrition_count,
       ROUND(100.0*SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)/COUNT(*),2) AS attrition_pct
FROM hr_employee
GROUP BY JobRole
ORDER BY attrition_pct DESC;

-- Attrition Breakdown By OverTime
SELECT OverTime,
       COUNT(*) AS total,
       SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS attrition_count,
       ROUND(100.0*SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)/COUNT(*),2) AS attrition_pct
FROM hr_employee
GROUP BY OverTime;

-- Attrition Breakdown by By MaritalStatus
SELECT MaritalStatus,
       COUNT(*) AS total,
       SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS attrition_count,
       ROUND(100.0*SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)/COUNT(*),2) AS attrition_pct
FROM hr_employee
GROUP BY MaritalStatus;

--                Numeric Feature Analysis

-- Income vs Attrition
SELECT Attrition,
       ROUND(AVG(MonthlyIncome),0) AS avg_income,
       ROUND(MIN(MonthlyIncome),0) AS min_income,
       ROUND(MAX(MonthlyIncome),0) AS max_income
FROM hr_employee
GROUP BY Attrition;

-- Attrition by Age group
SELECT CASE
          WHEN Age < 25 THEN '<25'
          WHEN Age BETWEEN 25 AND 34 THEN '25-34'
          WHEN Age BETWEEN 35 AND 44 THEN '35-44'
          ELSE '45+'
       END AS age_group,
       COUNT(*) AS total,
       SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS attrition_count,
       ROUND(100.0*SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)/COUNT(*),2) AS attrition_pct
FROM hr_employee
GROUP BY age_group
ORDER BY age_group;

-- Attrition by Tenure (YearsAtCompany)
SELECT CASE
          WHEN YearsAtCompany = 0 THEN '0'
          WHEN YearsAtCompany BETWEEN 1 AND 3 THEN '1-3'
          WHEN YearsAtCompany BETWEEN 4 AND 7 THEN '4-7'
          ELSE '8+'
       END AS tenure_group,
       COUNT(*) AS total,
       SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS attrition_count,
       ROUND(100.0*SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)/COUNT(*),2) AS attrition_pct
FROM hr_employee
GROUP BY tenure_group
ORDER BY tenure_group;

--                                        Performance & Satisfaction

-- JobSatisfaction vs Attrition
SELECT JobSatisfaction,
       COUNT(*) AS total,
       SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS attrition_count,
       ROUND(100.0*SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)/COUNT(*),2) AS attrition_pct
FROM hr_employee
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction;

-- WorkLifeBalance vs Attrition
SELECT WorkLifeBalance,
       COUNT(*) AS total,
       SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS attrition_count,
       ROUND(100.0*SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)/COUNT(*),2) AS attrition_pct
FROM hr_employee
GROUP BY WorkLifeBalance
ORDER BY WorkLifeBalance;









