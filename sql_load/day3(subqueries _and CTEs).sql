--SUBQUERY
SELECT *
FROM(
        -- subquery starts here
        SELECT *
        FROM job_postings_fact
        WHERE EXTRACT(
                MONTH
                FROM job_posted_date
            ) = 1
    ) AS january_jobs --subquery ends here 
    --  ------------------------------------------
    --CTEs(Common Table Expressions)
    WITH january_jobs AS (
        -- CTEs Starts
        SELECT *
        FROM job_postings_fact
        WHERE EXTRACT (
                MONTH
                FROM job_posted_date
            ) = 1
    ) -- CTEs Ends here 
SELECT *
FROM january_jobs -- -------------------------------------------
SELECT company_id,
    name AS company_name
FROM company_dim
WHERE company_id IN (
        SELECT company_id
        FROM job_postings_fact
        WHERE job_no_degree_mention = TRUE
        ORDER BY company_id
    )