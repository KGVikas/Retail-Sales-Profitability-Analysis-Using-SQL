select * from staging_sales_raw limit 10;

DELETE FROM staging_sales_raw
WHERE order_id IS NULL OR product_id IS NULL OR customer_id IS NULL;

update staging_sales_raw
set ship_mode=trim(ship_mode),
	customer_name=trim(customer_name),
	segment=trim(segment),
	product_name=trim(product_name),
	category=trim(category),
	sub_category=trim(sub_category);


alter table staging_sales_raw
alter column discount type numeric(5,2);



