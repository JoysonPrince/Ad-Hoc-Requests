# Ad-Hoc Requests: 
-- 1.  Provide the list of markets in which, the customer "Atliq Exclusive" operates its business in the APAC region
SELECT * FROM dim_customer
WHERE customer = 'Atliq Exclusive' AND region = 'APAC';

/* 2.  What is the percentage of unique product increase in 2021 vs. 2020? The final output contains these fields, 
i) unique_products_2020 
ii) unique_products_2021 
iii) percentage_chg */

# Solving with Window functions
SELECT * FROM dim_product;
WITH CTE_X AS (
SELECT DD.Fiscal_year, COUNT(DISTINCT DP.product_code) AS unique_products
FROM dim_product DP
JOIN fact_sales_monthly FSM ON FSM.product_code = DP.product_code
JOIN dim_date DD ON DD.Fiscal_year = FSM.Fiscal_year
WHERE DD.Fiscal_year IN (2020,2021)
GROUP BY DD.Fiscal_year)
SELECT *, CONCAT(ROUND(((unique_products - LAG(unique_products) OVER())/LAG(unique_products) OVER())*100,2), " %") 
AS percent_change
FROM CTE_X;
---
# Solving without using Window functions
WITH CTE_1 AS 
(SELECT DD.Fiscal_year, COUNT(DISTINCT DP.product_code) AS unique_products_FY20
FROM dim_product DP
JOIN fact_sales_monthly FSM ON FSM.product_code = DP.product_code
JOIN dim_date DD ON DD.Fiscal_year = FSM.Fiscal_year
WHERE DD.Fiscal_year = 2020),
CTE_2 AS
(SELECT DD.Fiscal_year, COUNT(DISTINCT DP.product_code) AS unique_products_FY21
FROM dim_product DP
JOIN fact_sales_monthly FSM ON FSM.product_code = DP.product_code
JOIN dim_date DD ON DD.Fiscal_year = FSM.Fiscal_year
WHERE DD.Fiscal_year = 2021)
SELECT unique_products_FY20, unique_products_FY21, 
CONCAT(ROUND(((unique_products_FY21 - unique_products_FY20)/unique_products_FY20)*100,2), " %") AS percent_change
FROM CTE_1
JOIN CTE_2 ON TRUE; 
/* Used 'ON TRUE' clause after JOIN, because both the CTE's have same columns, the only difference being
 WHERE filter clause and ALIAS */

/* 3. Provide a report with all the unique product counts for each segment and sort them in descending order of product counts.
The final output contains 2 fields: 
i) segment 
ii) product_count */

SELECT product_code, product, segment, COUNT(DISTINCT product_code) AS unique_products
FROM dim_product
GROUP BY segment
ORDER BY unique_products DESC;
--

/*  4. Follow-up: Which segment had the most increase in unique products in 2021 vs 2020? 
The final output contains these fields: 
i) segment 
ii) product_count_2020 
iii) product_count_2021
iv) % diff */
WITH CTE_A AS (
SELECT DP.segment, COUNT(DISTINCT DP.product_code) AS unique_products_FY20
FROM dim_product DP
JOIN fact_sales_monthly FSM ON FSM.product_code = DP.product_code
JOIN dim_date DD ON DD.Fiscal_year = FSM.Fiscal_year
WHERE DD.Fiscal_year = 2020
GROUP BY DP.segment, DD.Fiscal_year),
CTE_B AS (
SELECT DP.segment, COUNT(DISTINCT DP.product_code) AS unique_products_FY21
FROM dim_product DP
JOIN fact_sales_monthly FSM ON FSM.product_code = DP.product_code
JOIN dim_date DD ON DD.Fiscal_year = FSM.Fiscal_year
WHERE DD.Fiscal_year = 2021
GROUP BY DP.segment, DD.Fiscal_year)
SELECT CTE_B.segment, unique_products_FY20, unique_products_FY21,
(unique_products_FY21 - unique_products_FY20) AS difference,
ROUND(((unique_products_FY21 - unique_products_FY20)/unique_products_FY20)*100,2) AS percentage_diff
FROM CTE_B
JOIN CTE_A ON CTE_A.segment = CTE_B.segment
ORDER BY percentage_diff DESC;
--

/* 5. Get the products that have the highest and lowest manufacturing costs. The final output should contain these fields: 
i) product_code 
ii) product 
iii) manufacturing_cost */

WITH CTE_10 AS 
(SELECT DP.product_code, DP.product, ROUND(FMC.manufacturing_cost,2) AS Mfg_costs,
RANK() OVER(ORDER BY FMC.manufacturing_cost DESC) AS highest_mfg_cost,
RANK() OVER(ORDER BY FMC.manufacturing_cost ASC) AS lowest_mfg_cost
FROM fact_manufacturing_cost FMC
JOIN dim_product DP ON DP.product_code = FMC.product_code)
SELECT product_code, product, Mfg_costs
FROM CTE_10
WHERE highest_mfg_cost = 1 OR lowest_mfg_cost = 1;

