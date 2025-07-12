

create table dim_order(
	order_id varchar(50) primary key,
	order_date date,
	ship_date date,
	ship_mode varchar(20),
	foreign key (order_date) references dim_date (date_id),
	foreign key (ship_date) references dim_date (date_id)
);

create table dim_product(
	product_id varchar(50) primary key,
	product_name varchar(300),
	category varchar(50),
	sub_category varchar(50)
);

create table dim_customer(
	customer_id varchar(50) primary key,
	customer_name varchar(100),
	segment varchar(50),
	country varchar(50),
	city varchar(50),
	state varchar(50),
	postal_code int,
	region varchar(100)
);

create table fact_sales(
	order_id varchar(50),
	product_id varchar(50),
	customer_id varchar(50),
	quantity int,
	sales int,
	discount decimal(5,4),
	profit decimal(10,4),
	foreign key (order_id) references dim_order(order_id),
	foreign key (product_id) references dim_product(product_id),
	foreign key (customer_id) references dim_customer(customer_id)
);