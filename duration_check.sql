SELECT * 
FROM `marine-cycle-315514.tripdata.uncleaned_data`
WHERE
  ride_total_seconds <= 0
-- 38,376 rows with negative and zero values found for total duration, can skew the data