--
/* 6. Generate a report which contains the top 5 customers who received an 
average high  pre_invoice_discount_pct  for the  fiscal  year 2021  and in the 
Indian  market. The final output contains these fields, 
i) customer_code 
ii) customer 
iii) average_discount_percentage */
SELECT DC.customer_code, DC.customer, ROUND(AVG(PreID.pre_invoice_discount_pct),4) AS Avg_discount
FROM fact_pre_invoice_deductions PreID
JOIN dim_customer DC ON DC.customer_code = PreID.customer_code
WHERE PreID.fiscal_year = 2021 AND DC.market = 'India'
GROUP BY DC.customer, DC.customer_code
ORDER BY Avg_discount DESC
LIMIT 5;
--

/* 7. Get the complete report of the Gross sales amount for the customer “Atliq Exclusive” for each month.  
This analysis helps to get an idea of low and high-performing months and take strategic decisions. 
The final report contains these columns: 
i) Month 
ii) Year 
iii) Gross sales Amount */

WITH CTE_30 AS 
(SELECT FSM.fiscal_year, FSM.date, fiscal_month(FSM.date) AS Fiscal_month, DC.customer, FGP.gross_price, FSM.sold_quantity,
ROUND(SUM((FGP.gross_price*FSM.sold_quantity))/1000000,2) AS Gross_Sales
FROM fact_sales_monthly FSM
JOIN fact_gross_price FGP ON FGP.product_code = FSM.product_code AND FGP.fiscal_year = FSM.Fiscal_year
JOIN dim_customer DC ON DC.customer_code = FSM.customer_code
WHERE DC.customer = 'AtliQ Exclusive'
GROUP BY FSM.fiscal_year, FSM.date)
SELECT fiscal_year, date, fiscal_month, customer, CONCAT(Gross_Sales," M") AS Gross_sales_AE
FROM CTE_30
ORDER BY fiscal_year DESC;
--


/* 8.  In which quarter of 2020, got the maximum total_sold_quantity?
The final output contains these fields sorted by the total_sold_quantity:
i) Quarter 
ii) total_sold_quantity */
SELECT date, fiscal_quarters(date) AS Fiscal_Quarters, customer_code, product_code,
CONCAT(ROUND(SUM(sold_quantity)/1000000,2), ' M') AS Total_sold_qty
FROM fact_sales_monthly
WHERE Fiscal_year = 2020
GROUP BY fiscal_quarters(date)
ORDER BY sold_quantity DESC;
--

/* 9. Which channel helped to bring more gross sales in the fiscal year 2021 & the percentage of contribution? 
The final output  contains these fields: 
i) channel ii) gross_sales_mln percentage */
WITH CTE_9 AS (
SELECT FSM.fiscal_year, DC.channel, SUM(FGP.gross_price*FSM.sold_quantity) AS Gross_Sales
FROM fact_sales_monthly FSM
JOIN fact_gross_price FGP ON FGP.product_code = FSM.product_code AND FGP.fiscal_year = FSM.Fiscal_year
JOIN dim_customer DC ON DC.customer_code = FSM.customer_code
WHERE FSM.Fiscal_year = 2021
GROUP BY DC.channel)
SELECT channel, round(Gross_Sales/1000000,2) GS_mln,
CONCAT(ROUND((Gross_sales/SUM(Gross_sales) OVER())*100,2), " %") AS Channel_contribution
-- 'Gross_Sales' for each 'channel' row is divided by the sum of all 'Gross_Sales' values across all the rows
FROM CTE_9
ORDER BY GS_mln DESC;
--


/* 10. Get the Top 3 products in each division that have highest total_sold_quantity in the fiscal_year 2021?
The final output contains these fields: 
i) division, ii) product_code, iii) product, iv) total_sold_qty, v) rank_order */
WITH CTE_10 AS 
(SELECT DP.division, DP.product_code, DP.product, DP.variant, SUM(FSM.sold_quantity) AS Total_Sold_Qty,
RANK() OVER(PARTITION BY division ORDER BY SUM(FSM.sold_quantity) DESC) AS Rank_order
-- The products are ranked in the descending order of total sold qty groupd by their partition
FROM fact_sales_monthly FSM
JOIN dim_product DP ON DP.product_code = FSM.product_code
WHERE FSM.Fiscal_year = 2021
GROUP BY DP.product_code)
SELECT *
FROM CTE_10
WHERE Rank_order IN (1,2,3);
