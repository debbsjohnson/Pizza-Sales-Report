create table pizza_sales (
	pizza_id int,
	order_id int,
	pizza_name_id varchar(40),
	quantity int,
	order_date varchar(40),
	order_time time,
	unit_price float,
	total_price float,
	pizza_size varchar(20),
	pizza_category varchar(40),
	pizza_ingredients varchar(150),
	pizza_name varchar(80)
);

select * from pizza_sales;

-- Total Revenue: The sum of the total price of pizzas
select sum(total_price) as Total_Revenue from pizza_sales;


-- Average Order Value: the average amount spent per order, calculated
-- by dividing the total revenue by the total number of orders
select sum(total_price) / count(distinct order_id) as Avg_Order_Value from pizza_sales;

-- Total Pizzas Sold: The sum of the quantities of pizzas sold
select sum(quantity) as Total_Pizza_Sold from pizza_sales;

-- Total Orders: the total number of orders placed 
select count(distinct order_id) as Total_Orders from pizza_sales;

-- Average Pizzas per Order: The average number of pizzas sold per order,
-- calculated by dividing the total number of pizzas sold by the total
-- number of orders
select cast(cast(sum(quantity) as decimal (10,2)) / 
cast(count(distinct order_id) as decimal (10,2)) as decimal (10,2))
as Avg_Pizzas_Per_Order
from pizza_sales;




-- Hourly Trend For Total Pizzas Sold
select extract(hour from order_time) as order_hour, sum(quantity) as Total_Pizzas_Sold 
from pizza_sales
group by extract(hour from order_time)
order by extract(hour from order_time);


-- Weekly Trend For Total Orders
set datestyle = 'ISO, DMY';

select
  TO_CHAR(to_date(order_date, 'DD-MM-YYYY'), 'IYYY') as Order_Year,
  TO_CHAR(to_date(order_date, 'DD-MM-YYYY'), 'IW') as Week_Number,
  count(distinct order_id) as Total_Orders
from
  pizza_sales
group by
  TO_CHAR(to_date(order_date, 'DD-MM-YYYY'), 'IYYY'),
  TO_CHAR(to_date(order_date, 'DD-MM-YYYY'), 'IW')
order by
  TO_CHAR(to_date(order_date, 'DD-MM-YYYY'), 'IYYY'),
  TO_CHAR(to_date(order_date, 'DD-MM-YYYY'), 'IW');



SET datestyle = 'ISO, DMY';

-- Your query
SELECT
  TO_CHAR(to_date(order_date, 'DD-MM-YYYY'), 'IYYY') AS Order_Year,
  TO_CHAR(to_date(order_date, 'DD-MM-YYYY'), 'IW') AS Week_Number,
  COUNT(DISTINCT order_id) AS Total_Orders
FROM
  pizza_sales
GROUP BY
  TO_CHAR(to_date(order_date, 'DD-MM-YYYY'), 'IYYY'),
  TO_CHAR(to_date(order_date, 'DD-MM-YYYY'), 'IW')
ORDER BY
  TO_CHAR(to_date(order_date, 'DD-MM-YYYY'), 'IYYY'),
  TO_CHAR(to_date(order_date, 'DD-MM-YYYY'), 'IW');


-- Percentage of Sales by Pizza Category
select pizza_category, sum(total_price) as Total_Sales, sum(total_price) * 100 / 
(select sum(total_price) from pizza_sales)
as PCT_Sales from pizza_sales
group by pizza_category;



-- select pizza_category, sum(total_price) as Total_Sales, sum(total_price) * 100 / 
-- (select sum(total_price) from pizza_sales)
-- as PCT_Sales from pizza_sales
-- where extract(month from order_date::date) = 1
-- group by pizza_category;



-- Percentage of Sales by Pizza Size
select pizza_size, cast(sum(total_price) as decimal (10,2)) as Total_Sales, cast(sum(total_price) * 100 / 
(select sum(total_price) from pizza_sales) as decimal (10,2))
as PCT_Sales from pizza_sales
group by pizza_size
order by PCT_Sales desc;

-- for quarter
select pizza_size, cast(sum(total_price) as decimal (10,2)) 
as Total_Sales, cast(sum(total_price) * 100 / 
(select sum(total_price) from pizza_sales where 
 extract(quarter from order_date::date) = 1) as decimal (10,2))
as PCT_Sales from pizza_sales
where extract(quarter from order_date::date) = 1
group by pizza_size
order by PCT_Sales desc;


-- Top 5 Best Sellers by Revenue, Total Quantity and Total Orders
select pizza_name, sum(total_price) as Total_Rev from pizza_sales
group by pizza_name
order by Total_Rev desc
limit 5;


-- Bottom 5 Best Sellers by Revenue, Total Quantity and Total Orders
select pizza_name, sum(total_price) as Total_Rev from pizza_sales
group by pizza_name
order by Total_Rev asc
limit 5;



-- Top 5 Best Sellers by Total Quantity
select pizza_name, sum(quantity) as Total_Qty from pizza_sales
group by pizza_name
order by Total_Qty desc
limit 5;

-- Bottom 5 Best Sellers by Total Quantity
select pizza_name, sum(quantity) as Total_Qty from pizza_sales
group by pizza_name
order by Total_Qty asc
limit 5;


-- Top 5 Best Sellers by Total Orders
select pizza_name, count(distinct order_id) as Total_Ord from pizza_sales
group by pizza_name
order by Total_Ord desc
limit 5;


-- Bottom 5 Best Sellers by Total Orders
select pizza_name, count(distinct order_id) as Total_Ord from pizza_sales
group by pizza_name
order by Total_Ord asc
limit 5;













