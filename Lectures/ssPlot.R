ssPlot <- function(X, Y, b, do.plot = TRUE, do.labels = TRUE){
  n <- length(X)
  pred <- (X * b + (mean(Y) - b * mean(X)))
  SSy <- sum((Y - pred) ^ 2)

  M <- tibble(X, Y, pred)

  if (do.plot) {
    p <- ggplot() +
      geom_point(data = tibble(X = mean(X), Y = mean(Y)),
                 aes(X, Y), color = "blue", size = 7, pch = 1) +
      geom_abline(slope = b, intercept = mean(Y) - b * mean(X),
                  color = "blue") +
      geom_segment(data = M, aes(x = X, xend = X, y = Y, yend = pred),
                   color = "red") +
      geom_point(data = M, aes(x = X, y = Y), size = 2)

    v1 <- round(b, 2)
    v2 <- round(SSy, 2)
    ll <- paste0("theta_1 = ", v1, "\nSS = ", v2)

    xpos <- min(X) + 0.2 * diff(range(X))
    ypos <- min(Y) + 0.8 * diff(range(Y))

    if(do.labels) {
      p <- p +
        annotate(geom = "text", label = ll, x = xpos, y = ypos,
                 size = 7)
    }
    print(p)
  }
  return(SSy)
}
