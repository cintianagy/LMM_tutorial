library(dplyr)
library(afex)
library(ggplot2)
library(arm)

groups <- c('A', 'B', 'C', 'D', 'E')
x <- c(40000, 50000, 60000, 70000, 80000)
y <- c(2000, 500, 500, 1700, 500)
n <- 20
total <- n * length(groups)

ids <- 1:total
group <- rep(groups, n)
xs <- floor(runif(total, 0, 10))
ys <- rep(x, n) * runif(total, .9, 1.1)
zs <- rep(y, n) * runif(total, .9, 1.1)
df <- data.frame(ids, group, xs, ys, zs)

df <- df %>% mutate(
  outcome = ys + xs * zs
)

# Model without respect to grouping
m0 <- lm(outcome ~ xs, data=df)
predict(m0)
df$simple.model <- predict(m0)

# Model with varying intercept
m1 <- lmer(outcome ~ xs + (1|group), data = df)
df$random.intercpet.preds <- predict(m1)

# Model with varying slope
m2 <- lmer(outcome ~ xs + (0 + xs|group), data=df)
df$random.slope.preds <- predict(m2)

# Model with varying slope and intercept
m3 <- lmer(outcome ~ xs + (1 + xs|group), data=df)
df$random.slope.int.preds <- predict(m3)

# Some plots using ggplot2
# Visualize random intercept
vary.data.graph <- ggplot(data=df, aes(x=xs, y=outcome, group = group, colour = group)) +
  geom_point() + 
  labs(x="x", y="y") +
  scale_colour_discrete('group') +
  theme_classic()


# Visualize random intercept
vary.int.graph <- ggplot(data=df, aes(x=xs, y=random.intercpet.preds, group = group, colour = group)) +
  geom_line() + 
  labs(x="x", y="y") +
  ggtitle("Varying Intercept outcome Prediction") + 
  scale_colour_discrete('group')     

# Visualize random slope
vary.slope.graph <- ggplot(data=df, aes(x=xs, y=random.slope.preds, group = group, colour = group)) +
  geom_line() + 
  labs(x="x", y="y") +
  ggtitle("Varying Slope outcome Prediction") + 
  scale_colour_discrete('group')

# Visualize random slope + intercept
vary.slope.int.graph <- ggplot(data=df, aes(x=xs, y=random.slope.int.preds, group = group, colour = group)) +
  geom_line() + 
  labs(x="x", y="y") +
  ggtitle("Varying Slope and Intercept outcome Prediction") + 
  scale_colour_discrete('group')

# Visualize with data
model.with.data <- ggplot(data=df, aes(x=xs, y=random.slope.int.preds, group = group, colour = group)) +
  geom_line() + 
  geom_point(aes(x=xs, y=outcome, group = group, colour = group)) +
  labs(x="x", y="y") +
  ggtitle("Varying Slope and Intercept outcome Prediction") + 
  scale_colour_discrete('group')