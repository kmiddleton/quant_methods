shade_normal <- function(q, tail = "both", mean = 0, sd = 1) {
  require(tidyverse, quietly = TRUE)
  require(cowplot)
  crit <- qnorm(q, mean, sd)
  M <- tibble(x = seq(-4, 4, length = 200),
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
  if (!require(latex2exp, quietly = TRUE)) {
    stop("Please install the package 'latex2exp':\n\tinstall.packages('latex2exp')")
  }

  crit <- qt(q, df)
  M <- tibble(x = seq(-4, 4, length = 200),
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

shade_F <- function(q, df1, df2, vline = NULL) {
  require(tidyverse, quietly = TRUE)
  require(cowplot)
  if (!require(latex2exp, quietly = TRUE)) {
    stop("Please install the package 'latex2exp':\n\tinstall.packages('latex2exp')")
  }

  crit <- qf(q, df1, df2, lower.tail = FALSE)
  if (!is.null(vline)) {
    x_max <- max(vline * 1.05, crit * 1.5)
  } else {
    x_max <- crit * 1.5
  }
  M <- tibble(x = seq(0.001, x_max, length = 200),
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
  if (!require(latex2exp, quietly = TRUE)) {
    stop("Please install the package 'latex2exp':\n\tinstall.packages('latex2exp')")
  }

  crit <- qchisq(q, df, lower.tail = FALSE)
  M <- tibble(x = seq(0.1, crit * 1.5, length = 200),
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
