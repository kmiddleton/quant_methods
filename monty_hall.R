set.seed(43467)

n_games <- 100

doors <- 1:3

prize <- sample(doors, size = n_games, replace = TRUE)
guess <- sample(doors, size = n_games, replace = TRUE)

games <- tibble(
  prize = prize,
  guess = guess,
  stay = NA,
  switch = NA
)

for (ii in 1:n_games) {
  # Don't switch
  games$stay[ii] <- ifelse(games$prize[ii] == games$guess[ii], 1, 0)
  
  # Switch
  g <- games$guess[ii]
  p <- games$prize[ii]
  
  # If you guessed right, choose randomly one of the remaining doors
  # else choose the only other possible door
  open <- ifelse(g == p,
                 sample(doors[!(g == doors)], 1),
                 doors[doors != p & doors != g])
  g2 <- doors[doors != g & doors != open]
  games$switch[ii] <- ifelse(p == g2, 1, 0)
}

colMeans(games)
