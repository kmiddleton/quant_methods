library(tidyverse)
library(cvTools)
library(readxl)

M <- read_excel("../data/Birds.xlsx")

fm2 <- lm(N_Species ~ Area + Dist_to_Ecuador, data = M)
fm3 <- lm(N_Species ~ Dist_to_Island + Area + Dist_to_Ecuador, data = M)

obs <- 2

# fm2 fm3
M1 <- M %>% slice(2)
M_rest <- M %>% slice(-2)

fm2loo <- lm(N_Species ~ Area + Dist_to_Ecuador, data = M_rest)
fm3loo <- lm(N_Species ~ Dist_to_Island + Area + Dist_to_Ecuador,
             data = M_rest)

M1$N_Species - as.numeric(predict(fm2loo, newdata = M1))
M1$N_Species - as.numeric(predict(fm3loo, newdata = M1))

# LOOcv

cvFit(fm2, data = M, y = M$N_Species, K = nrow(M))
cvFit(fm3, data = M, y = M$N_Species, K = nrow(M))
