"""
Finding User Purchases


Interview Question Date: December 2020

Amazon
Medium
ID 10322

Write a query that'll identify returning active users. 
A returning active user is a user that has made a second purchase within 7 days of any other of their purchases. 
Output a list of user_ids of these returning active users.

Table: amazon_transactions

Hints:
- For each row, join rows respresenting following events on the left side of the join
- For each pair of events calculate the difference in days
- Filter events that have less then 8 days break

amazon_transactions

id:int
user_id:int
item:varchar
created_at:datetime
revenue:int
"""

SELECT DISTINCT(a.user_id)
FROM amazon_transactions a
JOIN amazon_transactions b
    ON a.user_id = b.user_id AND a.id != b.id
WHERE ABS(a.created_at - b.created_at) < 8 

"OR"

WITH lag AS(
    SELECT user_id, created_at - LAG(created_at) OVER(PARTITION BY user_id ORDER BY created_at ASC) AS lag_time
    FROM amazon_transactions
    )
        
SELECT DISTINCT(user_id)
FROM lag
WHERE abs(lag_time) < 8 
ORDER BY user_id;

