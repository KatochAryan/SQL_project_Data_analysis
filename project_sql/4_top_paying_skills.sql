/*
 Answer: What are the top skills based on salary?
 - Look at the average salary associated with each skill for Data Analyst positions
 Focuses on roles with specified salaries, regardless of location
 - Why? It reveals how different skills impact salary levels for Data Analysts and
 helps identify the most financially rewarding skills to acquire or improve
 */
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
    /*
     Here are some quick insights and trends based on the top 25 highest-paying skills for Data Analysts:
     
     🔹 1. Big Data & Cloud Skills Dominate High Salaries
     PySpark ($208K), Databricks ($141K), and Google Cloud Platform (GCP) ($122K) are among the highest-paying skills.
     This suggests that big data technologies and cloud-based data processing are in high demand.
     🔹 2. AI & Machine Learning Tools Pay Well
     DataRobot ($155K), Scikit-learn ($125K), and Numpy/Pandas ($143K/$151K) are commonly used in ML workflows.
     Employers value ML model development, automation, and AI-driven analytics.
     🔹 3. DevOps & Version Control Knowledge is Valuable
     Bitbucket ($189K), GitLab ($154K), Jenkins ($125K), and Kubernetes ($132K) are all DevOps-related.
     This indicates that companies prefer data analysts with strong version control and CI/CD knowledge.
     🔹 4. Programming & Scripting Languages Are Essential
     Swift ($153K), Golang ($145K), Scala ($124K), and PostgreSQL ($123K) are top earners.
     Learning multiple programming languages (Python, Scala, SQL) can increase salary potential.
     🔹 5. Data Engineering & ETL Tools Pay High
     Airflow ($126K) and Elasticsearch ($145K) show that ETL pipelines and search-based analytics are well-paid.
     
     [
     {
     "skills": "pyspark",
     "average_salary": "208172"
     },
     {
     "skills": "bitbucket",
     "average_salary": "189155"
     },
     {
     "skills": "couchbase",
     "average_salary": "160515"
     },
     {
     "skills": "watson",
     "average_salary": "160515"
     },
     {
     "skills": "datarobot",
     "average_salary": "155486"
     },
     {
     "skills": "gitlab",
     "average_salary": "154500"
     },
     {
     "skills": "swift",
     "average_salary": "153750"
     },
     {
     "skills": "jupyter",
     "average_salary": "152777"
     },
     {
     "skills": "pandas",
     "average_salary": "151821"
     },
     {
     "skills": "elasticsearch",
     "average_salary": "145000"
     },
     {
     "skills": "golang",
     "average_salary": "145000"
     },
     {
     "skills": "numpy",
     "average_salary": "143513"
     },
     {
     "skills": "databricks",
     "average_salary": "141907"
     },
     {
     "skills": "linux",
     "average_salary": "136508"
     },
     {
     "skills": "kubernetes",
     "average_salary": "132500"
     },
     {
     "skills": "atlassian",
     "average_salary": "131162"
     },
     {
     "skills": "twilio",
     "average_salary": "127000"
     },
     {
     "skills": "airflow",
     "average_salary": "126103"
     },
     {
     "skills": "scikit-learn",
     "average_salary": "125781"
     },
     {
     "skills": "jenkins",
     "average_salary": "125436"
     },
     {
     "skills": "notion",
     "average_salary": "125000"
     },
     {
     "skills": "scala",
     "average_salary": "124903"
     },
     {
     "skills": "postgresql",
     "average_salary": "123879"
     },
     {
     "skills": "gcp",
     "average_salary": "122500"
     },
     {
     "skills": "microstrategy",
     "average_salary": "121619"
     }
     ]
     */