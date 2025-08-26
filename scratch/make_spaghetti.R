
# Loading in packages that may be used
library(tidyverse)
library(dplyr)
library(janitor)
library(here)
library(zoo)


# Reading in CSV files and assigning into dataframes
brisley_one <- read_csv(here('data','QuebradaCuenca1-Bisley.csv')) %>% 
  clean_names()

brisley_two <- read_csv(here('data', 'QuebradaCuenca2-Bisley.csv')) %>% 
  clean_names()

brisley_three <- read_csv(here('data', 'QuebradaCuenca3-Bisley.csv')) %>% 
  clean_names()

prm <- read_csv(here('data','RioMameyesPuenteRoto.csv')) %>% 
  clean_names() 


#use rbind instead of full join. This will allow each row to be treated individually instead of a key
# Joining all csv's into one dataframe
all_brisley <- rbind(brisley_one, brisley_two, brisley_three, prm)


# ways to clean up dataframe with interested     
all_brisley <- all_brisley %>% 
  
  #Using mutate create a column called year, to have only the year
  mutate(year = lubridate::year(sample_date)) %>% 
  
  #Using filter, grab the dates interested in before and after events
  filter(year >= 1988 & year <= 1999) %>% 
  
  # Arrange by sample_date to have them in order
  arrange(sample_date) %>% 
  
  # Remove these columns from the original dataframe
  select(-don:-don_code) %>% 
  
  #group by sample_id
  group_by(sample_id) %>%
  
  # Grab the running average on the interested chemicals
  mutate(nh4_avg= rollmean(nh4_n, k= 1 , fill=NA)) %>%
  mutate(ca_avg= rollmean(ca, k= 1 , fill=0)) %>%
  mutate(mg_avg= rollmean(mg, k= 1, fill=0)) %>%
  mutate(no3_avg= rollmean(no3_n, k= 9 , fill=0)) %>%
  mutate(k_avg= rollmean(k, k= 1 , fill=0)) %>% 
  mutate(ph_avg=rollmean(p_h, k=1, fill=0))
  
  #ungroup the group_by
    #ungroup() %>% 

  
  
  
# Creating plots to see if dataframe works and how it looks
ggplot(data= all_brisley, aes(x= sample_date, y=k_avg ))+
  geom_line(aes(color=sample_id))


ggplot(data= all_brisley, aes(x= sample_date, y= nh4_avg)) +
  geom_line(aes(color=sample_id))


#9weeks breaks! 
week_brisley <- all_brisley %>% 
  filter(year == "1989") %>% 
  filter(sample_date >= "1989-09-22",
        year <= "1994") %>% 
  arrange(sample_date) %>% 
  group_by(sample_date) %>% 
  mutate(average_mg= rollmean(mg, 9,fill=NA, align='right')) # stopped at rolling mean

#DRAFT>>>
ggplot(data=all_brisley, aes(x= sample_date, y=k )) +
  geom_line()






