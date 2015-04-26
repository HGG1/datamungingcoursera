library(RUnit)
# Quiz #1
# Practice

# Working directory
getwd()         # What is ..
name = "C:\\Users\\ssbhat3\\Desktop\\Coursera Data Munging"
setwd(name)     # Change to 
getwd()         # Set?

# Explore files
list.files()
fname = "cards.R"
file.exists(fname)

# Download from the internet
# Give resource url, target file name to download.file() 
tutorial <- "http://www.autonlab.org/tutorials/hmm14.pdf"
destination <- "Auton_HiddenMarkovModels.pdf"
download.file(tutorial, destination, mode="wb")

# Download mini-pattern
if (!file.exists(destination)) { # Check for collision
  resource <- "http://www.autonlab.org/tutorials/hmm14.pdf"  
  download.file(resource, destination, mode="wb")
  dateDownloaded <- date()
}
# File I/O
# Create a matrix 9x9 with random nos between 0 and 9
mm <- matrix(round(runif(81, min=0, max=9)), nrow=9)
mm[1,3] <- -1
mm[3,1] <- -9
colnames(mm) <- seq_len(dim(mm)[2])
rownames(mm) <- paste0("t", seq_len(dim(mm)[2]))
# Save as a csv file
write.csv(mm, "Mat.dat")
# Read data using read.csv
MM <- read.csv("Mat.dat", header=TRUE)
rownames(MM) <- MM[,1]
MM <- MM[,-1]
# Read data using read.table
TT <- read.table("Mat.dat", header=TRUE, sep=",")
rownames(TT) <- TT[,1]
TT <- TT[,-1]
head(TT, 3)
summary(TT)
# Other options:
MM <- read.csv("Mat.dat", header=TRUE, nrows=3)
rownames(MM) <- MM[,1]
MM <- MM[,-1]
checkEqualsNumeric(3, dim(MM)[1])
#
MM <- read.csv("Mat.dat", header=TRUE, na.strings=c("-1", "-9"))
rownames(MM) <- MM[,1]
MM <- MM[,-1]
checkTrue(is.na(MM[1,3]))
checkTrue(is.na(MM[3,1]))
#
checkTrue(grepl("\'", MM[7,4]))   # Has quote
MM <- read.csv("Mat.dat", header=TRUE, quote="\"'")
checkTrue(grepl("\'", MM[7,4]))   # Quotation marks stripped



