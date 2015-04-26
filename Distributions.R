# Normal Distribution
samples <- rnorm(1000, mean = 0, sd = 1)
hist(samples, prob = T, main = "", col = gray(0.9))
lines(density(samples), lty = 2)
curve(dnorm(x, mean = 0, sd = 1), lwd = 2, add = TRUE)
rug(samples)
# Exponential Distribution
samples <- rexp(1000, rate = 1)
hist(samples, prob = T, main = "", col = gray(0.9))
lines(density(samples), lty = 2)
curve(dexp(x, rate = 1), lwd = 2, add = TRUE)
rug(samples)
# Student t Distribution
samples <- rt(1000, df = 9)
hist(samples, prob = T, main = "", col = gray(0.9))
lines(density(samples), lty = 2)
curve(dt(x, df = 9), lwd = 2, add = TRUE)
rug(samples)
# Binomial Distribution
samples <- rbinom(10000, size = 1000, prob = 0.3)
hist(samples, prob = T, main = "", col = gray(0.9))
lines(density(samples), lty = 2)
curve(dbinom(x, size = 1000, prob = 0.3), type = "h", lwd = 2, add = TRUE)
rug(samples)
# Poisson Distribution
samples <- rpois(1000, lambda = 7)
hist(samples, prob = T, main = "", col = gray(0.9))
lines(density(samples), lty = 2)
curve(dpois(x, lambda = 7), type = "h", lwd = 2, add = TRUE)
rug(samples)

duration <- rpois(500, 10) # For duration data I assume Poisson distributed
hist(duration,
   probability = TRUE, # In stead of frequency
   breaks = "FD",      # For more breaks than the default
   col = "darkslategray4", border = "seashell3")
lines(density(duration - 0.5),   # Add the kernel density estimate (-.5 fix for the bins)
   col = "firebrick2", lwd = 3)