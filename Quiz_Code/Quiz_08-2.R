# Quiz 07-2

set.seed(1034)

library(tidyverse)
library(GGally)
library(cowplot)

n <- 20
x1 <- scale(runif(n, 5, 9))
x2 <- scale(runif(n, 1, 4))
y <- rnorm(n, 5, 2) + (2.3 * x1 + rnorm(n)) + (1.8 * x2 + rnorm(n))

M <- data.frame(y, x1, x2)

ggscatmat(M)

fm <- lm(y ~ x1 + x2)
summary(fm)
