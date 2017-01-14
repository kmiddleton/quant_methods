set.seed(3220018)

dd<-data.frame('ID'=seq(1,50),'Length'=round(c(rnorm(25,57),rnorm(25,60)),1),
               'Width'=round(c(rnorm(25,22),rnorm(25,25)),1),
               'Group'=c(rep(1,25),rep(2,25)))

dd[1,c('Length','Width')]<-c(50.2,17.8)

write.csv(dd, file="01-2Ex.csv", row.names=FALSE)


















library(readxl)
library(ggplot2)
library(cowplot)

#Read in data
myDat <- read_excel("01-2Ex.xlsx")

#Plot data
ggplot(myDat,aes(x=Length,y=Width)) +
  geom_point()

#Filter out low temp outlier
myDat <- myDat %>% filter(Notes!='LowTemp')

#Calculate Area

myDat$Area <- myDat$Length*myDat$Width

#make a plot

ggplot(myDat, aes(x=as.factor(Group),y=Width,fill=as.factor(Group))) +
  geom_boxplot(alpha=1/5) +
  geom_point()



