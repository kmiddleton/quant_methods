shade_normal <- function(q, tail = "both", mean = 0, sd = 1) {
  require(tidyverse, quietly = TRUE)
  require(cowplot)
  crit <- qnorm(q, mean, sd)
  M <- data_frame(x = seq(-4, 4, length = 200),
                  y = dnorm(x))
  p <- ggplot(M, aes(x, y)) +
    geom_line() +
    labs(x = "Value", y = "Relative Likelihood")
  lower <- geom_ribbon(data = subset(M, x < crit),
                       aes(ymax = y), ymin = 0,
                       fill = "red", alpha = 0.5)
  upper <- geom_ribbon(data = subset(M, x > abs(crit)),
                       aes(ymax = y), ymin = 0,
                       fill = "red", alpha = 0.5)
  if (tail == "both") p <- p + lower + upper
  if (tail == "lower") p <- p + lower
  if (tail == "upper") p <- p + upper
  return(p)
}

shade_t <- function(q, df, tail = "both") {
  require(tidyverse, quietly = TRUE)
  require(cowplot)
  require(latex2exp, quietly = TRUE)
  crit <- qt(q, df)
  M <- data_frame(x = seq(-4, 4, length = 200),
                  y = dt(x, df))
  p <- ggplot(M, aes(x, y)) +
    geom_line() +
    labs(x = TeX("$t$"), y = "Relative Likelihood")
  lower <- geom_ribbon(data = subset(M, x < crit),
                       aes(ymax = y), ymin = 0,
                       fill = "red", alpha = 0.5)
  upper <- geom_ribbon(data = subset(M, x > abs(crit)),
                       aes(ymax = y), ymin = 0,
                       fill = "red", alpha = 0.5)
  if (tail == "both") p <- p + lower + upper
  if (tail == "lower") p <- p + lower
  if (tail == "upper") p <- p + upper
  return(p)
}

shade_F <- function(q, df1, df2) {
  require(tidyverse, quietly = TRUE)
  require(cowplot)
  require(latex2exp, quietly = TRUE)
  crit <- qf(q, df1, df2, lower.tail = FALSE)
  M <- data_frame(x = seq(0.001, crit * 1.5, length = 200),
                  y = df(x, df1, df2))
  p <- ggplot(M, aes(x, y)) +
    geom_line() +
    geom_ribbon(data = subset(M, x > crit),
                aes(ymax = y), ymin = 0,
                fill = "red", alpha = 0.5) +
    ylim(c(0, 1.1 * max(M$y))) +
    labs(x = TeX("$F$"), y = "Relative Likelihood")
  return(p)
}

shade_chisq <- function(q, df) {
  require(tidyverse, quietly = TRUE)
  require(cowplot)
  require(latex2exp, quietly = TRUE)
  crit <- qchisq(q, df, lower.tail = FALSE)
  M <- data_frame(x = seq(0.1, crit * 1.5, length = 200),
                  y = dchisq(x, df))
  p <- ggplot(M, aes(x, y)) +
    geom_line() +
    geom_ribbon(data = subset(M, x > crit),
                aes(ymax = y), ymin = 0,
                fill = "red", alpha = 0.5) +
    ylim(c(0, 1.1 * max(M$y))) +
    labs(x = TeX("$\\chi^2"), y = "Relative Likelihood")
  return(p)
}
