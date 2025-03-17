-- SELECT 
-- job_title_short,
-- company_id,
-- job_location
-- FROM january_jobs
-- UNION
-- SELECT
-- job_title_short,
-- company_id,
-- job_location
-- FROM februray_jobs
-- UNION
-- SELECT
-- job_title_short,
-- company_id,
-- job_location
-- FROM march_jobs
--------------------------------------
-- UNION ALL  INCLUDE ALL DUPLICATES ROW 
SELECT job_title_short,
    company_id,
    job_location
FROM january_jobs
UNION ALL
SELECT job_title_short,
    company_id,
    job_location
FROM februray_jobs
UNION ALL
SELECT job_title_short,
    company_id,
    job_location
FROM march_jobs