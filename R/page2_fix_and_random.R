library(shiny)
library(bslib)
library(tidyverse)
library(afex)

page2_fix_and_random_ui <- function() {
  page_fluid(
    tags$head(
      tags$link(rel = "stylesheet", href = "styles.css")
    ),
    h2("Fix és random hatások"),
    p("A lineáris kevert modell két komponensből áll: fix és random hatások. A ",
    strong("fix hatások"),
    "azok, amikre elsősorban kíváncsiak vagyunk. A ",
    strong("random hatások"),
    "viszont az adatok véletlenszerű változékonyságát ragadják meg, amelynek különböző forrásai lehetnek. A random hatások azok, amelyeken túl generalizálni szeretnék a modell érvényességét."),
    h3("Random tengelymetszet"),
    h3("Random meredekség"),
    p("Fontos megjegyezni, hogy a random hatások beléptetése nem változtatja meg a fix hatások értelmezését, hanem azt mutatja meg, hogy a random hatás különböző szintjein van-e eltérés a fix hatásban vagy sem, továbbá korrigálják az adatok nemfüggetlenségét."),
    p("A random hatásoknak a forrásuk alapján két típusa létezik: keresztezett ",
    em("(crossed)"),
    "és egymásba ágyazott", 
    em("(nested)."),
    "A",
    strong("keresztezett random hatások"),
    "akkor jelenek meg, ha a variabilitásnak nem csak egy forrása van (pl. a résztvevő), hanem több is (pl. résztvevő és az itemek nehézsége).",
    "Az ",
    strong("egymásba ágyazott random hatások"),
    "esetén az egyik random hatás egyes szintjei csak egy másik random hatás egyik szintjén jelennek meg, például random hatás, hogy melyik iskola tanulóit vizsgáljuk, de az iskolán belül az osztályok is ilyen hatást eredményeznek.")
  )
}