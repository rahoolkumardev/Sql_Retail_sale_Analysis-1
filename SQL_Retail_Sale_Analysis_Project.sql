SELECT * FROM Retail_sale

--selecting null data form the Retail_sale
SELECT * FROM Retail_sale
WHERE 
      transactions_id is null
	  OR
	  sale_date is null
	  OR
	  sale_time is null
	  OR
	  customer_id is null
	  OR 
	  gender is null
	  OR 
	  age is null;

---retrieve all sale columns from date "2022-11-05"
SELECT * FROM Retail_sale
WHERE sale_date = '2022-11-05';

---Retrieve all transtion where product is 'clothing', gender is to be female and quantity sold more than 5 and from the daten of "Nov-22"
SELECT * FROM Retail_sale
WHERE 
     category = 'Clothing'
	 AND 
	 TO_CHAR(sale_date,'YYYY-MM') = '2022-11'
	 AND
	 gender = 'Female'
	 AND
	 quantiy >= 4;
	 
---write a query to calculate total sale (total_sale),total_order for each category
SELECT         
      category,
      SUM(total_sale) AS total_Sales,
	  COUNT(cogs) AS total_orders
FROM Retail_sale
GROUP BY category;

---average age of customer who brought product category 'beauty'
SELECT ROUND(AVG(age),2) FROM Retail_sale 
WHERE category = 'Beauty'

---Find all transtion where total sale is greater than 1000
SELECT * FROM Retail_sale 
WHERE total_sale > 1000;

---find total number of transtion made by each gender for each category
SELECT gender,category, COUNT(*) AS total_transtion
FROM Retail_sale 
GROUP BY gender, category;

---calculate the average sale of each month,find out the best selling month of the year
SELECT 
     Year,
	 month,
	 avg_sale
FROM
(
	SELECT 
	           EXTRACT(YEAR from sale_date) AS year,
		       EXTRACT(MONTH from sale_date) AS month,
			   AVG(total_sale) AS avg_sale,
			   RANK() OVER (PARTITION BY EXTRACT(YEAR from sale_date) ORDER BY AVG(total_sale) DESC)
			   FROM Retail_sale
			   GROUP BY 1,2
) AS t1
WHERE RANK = 1 

--- top 5 customer based on heighest total sales 
SELECT customer_id, SUM(total_sale) AS total_sale FROM Retail_sale
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

---unique customer who purchased item form each category
SELECT category, COUNT( DISTINCT customer_id) AS unique_customer 
FROM Retail_sale
GROUP BY 1

--- write each shift and number of order example morning <= 12, afternon  12 to 17 , night 17 >.
WITH hourly_sale
as (
SELECT *,
  CASE
	  WHEN EXTRACT(HOURS FROM sale_time) <= 12 THEN 'Morning'
	  WHEN EXTRACT(HOURS FROM Sale_time) BETWEEN 12 AND 17 THEN 'Afternoon' 
      ELSE 'Evening'
     END AS shift
	 FROM Retail_sale
)
SELECT 
  shift,
  COUNT(*)
  FROM hourly_sale
  GROUP BY shift


---End of the Project
