# Student's t 
#	Simulation Appliance

# Set-Up 
#	Pre-Reqs
#		Data Sources
#		Functionality
library(LearnBayes)
Sleep.Time=with(studentdata, WakeUp - ToSleep)
Sleep.Time=Sleep.Time[complete.cases(Sleep.Time)]
library(MASS)
truehist(Sleep.Time)

# Construct Simulation Core 
ST_Appliance = function(n = 5) {
  y = sample(Sleep.Time, size = n, replace = TRUE)
  sqrt(n) * (mean(y) - 7.385) / sd(y)
}

# Simulate
T = replicate(100000, ST_Appliance())
T = T[T > -5 & T < 5]  # Delete outliers to improve display

# Render Visualizations
plot(density(T), main = "Density Estimate", lwd = 2)
curve(dnorm(x), col = "red", add = TRUE, lwd = 2)
text(-4, .3, "NORMAL", cex = 1.5, col = "red")
curve(dt(x, df = 4), col = "blue", add = TRUE, lwd = 2)
text(4, .3, "T(4)", cex=1.5, col="blue")

# Central Limit Theorem 
#	Simulation Appliance

CL_Appliance = function(rfun, size=9, runs=300, title="CL Appliance",...) {
	# Initialize
	# 	Stores the means of samples
	#		'runs' 	is the no. of samples
	#		'size'	is the size of each sample
		m <- double(0);
	# Sample
	#	Sample from base distribution specified in 'rfun'
		for (i in 1:runs) m[i] =  mean(rfun(size, ...));
		ms <- scale(m);
	# Plot
		par(mfrow = c(1,2));
		par(mar = c(5,2,5,1) + 0.1)
		# Base: Histogram, Population
		  hist(ms, probability = TRUE, col = "light grey", border = "grey", main = NULL, ylim = c(0,0.5));
		# Overlay: Density Function, Population
		  lines(density(ms));
		# Overlay: Normal Distribution, Sample
		  curve(dnorm(x,0,1), -3, 3, col = "blue", lwd = 2, add = TRUE);
		# Add: Q-Q Plot
		  qqnorm(ms);
};
CL_Appliance(runif);
CL_Appliance(rexp);
CL_Appliance(rexp, rate = 4);
CL_Appliance(rpois, lambda = 7);
CL_Appliance(rpois, lambda = 9);
