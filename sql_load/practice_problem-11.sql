-- SELECT sd.skill_id,
--     sd.skills AS skill_name,
--     sjd.SKILL_COUNT
-- FROM skills_dim AS
--     JOIN(
--         SELECT skill_id,
--             COUNT(skill_id) AS SKILL_COUNT
--         FROM skills_job_dim
--         GROUP BY skill_id
--         LIMIT 5
--     ) AS sjd ON sd.skill_id = sjd.skill_id
-- ORDER BY sjd.SKILL_COUNT DESC
------------------------------------------------------------------
SELECT cd.name AS company_name,
    jp.POSTING_CATEGORY,
    jp.count_of_job_postings AS total_postings
FROM company_dim AS cd
    JOIN(
        SELECT jp.company_id,
            COUNT(jp.job_title_short) AS count_of_job_postings,
            CASE
                WHEN COUNT(jp.job_title_short) < 10 THEN 'SMALL'
                WHEN COUNT(jp.job_title_short) BETWEEN 10 AND 50 THEN 'MEDIUM'
                ELSE 'LARGE'
            END AS POSTING_CATEGORY
        FROM job_postings_fact AS jp
        GROUP BY jp.company_id
    ) AS jp ON cd.company_id = jp.company_id