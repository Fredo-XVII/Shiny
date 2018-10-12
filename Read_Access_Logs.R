# Reading access log file code for Shiny Server

# source: https://www.r-bloggers.com/log-file-analysis-with-r/

## Read log
df = read.table('./app_logs/access.log')

colnames(df) <- c('host','Blank1','Blank2','Date','UTC','http-version_http-method','status','resp_lgth')

df$date=as.Date(df$Date,"[%d/%b/%Y")
