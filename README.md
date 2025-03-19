# Introduction

📊 Exploring the data analyst job market! This project looks at 💰 top-paying roles, 🔥 the most in-demand skills, and 📈 where high salaries and high demand come together in data analytics.

🔍 SQL queries? Check them out here: [project_sql folder](/project_sql/)

# Background

This project was created to better understand the data analyst job market, focusing on identifying top-paying and in-demand skills to help others find the best job opportunities more easily.

### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used

For my deep dive into the data analyst job market, I used several key tools:

- **SQL:** The core of my analysis, helping me extract valuable insights from the database.
- **PostgreSQL:** My database management system of choice, perfect for handling job posting data.
- **Visual Studio Code:** My primary workspace for writing and running SQL queries.
- **Git & GitHub:** Crucial for version control, sharing SQL scripts, and tracking project progress.

# The Analysis

Each query in this project focused on exploring different aspects of the data analyst job market. Here’s how I tackled each question:

### 1. Top Paying Data Analyst Jobs

To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS Company_name
FROM job_postings_fact
LEFT JOIN
    company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE (job_title_short = 'Data Analyst')
    AND (job_location = 'Anywhere')
    AND (salary_year_avg IS NOT NULL)
ORDER BY salary_year_avg DESC
LIMIT 10 ;

```

Top Data Analyst Jobs in 2023 – Key Insights:

- **Salary Range:** The top 10 highest-paying data analyst jobs offer salaries between $184,000 and $650,000, showing strong earning potential.
- **Top Employers:** Companies like SmartAsset, Meta, and AT&T offer high salaries, proving demand across different industries.
- **Job Title Variety:** Roles range from Data Analyst to Director of Analytics, highlighting different career paths in data analytics.

![Top Paying Roles](project_sql\assets_new\1_top_paying_roles.png)
_Bar graph visualizing the salary for the top 10 salaries for data analysts; ChatGPT generated this graph from my SQL query results_

### 2. Skills for Top Paying Jobs

To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

```sql
WITH top_paying_jobs AS(
    SELECT job_id,
        job_title,
        salary_year_avg,
        name AS Company_name
    FROM job_postings_fact
        LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE (job_title_short = 'Data Analyst')
        AND (job_location = 'Anywhere')
        AND (salary_year_avg IS NOT NULL)
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
SELECT top_paying_jobs.*,
    skills
FROM top_paying_jobs
    INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC ;
```

The top 10 highest-paying data analyst jobs in 2023 demand these key skills:

- **SQL** is the most in-demand, appearing in 8 out of 10 roles.
- **Python** follows closely, required in 7 roles
- **Tableau** is also highly sought after, appearing in 6 roles.
  Other skills like **R**, **Snowflake**, **Pandas**, and **Excel** show varying degrees of demand.
  ![Top Paying Skills](project_sql\assets_new\2_top_paying_roles_skills.png)

_Bar graph visualizing the count of skills for the top 10 paying jobs for data analysts; ChatGPT generated this graph from my SQL query results_

### 3. In-Demand Skills for Data Analysts

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql
SELECT skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND job_work_from_home = True
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5;
```

- **SQL** and **Excel** are still essential, highlighting the importance of strong basics in data handling and spreadsheets.
  **Programming** and **Visualization** Tools like **Python**, **Tableau**, and **Power BI** are crucial, showing the growing need for technical skills in data storytelling and decision-making.

| Skills   | Demand Count |
| -------- | ------------ |
| SQL      | 7291         |
| Excel    | 4611         |
| Python   | 4330         |
| Tableau  | 3745         |
| Power BI | 2609         |

_Table of the demand for the top 5 skills in data analyst job postings_

### 4. Skills Based on Salary

Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```sql
SELECT skills,
    ROUND(AVG(salary_year_avg), 0) AS Average_Salary --round function used to insert or delete decimal values
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY skills
ORDER BY Average_Salary DESC
LIMIT 25
```

Here's a breakdown of the results for top paying skills for Data Analysts:

- **High Demand for Big Data & ML Skills:** Analysts with expertise in big data tools (PySpark, Couchbase), machine learning platforms (DataRobot, Jupyter), and Python libraries (Pandas, NumPy) earn top salaries, highlighting the industry's focus on data processing and predictive modeling.
- **Software Development & Deployment Proficiency:** Skills in GitLab, Kubernetes, and Airflow are highly valued, showing the strong link between data analysis and engineering, especially for automation and data pipeline management.
- **Cloud Computing Expertise:** Knowledge of cloud-based tools like Elasticsearch, Databricks, and GCP is increasingly important, proving that cloud proficiency can significantly boost a data analyst’s earning potential.

| Skills        | Average Salary ($) |
| ------------- | -----------------: |
| pyspark       |            208,172 |
| bitbucket     |            189,155 |
| couchbase     |            160,515 |
| watson        |            160,515 |
| datarobot     |            155,486 |
| gitlab        |            154,500 |
| swift         |            153,750 |
| jupyter       |            152,777 |
| pandas        |            151,821 |
| elasticsearch |            145,000 |

_Table of the average salary for the top 10 paying skills for data analysts_

### 5. Most Optimal Skills to Learn

This query combined demand and salary data to identify skills that are both highly sought after and well-paid, providing a strategic focus for skill development.

```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```

| Skill ID | Skills     | Demand Count | Average Salary ($) |
| -------- | ---------- | ------------ | -----------------: |
| 8        | go         | 27           |            115,320 |
| 234      | confluence | 11           |            114,210 |
| 97       | hadoop     | 22           |            113,193 |
| 80       | snowflake  | 37           |            112,948 |
| 74       | azure      | 34           |            111,225 |
| 77       | bigquery   | 13           |            109,654 |
| 76       | aws        | 32           |            108,317 |
| 4        | java       | 17           |            106,906 |
| 194      | ssis       | 12           |            106,683 |
| 233      | jira       | 20           |            104,918 |

_Table of the most optimal skills for data analyst sorted by salary_

Here's a breakdown of the most optimal skills for Data Analysts in 2023:

- **High-Demand Programming Languages:** Python (236 jobs) and R (148 jobs) are highly sought after. Their average salaries—$101,397 for Python and $100,499 for R—show they are valuable skills, though widely available.

- **Cloud Tools and Technologies:** Snowflake, Azure, AWS, and BigQuery are in demand and offer high salaries, emphasizing the growing need for cloud and big data expertise in data analysis.

- **Business Intelligence & Visualization:** Tableau (230 jobs) and Looker (49 jobs) play a key role in data-driven decision-making, with average salaries of $99,288 and $103,795, showing the importance of BI tools.
- **Database Technologies:** Skills in Oracle, SQL Server, and NoSQL remain essential, with salaries ranging from $97,786 to $104,534, reflecting the ongoing need for database management expertise.

# What I Learned

Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- **🧩 Complex Query Crafting:** Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.
- **📊 Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
- **💡 Analytical Wizardry:** Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

# Conclusion

### Insights

From the analysis, several general insights emerged:

1. **Top-Paying Data Analyst Jobs**: The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!
2. **Skills for Top-Paying Jobs**: High-paying data analyst jobs require advanced proficiency in SQL, suggesting it’s a critical skill for earning a top salary.
3. **Most In-Demand Skills**: SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries**: Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value**: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

### Closing Thoughts

This project improved my SQL skills and gave me useful insights into the data analyst job market. The analysis helps prioritize skill development and job search strategies. Aspiring data analysts can gain a competitive edge by focusing on high-demand, high-paying skills. This study also emphasizes the need for continuous learning and staying updated with industry trends.
