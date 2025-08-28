# Adding sample_dates as usable dates when using functions
#all_brisley1$sample_date <- as.Date(all_brisley$sample_date)

# Creating moving average function
# assigning parameters
moving_average <- function(sample_date, dates, conc, win_size_wks) {
  is_in_window <- (dates > sample_date - (win_size_wks/2) * 7) &
    (dates > sample_date + (win_size_wks/2) * 7)
  
  window_cone <- conc[is_in_window]
  
  results <- mean(window_cone)
  
  return(results)
  
}


