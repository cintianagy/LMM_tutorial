library(shiny)
library(bslib)
library(tidyverse)
library(afex)

page3_fitting_ui <- function() {
  page_fluid(
    tags$head(
      tags$link(rel = "stylesheet", href = "styles.css")
    ),
    h2("Hogyan illesszünk modellt R-ben?"),
    p("A következőkben egy példakutatáson keresztül vesszük át, hogyan lehet lináris kevert modell futtatni R-ben.
      A kutatás során a résztvevők egy egyszerű reakcióidőt mérő feladatot végéztek el. A feladatban kétféle item fordult elő,
      valamint a feladat több blokkból állt. Feltételezhetjük, hogy a személyek reakcióidejében lesz egyéni variancia, valamint az eltérő 
      itemekre másképpen fognak reagálni."),
    p("A lineáris kevert modellek illesztéséhez az R program ",
    em("afex"),
    "csomagjának ",
    em("mixed"),
    "függvényét tudjuk használni. A modell általános szintaxisa a következőképpen nézz ki:",
    tags$code("kimeneti változó ~ prediktor + (random meredekség | random tengelymetszet)"),
      ". Ez a mi változóinkkal így néz ki:"),
    tags$code("model <- mixed(reakcióidő ~ item*blokk + (item*blokk | résztvevő), adat)"),
    p("Ha a modell sikeresen lefutott a következőkben az előfeltételeket kell tesztelnünk; 1. A kimeneti és prediktor változók között lineáris kapcsolatot feltételezünk, ugyanakkor a generalizált lineáris kevert modellek megoldást jelentenek erre (l. 6. Kitekintés),
      2. A reziduálisok szóródáshomogenitása, 3. A reziduálisok normalitása. Ez utóbbi feltételekre sérülésésre a modell robusztus.
      A feltételeket a következő függvénnyel tesztelhetjük:"),
    tags$code("plot(model$full_model)"),
    tags$code("qqPlot(resid(model$full_model)"),
    layout_columns(
      div(plotOutput("residual_plot")),
      div(plotOutput("qq_plot")),
      ),
    p("Az ábrák alapján az előfeltételek nem sérültek."),
    p("A",
      tags$code("model$anova_table"),
    "és",
    tags$code("tab_model(model$full_model)"),
    "függvényekkel tudjuk lekérni az eredményeket"),
    layout_columns(
    verbatimTextOutput("anova"),
    p("Az ANOVA táblázatból kiolvashatjuk a főhatásokhoz és az interakciókhoz tartozó",
      em("F"),
      "és",
      em("p"),
      "értékeket. Fontos észrevenni, hogy a modellbe nem az eredeti blokk változót léptettük be, hanem a centrált verzióját.
      Ezt az átalakítást a folytonos prediktorok esetén kell megtennünk, hiszen így tudunk a 0-dik értéken is értelmezni a hatásokat.")),
    layout_columns(
    uiOutput("model_table"),
    div(p("Az alábbi táblázat tartalmazza az egyes hatásokhoz béta értékekek (egy egységni változás a prediktorban, mekkora változást eredményez a kimeneti változóban), a standardizált béta értéket,
    a konfidencia intervallumot, valamint a hatáshoz tartozó tesztstatistikát, szabadságfokot és",
      em("p"),
      "-értéket.")),
     div(p("A táblázat alsó részében a random hatásokról kapunk információt. Az ICC (intraclass correlation) mutatja meg a korreláció két, azonos csoportból random kiválasztott alany értékei között.
      A τ az egyes hatásokhoz tartozó varianciát, míg a ρ a random hatások közötti varianciát mutatja.
      A modell magyarázó erejét a marginális (a fix hatások által megmagyarázott variancia) és feltételes R2 (a fix és random hatások által megmagyarázott variancia) érték adja meg. 
      ")),
    div(p("<df becslés>")),
    div(p("<post hoc>")))
    )
}