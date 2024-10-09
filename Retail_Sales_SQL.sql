
-- -------------------- EDA ---------------------------------------------
-- Queries

-- 1) Determine the total number of records in the dataset.
select count(*) from retail_sales;

-- 2) Find out how many unique customers are in the dataset.
select count(Distinct `customer_id`) as Unique_Customer_Count from retail_sales;

-- 3) Identify all unique product categories in the dataset.
select count(distinct `category`) as Unique_Category from retail_sales;

-- 4) Check for any null values in the dataset and delete records with missing data.
select * from retail_sales
where `transactions_id` is null or sale_date is  Null or sale_time is  null or
customer_id is  Null or gender is  null or age is  null or category is  null
or quantiy is  null or price_per_unit is  null or cogs is  null or total_sale is  null;


-- 5) Extracted month Name from Sales Date

UPDATE `retail_store`.`retail_sales`
SET
`sale_month` = monthname(`sale_date`);

-- 6) Extrate Year from sale date column
UPDATE `retail_store`.`retail_sales`
SET
`sales_year` = year(`sale_date`);

-- 7)  Extracted Time of day from Sale Time Column

UPDATE `retail_store`.`retail_sales`
SET
`Time_of_day` = case 
when `sale_time` > "00:00:01" and `sale_time` < "12:00:00" Then "Morning"
when `sale_time` > "12:00:01" and `sale_time` < "17:00:00" Then "Aftenoon"
else "Evening"
end;



-- ------------------------- Business Questions -------------------------------------

-- 1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05** ?
select * from retail_sales
where `sale_date` = "2022-11-05";


-- 2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and
-- the quantity sold is more than 4 in the month of Nov-2022**:

Select *
from retail_sales
where category = "Clothing" and 
quantiy >= 4 and sale_month = "November" and sales_year = "2022"; 


-- 3. **Write a SQL query to calculate the total sales (total_sale) for each category.** ?
select category, sum(total_sale) as Sales
from retail_sales
group by 1
order by 2 Asc;

-- 4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.** ?
select  round(avg(age),2)
from retail_sales
where category = "Beauty";

-- 5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.** ?
select *
from retail_sales
where total_sale > "1000";

-- 6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.* ?
select gender, category, count(`transactions_id`) as Trans_Count
from retail_sales
group by 1,2
order by 1 asc;

-- 7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year** ?
select  sale_month,sales_year,sales
from 
(select sale_month,sales_year, avg(total_sale) as sales,
RANK() OVER(PARTITION BY sales_year ORDER BY AVG(total_sale) DESC) 
from retail_sales 
group by 1,2
);


-- 8. **Write a SQL query to find the top 5 customers based on the highest total sales ** ?
select customer_id, sum(total_sale) as Sales
from retail_sales
group by 1
order by 2 Desc
limit 5;

-- 9. **Write a SQL query to find the number of unique customers who purchased items from each category.** ?

select Category ,count(distinct customer_id) as Unique_Customers
from retail_sales
group by 1;


-- 10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)** ?
select time_of_day, count(`transactions_id`) as Order_Count
from retail_sales
group by 1;



























