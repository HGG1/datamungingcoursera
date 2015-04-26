CL_Appliance = function(rfun, dfun, ssize=9, runs=300, title="CL Appliance",...) {
	# Initialize
	# 	Stores the means of samples
	#		'runs' 	is the no. of samples
	#		'ssize'	is the size of each sample
		m <- double(0);
	# Sample
	#	Sample from base distribution specified in 'rfun'
		for (i in 1:runs) m[i] =  mean(rfun(ssize, ...));
		ms <- scale(m);
	# Plot
		par(mfrow = c(1,3));
		par(mar = c(5,2,5,1) + 0.1);
		# Base: Histogram, Population
		  hist(ms, probability = TRUE, col = "light grey", border = "grey", main = NULL, ylim = c(0,0.5));
		# Overlay: Density Function, Population
		  lines(density(ms));
		# Overlay: Normal Distribution, Sample
		  curve(dnorm(x,0,1), -3, 3, col = "blue", lwd = 2, add = TRUE);
		# Add: Q-Q Plot
		  qqnorm(ms);
		# Add:
		  plotter(rfun, dfun, ...);
};

plotter = function(rfun, dfun, ...) {
	samples <- rfun(1000, ...)
	hist(samples, prob = T, main = "", col = "light gray", border = "gray")
	lines(density(samples), lty = 2)
	curve(dfun(x, ...), lwd = 2, col = "firebrick", add = TRUE)
	rug(samples)
}

CL_Appliance(runif, dunif);
CL_Appliance(rexp, dexp);
CL_Appliance(rexp, dexp, rate = 4);
CL_Appliance(rpois, dpois, lambda = 7);
CL_Appliance(rpois, dpois, lambda = 9);
CL_Appliance(rbinom, dbinom, size = 10, prob = 0.3);
#CL_Appliance(rt, dt, df = 13);
