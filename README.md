# Google-Data-Analytics-Case-Study-Bellabeat
Course: [Google Data Analytics Capstone: Complete a Case Study](https://www.coursera.org/learn/google-data-analytics-capstone)
## Introduction
In this case study, I will perform many real-world tasks as a junior data analyst at a high-tech manufacturer of health-focused products for women, Bellabeat. I will follow the steps of the data analysis process: Ask, Prepare, Process, Analyze, Share, and Act to answer the stakeholders' questions.

SQL Queries:  
[01. Data Combining](https://github.com/SomiaNasir/Google-Data-Analytics-Capstone-Cyclistic-Case-Study/blob/main/01.%20Data%20Combining.sql)  
[02. Data Exploration](https://github.com/SomiaNasir/Google-Data-Analytics-Capstone-Cyclistic-Case-Study/blob/main/02.%20Data%20Exploration.sql)  
[03. Data Cleaning](https://github.com/giatruc1702/-Google-Data-Analytics-Case-Study-Bellabeat/blob/main/clean_data.sql)  
[04. Data Analysis](https://github.com/SomiaNasir/Google-Data-Analytics-Capstone-Cyclistic-Case-Study/blob/main/04.%20Data%20Analysis.sql)  
  
Data Visualizations: [Tableau](https://public.tableau.com/app/profile/somia.nasir/viz/bike-tripdata-casestudy/Dashboard1#1)  
## Background
### Bellabeat
Urška Sršen and Sando Mur founded Bellabeat, a high-tech company that manufactures health-focused smart products. Sršen used her background as an assist to develop beautifully designed technology that informs and inspires women around the world. Collecting data on activity, sleep, stress, and reproductive health has allowed Bellabeat to empower women with knowledge about their own health and habits. Since it was founded in 2013, Bellabeat has grown rapidly and quickly positioned itself as a tech-driven wellness company for women.
By 2016, Bellabeat had opened offices around the world and launched multiple products. Bellabeat products became available through a growing number of online retailers in addition to their own e-commerce channel on their website. The company has invested in traditional advertising media, such as radio, out-of-home billboards, print, and television, but focuses on digital marketing extensively. Bellabeat invests year-round in Google Search, maintaining active Facebook and Instagram pages, and consistently engages consumers on Twiźer. Additionally, Bellabeat runs video ads on YouTube and display ads on the Google Display Network to support campaigns around key marketing dates. Sršen knows that an analysis of Bellabeat’s available consumer data would reveal more opportunities for growth. She has asked the marketing analytics team to focus on a Bellabeat product and analyze smart device usage data in order to gain insight into how people are already using their smart devices. Then, using this information, she would like high-level recommendations for how these trends can inform Bellabeat's marketing strategy

### Scenario
I am a junior data analyst working on the marketing analyst team at Bellabeat, a high-tech manufacturer of health-focused products for women. Bellabeat is a successful small company, but they have the potential to become a larger player in the global smart device market. Urška Sršen, cofounder and Chief Creative Oūcer of Bellabeat believes that analyzing smart device űtness data could help unlock new growth opportunities for the company. I have been asked to focus on one of Bellabeat’s products and analyze smart device data to gain insight into how consumers are using their smart devices. The insights I discover will then help guide the marketing strategy for the company. I will present your analysis to the Bellabeat executive team along with your high-level recommendations for Bellabeat’s marketing strategy

## Ask
### Business Task
Devise marketing strategies to convert casual riders to members.
### Analysis Questions
Three questions I'd like to know from this analysis:
* What are some trends in smart device usage?

* How could these trends apply to Bellabeat customers?

* How could these trends help influence Bellabeat's marketing strategy?

## Prepare
### Data Source
I will use Fitness Tracker data to analyze and identify trends, which can be downloaded from [Fitness Tracker](https://www.kaggle.com/datasets/arashnic/fitbit).
This Kaggle data set contains a personal fitness tracker from Fitbit users. These eligible Fitbit users consented to the submission of personal tracker data, including minute-level output for physical activity, heart rate, and sleep monitoring. It includes information about daily activity, steps, and heart rate that can be used to explore users’ habits.
## Process Data
* Tools I choose in this stage: Excel for checking duplicate data. SQL for merging data.

* Purpose for analysis: Understand the relationship between Calories and Activity.

* Files I use: dailyActivity_merged and dailyCalories_merged

### Data Cleaning
SQL Query: [Data Cleaning]

```ruby
-- first thing we want to do is create a clone table. In case something happens, we still have the data
CREATE TABLE IF NOT EXISTS
BellaBeat.Daily_Activity_Clone
CLONE `BellaBeat.Daily_Activity`;

INSERT BellaBeat.Daily_Activity_Clone
SELECT * FROM `BellaBeat.Daily_Activity`;
DROP TABLE IF EXISTS  `BellaBeat.Daily_Activity_Clone`;

-- find duplicate data from daily actitivy clone table
SELECT 
    Id,ActivityDate,TotalSteps,TotalDistance, TrackerDistance,LoggedActivitiesDistance, VeryActiveDistance,ModeratelyActiveDistance,LightActiveDistance,SedentaryActiveDistance,VeryActiveMinutes,FairlyActiveMinutes,LightlyActiveMinutes,SedentaryMinutes,Calories,
    COUNT(*) AS duplicate_count
FROM 
    `BellaBeat.Daily_Activity`
GROUP BY 
    Id,ActivityDate,TotalSteps,TotalDistance, TrackerDistance,LoggedActivitiesDistance, VeryActiveDistance,ModeratelyActiveDistance,LightActiveDistance,SedentaryActiveDistance,VeryActiveMinutes,FairlyActiveMinutes,LightlyActiveMinutes,SedentaryMinutes, Calories
HAVING 
    COUNT(*) > 1;
```
#### Query result of duplicate data:

![image](https://github.com/user-attachments/assets/ffad9099-5f17-440b-bfe2-439d41c436ea)

```ruby
--Clean duplicate data
DELETE FROM `BellaBeat.Daily_Activity`
WHERE id = 1644430081 
AND ActivityDate = '2016-04-02' 
AND TotalSteps = 20237 
AND TotalDistance = 14.710000038147 
AND TrackerDistance = 14.710000038147 
AND VeryActiveMinutes = 34 
AND Calories = 4029;
```

## Analyze and Share
SQL Query: [Data Analysis](https://github.com/SomiaNasir/Google-Data-Analytics-Capstone-Cyclistic-Case-Study/blob/main/04.%20Data%20Analysis.sql)  
Data Visualization: [Tableau](https://public.tableau.com/app/profile/somia.nasir/viz/bike-tripdata-casestudy/Dashboard1#1)  
After cleaning the data, I can start to analyze the data to gain insights and creating charts to let shareholders understand the results.

Tools I use: SQL for analysis, Tableau for creating charts.

Purpose for analysis:
1. Calories consumption from users
2. Calories comsumption and Total Steps from users
3. Calories comsumption and Active Minutes from users
4. Device usage

### 1. Calories consumption from users
I would like to know the percentage of users at each activity level. With this data, we can identify the percentage of inactive users. This will help us implement initiatives aimed at encouraging them to become more active or increase their physical activity.
Adult Daily Calorie Requirement Range:
| Active Level  | Calories Comsumptiomn |
| :------------- | :-------------: |
| Inactive  | <2000  |
| Moderately Inactive  | 2000~2200  |
| Active  | >2200 |
```ruby
--Filter out users with Calories
SELECT 
      User_Activity_Level,
      Number_of_Users,
      CONCAT(ROUND(((Number_of_users)/(sum(Number_of_users) OVER())*100),2),'%') AS Percentage
  FROM (
        SELECT
              CASE WHEN AVG_Calories < 2000 Then "Inactive"
                   WHEN  AVG_Calories BETWEEN 2000 AND 2200 Then "Moderately active"
                    ELSE "Active"
              END AS User_Activity_Level,
              COUNT (*) AS Number_of_Users,
          FROM (
                  SELECT 
                        Id,
                        ROUND(AVG(Calories),0) AS AVG_Calories
                    FROM `BellaBeat.Daily_Activity_Clone`
                  GROUP BY Id
              ) t
          GROUP BY User_Activity_Level
       ) 
GROUP BY User_Activity_Level,Number_of_Users;
```
#### Query result:

### 2. Calories comsumption and Total Steps from users
Based on the results from section 1, I would like to understand the factors contributing to user inactivity. To start, I will examine the relationship between TotalSteps and Calories.
I retrieved the TotalSteps and Calories data, and included the User_Activity_Level from the dailyActivity dataset using SQL.
The SQL code for this process is provided in the block below:
```ruby
-- Filter out users with Calories and TotalSteps
SELECT 
      Id,
      TotalSteps,
      TotalDistance,
      Calories,
      CASE WHEN Calories < 2000 OR TotalSteps < 5000 Then "Inactive" 
           WHEN Calories BETWEEN 2000 AND 2200 OR TotalSteps BETWEEN 5000 AND 9000 Then "Moderately active"
           WHEN Calories > 2200 OR TotalSteps > 10000 Then "Active"
       END AS User_Activity_Level
  FROM `BellaBeat.Daily_Activity_Clone`;
```
#### Query result:

### 3. Calories comsumption and Active Minutes from users
```ruby
--Filter out users with calories and active minutes
SELECT 
      Id,
      ROUND(AVG(((0.8*VeryActiveMinutes)+ (0.6*FairlyActiveMinutes) + (0.4* LightlyActiveMinutes) + (0.2*SedentaryMinutes))),0) AS Active_Minutes,
      ROUND(AVG(Calories),0) AS AVG_Calories,
      CASE 
        WHEN AVG(Calories) < 2000 OR ROUND(AVG(((0.8*VeryActiveMinutes)+ (0.6*FairlyActiveMinutes) + (0.4* LightlyActiveMinutes) + (0.2*SedentaryMinutes))),0) < 260 Then "Inactive"
        WHEN AVG(Calories) BETWEEN 2000 AND 2200 OR ROUND(AVG(((0.8*VeryActiveMinutes)+ (0.6*FairlyActiveMinutes) + (0.4* LightlyActiveMinutes) + (0.2*SedentaryMinutes))),0) BETWEEN 260 and 300 Then "Moderately active"
        ELSE "Active"
       END AS User_Activity_Level
  FROM `BellaBeat.Daily_Activity_Clone`
  GROUP BY Id;
```

#### Query result:

### 4. Device usage
```ruby
--Device Usage
  SELECT 
     Usage_Category,
     COUNT(*) AS Days_Used,
     CONCAT(ROUND((COUNT(*)/(sum(COUNT(*)) OVER())*100),2),'%') AS Percentage
  FROM (
        SELECT
              Id,
              COUNT(id) AS Days_Used,
              CASE WHEN COUNT(id) BETWEEN 1 AND 10 THEN "Low usage frequency (1~ 10 days)"
                   WHEN COUNT(id) BETWEEN 11 AND 20 THEN "Moderate usage frequency (11~ 20 days)"
                   ELSE "High usage frequency (21~ 30 days)"
              END Usage_Category
          FROM `BellaBeat.Daily_Activity_Clone`
          GROUP BY Id
       )
 GROUP BY Usage_Category
 ORDER BY Days_Used;
```

#### Query result:





## Act
Recommendations:

Based on the User_Activity_Level and active minutes data, 43% of users remain inactive, with slightly lower inactive minutes compared to the other two groups. To improve their health, we can present this data to raise awareness and encourage them to start small, such as taking a 10 to 15-minute walk or excersise daily. Additionally, organizing engaging competitions and activities could motivate all users, especially inactive ones, to participate and increase their activity levels through social interaction and competition. Furthermore, creating a community where users can share progress, challenges, and success stories could foster mutual motivation and support.

From the device usage data, 77% of users use our device for more than 25 days per month, indicating strong engagement. To retain these high-frequency users, we can introduce reward programs or premium features, as well as analyze their behaviors to understand what drives frequent use. For moderate and low-frequency users, we can investigate reasons for less frequent usage and address their needs by enhancing product features, providing more tips, and offering guidance to encourage increased usage.


