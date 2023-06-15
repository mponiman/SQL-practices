"""
# Activity Rank
Source - https://platform.stratascratch.com/coding/10351-activity-rank?code_type=1

Google
Medium
ID 10351

Find the email activity rank for each user. Email activity rank is defined by the total number of emails sent. The user with the highest number of emails sent will have a rank of 1, and so on. Output the user, total emails, and their activity rank. Order records by the total emails in descending order. Sort users with the same number of emails in alphabetical order.
In your rankings, return a unique value (i.e., a unique rank) even if multiple users have the same number of emails. For tie breaker use alphabetical order of the user usernames.

Table: google_gmail_emails

Hints:
Find the total email sent by each user using the COUNT() function.

- Group records by from_user.
- Use the formula ROW_NUMBER to order records by total emails in descending order.
- Order user with the same number of emails alphabetically

google_gmail_emails

id:int
from_user:varchar
to_user:varchar
day:int
"""

SELECT from_user, COUNT(from_user) AS total_emails,
    ROW_NUMBER() OVER (ORDER BY COUNT(from_user) DESC, from_user) 
FROM google_gmail_emails
GROUP BY from_user
ORDER BY total_emails DESC, from_user;
