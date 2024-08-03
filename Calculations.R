
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



