library(tidyverse)
library(afex)

generate_data <- function(n_subjects = 40, n_items = 2, n_trials = 20) {
  
  set.seed(123)
  
  subject <- factor(rep(1:n_subjects, each = n_items * n_trials))
  item <- factor(rep(rep(1:n_items, each = n_trials), times = n_subjects))
  
  # fixed effects
  beta0 <- 600
  beta_item <- c(0, -80)  # item effect (RT difference)
  
  # random effects
  u0 <- rnorm(n_subjects, 0, 80)   # random intercepts
  u1 <- rnorm(n_subjects, 0, 40)   # random slopes
  
  # map random effects to rows
  u0_long <- u0[subject]
  u1_long <- u1[subject]
  
  # numeric coding for item
  item_num <- as.numeric(item) - 1
  
  # generate RT
  RT <- beta0 +
    beta_item[item] +
    u0_long +
    u1_long * item_num +
    rnorm(length(subject), 0, 60)
  
  data.frame(
    RT = RT,
    item = item,
    subject = subject
  )
}