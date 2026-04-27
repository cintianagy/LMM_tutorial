library(shiny)
library(bslib)
library(tidyverse)
library(afex)

page2_fix_random_ui <- function() {
  page_fluid(
    tags$head(
      tags$link(rel = "stylesheet", href = "styles.css")
    ),
    h2(),
    p()
  )
}