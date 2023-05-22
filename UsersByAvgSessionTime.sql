-- My Answers
-- Using temporary tables
-- create load table
WITH load 
AS
(
    SELECT user_id, timestamp::DATE AS date, MAX(timestamp) AS latest_load
    FROM facebook_web_log
    WHERE action = 'page_load'
    GROUP BY user_id, timestamp::DATE
),
-- create exit table
exit 
AS
(
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
WHERE e.earliest_exit >= l.latest_load
GROUP BY e.user_id;

###################################################################

--Using CTE
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
