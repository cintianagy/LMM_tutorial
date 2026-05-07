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
    h3("Generalizált modellek"),
    p("A lineáris kevert modell egy speciális eset, amely az adatok normális eloszlását feltételezi és közvetlenül modellezi azokat. 
    A generalizált modellek viszont kiterjesztik ezt és más eloszlásokat feltételez, valamint eltérő link függvényeket használhat; 
      leggyakrabban bináris kimeneti változót logisztikus függvénnyel."),
    h3("Statisztikai erő"),
    p("Az erőelemzés a lineáris kevert modellek esetén is lehetséges, ugyanakkor lényegesen bonyolultabb, mint más eljárások esetén. 
      A nehézséget az okozza, hogy a statisztikai erőt a variabilitás befolyásolja, amelynek jelen esetben több forrása is van, így az erőelemzés módszerének képesnek kell lennie megragadni ezt a komplexitást. 
      Egyszerűbb modellek esetén léteznek analitikus megoldások, azonban a gyakorlatban gyakran komplexebb modellekkel dolgoznak. 
      Erre nyújt megoldást a szimuláció alapú erőelemzés, amely során adatbázisokat generálunk, mindegyiken teszteljük a hipotéziseket, majd kiszámoljuk a szignifikáns és nemszignifikáns szimulációk arányát, ami a statisztikai erő lesz. 
      Az erőelemzés könnyen megvalósítható",
      em("mixedpower"),
      "vagy",
      em("simr"),
      "csomag segítségével (ez utóbbi rugalmasabb a szimuláció beállításai terén)."),
    h3("Bayesiánus modellek"),
    p("A lineáris modelleket bayesiánus módon is futtathatjuk. Ez sok esetben lecsökkenti a konvergencia problémákat.
      A statisztikai interferencia során a",
      em("p"),
      "- érték helyett bizonyossági intervallumokat",
      em("(credible interval)"),
      "értelmezzünk. A bayesiánus modell könnyen futtatható a",
      em("brms"),
      "csomaggal. A hátrányok ugyanakkor a komputációs erőforrásigény, valamint az, hogy a priorok specifikálása nem triviális folyamat."),
  )
}