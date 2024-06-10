## World Life Expectancy Data Analysis

### Table of Contents
- [Project Objective](#project-objective)
- [Data Sources](#data-sources)
- [Tools Used](#tools-used)
- [Data Processing](#data-processing)
- [Data Visualization](#data-visualization)
- [Result](#result)
- [References](#references)
### Project Objective: 
To analyze the life expectancy and associated health factors of 183 countries over the period from 2007 to 2022, utilizing data from the World Health Organization (WHO) and economic data from the United Nations.

### Data Sources:
The primary dataset used for the analysis "WorldLifeExpectancy.csv" contains information from sources:
- World Health Organization (WHO): The Global Health Observatory (GHO) data repository tracks health status and various related factors for all countries. The life expectancy and health factors dataset for 193 countries was obtained from this repository.
- United Nations: Corresponding economic data for the countries were collected from the United Nations website.

### Tools Used:
- MySQL - Data Cleaning and EDA -[Download here](https://www.mysql.com/)
- Tableau- Data Visualization

### Data Processing:
#### Database Creation and Data Import:
A MySQL database named "World Life Expectancy" was created to store the dataset and then later imported into the database.
#### Data Cleaning and Preparation: 
- Removing Duplicates
- Handling Missing and Null Values- It was identified that data for 10 countries were only available for a single year. These incomplete records were removed, resulting in a refined dataset encompassing 183 countries.
- Standardizing Data types 

#### Exploratory Data Analysis (EDA): 
The cleaned dataset underwent exploratory data analysis in MySQL to uncover initial patterns and insights. Some of the questions asked were:
1. Average life expectancy over the years?
2. The life expectancy from 2007 to 2022 over 15 years for all the countries?
3. Relation between Life Expectancy and GDP?
4. Relation between Life Expectancy and Status of the Countries -Developed or Developing?
5. Relation between Life Expectancy and BMI?
6. Relation between Life Expectancy, Adult Mortality and Infants Death?
7. Relation between Life Expectancy, Average Thinness 1-19 years and Schooling for Children?
   

### Data Visualization:
Post-EDA, the cleaned dataset was exported to Tableau for advanced data visualization, facilitating a more intuitive understanding of life expectancy trends and health factors across the selected countries.
[Tableau Dashboard](https://public.tableau.com/app/profile/feba.francis/viz/WORLDLIFEEXPECTANCYDASHBOARD/Dashboard1)

### Result:
The analysis results can be summarised as follows:
1. Life expectancy has increased over the 15 years in both developed and developing countries.
2. There is a positive and strong correlation between GDP and Life expectancy.
3. With a higher schooling period there seems to be higher life expectancy.
4. Most of the developed countries seem to have high BMI with high life expectancy. This could be due to higher quality health care provided.
5. The average number of infant and under-five deaths has decreased over the 15 years, reflecting the global improvements in healthcare provision and accessibility.

### References:
1. Kaggle-[Life Expectancy](https://www.kaggle.com/datasets/kumarajarshi/life-expectancy-who)
2.  Analyst builder
