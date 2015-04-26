
folderName <- "C:/Users/ssbhat3/Desktop/Coursera Data Munging"
setwd(folderName)
getwd()

#
communityHousing <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

fileName <- "HousingData.csv"

        
destination <- file.path(folderName, fileName) 
destination

download.file(communityHousing, destination)

housingData <- read.csv(destination)
              
dim(housingData)
summary(housingData)

# How many properties are worth $1,000,000 (USD 1 M) or more?
# Ref. codebook
summary(housingData$VAL)
sum(housingData$VAL == 24, na.rm = TRUE) # Ans: 53

#
# library(xlsx)
# library(XLConnect)
naturalGas <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"

fileName <- "naturalGas.xlsx"

destination <- file.path(folderName, fileName)

download.file(naturalGas, destination, mode="wb")

dat <- read.xlsx(destination, sheetIndex = 1, rowIndex = 18:23, colIndex = 7:15)
head(dat)

sum(dat$Zip*dat$Ext,na.rm=T) # 36534720

# Fix?
# Sys.setenv(JAVA_HOME='C:\\Program Files (x86)\\Java\\jre6')
# library(rJava)
# Install 64-bit Java in C:\\Program Files\\Java

#
library(XML)
baltimoreRestaurants <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml'

fileName <- "restaurantData.xml"

destination <- file.path(folderName, fileName) 
destination

download.file(baltimoreRestaurants, destination)

restaurantData <- xmlTreeParse(destination)

restaurantTop <- xmlRoot(restaurantData)
xmlSize(restaurantTop[[1]])           # 1327 children
xmlName(restaurantTop[[1]])           # tag: row
xmlSize(restaurantTop[[1]][[1]])      # 6 children
xmlName(restaurantTop[[1]][[1]])      # tag: row
xmlSize(restaurantTop[[1]][[1]][[2]]) # children: 1
xmlName(restaurantTop[[1]][[1]][[2]]) # tag: zipcode
restaurantTop[[1]][[1]][[2]]          # zipcode, one of 6 elements
xmlValue(restaurantTop[[1]][[1]][[2]])

len <- seq(length.out= xmlSize(restaurantTop[[1]]))
out <- logical(0)
for (i in len) {
  zipCode = "21231"
  restaurant <- 
  out <- c(out, zipMatch(restaurantTop[[1]][[i]], zipCode)) 
}
out
sum(out) # 127
zipMatch <- function(restaurant_XMLnode, zip) {
  xmlValue((restaurant_XMLnode)[[2]]) == zip
}
zipMatch(restaurantTop[[1]][[1110]], "21202")

#
library(data.table)
housingIdaho <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv'

fileName <- "HousingIdaho.csv"

destination <- file.path(folderName, fileName) 
destination

download.file(housingIdaho, destination)

housingIdaho <- read.csv(destination)
DT <- fread(destination, header=T, sep=",", stringsAsFactors=F)

dim(housingIdaho)
summary(housingIdaho)

op <- microbenchmark(
  #OPT01A = rowMeans(DT)[DT$SEX==1],
  #OPT01B = rowMeans(DT)[DT$SEX==2],
  OPT02A=mean(DT[DT$SEX==1,]$pwgtp15),
  OPT02B=mean(DT[DT$SEX==2,]$pwgtp15),
  OPT03=DT[,mean(pwgtp15),by=SEX],
  OPT04=tapply(DT$pwgtp15,DT$SEX,mean),
  OPT05=mean(DT$pwgtp15,by=DT$SEX),
  OPT06=sapply(split(DT$pwgtp15,DT$SEX),mean),
  CONTROL=tapply(mtcars$hp, interaction(mtcars$cyl, 
                                         mtcars$gear), mean),
  times=100L)

print(op)               # standard data frame of the output
boxplot(op)             # boxplot of output
library(ggplot2)        # nice log plot of the output
qplot(y=time, data=op, colour=expr) + scale_y_log10()

# Alt.
# Note some options give an incorrect or partial answer.
#
system.time(replicate(1000, mean(DT[DT$SEX==1,]$pwgtp15)))
system.time(replicate(1000, mean(DT[DT$SEX==2,]$pwgtp15)))
system.time(replicate(1000, DT[,mean(pwgtp15),by=SEX]))             # FAST
system.time(replicate(1000, tapply(DT$pwgtp15,DT$SEX,mean)))
system.time(replicate(1000, mean(DT$pwgtp15,by=DT$SEX)))            # Partial - Discard
system.time(replicate(1000, sapply(split(DT$pwgtp15,DT$SEX),mean))) # FASTEST

# Microbenchmark examples
system.time(replicate(100000, DT[,mean(pwgtp15),by=SEX]))
system.time(replicate(100000, sapply(split(DT$pwgtp15,DT$SEX),mean)))

library(microbenchmark); library(plyr) 
op <- microbenchmark(
  PLYR=ddply(mtcars, .(cyl, gear), summarise, 
             output = mean(hp)),
  AGGR=aggregate(hp ~ cyl + gear, mtcars, mean),
  TAPPLY = tapply(mtcars$hp, interaction(mtcars$cyl, 
                                         mtcars$gear), mean),
  times=1000L)

print(op) #standard data frame of the output
boxplot(op) #boxplot of output
library(ggplot2) #nice log plot of the output
qplot(y=time, data=op, colour=expr) + scale_y_log10()
