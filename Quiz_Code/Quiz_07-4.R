library(tidyverse)
library(cowplot)
library(forcats)
library(latex2exp)

set.seed(4872364)

n <- 20

M <- data_frame(
  Area = c(rnorm(n, 8, 2), rnorm(n, 16, 2)),
  Treatment = fct_inorder(rep(c("Antibacterial", "Control"), each = n))
)

ggplot(M, aes(x = Treatment, y = Area)) +
  geom_point(position = position_jitter(width = 0.05), alpha = 0.5) +
  stat_summary(fun.y = mean, geom = "point", size = 3, color = "red") +
  stat_summary(fun.data = mean_se, geom = "errorbar", width = 0.1,
               color = "red", size = 0.7) +
  labs(x = "Treatment", y = TeX("Area (mm$^2$)"))

ggsave(last_plot(), file = "q7-4.png", height = 3, width = 5)
