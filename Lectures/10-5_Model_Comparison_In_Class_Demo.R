# Week 9 demo

# http://jfly.iam.u-tokyo.ac.jp/color/
# https://www.nceas.ucsb.edu/~frazier/RSpatialGuides/colorPaletteCheatsheet.pdf

library(tidyverse)
library(cowplot)

library(jcolors)
library(ggsci)
library(wesanderson)
library(viridis)

n <- 40
M <- tibble(
  x = runif(n, 0, 10),
  y = 2 * x + rnorm(n, 0, 0.5),
  grp = case_when(
    x < 2.5 ~ "low",
    x > 7.5 ~ "high",
    TRUE ~ "mid"
  )) %>%
  mutate(grp = factor(grp, levels = c("low", "mid", "high")))

str(M)

ggplot(M, aes(x = x, y = y)) +
  geom_point(size = 3, color = "blue")

ggplot(M, aes(x = x, y = y, shape = grp)) +
  geom_point(size = 5) +
  scale_shape_manual(values = c(13, 20, 4), name = "Shapes")
  # scale_color_brewer(palette = "Set2") +
  # scale_color_aaas() +
  # scale_color_d3() +
  # scale_color_futurama() +
  # scale_color_jama() +
  # scale_color_nejm() +
  # scale_color_startrek() +
  # scale_color_manual(values = wes_palette("Royal1")) +
  # scale_color_manual(values = wes_palette("GrandBudapest1")) +
  NULL

ggplot(M, aes(x = x, y = y, size = y)) +
  geom_point() +
  # scale_color_gradient(low = "blue", high = "orange") +
  # scale_color_viridis()
  NULL
