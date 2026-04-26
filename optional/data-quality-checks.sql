/*
Data Quality Checks for a Churn Analytics Dataset

Assumed table: customer_churn_dataset

Suggested columns:
- customer_id
- churn_flag
- customer_status
- monthly_revenue
- tenure_months
- usage_volume
- email
- phone_number
- source_system
- record_created_at
- record_updated_at

Note: Adjust table and column names according to your environment.
The SQL below is written in a mostly portable style, with a few PostgreSQL-friendly examples.
*/

-- 1. Completeness: required fields should not be null
SELECT
    COUNT(*) AS total_records,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS missing_customer_id,
    SUM(CASE WHEN churn_flag IS NULL THEN 1 ELSE 0 END) AS missing_churn_flag,
    SUM(CASE WHEN customer_status IS NULL THEN 1 ELSE 0 END) AS missing_customer_status,
    SUM(CASE WHEN monthly_revenue IS NULL THEN 1 ELSE 0 END) AS missing_monthly_revenue,
    SUM(CASE WHEN tenure_months IS NULL THEN 1 ELSE 0 END) AS missing_tenure
FROM customer_churn_dataset;

-- 2. Completeness percentage by critical field
SELECT 'customer_id' AS field_name,
       ROUND(100.0 * SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) / COUNT(*), 2) AS null_percentage
FROM customer_churn_dataset
UNION ALL
SELECT 'churn_flag',
       ROUND(100.0 * SUM(CASE WHEN churn_flag IS NULL THEN 1 ELSE 0 END) / COUNT(*), 2)
FROM customer_churn_dataset
UNION ALL
SELECT 'monthly_revenue',
       ROUND(100.0 * SUM(CASE WHEN monthly_revenue IS NULL THEN 1 ELSE 0 END) / COUNT(*), 2)
FROM customer_churn_dataset
UNION ALL
SELECT 'tenure_months',
       ROUND(100.0 * SUM(CASE WHEN tenure_months IS NULL THEN 1 ELSE 0 END) / COUNT(*), 2)
FROM customer_churn_dataset;

-- 3. Validity: churn flag should only contain expected values
SELECT churn_flag, COUNT(*) AS records
FROM customer_churn_dataset
GROUP BY churn_flag
ORDER BY records DESC;

-- Invalid churn flag values
SELECT *
FROM customer_churn_dataset
WHERE churn_flag NOT IN (0, 1)
   OR churn_flag IS NULL;

-- 4. Validity: customer status should belong to an approved catalog
SELECT customer_status, COUNT(*) AS records
FROM customer_churn_dataset
GROUP BY customer_status
ORDER BY records DESC;

-- Example allowed statuses: ACTIVE, INACTIVE, SUSPENDED, CANCELLED
SELECT *
FROM customer_churn_dataset
WHERE customer_status NOT IN ('ACTIVE', 'INACTIVE', 'SUSPENDED', 'CANCELLED')
   OR customer_status IS NULL;

-- 5. Accuracy / validity: numeric fields should be within expected ranges
SELECT *
FROM customer_churn_dataset
WHERE monthly_revenue < 0
   OR tenure_months < 0
   OR usage_volume < 0;

-- 6. Uniqueness: duplicated customer IDs
SELECT customer_id, COUNT(*) AS duplicate_count
FROM customer_churn_dataset
WHERE customer_id IS NOT NULL
GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

-- 7. Consistency: same customer with multiple active statuses
SELECT customer_id,
       COUNT(DISTINCT customer_status) AS distinct_status_count
FROM customer_churn_dataset
WHERE customer_id IS NOT NULL
GROUP BY customer_id
HAVING COUNT(DISTINCT customer_status) > 1;

-- 8. Timeliness: records not updated recently
-- Adjust interval according to business needs.
-- PostgreSQL version:
SELECT *
FROM customer_churn_dataset
WHERE record_updated_at < CURRENT_DATE - INTERVAL '7 days'
   OR record_updated_at IS NULL;

-- 9. Freshness by source system
SELECT
    source_system,
    MAX(record_updated_at) AS latest_update,
    COUNT(*) AS records
FROM customer_churn_dataset
GROUP BY source_system
ORDER BY latest_update ASC;

-- 10. Validity: basic email format check
-- PostgreSQL example using regular expression.
SELECT *
FROM customer_churn_dataset
WHERE email IS NOT NULL
  AND email !~* '^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$';

-- 11. Data profiling: distribution of revenue and tenure
SELECT
    MIN(monthly_revenue) AS min_revenue,
    MAX(monthly_revenue) AS max_revenue,
    AVG(monthly_revenue) AS avg_revenue,
    MIN(tenure_months) AS min_tenure,
    MAX(tenure_months) AS max_tenure,
    AVG(tenure_months) AS avg_tenure
FROM customer_churn_dataset;

-- 12. Outlier detection: unusually high revenue
-- Adjust threshold according to business context.
SELECT *
FROM customer_churn_dataset
WHERE monthly_revenue > 1000000;

-- 13. Churn label distribution
SELECT
    churn_flag,
    COUNT(*) AS records,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM customer_churn_dataset
GROUP BY churn_flag
ORDER BY churn_flag;

-- 14. Quality score summary by record
-- This creates a simple row-level score based on failed checks.
SELECT
    customer_id,
    (
        CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END +
        CASE WHEN churn_flag NOT IN (0, 1) OR churn_flag IS NULL THEN 1 ELSE 0 END +
        CASE WHEN customer_status NOT IN ('ACTIVE', 'INACTIVE', 'SUSPENDED', 'CANCELLED') OR customer_status IS NULL THEN 1 ELSE 0 END +
        CASE WHEN monthly_revenue IS NULL OR monthly_revenue < 0 THEN 1 ELSE 0 END +
        CASE WHEN tenure_months IS NULL OR tenure_months < 0 THEN 1 ELSE 0 END +
        CASE WHEN record_updated_at IS NULL THEN 1 ELSE 0 END
    ) AS failed_quality_checks
FROM customer_churn_dataset
ORDER BY failed_quality_checks DESC;

-- 15. Recommended next step:
-- Convert these checks into scheduled validations inside your data pipeline
-- and monitor the results using a data quality dashboard.
