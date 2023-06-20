"""
Salaries Differences
https://platform.stratascratch.com/coding/10308-salaries-differences?code_type=1

Interview Question Date: November 2020

LinkedIn
Dropbox
Easy
ID 10308

Write a query that calculates the difference between the highest salaries found in the marketing and engineering departments. Output just the absolute difference in salaries.

Tables: db_employee, db_dept
db_employee
id:int
first_name:varchar
last_name:varchar
salary:int
department_id:int

db_dept
id:int
department:varchar
"""

SELECT 
    ABS(
    MAX(CASE WHEN b.department = 'engineering' THEN SALARY END) - 
    MAX(CASE WHEN b.department = 'marketing' THEN SALARY END)
    ) AS salary_differences
FROM db_employee a
JOIN db_dept b
ON a.department_id = b.id
