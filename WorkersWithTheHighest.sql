"""
# Workers With The Highest Salaries
Source: https://platform.stratascratch.com/coding/10353-workers-with-the-highest-salaries?code_type=1
Interview Question Date: June 2021

Amazon
DoorDash
Medium
ID 10353

You have been asked to find the job titles of the highest-paid employees.


Your output should include the highest-paid title or multiple titles with the same salary.

Tables: worker, title

Hints:
* Filter worker salaries to the highest salary by using an aggregate function that returns the maximum value.
* Combine the tables to output worker title(s) based on the result of the maximum value.
Edge Cases To Consider:
* First position tie: Your solution should account for the possibility that two or more employees have the same salary.

worker

worker_id:int
first_name:varchar
last_name:varchar
salary:int
joining_date:datetime
department:varchar

title

worker_ref_id:int
worker_title: varchar
affected_from: datetime
"""

SELECT worker_title AS best_paid_title
FROM title 
WHERE worker_ref_id IN 
    (SELECT worker_id 
    FROM worker
    WHERE salary = (SELECT MAX(SALARY)
                    FROM worker))
