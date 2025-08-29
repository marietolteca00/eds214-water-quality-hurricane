# Sourcing the results from the intermediate folder, use data_import.R
source(here("intermediate_results","data_import.R"))

library(tidyverse)
library(dplyr)
library(here)


#use rbind instead of full join. This will allow each row to be treated individually instead of a key
# Joining all csv's into one dataframe
all_brisley <- rbind(brisley_one, brisley_two, brisley_three, prm) 


# Create a clean dataframe by filtering, mutating and group by     
all_brisley1 <- all_brisley %>% 
  
  
  # Selecting columns that I am interested in.
  select(sample_id, sample_date, no3_n, k, mg, ca, nh4_n) %>% 
  
  
  #Using mutate create a column called year, to have only the year
  mutate(year = lubridate::year(sample_date)) %>% 
  
  
  #Using filter, grab the dates interested in before and after events
  filter(year >= 1988 & year <= 1994) %>% 
  
  
  # Arrange by sample_date to have them in order
  arrange(sample_date) %>% 
  
  
  # Pivot_longer to have data together within a column
  pivot_longer(cols = c(nh4_n, no3_n, k, mg, ca), # inputting columns we want to add in one
               
               names_to = "stream_ion", # column title
               
               values_to = "concentration") #values of each concentration


# Calculating rolling average
rolling_avg <- all_brisley1 %>% 
  group_by(sample_id, stream_ion) %>% 
  mutate(rollin_avg = sapply(
    sample_date,
    # using function made from 'Rolling_average.R'
    moving_average, 
    dates = sample_date,
    conc = concentration,
    win_size_wks = 9)) %>% 
  
  ungroup()


# Save 
saveRDS(rolling_avg, file = here("outputs", "rolling_avg_1.RDS"))
