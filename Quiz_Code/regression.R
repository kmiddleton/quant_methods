library(tidyverse)
library(cowplot)
theme_set(theme_cowplot())

set.seed(761)
xx <- rnorm(25,30,5)
yy <- 0.035*xx + 0.12 +rnorm(25, 1, 0.2)


fldat <- tibble("FlowerSize" = xx, "NectarVolume" = yy)

ggplot(fldat, aes(FlowerSize,NectarVolume)) +
  geom_point() +
  geom_smooth(method="lm")


new.pts <- tibble("FlowerSize" = c(22,37,38), "NectarVolume" = c(2.08,2.17,2.06))

ggplot(fldat, aes(FlowerSize,NectarVolume)) +
  geom_point() +
  geom_smooth(method="lm") +
  geom_point(data=new.pts,aes(FlowerSize,NectarVolume), color='red', shape=17, size=3)
