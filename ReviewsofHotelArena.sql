"""
Airbnb
Expedia
EasyID 10166


Find the number of rows for each review score earned by 'Hotel Arena'. 
Output the hotel name (which should be 'Hotel Arena'), 
review score along with the corresponding number of rows with that score for the specified hotel.
  
Table: hotel_reviews

hotel_address:varchar
additional_number_of_scoring:int
review_date:datetime
average_score:floathotel_name:varchar
reviewer_nationality:varchar
negative_review:varchar
review_total_negative_word_counts:int
total_number_of_reviews:int
positive_review:varchar
review_total_positive_word_counts:int
total_number_of_reviews_reviewer_has_given:int
reviewer_score:float
tags:varchar
days_since_review:varchar
lat:float
lng:float
"""

SELECT hotel_name, reviewer_score,
       COUNT(*) AS count
FROM hotel_reviews
WHERE hotel_name = 'Hotel Arena'
GROUP BY hotel_name, reviewer_score;
