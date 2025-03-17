SELECT job_title_short,
    salary_year_avg,
    CASE
        WHEN salary_year_avg >= 130000 THEN 'HIGH SALARY'
        WHEN salary_year_avg >= 40000 THEN 'STANDARD SALARY'
        ELSE 'LOW SALARY'
    END AS SALARY_CATEGORY
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC;