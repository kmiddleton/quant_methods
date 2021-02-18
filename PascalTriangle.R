PascalTriangle <- function(h) {
  lapply(1:h, function(i) choose(i, 0:i))
}

PascalTriangle(6)
