"""
Number Of Units Per Nationality
https://platform.stratascratch.com/coding/10156-number-of-units-per-nationality?code_type=1

Airbnb
MediumID 10156

Find the number of apartments per nationality that are owned by people under 30 years old.

Output the nationality along with the number of apartments.

Sort records by the apartments count in descending order.
Tables: airbnb_hosts, airbnb_units

airbnb_hosts
host_id:int
nationality:varchar
gender:varchar
age:int

airbnb_units
host_id:int
unit_id:varchar
unit_type:varchar
n_beds:int
n_bedrooms:int
country:varchar
city:varchar
"""

SELECT 
    nationality, 
    COUNT(DISTINCT unit_id) AS apartment_count
FROM airbnb_hosts h
INNER JOIN airbnb_units u
    ON h.host_id = u.host_id
WHERE u.unit_type = 'Apartment'
AND h.age < 30
GROUP BY h.nationality
ORDER BY apartment_count DESC;

