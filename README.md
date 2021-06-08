
## Table of Contents

1. [Introduction](README.md#introduction)
2. [Business Task](README.md#business-task)
3. [Data](README.md#data)
4. [Processing and Cleaning](README.md#processing-and-cleaning)
5. [Analysis and Viz](README.md#analysis-and-viz)
6. [Report](README.md#report)
7. [Conclusions](README.md#conclusions)



## Introduction

The project is a part of **Google Data Analytics Certification course capstone**. The scenario involves analysis of the data of Cyclistic bike share company.

The company has two models for availing service: individual passes which are called "casual" riders and annual subscriptions called "member" riders.
The company operates in Chicago with around 6000 bicycles at 700 stations.

Maximizing the number of annual members will be key to future growth as it ensures financial sustainability and customer retention. The insights can help devise effective marketing strategies aimed to convert more casual riders into annual members.

## Business Task

How do annual members and casual riders use Cyclistic bikes differently ?

**Objective** : To clean, analyze and visualize the data to observe how casual riders use the bike rentals differently from annual member riders. 

## Data

* **Data source** : [Public data](https://divvy-tripdata.s3.amazonaws.com/index.html) from Motivate International Inc. (Divvy Bicycle Sharing Service from Chicago) under this [license](https://www.divvybikes.com/data-license-agreement).
* Cyclistic’s historical trip data (2013 onwards) available in .csv format. 
* **Our date range** : May 2020 to April 2021 (608MB data)
* The dataset has individual ride records consisting of ride start-end date & time, station information, bike type, rider type (casual/member). Rider's personally identifiable information has already been omitted.

## Processing and Cleaning

* Data imported into **BigQuery** for manipulation and analysis using SQL.
* Visualizations will be developed in **Google Data Studio**.
* Datatypes made consistent and then consolidated into one view using [this query](https://github.com/shivamgarg444/Cyclistic-Case-Study/blob/main/uncleaned_compile.sql).
* To assist in analysis, 4 new columns were added (start point location, end point location, ride start day name and ride duration in seconds).
* 3,742,624 rows were returned but required cleaning.
* **Cleaning process** :
  * Missing start and end station names found using [this query](station_check.sql).
  * Other columns checked using [this query]().
  * Negative and zero ride duration values found using [this query]().
* Following the cleaning and consolidating data in one table, 3,476,354 rows were returned for proceeding to analysis. All this can be achieved using [this single query]().

## Analysis and Viz

