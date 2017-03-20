library(tidyverse)
library(cowplot)

n <- 10
mu1 <- 5
mu2 <- 5.2
sd1 <- 2
sd2 <- 2

M <- data_frame(y = c(rnorm(n, mu1, sd1),
                      rnorm(n, mu2, sd2)),
                grp = factor(rep(c("A", "B"), each = n)))

nreps <- 1e4
t_stats <- numeric(nreps)
t_stats[1] <- t.test(y ~ grp, data = M)$statistic

for (ii in 2:nreps) {
  t_stats[ii] <- t.test(sample(y) ~ grp, data = M)$statistic
}

plt <- ggplot(data.frame(t_stats), aes(t_stats)) +
  geom_histogram() +
  geom_vline(xintercept = t_stats[1], color = "red") +
  labs(x = "t statistics", y = "Count")
plt

(p <- 2 * mean(t_stats <= t_stats[1]))

ggsave(plt, file = paste0("~/Desktop/p", round(p, 3), ".png"))
