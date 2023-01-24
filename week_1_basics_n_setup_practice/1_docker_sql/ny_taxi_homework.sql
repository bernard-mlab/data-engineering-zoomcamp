-- Now run the command to get help on the "docker build" command
-- Which tag has the following text? - Write the image ID to the file
-- >> docker build --help

-- Run docker with the python:3.9 image in an interactive mode and the entrypoint of bash.
-- Now check the python modules that are installed ( use pip list).
-- How many python packages/modules are installed?
-- >> sudo docker run -it --entrypoint=bash python:3.9

-- How many taxi trips were totally made on January 15?
SELECT
  COUNT(*) AS trips
FROM green_trip_data
WHERE
  DATE(lpep_pickup_datetime) = '2019-01-15'
  AND DATE(lpep_dropoff_datetime) = '2019-01-15'
;

-- Which was the day with the largest trip distance Use the pick up time for your calculations.
SELECT
  lpep_pickup_datetime
FROM green_trip_data
ORDER BY Trip_distance DESC
LIMIT 1
;

-- In 2019-01-01 how many trips had 2 and 3 passengers?
SELECT
  Passenger_count,
  COUNT(*)
FROM green_trip_data
WHERE
  DATE(lpep_pickup_datetime) = '2019-01-01'
GROUP BY 1
HAVING Passenger_count BETWEEN 2 AND 3
ORDER BY 1
;

-- For the passengers picked up in the Astoria Zone which was the drop off zone that had the largest tip?
-- We want the name of the zone, not the id.
SELECT
  trip.index,
  trip.lpep_pickup_datetime,
  trip.lpep_dropoff_datetime,
  trip."PULocationID",
  pu_zone."Zone" AS pickup_zone,
  trip."DOLocationID",
  do_zone."Zone" AS dropoff_zone,
  trip.tip_amount
FROM green_trip_data AS trip
LEFT JOIN dim_taxi_zone AS pu_zone
 	   ON trip."PULocationID" = pu_zone."LocationID"
LEFT JOIN dim_taxi_zone AS do_zone
 	   ON trip."DOLocationID" = do_zone."LocationID"
WHERE
  pu_zone."Zone" = 'Astoria'
ORDER BY trip.tip_amount DESC
LIMIT 1
;
