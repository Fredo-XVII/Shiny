# Demo Shiny App
# source: http://shiny.rstudio.com/articles/shinyapps.html

home <- getwd()
setwd('C:\\Users\\marqu\\Documents\\Shiny')

library(devtools)
library(rsconnect)
library(shiny)
library(ggplot2)

rsconnect::setAccountInfo(name='fredoxvii',
                          token='B402329ACE6C89A4A67D989A7685ED75',
                          secret='aNZvdhgiqNcARzaSFUt1spgCp/3Y570qQBC2zTor')

# Deploy the App
rsconnect::deployApp(getwd())
library(shiny)
runApp()

# Terminate the App
terminateApp("<your app's name>")
rsconnect::terminateApp

# Closing 
save.image()
setwd(home)


