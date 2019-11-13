# The pictures go in a www folder that sits next to the app.R file.
# UI - SIDE *******************************************************************
ui <- fluidPage(
  # Browser Options -----------------------------------------------------------
  
  ## Browser tab logo
  tags$head(tags$link(rel="shortcut icon", href="favicon.ico")),
  tags$head(tags$link(rel="icon", type="image/png", href="favicon-32x32.png", sizes="32x32")),
  tags$head(tags$link(rel="apple-touch-icon", type="image/png", href="favicon-32x32.png", sizes="32x32")),

  ## Application title
  titlePanel(
    title = div(
    img(
      src = "logo.png",
      height = 100,
      width = 100
      ), "Shiny App Title"),
    windowTitle = "Shiny App Title"),
  br(),
