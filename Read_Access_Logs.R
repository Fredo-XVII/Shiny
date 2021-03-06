# Reading log file code 

# source: https://www.r-bloggers.com/log-file-analysis-with-r/

# Testing
log_path <- './app_logs/'
curr_log <- Read_Access_Logs(path = log_path)

Read_Access_Logs <- function(path) {
  
  # Read log
  #df = readr::read_log('./app_logs/access.log')
  file <- paste0(path,'access.log')
  df = readr::read_log(file)
  
  # Separate Columns
  df1 <- df %>% tidyr::separate(X1, into = paste("addr", 0:5, sep = "_"))
  df1 <- df1 %>% tidyr::separate(X5, into = paste("V", 1:5, sep = "_"))
  
  # Build the date variables
  df1$datetime_str <- stringr::str_split_fixed(df1$X4," ",n = 2)
  df1$datetime_str2 <- gsub("/", "-",df1$datetime_str[,1])
  df1$datetime_str3 <- stringr::str_replace(df1$datetime_str2,":"," ")
  df1$datetime_str4 <- lubridate::dmy_hms(df1$datetime_str2)
  df1$datetime_str4 <- lubridate::with_tz(df1$datetime_str4, tzone = "US/Central") # question if needed
  df1$greg_d <- lubridate::date(df1$datetime_str4)
  df1$yr_i <- lubridate::year(df1$datetime_str4)
  df1$mth_i <- lubridate::month(df1$datetime_str4)
  df1$day_i <- lubridate::day(df1$datetime_str4)
  df1$wk_day_n <- lubridate::wday(df1$datetime_str4)
  df1$hr_i <- lubridate::hour(df1$datetime_str4)
  df1$min_i <- lubridate::minute(df1$datetime_str4)
  
  # Select final set of variables and rename variables
  df2 <- df1 %>% dplyr::select(addr_1:addr_5,V_1:X7,datetime_str4:min_i) %>%
    dplyr::rename(http_method = V_1,
                  http_type = V_2,
                  http_type_n = V_3,
                  http_up_down = V_4,
                  http_other = V_5,
                  http_resp = X6,
                  http_size = X7,
                  date_time = datetime_str4) %>%
    dplyr::mutate(ip = paste(addr_2,addr_3,addr_4,addr_5, sep = ".")) %>%
    ## filters out rows of no interest
    dplyr::filter(http_type %in% c("HTTP","session"))

  # Query the data down to the date and time - automation portal
  run_end_dt <- lubridate::as_datetime(paste0('<PARM="PERIOD_END"/>'," ",'<PARM="PERIOD_END_TM"/>'))
  run_start_dt <- run_end_dt - lubridate::hours(1)
  df2_slim <- df2 %>% dplyr::filter(
    dplyr::between(date_time, 
                   left = run_start_dt,
                   right = run_end_dt)
    )
  
  # Get lat longs for IP address
  df3 <- IPtoCountry::IP_location(df2$ip) # add df2_slim for automation portal
  
  # Merge IP data  
  df4 <- df2 %>% cbind(df3)

  # Write data to disk
  readr::write_csv(df4,path = paste0(path,'app_access_logs.csv'),append = TRUE)
  
  return(df4)
  
  # Remove columns that are not needed
  # addr_1:addr_5

  
}
