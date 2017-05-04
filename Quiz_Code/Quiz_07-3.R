# Quiz 07-3

library(tidyverse)
library(multcomp)

M <- read_delim("../data/sampleMod.txt", delim = " ") %>%
  drop_na() %>%
  mutate(Haplotype = factor(Haplotype)) %>%
  filter(Haplotype != "A2")

ggplot(M, aes(x = Haplotype, y = Expression)) +
  geom_point(position = position_jitter(width = 0.05), alpha = 0.5) +
  stat_summary(fun.y = mean, geom = "point", size = 3, color = "red") +
  stat_summary(fun.data = mean_se, geom = "errorbar", width = 0.1,
               color = "red", size = 0.7) +
  labs(x = "Haplotype", y = "Pi3K59F Expression")

M %>% group_by(Haplotype) %>%
  tally()

M %>% group_by(Haplotype) %>%
  summarize(exp_mean = mean(Expression),
            exp_sd = sd(Expression))

fm <- lm(Expression ~ Haplotype, data = M)
summary(fm)

anova(fm)

tukey <- glht(fm, linfct = mcp(Haplotype = "Tukey"))
summary(tukey)
