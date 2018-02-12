moviemodUI <- function(id) {
  ns <- NS(id)
  tagList(
    plotOutput(ns("scatterplot")),
    DT::renderDataTable(ns("moviestable"))
    
  )
}

moviemod <- function(input, output, session) {
  
  
}