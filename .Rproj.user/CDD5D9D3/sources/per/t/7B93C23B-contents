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
    layout_columns(
      plotOutput("plot1_page2"),
      div(
        style = "font-size: 24px; text-align: center;",
        
        span(class = "eq-term",
             "yᵢⱼ",
             onmouseover = "Shiny.setInputValue('hover_term1', 'y', {priority: 'event'})",
             onmouseout  = "Shiny.setInputValue('hover_term1', 'none', {priority: 'event'})"
        ),
        " = ",
        span(class = "eq-term",
             "β₀",
             onmouseover = "Shiny.setInputValue('hover_term1', 'beta0', {priority: 'event'})",
             onmouseout  = "Shiny.setInputValue('hover_term1', 'none', {priority: 'event'})"
        ),
        " + ",
        span(class = "eq-term",
             "β₁",
             onmouseover = "Shiny.setInputValue('hover_term1', 'beta1', {priority: 'event'})",
             onmouseout  = "Shiny.setInputValue('hover_term1', 'none', {priority: 'event'})"
        ),
        "×",
        span(class = "eq-term",
        "xᵢⱼ",
        onmouseover = "Shiny.setInputValue('hover_term1', 'x', {priority: 'event'})",
        onmouseout  = "Shiny.setInputValue('hover_term1', 'none', {priority: 'event'})"
      ),
        " + ",
        span(class = "eq-term",
             "u₀ⱼ",
             onmouseover = "Shiny.setInputValue('hover_term1', 'random', {priority: 'event'})",
             onmouseout  = "Shiny.setInputValue('hover_term1', 'none', {priority: 'event'})"
        ),
        " + ",
        span(class = "eq-term",
             "εᵢⱼ",
             onmouseover = "Shiny.setInputValue('hover_term1', 'error', {priority: 'event'})",
             onmouseout  = "Shiny.setInputValue('hover_term1', 'none', {priority: 'event'})"
        ),
        div(
          style = "margin-top: 15px; font-size: 16px;",
          textOutput("equation_explanation"),
          p(""),
          p("Ha feltételezzük, hogy az egy résztvevőtől származó adatok jobban hasonlítanak egymásra, mint a többi résztvevőtől származó adatpontok, 
            akkor személyenként random tengelymetszet kell beléptetnünk a modellbe. A random tengelymetszet mutatja az egyes személyek nagyátlagtól való eltérését.")
        )
      )
    ),
    h3("Random meredekség"),
    layout_columns(
      plotOutput("plot2_page2"),
      div(
        style = "font-size: 24px; text-align: center;",
        
        span(class = "eq-term",
             "yᵢⱼ",
             onmouseover = "Shiny.setInputValue('hover_term2', 'y', {priority: 'event'})",
             onmouseout  = "Shiny.setInputValue('hover_term2', 'none', {priority: 'event'})"
        ),
        " = ",
        span(class = "eq-term",
             "β₀",
             onmouseover = "Shiny.setInputValue('hover_term2', 'beta0', {priority: 'event'})",
             onmouseout  = "Shiny.setInputValue('hover_term2', 'none', {priority: 'event'})"
        ),
        " + ",
        span(class = "eq-term",
             "β₁",
             onmouseover = "Shiny.setInputValue('hover_term2', 'beta1', {priority: 'event'})",
             onmouseout  = "Shiny.setInputValue('hover_term2', 'none', {priority: 'event'})"
        ),
        "×",
        span(class = "eq-term",
             "xᵢⱼ",
             onmouseover = "Shiny.setInputValue('hover_term2', 'x', {priority: 'event'})",
             onmouseout  = "Shiny.setInputValue('hover_term2', 'none', {priority: 'event'})"
        ),
        " + ",
        span(class = "eq-term",
             "u₀ⱼ",
             onmouseover = "Shiny.setInputValue('hover_term2', 'random', {priority: 'event'})",
             onmouseout  = "Shiny.setInputValue('hover_term2', 'none', {priority: 'event'})"
        ),
        " + ",
        span(class = "eq-term",
             "u₁ⱼxᵢⱼ",
             onmouseover = "Shiny.setInputValue('hover_term2', 'random_slope', {priority: 'event'})",
             onmouseout  = "Shiny.setInputValue('hover_term2', 'none', {priority: 'event'})"
        ),
        " + ",
        span(class = "eq-term",
             "εᵢⱼ",
             onmouseover = "Shiny.setInputValue('hover_term2', 'error', {priority: 'event'})",
             onmouseout  = "Shiny.setInputValue('hover_term2', 'none', {priority: 'event'})"
        ),
        div(
          style = "margin-top: 15px; font-size: 16px;",
          uiOutput("equation_explanation2"),
          p(""),
          p("A random tengelymetszet nem veszi figyelembe az összes lehetséges dependenciát; elképzelhető, hogy az egyes kondícíók eltérően hatnak az egyes résztvevőkre.
            Ekkor kell egy új hatást bevezetni; a random meredekséget, azaz, hogy résztvevő szintjén mennyire mozdul el az egyes feltételek mentén az egyenes meredeksége.
            A random hatások között lehet korreláció is.")
        )
      )
    ),
    p("Fontos megjegyezni, hogy a random hatások beléptetése nem változtatja meg a fix hatások értelmezését, hanem azt mutatja meg, hogy a random hatás különböző szintjein van-e eltérés a fix hatásban vagy sem, továbbá korrigálják az adatok közötti függőséget."),
    p("A random hatásokat az adatok csoportosításának",
    em("(pooling)"),
    "szemszögéből is értelmezhetjük. A csak fix hatásokat tartalmazó lineáris regresszió a személyek közötti varianciát figyelmen kívül hagyja, a teljes adatbázist egyszerre modellezi, viszont ekkor az adatok függetlenségének feltétele sérül – ezt nevezzük teljes csoportosításnak",
    em("(complete pooling)."),
    "Ha egyáltalán nincs csoportosítás",
    em("(no pooling),"),
    "akkor minden személy esetén külön-külön regressziós paramétereket kell becsülni, ami szintén problematikus, mert adatigényes, illetve az regressziós egyenesek átfogó elemzése komplikált. A részleges csoportosítás",
    em("(partial pooling)"),
    "esete a lineáris kevert modellek, amikor egyes résztvevőkhöz külön regressziós paraméterek tartoznak, ugyanakkor a random hatások normális eloszlásának feltétele biztosítja, hogy a modell a teljes adatbázist figyelembe veszi. Tehát ezen modellek megragadják az egyéni variabilitást, ugyanakkor azt is, hogy a személyek valamilyen szinten hasonlók is egymáshoz."),
    p("A modell feltételezi, hogy az adatok ugyanazon eloszlásból származnak, így az illesztés során a prediktált értékek közelebb kerülnek a nagyátlaghoz",
    em("(shrinkage)."),
    "Ez a közelítés az extrémebb értékek esetén jelentősebb, ugyanis a normális eloszlás alatt ezen értékek kisebb valószínűséggel fordulnak elő, ezért feltételezhető, hogy ezek az adatok kevésbé megbízhatóak. E jelenség révén csökkentjük a túlillesztés esélyét, így a predikcióink könnyebben generalizálhatóvá válnak."),
    p("A random hatásoknak a forrásuk alapján két típusa létezik: keresztezett ",
    em("(crossed)"),
    "és egymásba ágyazott", 
    em("(nested)."),
    "A",
    strong("keresztezett random hatások"),
    "akkor jelennek meg, ha a variabilitásnak nem csak egy forrása van (pl. a résztvevő), hanem több is (pl. résztvevő és az itemek nehézsége).",
    "Az ",
    strong("egymásba ágyazott random hatások"),
    "esetén az egyik random hatás egyes szintjei csak egy másik random hatás egyik szintjén jelennek meg, például random hatás, hogy melyik iskola tanulóit vizsgáljuk, de az iskolán belül az osztályok is ilyen hatást eredményeznek.")
  )

}