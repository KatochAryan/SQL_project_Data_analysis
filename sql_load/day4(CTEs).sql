WITH count_of_jobs AS(
    SELECT company_id,
        COUNT(*) AS total_jobs
    FROM job_postings_fact
    GROUP BY company_id
)
SELECT company_dim.name AS company_name,
    count_of_jobs.total_jobs
FROM company_dim
    LEFT JOIN count_of_jobs ON count_of_jobs.company_id = company_dim.company_id
ORDER BY total_jobs DESC