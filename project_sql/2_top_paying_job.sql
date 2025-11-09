/* 
Identify top highest paying Data Scientist jobs along with required skills
Why? It provide a detailed on job in demand skills for high paying Data Scientist roles, helping job seekers align their skillset with market needs
*/

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




