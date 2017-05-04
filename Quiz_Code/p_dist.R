library(ggplot2)
ps <- data.frame('p'= c(runif(40,0,0.05),runif(20,0.05,0.6),runif(200,0,1)))

ggplot(ps, aes(p)) +
  geom_histogram(bins=20) +
  xlab("P value")



ps <- data.frame('p'= runif(200,0,1))

ggplot(ps, aes(p)) +
  geom_histogram(bins=20) +
  xlab("P value")

ps <- data.frame('p'= sort(-log10(c(runif(40,0,0.05),runif(20,0.05,0.6),runif(200,0,1)))),
                 'e' = sort(-log10(runif(260,0,1))))


ggplot(ps, aes(x=e, y=p)) +
  geom_point() +
  geom_abline(slope=1, intercept=0) +
  ylab('Observed P value') +
  xlab('Expected P value')
