# Water Quality Hurricane Disturbance in Puerto Rico Concentrations

## Hurricane Hugo affects during 1989-1999, focused on chemical balances

The goal of this repository to recreate the image from the original reports, with customization in visualization. Here you can find a guide on how the information was gathered, uploaded, tidy wrangled, and create a reproducible code to try other methods.

# Retrievable EDI Repository

The data was read into R studio, where the data was downloaded using the EDI repository. [<https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-luq.20.4923064>].

The citation for this paper is Schaefer DouglasA, McDowell WH, Scatena FN, Asbury CE. Effects of hurricane disturbance on stream water concentrations and fluxes in eight tropical forest watersheds of the Luquillo Experimental Forest, Puerto Rico. Journal of Tropical Ecology. 2000;16(2):189-207. <doi:10.1017/S0266467400001358>.

Author: Marie Tolteca (marietolteca00), UCSB Bren School of Environmental Data Science, Student Cohort 2025-2026.

# Flowchart- Thought Process

Libaries and Install Packages required for this repository are: tidyverse, dplyr, janitor, here, zoo, lubridate, and patchwork 

- Start by reading in the downloaded csv's from the EDI repository and assigning them into a variable for Brisley Quebrada 1-3 and Rio Mameyes Puente Roto.

- Once those csv are stored into a variable use 'rbind()' to create a combined join on all datasets. This will be stored into another variable with its combined dataframes.

- Starting the tidy wrangling proccess by removing columns that will not be needed, filtering by date, and grouping by. 

- Create a function on a separate R.script. Here you will create a funciton for rolling average that will be used for each concentration.

- After the function is complete and run, use it on a separate original R script and assigned it to each concentration that a rolling average is needed. 

- Finally, a plot will be created for all concentrations. After each plot is created, combined the plots and assign them into a different vector, this will store plots and configure a plot with all the information.

