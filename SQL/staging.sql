DROP TABLE IF EXISTS staging_sales_raw;

CREATE TABLE staging_sales_raw (
    row_id INT,
    order_id VARCHAR(25),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    customer_id VARCHAR(25),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code INT,
    region VARCHAR(50),
    product_id VARCHAR(25),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(300),
    sales DECIMAL(12,4),
    quantity INT,
    discount DECIMAL(5,4),
    profit DECIMAL(10,4)
);
