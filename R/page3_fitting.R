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
    p("A következőkben egy példakutatáson keresztül vesszük át, hogyan lehet lineáris kevert modell futtatni R-ben.
      A kutatás során a résztvevők egy egyszerű, reakcióidőt mérő feladatot végeztek el. A feladatban kétféle item fordult elő,
      valamint a feladat több blokkból állt. Feltételezhetjük, hogy a személyek reakcióidejében lesz egyéni variancia, valamint az eltérő 
      itemekre másképpen fognak reagálni."),
    p("A lineáris kevert modellek illesztéséhez az R program ",
    em("afex"),
    "csomagjának ",
    em("mixed"),
    "függvényét tudjuk használni. A modell általános szintaxisa a következő:",
    tags$code("kimeneti változó ~ független változó + (random meredekség | random tengelymetszet)"),
      ". Ez a mi változóinkkal:"),
    tags$code("model <- mixed(reakcióidő ~ item*blokk + (item*blokk | résztvevő), adat)"),
    p("Ha a modell sikeresen lefutott a következőkben az előfeltételeket kell tesztelnünk; 1. A kimeneti és prediktor változók között lineáris kapcsolatot feltételezünk, ugyanakkor a generalizált lineáris kevert modellek megoldást jelentenek erre (l. 6. Kitekintés),
      2. A reziduálisok szóródáshomogenitása, 3. A reziduálisok normalitása. Ez utóbbi feltételek sérülésére a modell robusztus.
      A feltételeket a következő függvényekkel tesztelhetjük:"),
    tags$code("plot(model$full_model)"),
    p(""),
    tags$code("qqPlot(resid(model$full_model))"),
    layout_columns(
      div(plotOutput("residual_plot")),
      div(plotOutput("qq_plot")),
      ),
    p("Az ábrák alapján az előfeltételek nem sérültek."),
    p("A",
      tags$code("model$anova_table"),
    "és",
    tags$code("tab_model(model$full_model)"),
    "függvényekkel tudjuk lekérni az eredményeket."),
    layout_columns(
    verbatimTextOutput("anova"),
    p("Az ANOVA táblázatból kiolvashatjuk a főhatásokhoz és az interakciókhoz tartozó",
      em("F -"),
      "és",
      em("p -"),
      "értékeket. Fontos észrevenni, hogy a modellbe nem az eredeti blokk változót léptettük be, hanem a ",
      strong("centrált"),
      "verzióját. Ezt az átalakítást a folytonos prediktorok esetén kell megtennünk, hiszen így tudjuk a változó 0-dik értékén is értelmezni a hatásokat.")),
    layout_columns(
      uiOutput("model_table"),
      div(
        p("Az alábbi táblázat tartalmazza az egyes hatásokhoz tartozó béta értéket (egy egységnyi változás a független változóban mekkora változást eredményez a kimeneti változóban), a béta standard hibáját,
    a konfidencia intervallumot, valamint a hatáshoz tartozó tesztstatisztikát, szabadságfokot és ",
          em("p"),
          "- értéket."
        ),
        p("Az eredmények értelmezéséhez a fix hatások együtthatóit használhatjuk, ami a független változó és a kimeneti változó közötti kapcsolatot méri a random hatások figyelembevétele után, valamint ezek",
          em("p"),
          "-értékét. Másik módszer a fix hatások III. típusú tesztje, ami a modell két verziójának összehasonlításán alapulnak - a tesztelendő hatás nélkül vs. a tesztelendő hatással együtt."),
        p("A táblázat alsó részében a random hatásokról kapunk információt. Az ICC (intraclass correlation) mutatja meg a korrelációt két, azonos csoportból random kiválasztott alany értékei között.
      A τ az egyes hatásokhoz tartozó varianciát, míg a ρ a random hatások közötti korrelációt mutatja.
      A modell magyarázó erejét a marginális (a fix hatások által megmagyarázott variancia) és feltételes R² (a fix és random hatások által megmagyarázott variancia) érték adja meg."
        ),
        p("Az adatok közötti dependencia miatt a szabadságfokok és a ",
          em("p"),
          "- értékek számítása nem triviális. A Kenward-Rogers közelítés az első fajú hibára jól kontrolláló módszer, ugyanakkor a komputációs erőforrások tekintetében egy költséges módszer, ami a komplexebb modellek esetében probléma lehet. Ennek egy jó alternatívája lehet a Satterthwaite közelítés, ami kevesebb erőforrást igényel. 
Egy másik módszer a likelihood tesztek alkalmazása, amely során két modellt hasonlítunk össze: az egyik modell tartalmazza a hatást, míg a másik nem. A módszer hátránya, hogy alacsony elemszámnál gyakran ad hamis pozitív eredményt. Ennek egy alternatívája lehet a parametrikus bootstrapping, ami ugyanakkor a komplexebb modellek esetén szintén erőforrás igényes."),
        p("Amennyiben adekvát, a post hoc összehasonlításokat az",
          em("emmeans"),
          "csomag segítségével tudjuk elvégezni.")
      )
    )
  )
}