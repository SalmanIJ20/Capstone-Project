

library(dplyr)
library(lubridate)
library(hms)

# Columns for ride length and day of week---------------------------------------------


# we are going to create new columns for ride_length and day of week

day_mapping <- c(
  "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"
)

df_cyclistic <- cleaned_df |>
  mutate(
    ride_length = hms::as_hms(ended_at - started_at),
    day_of_week = day_mapping[wday(started_at)]
    
  )

View(df_cyclistic)


# Calculating Average Ride Length and Max Ride Length ---------------------

df_new <- df_cyclistic |>
  group_by(member_casual) |>
  summarise(
    average_ride_length = as_hms(mean(ride_length,)),
    max_ride_length = as_hms(max(ride_length)) 
  ) %>%
  ungroup()

View(df_new)


# Frequent Trip Route -----------------------------------------------------


df_cyclistic <- df_cyclistic |>
  mutate(trip_route = paste(start_station_name, 'to', end_station_name))

# Group by member_type and find the most frequent trip_route
most_frequent_routes <- df_cyclistic |>
  group_by(member_casual) %>%
  summarize(most_frequent_trip_route = trip_route %>%
              table() |>
              which.max() |>
              names(),
            .groups = 'drop')

# Join to get the frequency of each most frequent trip_route
g <- df_cyclistic |>
  group_by(member_casual, trip_route) |>
  tally(name = 'frequency') |>
  right_join(most_frequent_routes, by = c('member_casual', 'trip_route' = 'most_frequent_trip_route')) %>%
  arrange(member_casual)

# Print the result
print(g)