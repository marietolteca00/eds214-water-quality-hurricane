

# Creating moving average function
# assigning parameters
#' Moving Average Function 
#'
#' @param sample_date 
#' @param dates 
#' @param conc 
#' @param win_size_wks 
#'
#' @returns
#' @export
#'
#' @examples all_brisley1$ca <- sapply( all_brisley1[["sample_date"]],
#     moving_average,
#     dates = all_brisley1[["sample_date"]],
#     conc = all_brisley1[["ca"]],
#     win_size_wks = 9)

moving_average <- function(sample_date, dates, conc, win_size_wks) {
  
  # Which dates are in the window?
  is_in_window <- (dates > sample_date - (win_size_wks / 2) * 7) &
    
    (dates < sample_date + (win_size_wks / 2) * 7)
  
  
  # Find the associated concentrations
  window_conc <- conc[is_in_window]
  
  
  # Calculate the mean
  result <- mean(window_conc,na.rm=TRUE)
  return(result)
}

