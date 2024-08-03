# Overall, data seems to be cleaned having columns appropriately named but datatypes for some columns need to be redefined to perform smooth calculations.
# Before continuing with our dataset, lets do some cleaning. 
# Though the cleaning process can be performed in-situ, it is advisable to check for any null enteries or anomaly in the dataset.

cyclistic_2020_transformed = cyclistic_2020 |> mutate(
  rideable_type = as.factor(rideable_type),
  member_type = as.factor(member_casual),
  start_station_id = as.numeric(start_station_id),
  end_station_id = as.numeric(end_station_id),
  start_lat = as.numeric(start_lat),
  start_lng = as.numeric(start_lng),
  end_lat = as.numeric(end_lat),
  end_lng = as.numeric(end_lng),
  start_station_name = as.character(start_station_name),
  end_station_name = as.character(end_station_name)
  
)

sum(is.na(cyclistic_2020_transformed))

# So, we have found 4 null values 

cleaned_df = cyclistic_2020_transformed |> drop_na()