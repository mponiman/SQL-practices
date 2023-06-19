"""
New Products
https://platform.stratascratch.com/coding/10318-new-products?code_type=1

Interview Question Date: December 2020
Salesforce
Tesla
MediumID 10318

You are given a table of product launches by company by year. 
Write a query to count the net difference between the number of products companies launched in 2020 
with the number of products companies launched in the previous year. 
Output the name of the companies and a net difference of net products released for 2020 compared to the previous year.

Table: car_launches
year:int
company_name:varchar
product_name:varchar
"""

SELECT company_name, 
    COUNT(CASE WHEN year = 2020 then 1 ELSE NULL END) - 
    COUNT(CASE WHEN year = 2019 then 1 ELSE NULL END) AS net_difference
FROM car_launches
GROUP BY company_name;
