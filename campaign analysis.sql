-- Sales & Website Trends
select 
date,
sales,
sessions
from site_data1
where client = 'A'
and date between'2022-01-01' and '2022-12-31';

-- find invalid keywords
SELECT keyword
FROM keyword_data1
GROUP BY 1; 

-- Keyword Trends
SELECT
date,
sum(search_volume) AS searches 
FROM keyword_data2
WHERE date between'2022-01-01' and '2022-12-31' and
keyword IN('eyeliner',
'lipstick', 'lipgloss', 'eyeshadow',
'foundation', 'highlighter', 'eyebrow' 
'lotion', 'facewash', 'serum') -- keep only the valid keywords
GROUP BY date;

-- how many channel
SELECT channel 
FROM campaign_performance_1
GROUP BY channel;

-- total sales
SELECT SUM(sales) AS attributed_sales
FROM user_level_sales1
WHERE date between'2022-01-01' and '2022-12-31';

-- sales by category
SELECT category,
SUM(sales) AS attributed_sales
FROM user_level_sales1
WHERE date between'2022-01-01' and '2022-12-31'
GROUP BY category;

-- most purchased categories
SELECT category,
SUM(sales) AS attributed_sales
FROM user_level_sales1
WHERE date between'2022-01-01' and '2022-12-31' 
and age_group = '35-39' and region = 'NY' and gender = 'F' and brand = 'A' and sales > 0
GROUP BY 1;

-- average purchase frequency
SELECT 
COUNT(distinct order_id)/count(distinct customer_id) as frequency
FROM user_level_sales1
WHERE date between'2022-01-01' and '2022-12-31'
and age_group = '35-39' and region = 'NY' and gender = 'F' and brand = 'A' and sales > 0;

-- average days since last purchase
SELECT
avg(datediff(date,previous_date)) AS days_since_last_purchase
FROM (SELECT
customer_id,
date,
LAG(date) OVER (partition by customer_id order by date) AS previous_date 
-- calculate the lag from last time to this time
FROM user_level_sales1
WHERE brand = 'A' and sales > 0 and age_group = '35-39'
AND date between'2022-01-01' and '2022-12-31'
AND region = 'NY' and gender = 'F' and brand = 'A') AS previous_date