"""
Top Percentile Fraud
https://platform.stratascratch.com/coding/10303-top-percentile-fraud?code_type=1

Interview Question Date: November 2020
Google
Netflix
HardID 10303

ABC Corp is a mid-sized insurer in the US and in the recent past their fraudulent claims 
have increased significantly for their personal auto insurance portfolio. 
They have developed a ML based predictive model to identify propensity of fraudulent claims. 
Now, they assign highly experienced claim adjusters for top 5 percentile of claims identified by the model.

Your objective is to identify the top 5 percentile of claims from each state. 
Your output should be policy number, state, claim cost, and fraud score.

Table: fraud_score
policy_num:varchar
state:varchar
claim_cost:int
fraud_score:float
"""

With CTE AS(
SELECT *,
    NTILE (100) OVER(PARTITION BY state ORDER BY fraud_score DESC) AS percentile
FROM fraud_score
)

SELECT policy_num, state, claim_cost, fraud_score
FROM CTE
WHERE percentile <= 5

"OR"
SELECT policy_num, state, claim_cost, fraud_score
FROM 
(
  SELECT *,
      NTILE (100) OVER(PARTITION BY state ORDER BY fraud_score DESC) AS percentile
  FROM fraud_score
) rank
WHERE percentile <=5

