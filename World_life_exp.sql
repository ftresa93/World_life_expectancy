#NEW DATABASE WORLD_LIFE_EXP WAS CREATED
USE  world_life_exp;

#UPLOADING world_life_expectancy CSV FILE USING TABLE DATA IMPORT WIZARD TO WORLD_LIFE DATABASE
SELECT * 
FROM world_life_expectancy; 

###DATA CLEANING

SELECT country, year, concat(country,year), count(concat(country,year))
FROM world_life_expectancy
GROUP BY country, year, concat(country,year)
HAVING count(*)>1 ;

SELECT row_id,
concat(country,year),
ROW_NUMBER() OVER(PARTITION BY  concat(country,year) ORDER BY concat(country,year)) AS row_num
FROM world_life_expectancy
;

SELECT row_id
FROM(
	SELECT row_id,
	concat(country,year),
	ROW_NUMBER() OVER(PARTITION BY  concat(country,year) ORDER BY concat(country,year)) AS row_num
	FROM world_life_expectancy) AS row_table
	WHERE row_num>1
	;


DELETE FROM world_life_expectancy
WHERE row_id IN(
	SELECT row_id
	FROM(
		SELECT row_id,
		concat(country,year),
		ROW_NUMBER() OVER(PARTITION BY  concat(country,year) ORDER BY concat(country,year)) AS row_num
		FROM world_life_expectancy) AS row_table
		WHERE row_num>1
		);

###STANDARDIZATION OF THE DATASET

SELECT * 
FROM world_life_expectancy; 

###CHECKING STATUS OF THE COUNTRY-DEVELOPED OR DEVELOPING 
SELECT country, status
FROM world_life_expectancy
WHERE status = '';

SELECT DISTINCT(COUNTRY)
FROM world_life_expectancy
WHERE STATUS='DEVELOPING';

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
ON t1.country= t2.country
SET t1.status ='Developing'
WHERE t1.Status =''
AND t2.Status <>''
AND t2. status ='Developing';
 
SELECT DISTINCT(COUNTRY)
FROM world_life_expectancy
WHERE STATUS='DEVELOPED';

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
ON t1.country= t2.country
SET t1.status ='Developed'
WHERE t1.Status =''
AND t2.Status <>''
AND t2. status ='Developed';

# FILLING DATA POINTS WITH EMPTY LIFE EXPECTANCY WITH AVERGAGE OF T1-1 AND T1+1 YEARS

SELECT *
FROM world_life_expectancy
WHERE `Life expectancy`='';


SELECT t1.Country, t1.year, t1.`life expectancy`,
t2.country, t2.year, t2.`life expectancy`,
t3.country, t3.year, t3.`life expectancy`, round((t2.`life expectancy`+t3.`life expectancy`)/2,1)
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
ON t1.country=t2.country
AND t1.year=t2.year-1
JOIN world_life_expectancy t3
ON t1.country=t3.country
AND t1.year=t3.year+1
WHERE t1.`life expectancy`='' ;

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
ON t1.country=t2.country
AND t1.year=t2.year-1
JOIN world_life_expectancy t3
ON t1.country=t3.country
AND t1.year=t3.year+1
SET t1.`life expectancy`= round((t2.`life expectancy`+t3.`life expectancy`)/2,1)
WHERE t1.`life expectancy` ='';


###EXPLORATORY DATA ANALYSIS

SELECT *
FROM world_life_expectancy
;

# COUNT OF COUNTRIES IN THE DATASET
SELECT COUNT(DISTINCT COUNTRY)
FROM world_life_expectancy
;

# COUNTRIES AND THE INCREASE IN LIFE EXPECTANCY FROM 2007 TO 2022
SELECT COUNTRY, 
MAX(`Life expectancy`),
MIN(`Life expectancy`), 
ROUND(MAX(`Life expectancy`)-MIN(`Life expectancy`),1) AS Life_increase_15_years
FROM world_life_expectancy
GROUP BY COUNTRY
HAVING MAX(`Life expectancy`)<>0 AND MIN(`Life expectancy`)<>0
ORDER BY Life_increase_15_years DESC ;

