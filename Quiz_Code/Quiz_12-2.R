library(tidyverse)
library(epiDisplay)
library(rstanarm)

D <- tibble(SUCCESS = c(rep(0, times = 17), rep(1, times = 33))) %>%
  mutate(SUCCESS = factor(SUCCESS))

fm <- glm(SUCCESS ~ 1, data = D, family = binomial)

summary(fm)
logistic.display(fm)

fm_b <- stan_glm(SUCCESS ~ 1, data = D, family = binomial)
summary(fm_b, digits = 3, probs = c(0.025, 0.975))
