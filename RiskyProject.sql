"""
Risky Projects

Interview Question Date: November 2020
LinkedIn
MediumID 10304
Data Engineer
Data Scientist
BI Analyst
Data Analyst
ML Engineer

Identify projects that are at risk for going overbudget. A project is considered to be overbudget if the cost of all employees assigned to the project is greater than the budget of the project.

You'll need to prorate the cost of the employees to the duration of the project. For example, if the budget for a project that takes half a year to complete is $10K, then the total half-year salary of all employees assigned to the project should not exceed $10K. Salary is defined on a yearly basis, so be careful how to calculate salaries for the projects that last less or more than one year.

Output a list of projects that are overbudget with their project name, project budget, and prorated total employee expense (rounded to the next dollar amount).

HINT: to make it simpler, consider that all years have 365 days. You don't need to think about the leap years.
Tables: linkedin_projects, linkedin_emp_projects, linkedin_employees

linkedin_projects
id:int
title:varchar
budget:int
start_date:datetime
end_date:datetime

linkedin_emp_projects
emp_id:int
project_id:int

linkedin_employees
id:int
first_name:varchar
last_name:varchar
salary:int
"""

-- prorated_employee_expense is calculated as: sum of salary employee per year * duration/365

" Long version " 
SELECT title, budget, CEILING((employee_expense /365 * days)) AS prorated_employee_expense
FROM
(
SELECT id, title, budget, (end_date - start_date) AS days
FROM linkedin_projects
) a
JOIN
(
SELECT project_id, SUM(salary) AS employee_expense
FROM linkedin_employees emp
FULL JOIN linkedin_emp_projects pro
ON emp.id = pro.emp_id
GROUP BY pro.project_id
) b
ON a.id = b.project_id
WHERE ROUND((employee_expense /365 * days)) > budget
ORDER BY title;

" Short version "

SELECT title, budget, 
    CEILING(SUM(salary * ((end_date - start_date)::decimal / 365))) AS prorated_employee_expense
FROM linkedin_projects p
    JOIN linkedin_emp_projects ep ON p.id = ep.project_id 
    JOIN linkedin_employees e ON ep.emp_id = e.id
GROUP BY title, budget
HAVING CEILING(SUM(salary * ((end_date - start_date)::decimal / 365))) > budget
ORDER BY title;

