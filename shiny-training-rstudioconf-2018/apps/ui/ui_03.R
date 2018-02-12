library(shiny)
library(htmltools)

# Define UI for YouTube player --------------------------------------
ui <- fluidPage(
  #includeHTML("youtube_thumbnail.html")
  div(class = "thumbnail",
      div(class = "embed-responsive embed-responsive-16by9",
        tags$iframe(class = "embed-responsive-item",
          src="https://www.youtube.com/embed/hou0lU8WMgo",
          allowfullscreen= "TRUE")
      ),
  div(class = "caption",
      h3("You are technically correct"),
      div("The best kind of correct!")
  )
  )
)

# Define server logic -----------------------------------------------
server <- function(input, output, session) {
  
}

# Run the app -------------------------------------------------------
shinyApp(ui, server)

<div class="thumbnail">
  <div class="embed-responsive embed-responsive-16by9">
    <iframe class="embed-responsive-item" src="https://www.youtube.com/embed/hou0lU8WMgo" allowfullscreen=""></iframe>
      </div>
      <div class="caption">
        <h3>You are technically correct</h3>
        <div>The best kind of correct!</div>
        </div>
        </div>