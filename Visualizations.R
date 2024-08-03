library(dplyr)
library(ggplot2)
library(gridExtra)


# Weekly Ride Trends ------------------------------------------------------


df_counts <- df_cyclistic %>%
  group_by(day_of_week, member_casual) %>%
  summarize(count_ride_id = n(), .groups = 'drop') %>%
  arrange(desc(count_ride_id))

# Create separate DataFrames for 'Casual' and 'Member'
df_casual <- df_counts %>% filter(member_casual == 'casual')
df_member <- df_counts %>% filter(member_casual == 'member')

# Plotting
fig1 <- ggplot(df_member, aes(x = day_of_week, y = count_ride_id)) +
  geom_bar(stat = 'identity', fill = 'blue') +
  labs(title = 'Annual Members', x = 'Day of Week', y = 'No. of Riders') +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

fig2 <- ggplot(df_casual, aes(x = day_of_week, y = count_ride_id)) +
  geom_bar(stat = 'identity', fill = 'red') +
  labs(title = 'Casual Riders', x = 'Day of Week', y = 'No. of Riders') +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Combine the two plots side by side
grid.arrange(fig1, fig2, ncol = 2)


# User Proportions --------------------------------------------------------




prop <- df_cyclistic %>%
  count(member_casual) %>%
  mutate(proportion = n / sum(n),
         label = paste0(member_casual, ": ", scales::percent(proportion)))

# Plotting
ggplot(prop, aes(x = "", y = proportion, fill = member_casual)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar(theta = "y") +
  geom_text(aes(label = label), position = position_stack(vjust = 0.5)) +
  labs(title = 'Proportions of Casual Riders and Membership Holders', x = NULL, y = NULL) +
  scale_fill_manual(values = c('casual' = 'red', 'member' = 'blue')) +
  theme_void() +
  theme(legend.title = element_blank())