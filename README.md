# 🛒 Retail Sales Profitability Analysis Using SQL

This project demonstrates how SQL can uncover actionable business insights from retail sales data. Using a star schema built on the Superstore dataset, I explored trends in customer profitability, product performance, discount impact, and regional losses to generate data-driven recommendations.

---

## 📊 Project Objectives

- Analyze profitability across customer segments, products, and geographies
- Identify loss-making cities and unprofitable products
- Measure discount impact on profit margins
- Uncover seasonal trends in sales and profit
- Provide actionable recommendations for business improvement

---

## 📁 Dataset

- **Source**: [Superstore Dataset (Kaggle)](https://www.kaggle.com/datasets/vivek468/superstore-dataset-final)
- **Format**: CSV (converted and loaded into a PostgreSQL database)
- **Entities**:
  - Orders
  - Products
  - Customers
  - Dates
  - Sales transactions

---

## 🗃️ Data Model

The project uses a **star schema**:
- `fact_sales`: core transaction data
- `dim_customer`: customer details
- `dim_product`: product hierarchy
- `dim_order`: order metadata
- `dim_date`: derived from order and ship dates

---

## 🧠 Key Insights & Queries

1. **Top 10 Customers by Profit Margin**
   - Identified customers with the highest profit margins across all sales.
   - 📌 *Recommendation*: Focus loyalty programs or upselling efforts on these high-value customers.

2. **Unprofitable Sub-Categories**
   - The "Tables" sub-category generated over **$200K in sales** but caused **$20K in losses**, particularly in high-discount regions like **California (West region)**.
   - 📌 *Recommendation*: Reassess pricing strategy, vendor costs, and discount thresholds for this category.

3. **Loss-Making Regions**
   - Cities such as **Pomona, CA** experienced losses exceeding sales — e.g., $5.7K in sales but $6.6K in losses.
   - 📌 *Recommendation*: Audit operations in these regions; consider logistics, return rates, or exit strategies.

4. **Monthly Profit Trends**
   - Highest profits occurred in **December 2016**, driven by holiday shopping (e.g., $97K in sales, $17.8K in profit).
   - 📌 *Recommendation*: Leverage seasonal campaigns and stock up during Q4.

5. **Discount Impact Analysis**
   - Orders with discounts **≥ 30%** resulted in **negative average profits**.
   - 📌 *Recommendation*: Cap discounts at ~25–30% or target discounts more strategically by category.

6. **Category-Wise Monthly Trends**
   - **Technology** and **Office Supplies** consistently performed best during **Q4 and Q1**, achieving up to **37% profit margins**.
   - 📌 *Recommendation*: Prioritize inventory, advertising, and promotions for these categories in peak months (Oct–Mar).

---

## 🛠️ Tech Stack

- PostgreSQL
- SQL (CTEs, Aggregations, Joins)
- Excel (for initial cleaning)
- pgAdmin / psql CLI

---

## 📈 Future Enhancements

- Visualizations in Power BI or Tableau
- Dashboard with KPIs and drilldowns
- Python ETL for automation
