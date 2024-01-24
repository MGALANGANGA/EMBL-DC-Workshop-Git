library(tidyverse)

surveys <- read_csv("data_raw/portal_data_joined.csv")
str(surveys)
view(surveys)

select(surveys, plot_id, species_id, weight)

select(surveys, -record_id, -species_id)

filter(surveys, year == 1995)
filter(surveys, year == 1995, sex == "M")

surveys2 <- filter(surveys, weight < 5)
surveys_sml <- select(surveys2, species_id, sex, weight)
surveys_sml

select(filter(surveys, weight < 5), species_id, sex, weight)

surveys %>% 
  filter(weight < 5) %>% 
  select(species_id, sex, weight)

#Challenge
surveys %>% 
  filter(year < 1995) %>% 
  select(year, sex, weight)


#Add new columns with mutate()
surveys %>% 
  mutate(weight_kg = weight/1000) %>% 
  view()

surveys %>% 
  mutate(weight_kg = weight/1000, weight_lb = weight_kg*2.2) %>% 
  view()

surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(weight_kg = weight/1000) %>% 
  head()


#Group_by() function
surveys %>% 
  group_by(sex) %>% 
  summarise(mean_weight = mean(weight, na.rm = TRUE))

surveys %>% 
  filter(!is.na(sex)) %>% 
  group_by(sex) %>% 
  summarise(mean_weight = mean(weight, na.rm = TRUE))

surveys %>% 
  group_by(sex, species_id) %>% 
  summarise(mean_weight = mean(weight, na.rm = TRUE))

surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(sex, species_id) %>% 
  summarise(mean_weight = mean(weight, na.rm = TRUE)) %>% 
  tail()

surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(sex, species_id) %>% 
  summarise(mean_weight = mean(weight, na.rm = TRUE)) %>% 
  print (n = 15)

surveys %>% 
  filter(!is.na(weight), !is.na(sex)) %>% 
  group_by(sex, species_id) %>% 
  summarise(mean_weight = mean(weight, na.rm = TRUE)) %>% 
  print (n = 15)

surveys %>% 
  filter(!is.na(weight), !is.na(sex)) %>% 
  group_by(sex, species_id) %>% 
  summarise(mean_weight = mean(weight, na.rm = TRUE), min_weight = min(weight)) %>% 
  print (n = 15)

surveys %>% 
  filter(!is.na(weight), !is.na(sex)) %>% 
  group_by(sex, species_id) %>% 
  summarise(mean_weight = mean(weight, na.rm = TRUE), min_weight = min(weight)) %>% 
  arrange(desc(min_weight))

surveys %>% 
  filter(!is.na(weight), !is.na(sex)) %>% 
  group_by(sex, species_id) %>% 
  summarise(mean_weight = mean(weight, na.rm = TRUE), min_weight = min(weight, na.rm = TRUE)) %>% 
  arrange(min_weight)

surveys %>% 
  count(sex, species) %>% 
  arrange(species, desc(n))

#Challenge
surveys %>% 
  count(plot_type)

surveys %>% 
  filter(!is.na(hindfoot_length)) %>% 
  group_by(species_id) %>% 
  summarise(
    mean_hindfoot_length = mean(hindfoot_length),
    min_hindfoot_length = min(hindfoot_length),
    max_hindfoot_length = max(hindfoot_length),
    n=n()) %>% 
  View()

surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(year) %>% 
  filter(weight == max(weight)) %>%
  select(year, genus, species_id, weight) %>%
  arrange(year) %>% 
  unique()
