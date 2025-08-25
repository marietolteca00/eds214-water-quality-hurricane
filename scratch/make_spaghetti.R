library(tidyverse)
library(dplyr)
library(janitor)
library(here)
library(zoo)

brisley_one <- read_csv(here('data','QuebradaCuenca1-Bisley.csv')) %>% 
  clean_names()

brisley_two <- read_csv(here('data', 'QuebradaCuenca2-Bisley.csv')) %>% 
  clean_names()

brisley_three <- read_csv(here('data', 'QuebradaCuenca3-Bisley.csv')) %>% 
  clean_names()

prm <- read_csv(here('data','RioMameyesPuenteRoto.csv')) %>% 
  clean_names() 


prm1 <- prm %>% 
  mutate(sample_date = lubridate::ymd(sample_date))

#all_brisley <- brisley_one %>% 
  # left_join(brisley_one, brisley_two, by= "sample_id", relationship = "many-to-many") %>% 
  # left_join(brisley_two, by = "sample_id") %>% 
  # left_join(brisley_three, by = "sample_id")

#skimr::skim(all_brisley)

half_brisley<- full_join(brisley_one, brisley_two)
other_half<- full_join(brisley_three, prm)


#use rbind instead of full join. This will allow each row to be treated individually instead of a key
all_brisley <- rbind(brisley_one, brisley_two, brisley_two, prm)

# all_brisley<- full_join(half_brisley, other_half) %>% 
#   mutate(date = lubridate::ymd(sample_date),
#          year= lubridate::year(sample_date))
  

#9weeks
week_brisley <- all_brisley %>% 
  filter(year == "1989") %>% 
  filter(sample_date >= "1989-09-22",
        sample_date <= "1989-10-31") %>% 
  arrange(sample_date) %>% 
  group_by(sample_date) %>% 
  mutate(average_mg= rollmean(mg, 9,fill=NA, align='right')) # stopped at rolling mean


ggplot(data=all_brisley, aes(x= sample_date, y=k )) +
  geom_point()




