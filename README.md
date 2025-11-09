# Introduction
Welcome to my SQL Portfolio Project, where I delve into the data job market with a focus on data science roles. This project is a personal exploration into identifying the top-paying jobs, in-demand skills, and the intersection of high demand with high salary in the field of data analytics.

Check out my SQL queries here: [project_sql](https://github.com/s8korto/SQL_Project_Data_Job_Analysis/tree/main/project_sql).

# Background
The motivation behind this project stemmed from my desire to understand the data science job market better. I aimed to discover which skills are paid the most and in demand, making my job search more targeted and effective. 

The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
   
# Tools I Used
In this project, I utilized a variety of tools to conduct my analysis:

- **SQL** (Structured Query Language): Enabled me to interact with the database, extract insights, and answer my key questions through queries.
- **PostgreSQL**: As the database management system, PostgreSQL allowed me to store, query, and manipulate the job posting data.
- **Visual Studio Code:** This open-source administration and development platform helped me manage the database and execute SQL queries.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data science job market. Here’s how I approached each question:

### 1. Top Paying Data Science Jobs
To identify the highest-paying roles, I filtered data science positions by average yearly salary and location. This query highlights the high paying opportunities in the field.
```sql
--- Calculate top paying Data Scientist jobs with respective skills companies are looking for
SELECT 
    job_postings_fact.job_id,
    company_dim.name AS company_name,
    job_postings_fact.job_title,
    job_postings_fact.job_location,
    job_postings_fact.job_schedule_type,
    job_postings_fact.salary_year_avg,
    job_postings_fact.job_posted_date
FROM 
    job_postings_fact
LEFT JOIN company_dim 
    ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_postings_fact.salary_year_avg IS NOT NULL 
    AND job_postings_fact.job_title_short = 'Data Scientist'
ORDER BY 
    job_postings_fact.salary_year_avg DESC
LIMIT 15;
```
Here's the breakdown of the top data science jobs in 2023:
- **Wide Salary Range:** Top 15 paying data science roles span from $390,000 to $960,000, indicating significant salary potential in the field.
- **Diverse Employers:** Companies like East River Electric Power Cooperative, ReServe, and Selby Jennings are among those offering high salaries, showing a broad interest across different industries.

![Top Paying Roles](assets/top_paying_job.png)
*Bar graph visualizing the salary for the top 15 salaries for data science; ChatGPT generated this graph from my SQL query results*

### 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.
```sql
-- Calculate top paying Data Scientist jobs with respective skills companies are looking for
WITH top_paying_jobs AS (
SELECT 
    job_postings_fact.job_id,
    company_dim.name AS company_name,
    job_postings_fact.job_title,
    job_postings_fact.salary_year_avg
FROM 
    job_postings_fact
LEFT JOIN company_dim 
    ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_postings_fact.salary_year_avg IS NOT NULL 
    AND job_postings_fact.job_title_short = 'Data Scientist'
ORDER BY 
    job_postings_fact.salary_year_avg DESC
LIMIT 15
)
-- List skills associated with these top paying jobs
SELECT 
    top_paying_jobs.job_id,
    top_paying_jobs.company_name,
    top_paying_jobs.job_title,
    skills_dim.skills
FROM   
    top_paying_jobs
LEFT JOIN skills_job_dim
    ON top_paying_jobs.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
    salary_year_avg DESC;
```
Here's the breakdown of the most demanded skills for the highest paying data science jobs in 2023:

- The dominance of Python and SQL indicates that strong proficiency in data manipulation, analysis, and querying remains fundamental for most data science roles.
- The high demand for AWS shows that organizations increasingly rely on cloud-based data infrastructure for storage, model deployment, and analytics pipelines.
- Employers seek professionals who can collect, process, analyze, and deploy models — skills that Python, SQL, and AWS together enable efficiently.

| **Skill** | **Description**    |
|------------|-------------------|
| Python     | Programming       |
| R          | Data Analysis     |
| Excel      | Data Analysis     |
| SQL        | Database Querying |
| Spark      | Big Data          |
| AWS        | Cloud Computing   |

*Table showcasing vauable skills in demand for data science base on sql query*

### 3. In-Demand Skills for Data Science

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql
-- Calculate top paying Data Scientist jobs with respective skills companies are looking for 
WITH top_paying_jobs AS (
SELECT 
    job_postings_fact.job_id,
    company_dim.name AS company_name,
    job_postings_fact.job_title,
    job_postings_fact.salary_year_avg
FROM 
    job_postings_fact
LEFT JOIN company_dim 
    ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_postings_fact.salary_year_avg IS NOT NULL 
    AND job_postings_fact.job_title_short = 'Data Scientist'
ORDER BY 
    job_postings_fact.salary_year_avg DESC
LIMIT 15
), 

-- List skills associated with these top paying jobs
skills_dim AS 
(
SELECT 
    top_paying_jobs.job_id,
    top_paying_jobs.company_name,
    top_paying_jobs.job_title,
    skills_dim.skills
FROM   
    top_paying_jobs
LEFT JOIN skills_job_dim
    ON top_paying_jobs.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
    salary_year_avg DESC
)
-- Count the demand for each skill in these top paying Data Scientist jobs
SELECT 
    skills_dim.skills,
    COUNT(skills_dim.skills) AS demand_count 
FROM 
    skills_dim
GROUP BY 
    skills_dim.skills
ORDER BY 
    demand_count DESC;
```
Here's the breakdown of the most demanded skills for data science in 2023:
- Python leads by a significant margin, emphasizing its versatility and dominance in modern data workflows.
- SQL is close behind, reinforcing that database querying is a must-have core skill.
- R remains relevant but trails Python as industries shift to more flexible open-source ecosystems.
- SAS and Excel show continued but declining demand — valuable in certain roles but less critical for advanced analytics.

| Skills   | Demand Count |
|----------|--------------|
| Python   | 11           |
| R        | 9            |
| SQL      | 7            |
| Excel    | 4            |
| sas      | 4            |

*Table of the demand for the top 5 skills in data science job postings base on top paying job*



# What I Learned
# Conclusions
