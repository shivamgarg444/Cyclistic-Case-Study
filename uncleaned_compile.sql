---- Data compilation only

WITH 
  temp_2020 AS (        -- temp table 1 : makes datatypes consistent, compiles may-nov 2020 data using UNION ALL 
    SELECT 
      ride_id,
      rideable_type,
      started_at,
      ended_at,
      start_station_name,
      CAST(start_station_id AS STRING) AS start_id,    -- datatypes of stations ids were not consistent for all data files
      end_station_name,
      CAST(end_station_id AS STRING) AS end_id,
      start_lat,
      start_lng,
      end_lat,
      end_lng,
      member_casual	
    FROM (
         SELECT *
         FROM `marine-cycle-315514.tripdata.052020`
         UNION ALL
         SELECT * 
         FROM `marine-cycle-315514.tripdata.062020`
         UNION ALL
         SELECT * 
         FROM `marine-cycle-315514.tripdata.072020`
         UNION ALL
         SELECT *
         FROM `marine-cycle-315514.tripdata.082020`
         UNION ALL
         SELECT *
         FROM `marine-cycle-315514.tripdata.092020`
         UNION ALL
         SELECT *
         FROM `marine-cycle-315514.tripdata.102020`
         UNION ALL
         SELECT * 
         FROM `marine-cycle-315514.tripdata.112020`)
         ),
  temp_all AS (        -- temp table 2 : compiles data from dec 2020, jan-apr 2021, and temp table 1(may-nov 2020) 
    SELECT *
    FROM `marine-cycle-315514.tripdata.122020`
    UNION ALL 
    SELECT *
    FROM `marine-cycle-315514.tripdata.012021`
    UNION ALL 
    SELECT *
    FROM `marine-cycle-315514.tripdata.022021`
    UNION ALL 
    SELECT *
    FROM `marine-cycle-315514.tripdata.032021`
    UNION ALL 
    SELECT *
    FROM `marine-cycle-315514.tripdata.042021`    
    UNION ALL 
    SELECT *
    FROM temp_2020
    ),
  temp_metrics AS (        -- temp table 3 : adding new metrics for analysis and viz using data from temp table 2 (all data)      
    SELECT  
      ride_id,
      TIMESTAMP_DIFF(ended_at, started_at, SECOND) AS ride_total_seconds,    -- To calculate ride duration in seconds
      ST_GEOGPOINT(start_lng, start_lat) AS start_point,    -- To get a single value from given lat-long (used further to get distance)
      ST_GEOGPOINT(end_lng, end_lat) AS end_point,
      CASE
            WHEN EXTRACT(DAYOFWEEK FROM started_at) = 1 THEN 'Sunday'
            WHEN EXTRACT(DAYOFWEEK FROM started_at) = 2 THEN 'Monday'
            WHEN EXTRACT(DAYOFWEEK FROM started_at) = 3 THEN 'Tuesday'
            WHEN EXTRACT(DAYOFWEEK FROM started_at) = 4 THEN 'Wednesday'
            WHEN EXTRACT(DAYOFWEEK FROM started_at) = 5 THEN 'Thursday'
            WHEN EXTRACT(DAYOFWEEK FROM started_at) = 6 THEN 'Friday'
            WHEN EXTRACT(DAYOFWEEK FROM started_at) = 7 THEN 'Saturday'
            END AS start_day     -- To get ride start day names
    FROM temp_all
    )
-- Call for final data set, joining new metrics (temp table 3) with all data (temp table 2)
-- Can ignore unnecessary columns here like lat-long
SELECT        
  a.ride_id,
  a.rideable_type,
  b.start_day,
  a.started_at,
  a.ended_at,
  b.ride_total_seconds,
  a.start_station_name,
  a.start_station_id,
  a.end_station_name,
  a.end_station_id,
  ST_DISTANCE(b.start_point, b.end_point) AS ride_distance,    -- To compute distance in meters
  a.member_casual
FROM
  temp_all AS a       -- temp table 2
JOIN
  temp_metrics AS b        -- temp table 3
ON a.ride_id = b.ride_id

---Query result saved in a permanent table : uncleaned_data
