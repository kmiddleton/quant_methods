library(factoextra)
library(tidyverse)
library(readxl)
library(GGally)

M <- read_excel("../data/Birds.xlsx")

ggscatmat(as.data.frame(M[, 3:6]))

z <- prcomp(~ .,
            data = M[, 3:6],
            center = TRUE,
            scale. = TRUE)

z

get_eig(z)

fviz_eig(z, addlabels = TRUE)

fviz_pca_var(z) + coord_fixed()
