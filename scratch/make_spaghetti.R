
rm(list = ls())
# Loading in packages that may be used
library(tidyverse)
library(dplyr)
library(janitor)
library(here)
library(zoo)
library(patchwork)


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




# create a clean dataframe by filtering, mutating and group by     
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
  pivot_longer(cols = c(nh4_n, no3_n, k, mg, ca), 
               names_to = "stream_ion", # column title
               values_to = "concentration") #values of each concentration

# Sourcing Rolling Average
source(here("R","Rolling_average.R"))  
  
# Calculating rolling average
rolling_avg <- all_brisley1 %>% 
  group_by(sample_id, stream_ion) %>% 
  mutate(rollin_avg = sapply(
    sample_date,
    moving_average,
    dates = sample_date,
    conc = concentration,
    win_size_wks = 9)) %>% 
  ungroup()

# this would work if pivot_long() was not applied
# across(all_brisley1[["concentration"]], ~moving_average(dates = all_brisley1[["sample_date"]],conc = all_brisley1[["concentration"]], win_size_wks = 9))
  



# Try using the moving_average function created

# # ca
# all_brisley1$ca <- sapply(
#     all_brisley1[["sample_date"]],
#     moving_average,
#     dates = all_brisley1[["sample_date"]],
#     conc = all_brisley1[["ca"]],
#     win_size_wks = 9)
# 
# # no3_n
# all_brisley1$no3 <- sapply(
#   all_brisley1$sample_date,
#   moving_average,
#   dates = all_brisley1$sample_date,
#   conc = all_brisley1$no3_n,
#   win_size_wks = 9)
# 
# 
# # k
# all_brisley1$k <- sapply(
#   all_brisley1$sample_date,
#   moving_average,
#   dates = all_brisley1$sample_date,
#   conc = all_brisley1$k,
#   win_size_wks = 9)
# 
# 
# # mg
# all_brisley1$mg <- sapply(
#   all_brisley1$sample_date,
#   moving_average,
#   dates = all_brisley1$sample_date,
#   conc = all_brisley1$mg,
#   win_size_wks = 9)
# 
# 
# # nh4
# all_brisley1$nh4_n <- sapply(
#   all_brisley1$sample_date,
#   moving_average,
#   dates = all_brisley1$sample_date,
#   conc = all_brisley1$nh4_n,
#   win_size_wks = 9)


# REMOVE ?
  # Grab the running average on the interested chemicals
  # mutate(nh4_avg= rollmean(nh4_n, k= 1 , fill=NA)) %>%
  # mutate(ca_avg= rollmean(ca, k= 1 , fill=0)) %>%
  # mutate(mg_avg= rollmean(mg, k= 1, fill=0)) %>%
  # mutate(no3_avg= rollmean(no3_n, k= 9 , fill=0)) %>%
  # mutate(k_avg= rollmean(k, k= 1 , fill=0)) %>% 
  # mutate(ph_avg=rollmean(p_h, k=1, fill=0))
  
  #ungroup the group_by
    #ungroup() %>% 

  
  
  
# Creating plots to see if dataframe works and how it looks

# PLOT for NH4- ITS NOT WORKING :(
p1 <- ggplot(data= rolling_avg, aes(x= sample_date, y=concentration )) + # nh4
  
  # plot as line
  geom_line(aes(linetype = sample_id)) + # sample_id does not auto populate
  facet_wrap(~stream_ion, scales = "free_y", ncol=1,
             strip.position = "left")+

  # Add a vertical line to plot
  geom_vline(xintercept = as.Date("1989-09-22"), linetype = "dashed", color = "red")+
  labs(x = "Year",
       y = "Concentration Measured by ug/L",
       title = "Chemical Balance after Hurricane Hugo",
       subtitle = "Hurrican Hugo happened on 1989-09-22") +
  theme_bw()+
  
  theme(
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5),
    legend.position.inside = c(500,500) )
  
  
  # Removing x-axis and removing legend
  #theme(axis.text.x = element_blank(), legend.position = "none")

print(p1)



# p2 <- ggplot(data= all_brisley1, aes(x = sample_date, y = ca)) + # ca
#   geom_line(aes(linetype = sample_id))+
#   geom_vline(xintercept = as.Date("1989-09-22"), linetype = "dashed", color = "red")+
#   labs(x = " ",
#        y = "ca",
#        legend= " ")+
#   theme(axis.text.x = element_blank(), legend.position = c())
# 
# print(p2)
# 
# p3 <- ggplot(data= all_brisley1, aes(x= sample_date, y= mg)) + # mg
#   geom_line(aes(linetype=sample_id)) +
#   geom_vline(xintercept = as.Date("1989-09-22"), linetype = "dashed", color = "red")+
#   labs(x = " ",
#        legend= " ")+
#   theme(axis.text.x = element_blank(), legend.position = "none")
# 
# 
# p4 <- ggplot(data= all_brisley1, aes(x= sample_date, y=no3_n))+ # no3
#   geom_line(aes(linetype=sample_id))+
#   geom_vline(xintercept = as.Date("1989-09-22"), linetype = "dashed", color = "red")+
#   labs(x = " ",
#        legend= " ")+ 
#   theme(axis.text.x = element_blank(), legend.position = "none")
# 
# 
# p5 <- ggplot(data= all_brisley1, aes(x= sample_date, y= k)) + # k
#   geom_line(aes(linetype=sample_id))+
#   geom_vline(xintercept = as.Date("1989-09-22"), linetype = "dashed", color = "red")+
#   labs(x = " ",
#        legend= " ")+
#   theme(legend.justification.inside = "top,right")
# 
# print(p5)
# 
# 
# 
# #DRAFT - Attempting to make plots in one >>>
# combine_plots<- (p5/ p4/ p3/ p2/ p1)
# 
# 
# # Printing plots
# print(combine_plots)
# 
# 

# 
# #9weeks breaks! 
# week_brisley <- all_brisley %>% 
#   filter(sample_date >= "1989-09-22",
#         year <= "1994") %>% 
#   arrange(sample_date) %>% 
#   group_by(sample_date) %>% 
#   mutate(average_mg= rollmean(mg, 9,fill=NA, align='right')) # stopped at rolling mean

#DRAFT - Attemping to make plots in one >>>


#combine_plots<- no3_avg + nh4_avg
#print(combine_plots)





