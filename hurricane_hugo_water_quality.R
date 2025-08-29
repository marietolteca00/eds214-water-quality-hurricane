#Over the course of this week, you’re going to reproduce figure 3 from Schaefer et al. (2000). Your goal for today is to gather the data, make an analysis plan, and write the code to process and visualize the data. By the end of the week, you will organize your analysis and document your workflow. Even better, you’ll do it collaboratively and prepare it to run on a high-performance cluster.

# Load in libraries for this script

library(tidyverse)
library(dplyr)
library(janitor)
library(here)


# raw_data <- read.csv(here('data','BasicFieldData-Streams.csv'))
# view(raw_data)
# skimr::skim(raw_data)

## READ In DATA: 
brisley_one <- read_csv(here('data','QuebradaCuenca1-Bisley.csv')) %>% 
  clean_names()

brisley_two <- read_csv(here('data', 'QuebradaCuenca2-Bisley.csv')) %>% 
  clean_names()

brisley_three <- read_csv(here('data', 'QuebradaCuenca3-Bisley.csv')) %>% 
  clean_names()

prm <- read_csv(here('data','RioMameyesPuenteRoto.csv')) %>% 
  clean_names() 

  
  
