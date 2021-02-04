library(tidyverse)

set.seed(32742)

b1 <- beaver1 %>%
  mutate(time = as.integer(time)) %>%
  select(-activ) %>% slice(1:10)

air_temps <- tibble(
  day = 346,
  time = as.integer(c(830, 835, 840, 845, 850, 855,
                      900, 905, 910, 915, 920, 930, 935, 940, 945, 950, 955,
                      1000, 1005, 1010, 1015, 1020, 1025)),
  air_temp = runif(length(time), 9, 10)
)

b1
air_temps

left_join(b1, air_temps)
full_join(b1, air_temps)
