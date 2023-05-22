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

