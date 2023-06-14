/*In this project, I worked with a dataset ('New') that contained Airbnb listing information to answer a few key business questions. It allowed me to combine my skills in both SQL and Python, as the primary data cleaning and pre-processing were done through Python and further analysis was done through writing SQL queries.*/ 

/*Question 1: What property type is the most expensive property in this dataset? How much does it cost to rent this type of property on average?*/

select property_type, round(avg(price),2) as "average_price"
from new
group by property_type 
order by average_price desc
limit 15;

/*Question 2: What type of property is the most reasonably priced?*/

select a.property_type
from (select property_type, round(avg(price),2) as 'average_price'
      from new
      group by property_type
      order by average_price
      limit 1) as a

/*Question 3: I'd like to look for something immediately available for at least 5 nights and has the highest rating. Is it possible? If so, how much does it cost per night?*/

select listing_url, host_name, review_scores_rating, price
from new
where instant_bookable = 't' and availability_30 >= 5
and review_scores_rating in (select max(review_scores_rating)
                             from new
                             where instant_bookable = 't' and availability_30 >= 5)
order by price
