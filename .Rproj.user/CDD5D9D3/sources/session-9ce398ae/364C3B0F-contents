library(tidyverse)
library(afex)

generate_data <- function(n_subjects = 40, n_items = 2, n_trials = 20) {
  
  set.seed(123)
  
  subject <- factor(rep(1:n_subjects, each = n_items * n_trials))
  item <- factor(rep(rep(1:n_items, each = n_trials), times = n_subjects))
  block <- rep(rep(1:n_trials, times = n_items), times = n_subjects)
  block_centered <- scale(block, center = TRUE, scale = TRUE)[,1]
  
  # fixed effects
  beta0 <- 600
  beta_item <- c(0, -80)
  beta_time <- -30   # people get faster over time
  
  # random effects
  u0 <- rnorm(n_subjects, 0, 80)
  u1 <- rnorm(n_subjects, 0, 40)
  u2 <- rnorm(n_subjects, 0, 20)
  
  # map random effects
  u0_long <- u0[subject]
  u1_long <- u1[subject]
  u2_long <- u2[subject]
  
  # numeric item
  item_num <- as.numeric(item) - 1
  
  # generate RT
  RT <- beta0 +
    beta_item[item] +
    beta_time * block_centered +
    u0_long +
    u1_long * item_num +
    u2_long * block_centered +
    rnorm(length(subject), 0, 60)
  
  data.frame(
    RT = RT,
    item = item,
    subject = subject,
    block = block,
    block_centered = block_centered
  )
}