
-- Top 10 customers by profit margin 
select 
	c.customer_name,
	sum(f.sales) total_sales,
	sum(f.profit) total_profit,
	round(sum(f.profit)/nullif(sum(f.sales),0),2) profit_margin
from
	dim_customer c
join 
	fact_sales f
on
	c.customer_id=f.customer_id
group by
	c.customer_name
order by 
	profit_margin desc
limit 10;

-- Recommendation: Focus on loyalty programs or upselling on these customers

with top_cust as (
	select 
	c.customer_name,
	sum(f.sales) total_sales,
	sum(f.profit) total_profit,
	round(sum(f.profit)/nullif(sum(f.sales),0),2) profit_margin
	from
		dim_customer c
	join 
		fact_sales f
	on
		c.customer_id=f.customer_id
	group by
		c.customer_name
	order by 
		profit_margin desc
	limit 10
)
select sum(total_profit) total_profit,(avg(profit_margin)*100)::int avg_margin from top_cust;

-- Observation: The top 10 customers generated over $30,000 in profit with an average profit margin of 45%.


-- Identifying products that sell well but hurt profit margins
select 
	p.sub_category category,
	sum(f.sales) total_sales,
	sum(f.profit) total_profit,
	round(sum(f.profit)/nullif(sum(f.sales),0),2) profit_margin
from 
	dim_product p
join 
	fact_sales f
on 
	p.product_id=f.product_id
group by 
	p.sub_category
order by 
	profit_margin
limit 5;

-- Observation: Sub-category "Tables" generate $200k in sales but cause $20k in loses
-- Recommendation: Investigate pricing, reduce discounts or change vendors



-- Profit by state
select 
	c.state state,
	sum(f.sales) total_sales,
	sum(f.profit) total_profit,
	round(sum(profit)/nullif(sum(f.sales),0),2) profit_margin
from 
	dim_customer c
join 
	fact_sales f
on
	c.customer_id=f.customer_id
group by 
	c.state
order by
	profit_margin
limit 10;



-- Regions Where Losses Exceed sales
with loss_cte as (
	select 
	c.state state,
	c.city city,
	sum(f.sales) total_sales,
	sum(f.profit) total_profit,
	round(sum(profit)/nullif(sum(f.sales),0),2) profit_margin
	from 
		dim_customer c
	join 
		fact_sales f
	on
		c.customer_id=f.customer_id
	group by 
		c.state,c.city
	order by
		profit_margin
) 
select * 
from 
	loss_cte
where 
	total_sales<(total_profit)*-1;

-- Observation: California Pomona generated $5,691 in sales but caused a net loss of $6,626 resulting in a negative profit margin of 116%

select * from dim_date; 
select * from dim_order;
select * from fact_sales;

-- Monthly profit
with month_profit as(
	select 
	o.order_date date,
	sum(f.sales) total_sales,
	sum(f.profit) total_profit
	from 
		dim_order o
	join 
		fact_sales f
	on
		o.order_id=f.order_id 
	group by 
		o.order_date
)
select 
	d.year,
	d.month,
	sum(total_sales) total_sales,
	sum(total_profit) total_profit
from 
	month_profit m
join 
	dim_date d
on
	m.date=d.date_id
group by
	d.year,d.month
order by
	total_profit desc;

-- Observation: December 2016 recorded the highest monthly profit ($17.8k) and sales ($97k), indicating a strong seasonal spike — likely due to holiday shopping behavior.

select 
	round(discount,2) discount_rate,
	count(*) order_count,
	round(avg(profit),2) avg_profit
from 
	fact_sales
group by
	discount
order by 
	discount;

-- Observation: Orders with 30% and above discounts lead to negative average profit
-- Recommendation: Cap the discount at 30% or review high discount categories

WITH monthly_category_profit AS (
  SELECT 
    p.category,
    d.year,
    d.month,
    ROUND(SUM(f.sales), 2) AS total_sales,
    ROUND(SUM(f.profit), 2) AS total_profit,
    ROUND(SUM(f.profit) / NULLIF(SUM(f.sales), 0), 2) AS profit_margin
  FROM fact_sales f
  JOIN dim_product p ON f.product_id = p.product_id
  JOIN dim_order o ON f.order_id = o.order_id
  JOIN dim_date d ON o.order_date = d.date_id
  GROUP BY p.category, d.year, d.month
)
SELECT * FROM monthly_category_profit
ORDER BY total_profit desc;

-- Observation: Technology and Office Supplies categories are major profit drivers during Q4 and Q1. For example, Technology in Oct 2016 generated $11.7K in profit at a 37% margin. Office Supplies in Dec 2016 had $38K in sales and $11.4K in profit — a strong performance during the holiday season.

-- Recommendation
-- Prioritize inventory and marketing for Technology and Office Supplies during peak seasons (Oct–Mar).
-- Analyze top-selling sub-categories or products in these months to double down on what’s working.
