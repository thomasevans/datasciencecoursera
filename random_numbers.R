# Probability distributions and random number generation


str(dnorm)

par(mfrow = c(2,1))
plot(dnorm(0:20, 10, 3), type = "b", main = "dnorm")
plot(pnorm(0:20, 10, 3), type = "b", main = "pnorm")

str(rpois)
hist(rpois(1000, 3))

z <- NULL
x <- NULL
Rprof({
  for(i in 1:1000000){
    z <- i + z
    x <- z^z
  }
})
summaryRprof()



set.seed(1)
rpois(5, 2)

?set.seed
#

set.seed(10)
x <- rep(0:1, each = 5)
e <- rnorm(10, 0, 20)
y <- 0.5 + 2 * x + e
y



set.seed(1)
rpois(5, 2)
