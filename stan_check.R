install.packages(c("Rcpp", "RcppEigen", "BH", "inline", "StanHeaders"), type = "source")
devtools::install_github("stan-dev/rstan", ref = "develop", subdir = "rstan/rstan", dependencies = TRUE)


library(rstan)

stanmodelcode <- "
data {
int<lower=0> N;
real y[N];
}

parameters {
real mu;
}

model {
target += normal_lpdf(mu | 0, 10);
target += normal_lpdf(y  | mu, 1);
}
"

y <- rnorm(20)
dat <- list(N = 20, y = y);
fit <- stan(model_code = stanmodelcode, model_name = "example",
            data = dat, iter = 2012, chains = 3,
            verbose = TRUE)

install_github("rmcelreath/rethinking", force=TRUE)
library(rethinking)

data(chimpanzees)

# don't want any variables with NAs
d <- list(
  pulled_left = chimpanzees$pulled_left ,
  prosoc_left = chimpanzees$prosoc_left ,
  condition = chimpanzees$condition ,
  actor = as.integer( chimpanzees$actor ) ,
  blockid = as.integer( chimpanzees$block )
)

# RStan fit
m2 <- map2stan(
  alist(
    pulled_left ~ dbinom(1,theta),
    logit(theta) <- a + bp*prosoc_left + bpc*condition*prosoc_left ,
    a ~ dnorm(0,10),
    bp ~ dnorm(0,10),
    bpc ~ dnorm(0,10)
  ) ,
  data=d, chains=2, cores=1 )
