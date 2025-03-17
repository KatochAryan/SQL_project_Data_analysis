WITH JOB AS (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
)
SELECT job_title_short,
    job_location,
    salary_year_avg,
    job_posted_date::date
FROM JOB
WHERE (salary_year_avg > 70000)
    AND (job_title_short = 'Data Analyst')
ORDER BY salary_year_avg DESC