library(shiny)
library(bslib)
library(tidyverse)
library(afex)

page6_outlook_ui <- function() {
  page_fluid(
    tags$head(
      tags$link(rel = "stylesheet", href = "styles.css")
    ),
    h2("Kitekintés"),
    p()
  )
}