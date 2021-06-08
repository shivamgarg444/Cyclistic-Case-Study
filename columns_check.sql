---Check for missing values in other columns
SELECT * 
FROM `marine-cycle-315514.tripdata.uncleaned_data`
WHERE 
  start_day IS NULL
  OR
  started_at IS NULL
  OR 
  ended_at IS NULL
  OR
  member_casual IS NULL
  
-- No issues found

