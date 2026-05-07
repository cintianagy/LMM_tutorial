required_packages <- c(
  "shiny",
  "bslib",
  "tidyverse",
  "afex",
  "sjPlot",
  "gganimate",
  "emmeans",
  "rstatix",
  "car"
)


missing_packages <- required_packages[!required_packages %in% installed.packages()[, "Package"]]

if (length(missing_packages) > 0) {
  install.packages(missing_packages)
}

lapply(required_packages, library, character.only = TRUE)

source("R/page1_intro.R")
source('R/page2_fix_and_random.R')
source("R/page3_fitting.R")
source("R/page4_problems_solutions.R")

# ui
ui <- page_fluid(
  tags$head(
    tags$link(rel = "stylesheet", href = "styles.css")
  ),
  navset_tab( 
    nav_panel("1. Miért hasznos az LMM?", page1_intro_ui()), 
    nav_panel("2. Fix és random hatások", page2_fix_and_random_ui()), 
    nav_panel("3. Modellillesztés R-ben", page3_fitting_ui()),
    nav_panel("4. Lehetséges problémák és kezelésük", page4_problems_solutions_ui()),
    nav_panel("5. Módszerek és eredmények közlése", page5_reporting_ui()),
    nav_panel("6. Kitekintés", page6_outlook_ui()),
    nav_panel("7. Források és köszönetnyilvánítás", page7_references_feedback_ui())
  ), 
  id = "tab" 
)

