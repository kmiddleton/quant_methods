library(tidyverse)

set.seed(993255)
SSD<-data_frame(
  Species=c(rep("Pardosa_ramulosa",100),rep("Nephila_clavipes",100)),
  Sex = c(rep(c('M','F'),each=50,times=2)),
  BodyLength = c(rnorm(50,5),rnorm(50,6),rnorm(50,20,3),rnorm(50,50,10)),
  BodyMass = BodyLength ^ (3  + rnorm(200, 0, 0.2)) / 1000)

write_csv(SSD, "Size_Dimorphism.csv")

ggplot(SSD, aes(x=BodyLength, y=BodyMass, color=Sex))+
         geom_point() +
   scale_x_log10() +
   scale_y_log10() +
  facet_grid(Species ~ .)

SSD %>%
  filter(Species == "Pardosa_ramulosa") %>%
  ggplot(aes(x=BodyLength, y=BodyMass, color=Sex))+
  geom_point()

SSD %>%
  filter(Species == "Nephila_clavipes") %>%
  ggplot(aes(x=BodyLength, y=BodyMass, color=Sex))+
  geom_point()
