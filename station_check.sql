SELECT * 
FROM `marine-cycle-315514.tripdata.uncleaned_data`
WHERE 
  start_station_name IS NULL
  OR
  end_station_name IS NULL
--End station info missing, leading to missing values for ride_distance
--Missing station info in 2,33,112 rows
