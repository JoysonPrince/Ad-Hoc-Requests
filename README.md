# **AtliQ Hardware: Consumer goods Ad-Hoc Requests:**



Problem Statement: Provide insights to the management in Consumer Goods Domain

Domain: Consumer Goods | Function: Executive Management

AtliQ Hardwares is one of the leading computer hardware producers in India and well expanded in other countries too.

However, the management noticed that they do not get enough insights to make quick and smart data-informed decisions. 
They want to expand their data analytics team by adding several junior data analysts.

Ad-Hoc Requests: 

***Ad-Hoc:*** 
-- It is nothing but the process of performing analysis on-the-fly or as needed, typically without a pre-defined plan or structure.
-- It involves examining data or information to answer specific questions or address immediate needs, often using tools like spreadsheets, databases or specialized software.
-- Ad-Hoc analysis allows for flexibility and agility in exploring data to gain insights or make decisions.*


**Data description:**
This is the list of tables in the dataset:

![List of tables gdb0041](https://github.com/JoysonPrince/Ad-Hoc-Requests/assets/137388224/90575cb6-8a9c-4bb5-bf69-eac72805d9f5)





*Request 1:* Provide the list of markets in which customer "Atliq  Exclusive" operates its business in the  APAC  region. 

![Req1](https://github.com/JoysonPrince/Ad-Hoc-Requests/assets/137388224/b4cbefc2-f615-4364-854a-7fab706cf631)





![Atliq Excl markets](https://github.com/JoysonPrince/Ad-Hoc-Requests/assets/137388224/1169ae7c-c258-4cfc-9472-1b16d81d6d14)






*Request 2:* What is the percentage of unique product increase in 2021 vs 2020?
   The final output should contain these fields:
   i) unique_products_2020  (-- Finding the number of new/unique products released in FY2020)
   ii) unique_products_2021 (-- Finding the number of new/unique products released in FY2021)
   iii) percentage_change


![Req2 with double CTEs](https://github.com/JoysonPrince/Ad-Hoc-Requests/assets/137388224/1abfae6e-d8ba-4c8f-869c-3c17fc0c0c22)





![Req1](https://github.com/JoysonPrince/Ad-Hoc-Requests/assets/137388224/7cc5cb37-fc40-49d4-a1b4-8867ada78c88)





![Req2](https://github.com/JoysonPrince/Ad-Hoc-Requests/assets/137388224/d1c8d870-3852-4f86-ac91-cbf6c301fd0e)






*Request 3:* Provide a report with all the unique product counts for each segment and sort them in descending order of product counts.
The final output contains 2 fields: 
i) segment 
ii) product_count



![Req3](https://github.com/JoysonPrince/Ad-Hoc-Requests/assets/137388224/06018f36-9bff-44ae-8643-52e4dd8f3fc4)





![Req3](https://github.com/JoysonPrince/Ad-Hoc-Requests/assets/137388224/a5f6c487-556d-40a3-afbe-3470196c54a6)






*Request 4:* Follow-up: Which segment had the most increase in unique products in 2021 vs 2020? 
The final output contains these fields: 
i) segment 
ii) product_count_2020 
iii) product_count_2021
iv) % diff
v) difference

![Req4](https://github.com/JoysonPrince/Ad-Hoc-Requests/assets/137388224/f59550a1-644b-4e23-a82c-d51e0c2c32aa)





![Req4](https://github.com/JoysonPrince/Ad-Hoc-Requests/assets/137388224/8d5099de-2faf-473a-ae54-ccf14bb513f4)






*Request 5:* Get the products that have the highest and lowest manufacturing costs. The final output should contain these fields: 
i) product_code 
ii) product 
iii) manufacturing_cost

![Req5](https://github.com/JoysonPrince/Ad-Hoc-Requests/assets/137388224/3d6de9c7-1a00-4c3d-aea3-52e26b53e4c1)





![Req5](https://github.com/JoysonPrince/Ad-Hoc-Requests/assets/137388224/77fc7df8-9821-4b4e-94a8-5208afcf4739)






*Request 6:* Generate a report which contains the top 5 customers who received an average highest pre_invoice_discount_pct for the fiscal year 2021 and in the 
Indian  market. 
The final output should contain these fields, 
i) customer_code 
ii) customer 
iii) average_discount_percentage


![Req6](https://github.com/JoysonPrince/Ad-Hoc-Requests/assets/137388224/fd74a9e3-629b-4cec-92aa-04a57bce288a)





![Req6](https://github.com/JoysonPrince/Ad-Hoc-Requests/assets/137388224/ad610d97-fa58-48fa-a2f4-4615c51b9056)





*Request 7:* Get the complete report of the Gross sales amount for the customer “Atliq Exclusive” for each month.  
This analysis helps to get an idea of low and high-performing months and take strategic decisions. 
The final report should contain these fields:
i) Month 
ii) Year 
iii) Gross sales Amount


![Req7](https://github.com/JoysonPrince/Ad-Hoc-Requests/assets/137388224/63877422-3092-4276-8547-164ddaf2de59)





![Req7](https://github.com/JoysonPrince/Ad-Hoc-Requests/assets/137388224/53b1699b-055d-493f-8271-8cbfaa265b89)





*Request 8:* In which quarter of 2020, got the maximum total_sold_quantity?
The final output should contain these fields sorted by the total_sold_quantity:
i) Quarter 
ii) total_sold_quantity


![Req8](https://github.com/JoysonPrince/Ad-Hoc-Requests/assets/137388224/b2e58f53-8e72-4503-b1c3-280ed5dbc78f)





![Req8](https://github.com/JoysonPrince/Ad-Hoc-Requests/assets/137388224/f8ede85d-f45c-4919-b7c5-b19a52802c71)






*Request 9:* Which channel helped to bring more gross sales in the fiscal year 2021 & the percentage of contribution? 
The final output should contain these fields: 
i) channel ii) gross_sales_mln percentage


![Req9](https://github.com/JoysonPrince/Ad-Hoc-Requests/assets/137388224/7ee0274c-5833-4bd7-8a40-55236c3c53e7)





![Req9](https://github.com/JoysonPrince/Ad-Hoc-Requests/assets/137388224/331c35b5-06f3-4059-9fae-6576e4b14a3a)






*Request 10:* Get the Top 3 products in each division that have highest total_sold_quantity in the fiscal_year 2021?
The final output contains these fields: 
i) division, ii) product_code, iii) product, iv) total_sold_qty, v) rank_order


![Req10](https://github.com/JoysonPrince/Ad-Hoc-Requests/assets/137388224/01333240-e5bc-42a8-9032-803d2f6ab7cd)






![Req10 N S div](https://github.com/JoysonPrince/Ad-Hoc-Requests/assets/137388224/b7818146-a803-4788-addf-9f693a9d5056)





![Req10 P A div](https://github.com/JoysonPrince/Ad-Hoc-Requests/assets/137388224/131a168c-c4aa-4bd2-85e7-140675fc4082)





![Req10 PC div](https://github.com/JoysonPrince/Ad-Hoc-Requests/assets/137388224/c879c765-c33f-400e-a9c4-7c970abb7f6d)






**Concepts learnt:**
1. Leveraging Common Table Expressions (CTEs), multi-table JOINs, Aggregate functions, and Window functions extensively to enhance query efficiency and data manipulation capabilities.
2. Employing query optimization strategies to minimize fetch time, including the implementation of a manually curated date table (dim_date) for streamlined data retrieval and analysis.
3. Demonstrating proficient utilization of user-defined functions to enhance query flexibility, maintainability, and code modularity within the database environment


