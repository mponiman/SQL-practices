"""
Find the number of Apple product users and the number of total users with a device and group the counts by language. 
Assume Apple products are only MacBook-Pro, iPhone 5s, and iPad-air. 
Output the language along with the total number of Apple users and users with any device. 
Order your results based on the number of total users in descending order.

Tables: playbook_events, playbook_users

playbook_events
user_id:int
occurred_at:datetime
event_type:varchar
event_name:varchar
location:varchar
device:varchar

playbook_users
user_id:int
created_at:datetime
company_id:int
language:varchar
activated_at:datetime
state:varchar
"""

SELECT pu.language, 
    COUNT(DISTINCT CASE 
        WHEN device IN ('macbook pro', 'iphone 5s', 'ipad air') 
        THEN pu.user_id
        ELSE NULL
        END) AS n_apple_users,
    COUNT(DISTINCT pu.user_id) AS n_total_users
        
FROM playbook_users pu
INNER JOIN playbook_events pe 
ON pu.user_id = pe.user_id
GROUP BY pu.language
ORDER BY n_total_users DESC
