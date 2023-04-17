-- 1. Total number of product in the dataset

SELECT COUNT(product_id) FROM `Ecommerce Database`.kz;

-- 2.The highest priced category from the ecommerce dataset

SELECT category_code, MAX(Price) AS max_price
FROM `Ecommerce Database`.kz
GROUP BY category_code
ORDER BY max_price DESC ; 

-- 3. What is the average price of the products within the dataset 

SELECT ROUND(AVG(price),2)
FROM `Ecommerce Database`.kz

-- 4. How many DISTINCT user Id are there in the dataset

SELECT COUNT(DISTINCT(user_id))
FROM `Ecommerce Database`.kz; 

-- Answer is 40790
5. How many products are from apple, Samsung

SELECT COUNT(*)
FROM `Ecommerce Database`.kz
WHERE brand = 'apple'; 

-- Answer is 2981

-- 6. Which brand has the highest number of products?

SELECT COUNT(*), brand
FROM `Ecommerce Database`.kz
GROUP BY brand
HAVING COUNT('apple' 'samsung' 'huawei')
ORDER BY COUNT(*) DESC

-- Answer is Samsung with 11070 
-- 7. What is the difference between the dates (in days) in the dataset

SELECT MAX(event_time),
	   MIN(event_time)
FROM `Ecommerce Database`.kz

SELECT event_time
FROM`Ecommerce Database`.kz
ORDER BY event_time DESC; 

SELECT DATEDIFF("2020-07-08", "1970-01-01") 

-- Answer is 18451 days

-- 8. The number of unique users who have made purchases of Apple products 

SELECT COUNT(DISTINCT(user_id))
FROM `Ecommerce Database`.kz
WHERE brand = 'apple'

-- Answer is 2488

-- 9. What is the length of the product, category and order IDs

SELECT LENGTH(order_id),
       LENGTH(product_id),
       LENGTH(category_id)
FROM `Ecommerce Database`.kz;

-- Answer to all: 19. 

-- 10. Categorize products by price range

SELECT category_code, price,
     CASE 
       WHEN price < 148 THEN 'Under Average Price'
       WHEN price > 148 THEN 'Above Average Price'  
       ELSE 'NULL'
       END AS price_range
FROM `Ecommerce Database`.kz
ORDER BY price

-- $148 was the average price in the dataset. Anything under or over were named accordingly. 

-- 11. What was the purchase value from  Apple, Samsung & Huawei?

SELECT brand, ROUND(SUM(price),2) AS total_price
FROM `Ecommerce Database`.kz
GROUP BY brand
HAVING brand IN ('samsung', 'apple','huawei')
￼
-- Answer is: 
-- samsung -> $2808420.96
-- huawei -> $383008.04
-- apple -> $1784176.42

-- 12. Smartphone sales across brands

SELECT ROUND(SUM(price),2) AS total_price
FROM `Ecommerce Database`.kz

SELECT brand, ROUND(SUM(price),2) AS total_price FROM `Ecommerce Database`.kz
WHERE category_code = 'electronics.smartphone'
GROUP BY bran

-- You can then use to find the percentage of revenue of smartphone per brand from the total price of all products
￼

-- 13. Using subquery to find all tables results for the brand Samsung
SELECT *
FROM `Ecommerce Database`.kz
WHERE brand IN (SELECT brand 
FROM `Ecommerce Database`.kz
WHERE brand = 'samsung'
)

The subquery within the parentheses returns all the distinct brand names that are equal to "samsung". 
The outer query then uses this list of brand names to filter the results and returns all the rows that have a brand name that matches any of the names in the subquery.

-- 14. A temp table with some columns names and then select all to view results 

WITH temp_table AS (SELECT order_id, 
       category_code, 
	   price,
       brand
FROM `Ecommerce Database`.kz
)
SELECT *
FROM temp_table

-- 15. Create Procedure

DELIMITER $$

CREATE PROCEDURE apple_products()
BEGIN
   SELECT * 
   FROM `Ecommerce Database`.kz
   WHERE brand = 'apple'
END 

DELIMITER $$

-- 16. UPDATE TABLE

UPDATE `Ecommerce Database`.kz
  SET category_code = null
WHERE category_code = ‘’  

Fills all the blank spaces with null values. 

-- 17. Group records by date (top 10)
SELECT DATE(event_time) AS date, COUNT(*) AS count 
FROM `Ecommerce Database`.kz
GROUP BY date
LIMIT 10;
￼

-- This query groups records by date and counts the number of records for each date.

-- 18. Top 10 products bought and their respective brands. 

SELECT category_code, brand, COUNT(*)AS total_count
FROM `Ecommerce Database`.kz
WHERE category_code IS NOT NULL
GROUP BY category_code, brand
ORDER BY total_count DESC
LIMIT 10;
 
￼
-- 19. Find the user ID with the highest total purchase amount

SELECT user_id
FROM `Ecommerce Database`.kz
GROUP BY user_id 
ORDER BY SUM(price) DESC
LIMIT 1; 

-- Answer is User id - 1515915625440099873

-- 20. How many null values does the category column have?

SELECT category_code, COUNT(*)
FROM `Ecommerce Database`.kz
WHERE category_code IS NULL 
GROUP BY category_code;

-- The column category-code has 21770 null values. 

-- 21. Product brands and prices purchased between 24th - 30th April 

SELECT brand, price
FROM `Ecommerce Database`.kz
WHERE event_time BETWEEN '2020-04-24 11:50:39' AND '2020-04-30 21:27:37'
ORDER BY price DESC;

-- 22. Top 10 highest purchasing huawei brand users

SELECT user_id,price
FROM `Ecommerce Database`.kz
WHERE brand = 'huawei'
GROUP by user_id, price
Order by price DESC
LIMIT 10;


-- 23. How many headphones are there in the category column?

SELECT category_code, COUNT(*)
FROM `Ecommerce Database`.kz
WHERE category_code LIKE '%headphone'
GROUP BY category_code

-- Answer is 3380 

-- 24. Purchases made in the year 2020 only 

SELECT YEAR(event_time), price, brand
FROM `Ecommerce Database`.kz
WHERE brand <> '' AND YEAR(event_time) = '2020'
GROUP BY YEAR(event_time), price, brand
ORDER BY price DESC

-- The max Value is $9606.48 
-- The min value is $0.02 
-- There are a total of 6061 purchases made in the year 2020. 

-- 25. Select records within a specific time range and group by hour:

SELECT DATE_FORMAT(event_time, '%Y-%m-%d %H:00:00') AS hour, COUNT(*) AS count 
FROM `Ecommerce Database`.kz 
WHERE event_time BETWEEN '1970-01-01 00:33:40' AND '2020-07-08 15:06:52' 
GROUP BY hour;

-- This query selects all records within a specific time range and groups them by hour. 
-- The DATE_FORMAT function formats the timestamp to show the hour, 
-- and the COUNT function counts the number of records in each hour.

