library(shiny)
library(bslib)
library(tidyverse)
library(afex)

page4_problems_solutions_ui <- function() {
  page_fluid(
    tags$head(
      tags$link(rel = "stylesheet", href = "styles.css")
    ),
    h2("Lehetséges problémák és kezelésük"),
    p("Egy gyakori probléma a modellillesztés során, a szinguláris illeszkedés ",
    em("(singular fit),"),
    "amikoris a program nem tudja az összes paramétért becsülni. Ennek egy megoldása lehet a modell egyszerűsítése, amely során kevesebb random hatást becslünk. A teljes random struktúrából először eltávolítjuk a random hatásokat. Ha ez sem elég, akkor a legkisebb varianciával rendelkező legmagasabb szintű random hatást távolítjuk el. Ez addig folyathatjuk, amig el nem érjük a minimális random struktúrát, ami általában az alanyonkénti random tengelymetszet lesz."),
    p("Konvergencia problémák esetén az illesztési algoritmuson is változtathatunk; használhatunk eltérő algoritmust vagy növelhetjük az iterációk számát.")
  )
}