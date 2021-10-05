library(tidyverse)
library(png)


filename_rui = "Google-Analytics-Data/bq-results-20211005-141242-dwiyrbrbeytu.csv"
raw = read_csv(filename_rui)

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

ggplot(with_adjusted_types, aes(x=event_date, y=hostname))+
  geom_bar(stat='identity')

rui_all = with_adjusted_types

rui_ingest = with_adjusted_types %>% 
  filter(hostname=='ingest.hubmapconsortium.org')
rui_ingest

rui_standalone = with_adjusted_types %>% 
  filter(hostname=='hubmapconsortium.github.io')
rui_standalone

eui = with_adjusted_types %>% 
  filter(hostname=='hubmapconsortium.github.io')
