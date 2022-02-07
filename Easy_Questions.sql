##1. Find the total cost of each customer's orders. Output customer's id, first name, and the total order cost. Order records by customer's first name alphabetically.

select c.id, c.first_name, sum(o.total_order_cost) 
from customers as c, orders as o
where c.id = o.cust_id
group by c.id, c.first_name
order by c.first_name

##2. Find the details of each customer regardless of whether the customer made an order. Output the customer's first name, last name, and the city along with the order details. you may have duplicate rows in your results due to a customer ordering several of the same items. Sort records based on the customer's first name and the order details in ascending order.

select c.first_name, c.last_name, c.city, o.order_details 
from customers as c
left join orders as o
on o.cust_id=c.id
order by c.first_name, o.order_details

##3. Write a query that calculates the difference between the highest salaries found in the marketing and engineering departments. Output just the absolute difference in salaries.

select ((select max(e.salary) 
from db_employee as e
inner join db_dept as d
on e.department_id = d.id 
where d.department = 'marketing') -
(select max(e.salary) 
from db_employee as e
inner join db_dept as d
on e.department_id = d.id 
where d.department = 'engineering')) as difference

##4. We have a table with employees and their salaries, however, some of the records are old and contain outdated salary information. Find the current salary of each employee assuming that salaries increase each year. Output their id, first name, last name, department ID, and current salary. Order your list by employee ID in ascending order.

with ctesalary as (
select id, first_name, last_name, department_id, salary,Row_number() OVER ( 
		Partition BY first_name,last_name order by salary DESC
	) salary_rank 
from ms_employee_salary
)
select cte.id, cte.first_name, cte.last_name, cte.department_id,cte.salary
from ctesalary as cte
where salary_rank = 1;

##5 Find the average number of bathrooms and bedrooms for each city’s property types. Output the result along with the city name and the property type.

select city, avg(bedrooms) total_bedrooms, avg(bathrooms) as total_bathrooms,property_type 
from airbnb_search_details
group by city, property_type

##6 Meta/Facebook has developed a new programing language called Hack.To measure the popularity of Hack they ran a survey with their employees. The survey included data on previous programing familiarity as well as the number of years of experience, age, gender and most importantly satisfaction with Hack. Due to an error location data was not collected, but your supervisor demands a report showing average popularity of Hack by office location. Luckily the user IDs of employees completing the surveys were stored. Based on the above, find the average popularity of the Hack per office location. Output the location along with the average popularity.

select f.location, avg(h.popularity)
from facebook_employees as f, facebook_hack_survey as h
where f.id = h.employee_id
group by f.location

##7 Write a query to find which gender gives a higher average review score when writing reviews as guests. Use the `from_type` column to identify guest reviews. Output the gender and their average review score.

select g.gender, avg(r.review_score) as avg_review
from airbnb_reviews as r, airbnb_guests as g
where r.from_user = g.guest_id and from_type = 'guest'
group by g.gender, r.from_type
order by avg_review desc
limit 1;

##8 Find the average number of beds in each neighborhood that has at least 3 beds in total. Output results along with the neighborhood name and sort the results based on the number of average beds in descending order.

select neighbourhood, avg(beds) as avg_beds from airbnb_search_details
group by neighbourhood
having avg(beds) >= 3
order by avg_beds desc

##9 Count the number of unique facilities per municipality zip code along with the number of inspections. Output the result along with the number of inspections per each municipality zip code. Sort the result based on the number of inspections in descending order.

select facility_zip, count(*) as inspections 
from los_angeles_restaurant_health_inspections
group by facility_zip
order by inspections

##10 
