use house_price_reg;

SELECT *
FROM reg_data;

ALTER TABLE reg_data
RENAME COLUMN ï»¿id TO id;

-- 4.  Select all the data from table `house_price_data` to check if the data was imported correctly

ALTER TABLE reg_data
DROP COLUMN date;

-- 5.  Use the alter table command to drop the column `date` from the database, as we would not use it in the analysis with SQL. 
-- Select all the data from the table to  verify if the command worked. Limit your returned results to 10.
SELECT *
FROM reg_data
LIMIT 10;

-- 6.  Use sql query to find how many rows of data you have.

SELECT COUNT(*)
FROM reg_data;

-- 7.  Now we will try to find the unique values in some of the categorical columns:

   -- a) - What are the unique values in the column `bedrooms`?

SELECT DISTINCT(bedrooms)
FROM reg_data;
   -- b) - What are the unique values in the column `bathrooms`?
SELECT DISTINCT(bathrooms)
FROM reg_data;
   -- c)- What are the unique values in the column `floors`?
SELECT DISTINCT(floors)
FROM reg_data;
   -- d)- What are the unique values in the column `condition`?
SELECT DISTINCT(`condition`)
FROM reg_data;
   -- e)- What are the unique values in the column `grade`?

SELECT DISTINCT(grade)
FROM reg_data;
   
-- 8.  Arrange the data in a decreasing order by the price of the house. Return only the IDs of the top 10 most expensive houses 
-- in your data.
SELECT id, price
FROM reg_data
ORDER BY price DESC
LIMIT 10;


-- 9.  What is the average price of all the properties in your data

SELECT AVG(price)
FROM reg_data;
-- 10. In this exercise we will use simple group by to check the properties of some of the categorical variables in our data

   --  a) - What is the average price of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and 
   -- Average of the prices. Use an alias to change the name of the second column.
   
   SELECT bedrooms, AVG(price) as average_price
   FROM reg_data
   GROUP BY bedrooms
   ORDER BY average_price DESC;
   
   -- b) - What is the average `sqft_living` of the houses grouped by bedrooms? The returned result should have only two columns,
   -- bedrooms and Average of the `sqft_living`. Use an alias to change the name of the second column.
SELECT bedrooms, AVG(sqft_living) as average_sqft_living
FROM reg_data
GROUP BY bedrooms
ORDER BY average_sqft_living DESC;
   
    -- c) - What is the average price of the houses with a waterfront and without a waterfront? The returned result should have 
    -- only two columns, waterfront and `Average` of the prices. Use an alias to change the name of the second column.
SELECT waterfront, AVG(price) as average_price
FROM reg_data
GROUP BY waterfront;
    
    -- d) - Is there any correlation between the columns `condition` and `grade`? You can analyse this by grouping the data by one of 
    -- the variables and then aggregating the results of the other column. Visually check if there is a positive correlation or negative 
    -- correlation or no correlation between the variables.
    
SELECT `condition`, grade
FROM reg_data
GROUP BY `condition`
ORDER BY `condition` DESC;


-- You might also have to check the number of houses in each category (ie number of houses for a given `condition`) to assess if 
-- that category is well represented in the dataset to include it in your analysis. For eg. If the category is under-represented as
-- compared to other categories, ignore that category in this analysis

SELECT `condition`, COUNT(DISTINCT(id))
FROM reg_data
GROUP BY `condition`
ORDER BY `condition` DESC;
        
	-- 11. One of the customers is only interested in the following houses:

    -- - Number of bedrooms either 3 or 4
    -- - Bathrooms more than 3
    -- - One Floor
    -- - No waterfront
    -- - Condition should be 3 at least
    -- - Grade should be 5 at least
    -- - Price less than 300000

    -- For the rest of the things, they are not too concerned. Write a simple query to find what are the options available for them?
    
    SELECT *
FROM reg_data
WHERE (bedrooms=3 OR bedrooms=4) AND (bathrooms>3) AND (floors=1) AND (waterfront=0) AND (`condition`>3) AND (grade>5)
ORDER BY price ASC; -- there is no house with these characteristics cheaper than 300.000 dollar.
    
-- 12. Your manager wants to find out the list of properties whose prices are twice more than the average of all the properties in 
-- the database. Write a query to show them the list of such properties. You might need to use a sub query for this problem.

SELECT*
FROM reg_data
WHERE price>(
SELECT AVG(price)*2
FROM reg_data);

-- 13. Since this is something that the senior management is regularly interested in, create a view called
 -- `Houses_with_higher_than_double_average_price` of the same query.
 
CREATE VIEW Houses_with_higher_than_double_average_price AS
SELECT*
FROM reg_data
WHERE price>(
SELECT AVG(price)*2
FROM reg_data);
    

-- 14. Most customers are interested in properties with three or four bedrooms. What is the difference in average prices of the properties with three and four bedrooms? 
-- In this case you can simply use a group by to check the prices for those particular houses

SELECT AVG(price), bedrooms
FROM reg_data
WHERE bedrooms=3 or bedrooms=4
GROUP BY bedrooms;

-- 15. What are the different locations where properties are available in your database? (distinct zip codes)

SELECT DISTINCT(zipcode)
FROM reg_data;

-- 16. Show the list of all the properties that were renovated.
SELECT *
FROM reg_data
WHERE yr_renovated>0;

-- 17. Provide the details of the property that is the 11th most expensive property in your database.

SELECT *
FROM reg_data
ORDER BY price DESC
LIMIT 10,1; -- shows the first occurence after not showing the first ten rows.

