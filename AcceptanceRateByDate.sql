"""
Acceptance Rate By Date
https://platform.stratascratch.com/coding/10285-acceptance-rate-by-date?code_type=1
  
Interview Question Date: November 2020
Meta/Facebook
MediumID 10285

What is the overall friend acceptance rate by date? 
Your output should have the rate of acceptances by the date the request was sent. 
Order by the earliest date to latest.

Assume that each friend request starts by a user sending (i.e., user_id_sender) 
a friend request to another user (i.e., user_id_receiver) that's logged in the table with action = 'sent'. 
If the request is accepted, the table logs action = 'accepted'. 
If the request is not accepted, no record of action = 'accepted' is logged.
  
Table: fb_friend_requests
user_id_sender:varchar
user_id_receiver:varchar
date:datetime
action:varchar
"""
  
SELECT A.date, 
    (COUNT(B.user_id_receiver) / COUNT(A.user_id_sender)::float) AS percentage_acceptance
FROM fb_friend_requests A
LEFT JOIN fb_friend_requests B
    ON A.user_id_receiver = B.user_id_receiver
    AND A.user_id_sender = B.user_id_sender
    AND B.action = 'accepted'
WHERE A.action = 'sent'
GROUP BY A.date
ORDER BY A.date
