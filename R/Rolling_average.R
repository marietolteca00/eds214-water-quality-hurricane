# Adding sample_dates as usable dates when using functions
all_brisley$sample_date <- as.Date(all_brisley$sample_date)

# Creating moving average function
# assigning parameters
moving_average <- function(sample_date, dates, conc, win_size_wks) {
  is_in_window <- (dates > sample_date - (win_size_wks/2) * 7) &
    (dates > sample_date + (win_size_wks/2) * 7)
  
  window_cone <- conc[is_in_window]
  
  results <- mean(window_cone)
  
  return(results)
  
}

# First attempt at seeing it will work
ca_ma_1988_01_05 <- moving_average(sample_date = as.Date("1988-01-05"),
                                   dates = all_brisley$sample_date,
                                   conc = all_brisley$ca,
                                   win_size_wks = 9)


# Creating a column for rolling output, 

# ca
all_brisley$ca_rolling <- sapply( 
  all_brisley$sample_date,
  moving_average,
  dates = all_brisley$sample_date,
  conc = all_brisley$ca,
  win_size_wks = 9)


#no3_n
all_brisley$no3_rolling <- sapply( 
  all_brisley$sample_date,
  moving_average,
  dates = all_brisley$sample_date,
  conc = all_brisley$no3_n,
  win_size_wks = 9)


# k
all_brisley$k_rolling <- sapply(  
  all_brisley$sample_date,
  moving_average,
  dates = all_brisley$sample_date,
  conc = all_brisley$k,
  win_size_wks = 9)


# mg
all_brisley$mg_rolling <- sapply( 
  all_brisley$sample_date,
  moving_average,
  dates = all_brisley$sample_date,
  conc = all_brisley$mg,
  win_size_wks = 9)


# nh4
all_brisley$nh4_n_rolling <- sapply( 
  all_brisley$sample_date,
  moving_average,
  dates = all_brisley$sample_date,
  conc = all_brisley$nh4_n,
  win_size_wks = 9)



