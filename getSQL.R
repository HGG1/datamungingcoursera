library(sqldf)

# Get data
mySource <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv "
myDestination <- "AmericanCommunitySurvey.csv"

download.file(mySource, myDestination)

ACS <- read.csv(myDestination)
dim(ACS)
summary(ACS)

pwgtp1 <- sqldf("select pwgtp1 from ACS where AGEP < 50")
dim(pwgtp1)[1]
sqldf("select distinct AGEP from ACS")
unique(ACS$AGEP)

