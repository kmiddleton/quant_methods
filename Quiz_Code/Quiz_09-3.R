library(tidyverse)
library(AICcmodavg)

M <- read_excel("../data/Birds.xlsx")

fm0 <- lm(N_Species ~ 1, data = M)
fm1 <- lm(N_Species ~ Dist_to_Island, data = M)
fm2 <- lm(N_Species ~ Area + Dist_to_Ecuador, data = M)
fm3 <- lm(N_Species ~ Dist_to_Island + Area + Dist_to_Ecuador, data = M)
fm4 <- lm(N_Species ~ Dist_to_Island + Elevation + Area + Dist_to_Ecuador, data = M)
fm5 <- lm(N_Species ~ Dist_to_Island + Elevation + Area * Dist_to_Ecuador, data = M)

aictab(list(fm0, fm1, fm2, fm3, fm4, fm5),
      modnames = c("fm0", "fm1", "fm2", "fm3", "fm4", "fm5"))
