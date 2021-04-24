library(palmerpenguins)
library(factoextra)

penguins <- penguins %>% drop_na()

z <- prcomp(~ bill_length_mm + bill_depth_mm + flipper_length_mm + body_mass_g,
            data = penguins,
            center = TRUE,
            scale. = TRUE)

print(z)
fviz_pca_var(z)
fviz_eig(z, addlabels = TRUE)
