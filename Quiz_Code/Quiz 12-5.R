library(tidyverse)
library(cowplot)
theme_set(theme_cowplot())

M <- read_excel("../data/Tibetan_Skulls.xlsx") %>%
  mutate(Origin = factor(Origin))
str(M)


ggscatmat(M, 1:5, color = "Origin") +
  theme(text = element_text(size = 9),
        axis.text = element_text(size = 6),
        axis.text.x = element_text(angle = -90, vjust = 0.5))

skulls_lda <- lda(Origin ~ ., data = M)
table(Original = M$Origin, Predicted = predict(skulls_lda)$class)

26/32

nd <- data.frame(Skull_Length = c(180, 187),
                 Skull_Width = c(135, 140),
                 Skull_Height = c(125, 127),
                 Face_Height = c(70, 73),
                 Face_Breadth = c(130, 127),
                 Origin = c("Unknown", "Unknown"))

bind_rows(M, nd) %>%
  mutate(Origin = factor(Origin)) %>%
  ggscatmat(., 1:5, color = "Origin") +
  theme(text = element_text(size = 9),
        axis.text = element_text(size = 6),
        axis.text.x = element_text(angle = -90, vjust = 0.5)) +
  scale_color_manual(values = c("pink", "lightblue", "purple"))

predict(skulls_lda, nd)$posterior