### COUNTRIES WITH DATA POINTS ONLY FOR THE YEAR 2020
SELECT *
FROM world_life_expectancy
WHERE `Life expectancy`=0;

SELECT *
FROM world_life_expectancy
WHERE country IN ('Dominica','Marshall Islands','Monaco','Cook Islands','Nauru','Niue','Palau','Saint Kitts and Nevis','San Marino','Tuvalu');

DELETE FROM world_life_expectancy
WHERE country IN ('Dominica','Marshall Islands','Monaco','Cook Islands','Nauru','Niue','Palau','Saint Kitts and Nevis','San Marino','Tuvalu');

# AVERAGE LIFE EXPECTANCY OVER THE YEARS
SELECT year,
ROUND(AVG(`Life expectancy`),2) AS Avg_Life_Exp 
FROM world_life_expectancy
GROUP BY year
HAVING  Avg_Life_Exp >0 
ORDER BY year ;

# RELATION BETWEEN LIFE EXPECTANCY AND GDP
SELECT country,
ROUND(AVG(`Life expectancy`),2) AS Avg_Life_Exp, 
ROUND(AVG(GDP),2) AS Avg_GDP
FROM world_life_expectancy
GROUP BY country
HAVING  Avg_Life_Exp >0 AND Avg_GDP>0
ORDER BY Avg_GDP DESC ;

# AVG LIFE EXPECTANCY AND AVG GDP OF THE WORLD
SELECT ROUND(AVG(`Life expectancy`),2),
ROUND(AVG(GDP),2)
FROM world_life_expectancy;

# RELATION BETWEEN STATUS, AVG LIFE EXPECTANCY
SELECT status, 
COUNT(DISTINCT country),
ROUND(AVG(`Life expectancy`),2)
FROM world_life_expectancy
GROUP BY status;

# RELATION BETWEEN  AVG BMI AND AVG LIFE EXPECTANCY
SELECT country,
ROUND(AVG(bmi),2) AS AVG_BMI,
ROUND(AVG(`Life expectancy`),2) AS AVG_LIFE_EXP
FROM world_life_expectancy
GROUP BY country
HAVING AVG_BMI<>0 AND AVG_LIFE_EXP<>0
ORDER BY AVG_BMI DESC
;

# RELATION BETWEEN LIFE EXPECTANCY AND ADULT MORTALITY
SELECT country,
year,
`Life expectancy`,
`Adult Mortality`,
SUM(`Adult Mortality`) OVER(PARTITION BY country ORDER BY year) AS Rolling_total
FROM world_life_expectancy
;

# PERCENTAGE EXPENDITURE 
SELECT `percentage expenditure`
FROM world_life_expectancy
ORDER BY `percentage expenditure` DESC
;

# PERCENTAGE EXPENDITURE COLUMN SEEMS TO HAVE INACCURATE DATA HENCE DROPPED
ALTER TABLE world_life_expectancy
DROP COLUMN `percentage expenditure`
;

# REALTION BETWEEN  AVG SCHOOLING FOR CHILDREN & AVG LIFE EXPECTANCY - COUNTRY
SELECT *
FROM world_life_expectancy;

SELECT COUNTRY,
ROUND(AVG(Schooling),2) AS AVG_SCHOOLING,
ROUND(AVG(`Life expectancy`),2) AS AVG_LIFE_EXP
FROM world_life_expectancy
GROUP BY COUNTRY
HAVING  AVG_SCHOOLING <>0
ORDER BY AVG_SCHOOLING DESC 
;

# REALTION BETWEEN  AVG LIFE EXPECTANCY, ADULT MORTALITY AND INFANT DEATHS
SELECT COUNTRY,
ROUND(AVG(`Life expectancy`),2) AS AVG_LIFE_EXP,
ROUND(AVG(`Adult Mortality`),2) AS AVG_ADULT_MORTALITY,
ROUND(AVG(`infant deaths`),2) AS AVG_INFANT_DEATHS
FROM world_life_expectancy
GROUP BY COUNTRY
ORDER BY AVG_LIFE_EXP DESC 
;