# server
server <- function(input, output, session) {
  
  # page 1
  show_groups <- reactiveVal(FALSE)
  
  observeEvent(input$show_groups, {
    show_groups(!show_groups())
  })
  
  output$plot_page1 <- renderPlot({
    
    df <- df

    alpha_val <- if (show_groups()) 1 else 0
    
    ggplot(df, aes(x = xs, y = outcome)) +
      geom_point(color = "gray70", size = 3) +
      geom_point(aes(color = group), alpha = alpha_val, size = 3.5) +
      geom_line(aes(group = group, color = group), alpha = 0.6 * alpha_val) +
      stat_ellipse(aes(group = group, color = group), linetype = 2, alpha = 0.5 * alpha_val) +
      labs(color = "Személyek") +
      theme_classic() +
      theme(
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank()

      )
      
  })
  
  output$page1_explanation <- renderText({
    if (!show_groups()) {
      "Első ránézésre az adatok függetlennek tűnnek."
    } else {
      "Valójában az adatok között van kapcsolat – ugyanazon személytől származnak."
    }
  })
  
  # page 2: random intercept
  hover_term1 <- reactive({
    input$hover_term1 %||% "none"
  })
  
  output$plot1_page2 <- renderPlot({
    
    df <- df
    
    term <- hover_term1()
    
    base <- ggplot(df, aes(xs, outcome)) +
      geom_point(color = "gray70", size = 3) +
      theme_classic() +
      theme(
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank()
      )
    
    if (term == "random") {
      
      fit <- lm(outcome ~ xs, data = df)
      
      beta0 <- coef(fit)[1]
      beta1 <- coef(fit)[2]
      
      group_intercepts <- aggregate(outcome ~ group, df, mean)
      names(group_intercepts)[2] <- "intercept"
      
      df_lines <- do.call(rbind, lapply(split(df, df$group), function(d) {
        
        g <- d$group[1]
        intercept <- group_intercepts$intercept[group_intercepts$group == g]
        
        data.frame(
          group = g,
          xs = d$xs,
          pred = intercept + beta1 * d$xs
        )
      }))
      
      base + 
        geom_point(aes(color = group), size = 3.5) +
        labs(color = "Személyek") +
        geom_line(
          data = df_lines,
          aes(x = xs, y = pred, color = group, group = group),
          size = 1.2
        )
  
    } else if (term == "beta1") {
      
      base +
        geom_smooth(method = "lm", se = FALSE, color = "#7393B3", size = 1.5)
    }
      else if (term == "beta0") {
        beta0 <- coef(lm(outcome ~ xs, data = df))[1]
        base +
          geom_hline(yintercept = beta0, linetype = "dashed", color = "black") +
          annotate("text", x = min(df$xs), y = beta0,
                   label = expression(beta[0]),
                   hjust = -0.2, vjust = -1)
      
    } else if (term == "y") {
      
      base
      
    } else {
      base
    }
  })
  
  output$equation_explanation <- renderText({
    
    term <- input$hover_term1 %||% "none"
    
    switch(term,
           "y" = "yᵢⱼ: megfigyelt kimeneti érték",
           "x" = "xᵢⱼ: független változó értéke", 
           "beta0" = "β₀: fix tengelymetszet",
           "beta1" = "β₁: fix meredekség – hogyan változik y az x függvényében",
           "random" = "u₀ⱼ ~ N(0, σᵤ²): random tengelymetszet – a tengelymetszet eltérése az fix tengelymetszettől",
           "error" = "εᵢⱼ ~ N(0, σₑ²): hibatag – meg nem magyarázott variancia",
           "Vidd az egeret az egyenlet egyik elemére."
    )
  })
  
  # page 2: random slope
  hover_term2 <- reactive({
    input$hover_term2 %||% "none"
  })
  
  output$plot2_page2 <- renderPlot({
    
    df <- df
    
    term <- hover_term2()
    
    base <- ggplot(df, aes(xs, outcome)) +
      geom_point(color = "gray70", size = 3) +
      theme_classic() +
      theme(
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank()
      )
    
    if (term == "random") {

      fit <- lm(outcome ~ xs, data = df)
      
      beta0 <- coef(fit)[1]
      beta1 <- coef(fit)[2]

      group_intercepts <- aggregate(outcome ~ group, df, mean)
      names(group_intercepts)[2] <- "intercept"
      
      df_lines <- do.call(rbind, lapply(split(df, df$group), function(d) {
        
        g <- d$group[1]
        intercept <- group_intercepts$intercept[group_intercepts$group == g]
        
        data.frame(
          group = g,
          xs = d$xs,
          pred = intercept + beta1 * d$xs
        )
      }))
      
      base + 
        geom_point(aes(color = group), size = 3.5) +
        labs(color = "Személyek") +
        geom_line(
          data = df_lines,
          aes(x = xs, y = pred, color = group, group = group),
          size = 1.2
        )
      
     } else if (term == "random_slope") {
        
        fit_global <- lm(outcome ~ xs, data = df)
        beta0 <- coef(fit_global)[1]

        df_lines <- do.call(rbind, lapply(split(df, df$group), function(d) {
          
          fit <- lm(outcome ~ xs, data = d)

          data.frame(
            group = d$group[1],
            xs = d$xs,
            pred = predict(fit, newdata = d)
          )
        }))
        
        
        base +
          geom_point(aes(color = group), size = 3.5) +
          labs(color = "Személyek") +
          geom_line(
            data = df_lines,
            aes(xs, pred, color = group, group = group),
            size = 1.2
          )
        
    } else if (term == "beta1") {
      
      base +
        geom_smooth(method = "lm", se = FALSE, color = "#7393B3", size = 1.5)
    }
    else if (term == "beta0") {
      beta0 <- coef(lm(outcome ~ xs, data = df))[1]
      base +
        geom_hline(yintercept = beta0, linetype = "dashed", color = "black") +
        annotate("text", x = min(df$xs), y = beta0,
                 label = expression(beta[0]),
                 hjust = -0.2, vjust = -1)
      
    } else if (term == "y") {
      
      base
      
    } else {
      base
    }
  })
  
  output$equation_explanation2 <- renderUI({
    
    term2 <- input$hover_term2 %||% "none"
    
    switch(term2,
           "y" = "yᵢⱼ: megfigyelt kimeneti érték",
           "x" = "xᵢⱼ: független változó értéke", 
           "beta0" = "β₀: fix tengelymetszet",
           "beta1" = "β₁: fix meredekség – hogyan változik y az x függvényében",
           "random" = "u₀ⱼ ~ N(0, σᵤ²): random tengelymetszet – a tengelymetszet eltérése az fix tengelymetszettől",
           "error" = "εᵢⱼ ~ N(0, σₑ²): hibatag – meg nem magyarázott variancia",
           "random_slope" = HTML("
(u<sub>0j</sub>, u<sub>1j</sub>) ~ N(0, Ω): random meredekség - a meredekség eltérése az fix meredekségtől<br><br>

Ω =
<table style='display:inline-table; border-spacing:8px;'>
  <tr>
    <td>σ<sub>u0</sub><sup>2</sup></td>
  </tr>
  <tr>
    <td>σ<sub>u01</sub></td>
    <td>σ<sub>u1</sub><sup>2</sup></td>
  </tr>
</table>
"),
           "Vidd az egeret az egyenlet egyik elemére."
    )
  })
  
  # page 3
  data_reactive <- reactive({
    generate_data()
  })
  
  model_reactive <- reactive({
    df <- data_reactive()
    model <- mixed(RT ~ item*block_centered + (item*block_centered| subject), data = df)
  })
  
  output$anova <- renderPrint({
    model <- model_reactive()
    model$anova_table
  })
  
  output$model_table <- renderUI({
    model <- model_reactive()
      
    tbl <- tab_model(
        model$full_model,
        df.method = "satterthwaite",
        show.se = TRUE,
        show.stat = TRUE,
        show.df = TRUE,
        string.pred = "Terms",
        string.est = "b",
        string.ci = "95% CI",
        string.se = "SE b",
        string.stat = "t",
        col.order = c("est", "se", "ci", "stat", "df.error", "p")
      )
    HTML(tbl$page.complete)
  })
  
  output$residual_plot <- renderPlot({
    
    model <- model_reactive()
    df <- data_reactive()

    plot(model$full_model)
  })
  
  output$qq_plot <- renderPlot({
    model <- model_reactive()
    df <- data_reactive()
    qqPlot(resid(model$full_model))
  })
}

shinyApp(ui, server)
