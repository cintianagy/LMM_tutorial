library(shiny)
library(bslib)
library(tidyverse)
library(afex)

source("R/simulation.R")
source("R/page1_intro.R")
source('R/page2_fix_and_random.R')
source("R/page4_problems_solutions.R")

# ui
ui <- page_fluid(
  tags$head(
    tags$link(rel = "stylesheet", href = "styles.css")
  ),
  navset_tab( 
    nav_panel("1. Miért hasznos az LMM?", page1_intro_ui()), 
    nav_panel("2. Fix és random hatások", page2_fix_and_random_ui()), 
    nav_panel("3. Modellillesztés R-ben", "content"),
    nav_panel("4. Lehetséges problémák és kezelésük", page4_problems_solutions_ui()),
    nav_panel("5. Módszerek és eredmények közlése", page5_reporting_ui()),
    nav_panel("6. Kitekintés", page6_outlook_ui()),
    nav_panel("7. Források és köszönetnyilvánítás", "content")
  ), 
  id = "tab" 
)

# server
server <- function(input, output, session) {
  
  output$plot_page1 <- renderPlot({
    vary.data.graph
  })
  
}

shinyApp(ui, server)
