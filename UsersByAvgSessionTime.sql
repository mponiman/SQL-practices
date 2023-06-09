"""
# Users By Average Session Time
This question is from Meta/Facebook Inverview. 
Source: https://platform.stratascratch.com/coding/10352-users-by-avg-session-time?code_type=1

Calculate each user's average session time. A session is defined as the time difference between a page_load and page_exit. 
For simplicity, assume a user has only 1 session per day and if there are multiple of the same events on that day, consider only the latest page_load and earliest page_exit. 
Output the user_id and their average session time.

Table: facebook_web_log
user_id(int),
timestamp(datetime),
action(varchar)

Preview
| user_id |       timestamp     |    action   |
|---------|---------------------|-------------|
|    0	  | 2019-04-25 13:30:15	| page_load   |
|    0	  | 2019-04-25 13:30:18 | page_load   |
|    0	  | 2019-04-25 13:30:40 | scroll_down |
|    0	  | 2019-04-25 13:30:45 | scroll_up   |
|    0	  | 2019-04-25 13:31:10	| scroll_down |
|    0	  | 2019-04-25 13:31:25	| scroll_down |
|    0	  | 2019-04-25 13:31:40	| page_exit   | 


Hints:
- Select from the table only events that are crucial for the analysis: page load and exit
- Consider different cases that appear in the data set
- For users loading the page multiple times, assume that there is a unique page visit within the hour.
"""

-- My Answers
-- Using temporary tables
-- create load table
WITH load 
AS
(
    -- taking the date from the timestamp 
    -- use MAX to get the latest page load 
    SELECT user_id, timestamp::DATE AS date, MAX(timestamp) AS latest_load
    FROM facebook_web_log
    WHERE action = 'page_load'
    GROUP BY user_id, timestamp::DATE
),
-- create exit table
exit 
AS
(
    -- taking the date from the timestamp 
    -- use MIN to get the earliest page exit
    SELECT user_id, timestamp::DATE AS date, MIN(timestamp) AS earliest_exit  
    FROM facebook_web_log
    WHERE action = 'page_exit'
    GROUP BY user_id, timestamp::DATE
)
-- joining load and exit table
SELECT e.user_id, AVG(e.earliest_exit - l.latest_load) AS avg_session 
FROM load l
INNER JOIN exit e
ON e.user_id = l.user_id AND e.date = l.date
-- to make sure that page exit is later than page load
WHERE e.earliest_exit >= l.latest_load
GROUP BY e.user_id;

-- OR

-- Using CTE & Case When Statement
WITH CTE AS(
SELECT user_id,
timestamp::DATE AS date,
MAX(CASE WHEN action = 'page_load' THEN timestamp ELSE NULL END) AS latest_load,
MIN(CASE WHEN action = 'page_exit' THEN timestamp ELSE NULL END) AS earliest_exit
FROM facebook_web_log
GROUP BY user_id, timestamp::DATE
)

SELECT user_id, AVG(earliest_exit - latest_load) AS avg_session
FROM CTE
WHERE (earliest_exit - latest_load) IS NOT NULL 
AND earliest_exit >= latest_load
GROUP BY user_id;
