insert into dim_date(date_id,day,month,quarter,year,weekday_name,is_weekend)
select distinct
	d::date as date_id,
	extract(day from d)::int,
	extract(month from d)::int,
	extract(quarter from d)::int,
	extract(year from d)::int,
	to_char(d,'Day') as weekday_name,
	case 
		when 
			extract(dow from d) in (0,6) then true
		else
			false
	end as is_weekend
from
	(
		select order_date as d from staging_sales_raw
		union
		select ship_date as d from staging_sales_raw
	) as all_dates
where d is not null;

select * from dim_date;
		



INSERT INTO dim_customer (
    customer_id, customer_name, segment, country, city, state, postal_code, region
)
SELECT DISTINCT ON (customer_id)
    customer_id, customer_name, segment, country, city, state, postal_code, region
FROM staging_sales_raw
ORDER BY customer_id;

select * from dim_customer;


INSERT INTO dim_product (product_id, product_name, category, sub_category)
SELECT DISTINCT on (product_id)
	product_id, product_name, category, sub_category
FROM staging_sales_raw
order by product_id;

select * from dim_product;

INSERT INTO dim_order (order_id, order_date, ship_date, ship_mode)
SELECT DISTINCT order_id, order_date, ship_date, ship_mode
FROM staging_sales_raw;

select * from dim_order;

INSERT INTO fact_sales (order_id, product_id, customer_id, quantity, sales, discount, profit)
SELECT order_id, product_id, customer_id, quantity, sales, discount, profit
FROM staging_sales_raw;

select * from fact_sales;






