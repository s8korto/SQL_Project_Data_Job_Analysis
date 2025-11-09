/* 
Top 20 Highest Paying Data Scientist Jobs
This query retrieves the top 15 highest paying Data Scientist job postings
Focues on job title with salary information available
Why? Aim to highlight top paying opportunities for Data Scientists, offering insights into employment options and location flexibility
*/

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

