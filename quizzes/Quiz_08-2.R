library(tidyverse)
library(cowplot)

n <- 10
m1 <- 5
m2 <- 8
m3 <- 5
m4 <- 3
sds <- 1

y <- c(rnorm(n, m1, sds),
       rnorm(n, m2, sds),
       rnorm(n, m3, sds),
       rnorm(n, m4, sds))
x1 <- factor(rep(c("A", "a"), each = n * 2))
x2 <- factor(rep(c("B", "b", "B", "b"), each = n))

M <- data.frame(x, y)

ggplot(M, aes(x = x1,
              y = y,
              color = x2,
              group = x2)) +
  geom_point(position = position_jitter(width = 0.1)) +
  stat_summary(fun.y = mean, geom = "point", pch = 12, size = 5) +
  stat_summary(fun.y = mean, geom = "line")

summary(lm(y ~ x1 * x2, M))
