library(ggplot2)
library(cowplot)

MM <- data.frame("Treatment" = c("Wet","Dry"), "LeafArea" = c(19,11))

p1 <- ggplot(MM, aes(Treatment, LeafArea)) +
  geom_bar(stat="identity") +
  theme_bw()

ggsave(filename="dynamiteplot.png", plot=p1, width=5, height=5)




