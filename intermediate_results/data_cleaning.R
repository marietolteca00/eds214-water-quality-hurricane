source("intermediate_results/data_import.R")

#use rbind instead of full join. This will allow each row to be treated individually instead of a key
# Joining all csv's into one dataframe
all_brisley <- rbind(brisley_one, brisley_two, brisley_three, prm)

# create a clean dataframe by filtering, mutating and group by     
all_brisley1 <- all_brisley %>% 
  
  #Using mutate create a column called year, to have only the year
  mutate(year = lubridate::year(sample_date)) %>% 
  
  #Using filter, grab the dates interested in before and after events
  filter(year >= 1988 & year <= 1994) %>% 
  
  # Arrange by sample_date to have them in order
  arrange(sample_date) %>% 
  
  # Remove these columns from the original dataframe
  select(-don:-don_code)