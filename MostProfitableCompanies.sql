"""
Most Profitable Companies
https://platform.stratascratch.com/coding/10354-most-profitable-companies?code_type=1

Forbes
Medium
ID 10354

Find the 3 most profitable companies in the entire world.
Output the result along with the corresponding company name.
Sort the result based on profits in descending order.

Table: forbes_global_2010_2014

company: varchar
sector: varchar
industry: varchar
continent: varchar
country: varchar
marketvalue: float
sales: float 
profits: float
assets: float
rank: int
forbeswebpage: varchar
"""

SELECT company, profits
FROM
(
SELECT company, profits, 
        RANK() OVER(ORDER BY profits DESC) AS ranking
FROM forbes_global_2010_2014
) a
WHERE ranking < 4
ORDER BY profits desc
