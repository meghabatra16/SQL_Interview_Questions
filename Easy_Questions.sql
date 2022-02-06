##1. Find the total cost of each customer's orders. Output customer's id, first name, and the total order cost. Order records by customer's first name alphabetically.

select c.id, c.first_name, sum(o.total_order_cost) 
from customers as c, orders as o
where c.id = o.cust_id
group by c.id, c.first_name
order by c.first_name

##2. Find the details of each customer regardless of whether the customer made an order. Output the customer's first name, last name, and the city along with the order details.
You may have duplicate rows in your results due to a customer ordering several of the same items. Sort records based on the customer's first name and the order details in ascending order.

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

##4. 
