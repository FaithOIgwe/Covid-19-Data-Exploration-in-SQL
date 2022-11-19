
--AFTER IMPORTING THE DATASET INTO MICROSOFT SQL SERVER,IS TO UNDERSTAND THE DATA AND LOOK FOR MISSING VALUES AND DATATYPES

SELECT *
FROM dbo.['Order Database$']
--From the records there are 66535 records(rows) and 27 fields(columns) in this dataset
 
 --Checking for missing values in the different fields
 SELECT [Booking ID], [Date of Booking], Year, Time, [Customer ID], Count(*) AS missing_Values
 FROM dbo.['Order Database$']
 GROUP BY [Booking ID], [Date of Booking], Year, Time, [Customer ID]
 HAVING COUNT(*) < 1;
 
 --There are currently no missing values in the following fields: [Booking ID], [Date of Booking], Year, Time, and  [Customer ID]

 -- Checking for more missing values
 SELECT Gender, age,[Origin Country], State, Location, [Destination Country], COUNT(*) AS missing_Values
 FROM dbo.['Order Database$']
  GROUP BY Gender, age,[Origin Country], State, Location, [Destination Country]
 HAVING COUNT(*) < 1;
 
 --There are currently no missing values in the following fields: Gender, age,[Origin Country], State, Location, [Destination Country]

 --Chceking for missing records
 SELECT [Destination City], [No# Of People], [Check-in date], [No# Of Days], [Check-Out Date], COUNT(*) AS missing_Values
 FROM dbo.['Order Database$']
 GROUP BY [Destination City], [No# Of People], [Check-in date], [No# Of Days], [Check-Out Date]
 HAVING COUNT(*) < 1;

--There are no missing records in the following fields: [Destination City], [No# Of People], [Check-in date], [No# Of Days], [Check-Out Date]

SELECT Rooms, [Hotel Name], [Hotel Rating], [Payment Mode], [Bank Name], [No# Of Days1], Rooms1, [Booking Price(SGD)], Discount, GST, [Profit Margin], COUNT(*) AS missing_Values
FROM dbo.['Order Database$']
GROUP BY Rooms, [Hotel Name], [Hotel Rating], [Payment Mode], [Bank Name], [No# Of Days1], Rooms1, [Booking Price(SGD)], Discount, GST, [Profit Margin]
HAVING COUNT(*) < 1;

--There are no null or empty records in the Hotel Dataset
--Next step is to check for the accurate datatypes represented are accurate so as to make the adequate changes where necessary
--We will be doing thsi for eacah  of the columns

 
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Order Database$'
AND COLUMN_NAME = '[Payment Mode]';

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Order Database$'
AND COLUMN_NAME = '[Bank Name]';

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Order Database$'
AND COLUMN_NAME = ' [Bank Name]';

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Order Database$'
AND COLUMN_NAME = '[No# Of Days1]';

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Order Database$'
AND COLUMN_NAME = ' Rooms1';

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Order Database$'
AND COLUMN_NAME = '[Booking Price(SGD)]';

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Order Database$'
AND COLUMN_NAME = 'Discount';

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Order Database$'
AND COLUMN_NAME = '[Profit Margin]';

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Order Database$'
AND COLUMN_NAME = '[Destination City]';

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Order Database$'    
AND COLUMN_NAME = '[No# Of People]';

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Order Database$'
AND COLUMN_NAME = '[Check-in date]';

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Order Database$'
AND COLUMN_NAME = '[No# Of Days]';

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Order Database$'
AND COLUMN_NAME = 'State';

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Order Database$'
AND COLUMN_NAME = '[Origin Country]';

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Order Database$'
AND COLUMN_NAME = 'Gender';

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Order Database$'
AND COLUMN_NAME = 'GST';
--All fields have the accurate data type represented so we can proceed to my favourite part which is analyzing the dataset ;)

SELECT COUNT(DISTINCT [Booking ID]) as total_customers  
FROM dbo.['Order Database$'];

--There are 66,535 customers that their hotel record was taken

SELECT Year, COUNT(Year) AS years_represented
FROM dbo.['Order Database$']
GROUP BY Year
ORDER BY Year;

--This records were taken from 2010-2019

SELECT Gender, COUNT(Gender) as num_by_gender
FROM dbo.['Order Database$']
GROUP BY Gender;
--There are 33148 Males that have booked hotels while 33387 females have booked hotels. It's still early in the analysis to conclude that female are leading the travelling game but at this point that's what's happening ;)

SELECT [Origin Country], COUNT([Origin Country])
FROM dbo.['Order Database$']
GROUP BY [Origin Country]
ORDER BY [Origin Country] DESC;

--These are the top tourist countries arranged from top tourists to the least tourists Vietnam	5959, Thailand	12170, Singapore	12036, Philippines	6383, Malaysia	12049, Indonesia	11986, Cambodia	5952

SELECT [Destination Country], COUNT([Destination Country]) AS num_destinatiom_country
FROM dbo.['Order Database$']
GROUP BY [Destination Country]
ORDER BY [Destination Country] DESC;

--Tourists travelled to 20 countries  with New Zealand, Nepal and Mexico  topping the lists

--Total hotels 
SELECT DISTINCT [Hotel Name]
FROM dbo.['Order Database$']
GROUP BY [Hotel Name]
ORDER BY [Hotel Name];

--There are 614 hotels for tourist to pick from

---Getting the total number of people
SELECT SUM([No# Of People]) AS num_tourist
FROM dbo.['Order Database$']
-- Total number of tourist is 265864

SELECT *
FROM dbo.['Order Database$']

--Origin countries by destination countries across years
SELECT [Origin Country], [Destination Country], YEAR([Check-in date]) AS year, SUM([No# Of People]) AS num_tourists
FROM dbo.['Order Database$']
GROUP BY [Check-in date], [Origin Country], [Destination Country]
ORDER BY [Check-in date];

--Hotels by number of toursists
SELECT [Hotel Name], SUM([No# Of People]) AS num_tourists
FROM dbo.['Order Database$']
GROUP BY [Hotel Name], [No# Of People]
ORDER BY [No# Of People] DESC;

--Tourist favorite hotels with high rating
--We will do this by segmenting the ratings into : 5 star, 4 star, 3 star, 2 star and lastly 1 star
--From observation no hotel was rated at a 5 star however it is safe to say there are a lot of hotels that were rated at 4 -3 star
SELECT [Hotel Name], [Hotel Rating], CASE WHEN [Hotel Rating] >= 5.0 THEN '5 star'
									  WHEN [Hotel Rating] >= 4.0 THEN '4 star'
										  WHEN [Hotel Rating] >= 3.0 THEN '3 star'
										  WHEN [Hotel Rating] >= 2.0 THEN '2 star'
										  ELSE '1 star' 
										  END AS ratings
FROM dbo.['Order Database$'];

--Which hotel made more had more revenue 
SELECT [Hotel Name], SUM([Booking Price(SGD)] ) AS prices 											   
FROM dbo.['Order Database$']
GROUP BY [Hotel Name], [Check-in date]
ORDER BY prices DESC;

--What are the max and min days tourists have stayedper hotels
SELECT [Hotel Name], MIN([No# Of Days]) as min_stayed, MAX([No# Of Days]) AS max_stayed
FROM dbo.['Order Database$']
GROUP BY [Hotel Name]
ORDER BY min_stayed DESC, max_stayed DESC;

--what is the average time stayed per hotel?
--This query will help us understand the average time our customers stay in out hotels, does it favour us and how can we improve and where?
SELECT [Hotel Name], ROUND(AVG([No# Of Days]), 0) AS mean_days
FROM dbo.['Order Database$']
GROUP BY [Hotel Name]
ORDER BY mean_days DESC;

---Understansing the trends of tourists across years, months and days
--This query will help us further understand the seasons in which we do well and vice versa
SELECT [Hotel Name], month([Check-in date]) as month, SUM([Booking Price(SGD)]) OVER(PARTITION BY [Hotel Name] ORDER BY [Booking Price(SGD)]) AS running_total
FROM dbo.['Order Database$'];

SELECT [Hotel Name], Year([Check-in date]) as year, SUM([Booking Price(SGD)]) OVER(PARTITION BY [Hotel Name] ORDER BY [Booking Price(SGD)]) AS running_total
FROM dbo.['Order Database$'];

SELECT [Hotel Name], DAY([Check-in date]) as day, SUM([Booking Price(SGD)]) OVER(PARTITION BY [Hotel Name] ORDER BY [Booking Price(SGD)]) AS running_total
FROM dbo.['Order Database$'];

--What are the top locations by number of visits in each country 
SELECT  RANK() OVER(PARTITION BY [Destination Country] ORDER BY [Destination Country]) AS Rank, [Destination Country], Location, SUM([No# Of People]) AS sum_tourists
FROM dbo.['Order Database$']
GROUP BY Location, [Destination Country];

--Busiest travel times in the year
SELECT month([Date of Booking]) as month_num, (CASE WHEN month([Date of Booking]) = 1 THEN 'January'
																			 WHEN month([Date of Booking]) = 2 THEN 'February'
																			 WHEN month([Date of Booking]) = 3 THEN 'March'
																			 WHEN month([Date of Booking]) = 4 THEN 'April'
																			 WHEN month([Date of Booking]) = 5 THEN 'May'
																			 WHEN month([Date of Booking]) = 6 THEN 'June'
																			 WHEN month([Date of Booking]) = 7 THEN 'July'
																			 WHEN month([Date of Booking]) = 8 THEN 'August'
																			 WHEN month([Date of Booking]) = 9 THEN 'September'
																			 WHEN month([Date of Booking]) = 10 THEN 'October'
																			 WHEN month([Date of Booking]) = 11 THEN 'November'
																			 ELSE 'December'
																			 END) AS month, COUNT(*) AS num_tourists
FROM dbo.['Order Database$']
GROUP BY month([Date of Booking])
ORDER BY month_num;

--What are the tourist favorite ways of paying?
SELECT [Payment Mode], COUNT(*) AS num_tourist 
FROM dbo.['Order Database$']
GROUP BY [Payment Mode]
ORDER BY num_tourist;

--what are the tourists favorite way of paying by hotels?
SELECT [Hotel Name], [Payment Mode],DENSE_RANK() OVER(PARTITION BY [Payment Mode] ORDER BY [Hotel Name]) as payment_row, COUNT(*) as num_tourists
FROM dbo.['Order Database$']
GROUP BY [Payment Mode],[Hotel Name]
ORDER BY COUNT(*);


