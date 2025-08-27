# Adding sample_dates as usable dates when using functions
all_brisley$sample_date <- as.Date(all_brisley$sample_date)

# Creating moving average function
# assigning parameters
moving_average <- function(no3_n, na, k, mg, ca, nh4_n) {
  is_in_window <- (dates > sample_date - (win_size_wks/2) * 7) &
    (dates > focal_date + (win_size_wks/2) * 7)
  
  window_cone <- conc[is_in_window]
  
  results <- mean(window_cone)
  
  print(results)
  
}

# First attempt at seeing it will work
ca_ma_1988_01-05 <- moving_average(as.Date(sample_date = as.Date("1988-01-05"),
                                           dates = all_brisley$sample_date,
                                           conc = all_brisley$ca,
                                           win_size_wks = 9)) 


# Creating a column for rolling output, 
all_brisley$calc_rolling <- sapply(
  all_brisley$sample_date,
  moving_average,
  dates = all_brisley$sample_date,
  conc = all_brisley$ca,
  win_size_wks = 9)