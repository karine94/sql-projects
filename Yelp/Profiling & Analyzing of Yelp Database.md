# Final work for the `SQL FOR DATA SCIENCE` course offered by Coursera

## Part 1: Yelp Dataset Profiling and Understanding

### Yelp Database ER Diagram* 
![YelpERDiagram](https://github.com/karine94/sql-projects/assets/103138813/4deacf5d-0b5a-4438-b338-27dee5ca9423)

### Profile the data by finding the total number of records for each of the tables below:
   
i. Attribute table = 10000   
ii. Business table = 10000  
iii. Category table = 10000  
iv. Checkin table = 10000  
v. elite_years table = 10000  
vi. friend table = 10000  
vii. hours table = 10000  
viii. photo table = 10000  
ix. review table = 10000  
x. tip table = 10000  
xi. user table = 10000  

### Find the total distinct records by either the foreign key or primary key for each table. If two foreign keys are listed in the table, please specify which foreign key.

i. Business = 10000  
ii. Hours = 1562(business_id)  
iii. Category = 2643 (business_id)  
iv. Attribute = 1115(business_id)  
v. Review = id (10000), business_id (8090), user_id (9581)  
vi. Checkin = business_id (493)  
vii. Photo = business_id (6493), id(10000)  
viii. Tip = user_id (537), business_id (3979)  
ix. User = id (10000)  
x. Friend = user_id (1)  
xi. Elite_years = user_id (2780)  

Note: Primary Keys are denoted in the ER-Diagram with a yellow key icon.	

### Are there any columns with null values in the Users table? Indicate "yes," or "no."

Answer: no	 	

SQL code used to arrive at answer:

```
    SELECT * 
    FROM user
    WHERE compliment_photos IS NULL
```
*This same code was used for the rest of the columns    
	
### For each table and column listed below, display the smallest (minimum), largest (maximum), and average (mean) value for the following fields:

	i. Table: Review, Column: Stars  
	
		min: 1		max: 5 	 	avg: 3.7082  
		
	
	ii. Table: Business, Column: Stars  
	
		min: 1		max: 5		avg: 3.6549  
		
	
	iii. Table: Tip, Column: Likes  
	
		min:0		max:2		avg:0.0144  
		
	
	iv. Table: Checkin, Column: Count  
	
		min:1		max:53		avg:1.9414  
		
	
	v. Table: User, Column: Review_count  
	
		min:0		max:200		avg:24.2995   
		

### List the cities with the most reviews in descending order:

SQL code used to arrive at answer:

```
SELECT city, SUM(review_count) AS total_reviews
FROM business
GROUP BY city
ORDER BY total_reviews DESC;
```
Copy and Paste the Result Below:
```
+-----------------+---------------+
| city            | total_reviews |
+-----------------+---------------+
| Las Vegas       |         82854 |
| Phoenix         |         34503 |
| Toronto         |         24113 |
| Scottsdale      |         20614 |
| Charlotte       |         12523 |
| Henderson       |         10871 |
| Tempe           |         10504 |
| Pittsburgh      |          9798 |
| Montréal        |          9448 |
| Chandler        |          8112 |
| Mesa            |          6875 |
| Gilbert         |          6380 |
| Cleveland       |          5593 |
| Madison         |          5265 |
| Glendale        |          4406 |
| Mississauga     |          3814 |
| Edinburgh       |          2792 |
| Peoria          |          2624 |
| North Las Vegas |          2438 |
| Markham         |          2352 |
| Champaign       |          2029 |
| Stuttgart       |          1849 |
| Surprise        |          1520 |
| Lakewood        |          1465 |
| Goodyear        |          1155 |
+-----------------+---------------+
(Output limit exceeded, 25 of 362 total rows shown)
```
### Find the distribution of star ratings to the business in the following cities:

i. Avon

SQL code used to arrive at answer:
```
SELECT stars, SUM(review_count) AS total_reviews
FROM business
WHERE city = 'Avon'
GROUP BY stars;
```
*Copy and Paste the Resulting Table Below (2 columns â€“ star rating and count):*
```
+-------+---------------+
| stars | total_reviews |
+-------+---------------+
|   1.5 |            10 |
|   2.5 |             6 |
|   3.5 |            88 |
|   4.0 |            21 |
|   4.5 |            31 |
|   5.0 |             3 |
+-------+---------------+
```
ii. Beachwood

SQL code used to arrive at answer:
```
SELECT stars, SUM(review_count) AS total_reviews
FROM business
WHERE city = 'Beachwood'
GROUP BY stars;
```
Copy and Paste the Resulting Table Below (2 columns â€“ star rating and count):
```
+-------+---------------+
| stars | total_reviews |
+-------+---------------+
|   2.0 |             8 |
|   2.5 |             3 |
|   3.0 |            11 |
|   3.5 |             6 |
|   4.0 |            69 |
|   4.5 |            17 |
|   5.0 |            23 |
+-------+---------------
```
### Find the top 3 users based on their total number of reviews:
		
SQL code used to arrive at answer:
```
SELECT name, review_count
FROM user
ORDER BY review_count DESC
LIMIT 3;
```		
Copy and Paste the Result Below:	
```
+--------+--------------+
| name   | review_count |
+--------+--------------+
| Gerald |         2000 |
| Sara   |         1629 |
| Yuri   |         1339 |
+--------+--------------+
```

### Does posing more reviews correlate with more fans?

Please explain your findings and interpretation of the results:

- There appears to be no correlation between the two columns. As we can see, there are people with high numbers of reviews but small numbers of fans, and the opposite is also observed. 

```
SELECT name, review_count, fans
FROM user
ORDER BY review_count DESC;
```
Output:
```
+-----------+--------------+------+
| name      | review_count | fans |
+-----------+--------------+------+
| Gerald    |         2000 |  253 |
| Sara      |         1629 |   50 |
| Yuri      |         1339 |   76 |
| .Hon      |         1246 |  101 |
| William   |         1215 |  126 |
| Harald    |         1153 |  311 |
| eric      |         1116 |   16 |
| Roanna    |         1039 |  104 |
| Mimi      |          968 |  497 |
| Christine |          930 |  173 |
| Ed        |          904 |   38 |
| Nicole    |          864 |   43 |
| Fran      |          862 |  124 |
| Mark      |          861 |  115 |
| Christina |          842 |   85 |
| Dominic   |          836 |   37 |
| Lissa     |          834 |  120 |
| Lisa      |          813 |  159 |
| Alison    |          775 |   61 |
| Sui       |          754 |   78 |
| Tim       |          702 |   35 |
| L         |          696 |   10 |
| Angela    |          694 |  101 |
| Crissy    |          676 |   25 |
| Lyn       |          675 |   45 |
+-----------+--------------+------+
(Output limit exceeded, 25 of 10000 total rows shown)
```

### Are there more reviews with the word "love" or with the word "hate" in them?

Answer:
```
+------+------+
| love | hate |
+------+------+
| 1780 |  232 |
+------+------+
```
SQL code used to arrive at answer:
```
SELECT 
(SELECT COUNT(id)
FROM review
WHERE text LIKE '%love%') AS love, 
(SELECT COUNT(id)
FROM review
WHERE text LIKE '%hate%') AS hate;
```
### Find the top 10 users with the most fans:

SQL code used to arrive at answer:

```
SELECT name, fans
FROM user
ORDER BY fans DESC
LIMIT 10;	
```
Copy and Paste the Result Below:
```
+-----------+------+
| name      | fans |
+-----------+------+
| Amy       |  503 |
| Mimi      |  497 |
| Harald    |  311 |
| Gerald    |  253 |
| Christine |  173 |
| Lisa      |  159 |
| Cat       |  133 |
| William   |  126 |
| Fran      |  124 |
| Lissa     |  120 |
+-----------+------+
```

## Part 2: Inferences and Analysis

### Pick one city and category of your choice and group the businesses in that city or category by their overall star rating. Compare the businesses with 2-3 stars to the businesses with 4-5 stars and answer the following questions. Include your code.

I have choosen city = 'Phoenix' and category = 'Restaurants'

code:
```
SELECT stars, COUNT(DISTINCT id) AS TotalRestaurants, count(hours)
FROM business b 
JOIN category c
ON b.id = c.business_id
JOIN hours h 
ON b.id = h.business_id
WHERE category == 'Restaurants' AND city == 'Phoenix'
GROUP BY stars;
```
result:
```
+-------+------------------+--------------+
| stars | TotalRestaurants | count(hours) |
+-------+------------------+--------------+
|   2.0 |                1 |            7 |
|   3.0 |                1 |            7 |
|   3.5 |                1 |            7 |
|   4.0 |                1 |            7 |
|   4.5 |                1 |            7 |
+-------+------------------+--------------+
```
analysis:
Restaurants have the same number of hours, regardless of their star rating. 

### Do the two groups you chose to analyze have a different number of reviews?
code:
```
SELECT stars, COUNT(DISTINCT id) AS TotalRestaurants, SUM(review_count)
FROM business b 
JOIN category c
ON b.id = c.business_id
WHERE category == 'Restaurants' AND city == 'Phoenix'
GROUP BY stars;
```
result:
```
+-------+------------------+-------------------+
| stars | TotalRestaurants | SUM(review_count) |
+-------+------------------+-------------------+
|   2.0 |                1 |                 8 |
|   3.0 |                1 |                60 |
|   3.5 |                1 |                63 |
|   4.0 |                2 |               619 |
|   4.5 |                1 |                 7 |
+-------+------------------+-------------------+
```
analysis:  

Yes, the ones with the most reviews are the 4 star restaurants and the ones with the least reviews are the 4.5 star restaurants.
            
### Are you able to infer anything from the location data provided between these two groups? Explain.

SQL code used for analysis:
```
SELECT stars
,COUNT(DISTINCT id) AS TotalRestaurants
,address, postal_code
FROM business b 
JOIN category c
ON b.id = c.business_id
WHERE category == 'Restaurants' AND city == 'Phoenix'
GROUP BY stars;
```
result:
```
+-------+------------------+-------------------------+-------------+
| stars | TotalRestaurants | address                 | postal_code |
+-------+------------------+-------------------------+-------------+
|   2.0 |                1 | 1850 S 7th St           | 85004       |
|   3.0 |                1 | 751 E Union Hls Dr      | 85024       |
|   3.5 |                1 | 2641 N 44th St, Ste 100 | 85008       |
|   4.0 |                2 | 3118 E Camelback Rd     | 85016       |
|   4.5 |                1 | 1153 E Jefferson St     | 85034       |
+-------+------------------+-------------------------+-------------+
```
analysis:  

Restaurants with the highest and lowest stars are scattered throughout Phoenix. I can't say if this has anything to do with the neighborhood, as I don't know the area.
		
### Group business based on the ones that are open and the ones that are closed. What differences can you find between the ones that are still open and the ones that are closed? List at least two differences and the SQL code you used to arrive at your answer.
		
i. Difference 1:
Open companies have more stars.
         
ii. Difference 2:
Open companies have the highest number of reviews.    
                
SQL code used for analysis:
```
SELECT is_open, COUNT(id) AS TotalBusiness, 
    SUM(stars) AS sum_stars, SUM(review_count) AS TotalReviews
FROM business 
GROUP BY is_open;
```
### For this last part of your analysis, you are going to choose the type of analysis you want to conduct on the Yelp dataset and are going to prepare the data for analysis.
	
i. Indicate the type of analysis you chose to do:

Which city has the best services in the category of hotels and travels?
         
ii. Write 1-2 brief paragraphs on the type of data you will need for your analysis and why you chose that data:

My goal was to:
1. Select the 15 categories with the highest number of establishments in the city of Phoenix
2. Check how many establishments are still open
3. Check the total number of reviews of these categories

To do this:
1. grouped the data by category
2. selected the desired city
3. counted the number of establishments and used DISTINCT to avoid repetition
4. added up the number of reviews for each category and added up the number of open establishments for each category

Analysis:  
This allowed me to observe that businesses whose categories are related to food are the most successful in Phoenix, so if I were to open a business, I would invest in the food category.
                            
iii. Output of your finished dataset:
```
+------------------------+------------+--------------+------------------+
| category               | noBusiness | TotalReviews | No_business_open |
+------------------------+------------+--------------+------------------+
| Restaurants            |          6 |          757 |                5 |
| Food                   |          4 |          501 |                4 |
| Home Services          |          4 |           27 |                4 |
| American (Traditional) |          3 |          498 |                2 |
| Health & Medical       |          3 |           41 |                3 |
| Bars                   |          2 |          491 |                2 |
| Beauty & Spas          |          2 |           22 |                2 |
| Burgers                |          2 |           71 |                2 |
| Chiropractors          |          2 |           37 |                2 |
| Contractors            |          2 |           18 |                2 |
| Fast Food              |          2 |           71 |                2 |
| Nightlife              |          2 |          491 |                2 |
| Shopping               |          2 |           18 |                1 |
| Active Life            |          1 |            9 |                1 |
| American (New)         |          1 |           63 |                1 |
+------------------------+------------+--------------+------------------+     
```         
iv. Provide the SQL code you used to create your final dataset:
```
SELECT category, COUNT(DISTINCT id) AS noBusiness, 
    SUM(review_count) AS TotalReviews, 
    SUM(is_open) AS No_business_open
FROM business b 
INNER JOIN category c
ON b.id = c.business_id
WHERE city = 'Phoenix' 
GROUP BY category
ORDER BY noBusiness DESC
LIMIT 15;
```
