-- SELECT* from skills_dim
-- select *from skills_job_dim
WITH Remote_job_skills AS (
    SELECT skill_id,
        COUNT(*) AS SKILL_COUNT
    from skills_job_dim AS sjd
        INNER JOIN job_postings_fact AS jp ON jp.job_id = sjd.job_id
    WHERE (jp.job_work_from_home = True)
        AND (jp.job_title_short = 'Data Analyst')
    GROUP BY sjd.skill_id
)
SELECT sd.skill_id,
    skills AS skill_name,
    SKILL_COUNT
FROM Remote_job_skills
    INNER JOIN skills_dim AS sd ON sd.skill_id = Remote_job_skills.skill_id
ORDER BY SKILL_COUNT DESC
LIMIT 5