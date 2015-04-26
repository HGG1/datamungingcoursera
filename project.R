# Project Work

simulatorCentral = function(rfun, dfun, ssize=40, runs=1000, title="Course Project: Central Limit Theorem",...) {
  # Initialize
  # 	m:      stores the means of samples
  #		runs: 	no. of simulations
  #		ssize:	sample size
  m <- double(0);

  for (i in 1:runs) m[i] =  mean(rfun(ssize, ...));   # Collect sample means
  ms <- scale(m);                                     # Scale for plotting
  
  plotSet()                   # Set up for plotting, 1x3 plots
  plotterA(ms)                # Plot the distribution of sample means
  plotterB(rfun, dfun, ...);  # Plot the underlying distribution
  
  return(m)
};


plotSet = function() {
  par(mfrow = c(1,3));
  par(mar = c(5,2,5,1) + 0.1);
}

plotterA = function(ms) { # Plot the distribution of sample means
  hist(ms, probability = TRUE, 
       col = "light grey", border = "grey", 
       main = "Sample Means", ylim = c(0,0.5));                   # Plot: Histogram
  lines(density(ms));                                             # Density plot 
  curve(dnorm(x,0,1), -3, 3, col = "blue", lwd = 2, add = TRUE);  # Std. normal distribution
  qqnorm(ms);                                                     # Add: Q-Q Plot
}

plotterB = function(rfun, dfun, ...) { # Plot the underlying distrbution
  samples <- rfun(1000, ...)
  # Plot: Histogram
  hist(samples, prob = TRUE, 
       main = "Original Distribution", 
       col = "light gray", border = "gray")
  lines(density(samples), lty = 2)
  curve(dfun(x, ...), lwd = 2, col = "firebrick", add = TRUE)
  rug(samples)
}

simulatorCentral(runif, dunif);
simulatorCentral(rexp, dexp);
simulatorCentral(rexp, dexp, rate = 4);
simulatorCentral(rexp, dexp, rate = 0.2);
simulatorCentral(rpois, dpois, lambda = 7);
simulatorCentral(rbinom, dbinom, size = 10, prob = 0.3);
#simulatorCentral(df=13, rt, dt);
