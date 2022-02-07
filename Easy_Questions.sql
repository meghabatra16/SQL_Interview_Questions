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
