library(shiny)
library(bslib)
library(tidyverse)
library(afex)

page5_reporting_ui <- function() {
  page_fluid(
    tags$head(
      tags$link(rel = "stylesheet", href = "styles.css")
    ),
    h2("Módszerek és eredmények közlése"),
    p("Az eredmények reprodukálhatósága érdekében az alábbi információkat kell közölnünk:"),
    tags$ul(
      tags$li("Programok és csomagok pontos verzió"),
      tags$li("Az adatszűrés lépései"),
      tags$li("Teljesültek-e a feltételek"),
      tags$li("Fix és random hatások"),
      tags$li("A modellszelekció lépései"),
      tags$li("Konvergencia probléma és hogyan oldottuk meg őket"),
      tags$li(" A vgéső modell egyenlete"),
      tags$li("A végső modell részletei: fix hatások (együtthatók, standard hiba/konfidencia intervallum, teszt statisztikák és p-értékek), random hatások (szórás/variancia), illeszkedési mutatók"),
      tags$li("Adatok és elemzőkódok")
    )
  )
}