library(tidyverse)


filename = "Google-Analytics-Data/bq-results-20220126-160011-x8zuz1raqoc.csv"
raw = read_csv(filename)

# split mouse position string intoacross multiple columns

with_adjusted_types = raw %>%
  mutate(
    user_pseudo_id = as.character(user_pseudo_id),
    user_first_touch_timestamp = as.character(user_first_touch_timestamp),
    event_timestamp = as.character(event_timestamp)
    )

with_adjusted_types$event_category[is.na(with_adjusted_types$event_category)] = ""
with_adjusted_types$event_label[is.na(with_adjusted_types$event_label)] = ""
with_adjusted_types

ccf_reporter = with_adjusted_types
