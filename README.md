
## Table of Contents

1. [Introduction](README.md#introduction)
2. [Business Task](README.md#business-task)
3. [Data](README.md#data)
4. [Processing and Cleaning](README.md#processing-and-cleaning)
5. [Analysis and Viz](README.md#analysis-and-viz)
6. [Report](README.md#report)
7. [Conclusions](README.md#conclusions)

## Introduction

The project is a part of **Google Data Analytics Certification course capstone**. The scenario involves analysis of the trip data of Cyclistic bike share company.

The company has two models for availing service: individual passes which are called "casual" riders and annual subscriptions called "member" riders.
The company operates in Chicago with around 6000 bicycles at 700 stations.

Maximizing the number of annual members will be key to future growth as it ensures financial sustainability and customer retention. The insights can help devise effective marketing strategies aimed to convert more casual riders into annual members.

## Business Task

How do annual members and casual riders use Cyclistic bikes differently ?

> **Objective** : To clean, analyze and visualize the data to observe how casual riders use the bike rentals differently from annual member riders. 

## Data

* **Data source** : Public data from Motivate International Inc. (Divvy Bicycle Sharing Service from Chicago) under this [license](https://www.divvybikes.com/data-license-agreement).
* [Cyclistic’s historical trip data](https://divvy-tripdata.s3.amazonaws.com/index.html) (2013 onwards) available in `.csv` format. 
* **Our date range** : May 2020 to April 2021 (608 MB data)
* The dataset has individual ride records consisting of ride start-end date & time, station information, bike type, rider type (casual/member).
* Data uploaded to Google Cloud Storage(GCS) in order to import the large files.

## Processing and Cleaning

* Data imported from GCS into **BigQuery** for manipulation and analysis using SQL.
* Visualizations to be developed in **Google Data Studio**.
* Datatypes made consistent and then consolidated into one view using [this query](https://github.com/shivamgarg444/Cyclistic-Case-Study/blob/main/uncleaned_compile.sql).
* To assist in analysis, 4 new columns were added (start point location, end point location, ride start day name and ride duration in seconds).
* `3,742,624` rows were returned but required cleaning.
* **Cleaning process** :
  * Missing start and end station names found using [this query](station_check.sql).
  * Other columns checked using [this query](columns_check.sql).
  * Negative and zero ride duration values found using [this query](duration_check.sql).
> Following the cleaning and consolidating data in one table, `3,476,354` rows were returned for proceeding to analysis. All of this was achieved using [this single master query](single_query.sql). `JOIN`, `WITH`, `UNION ALL`, `WHERE`, _subqueries_ and many other SQL functions were used here.

## Analysis and Viz

The final dataset containing trip data of roughly 3.4 million ride records was analyzed. 
Visualizations were made to observe differential trends between the usage by casual riders and annual members.  


> ### Total ride share
![piechart](viz/pie_chart.PNG)
#### **Insights**
* 58.6% of total rides (3.4M) were taken by annual members.
* 41.4% of total rides were taken by casual riders.
* Annual members form the majority of business for the company and maximizing on this number should be the focus in the long run.


> ### Weekly distribution of number of rides
![line_chart_1](viz/line_chart_1.PNG)
#### **Insights**
* Clearly, the rides taken by casual riders peak throughout Friday, Saturday and Sunday as compared to that of annual members which remains relatively flat. 
* About 50% less casual riders use the rentals during weekdays as compared to weekends.  
* This indicates that casual riders use the bike rentals for leisure purposes and not for commuting. 

> ### Weekly distribution of average ride duration
![line_chart_2](viz/line_chart_2.PNG)
#### **Insights**
* The average ride duration of casual members is 2-3 times that of annual members.
* The average ride duration both type of riders increase on weekends.
* Again, this indicates that casual riders use the bike rentals for leisure purposes.


> ### Ride duration vs Ride distance
![bars](viz/bars_dist_duration.PNG)
#### **Insights**
* The plots clearly show the contrast between average ride duration and average ride distance  for both user types. 
* While both user types ride a similar average distance, casual riders ride for 3x longer duration as compared to annual members.   

> ### Hourly distribution of number of rides
![bar_hour](viz/bar_hour.PNG)
#### **Insights**
* The proportion of casual riders increases in the non-commuting hours ie in forenoon hours and after 8pm from 0.25x of total rides to 1.5x of total rides.
* Annual members take the major chunk of the rides during peak-travel hours in the morning and evening by upto 4x of casual members. 
* Again, this indicates that casual riders use the bike rentals for leisure purposes while annual members use it for commuting.


> ### Monthly distribution of number of rides - Seasonality 
![bar_season](viz/bar_season.PNG)
#### **Insights**
* The proportion of casual riders falls drastically during winter months(Dec-Feb) to only about 1/4th of total rides.
* The proportion of casual riders goes maximum in the months of June, July, August and September to upto half of total rides.



## Conclusion
