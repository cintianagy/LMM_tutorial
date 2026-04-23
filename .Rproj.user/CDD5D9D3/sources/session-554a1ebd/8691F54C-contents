library(shiny)
library(bslib)
library(tidyverse)
library(afex)

# ui
ui <- page_fluid(
  navset_tab( 
    nav_panel("1. Miért hasznos az LMM?", "Page A content"), 
    nav_panel("2. Fix és random hatások", "Page B content"), 
    nav_panel("3. Modellillesztés példa", "Page C content"),
    nav_panel("4. Modellillesztés R-ben", "content"),
    nav_panel("5. Lehetséges problémák és kezelésük", "content"),
    nav_panel("6. Módszerek és eredmények közlése", "content"),
    nav_panel("7. Kitekintés", "content"),
    nav_panel("8. Források és köszönetnyilvánítás", "content")
  ), 
  id = "tab" 
)

# server
server <- function(input, output) {
  
  data <- reactive({
    simulate_data(input$n_subj, 20, input$sd_intercept, input$sd_slope, 1)
  })
  
  output$plot <- renderPlot({
    df <- data()
    ggplot(df, aes(x, y, group = subj)) +
      geom_line(alpha = 0.3)
  })
  
  model <- eventReactive(input$fit, {
    lmer(y ~ x + (1 + x | subj), data = data())
  })
  
  output$model <- renderPrint({
    model()
  })
}

shinyApp(ui, server)
