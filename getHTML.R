#
myURL <- "http://biostat.jhsph.edu/~jleek/contact.html"
con <- url(myURL)
htmlPage <- readLines(con) 
close(con)

nchar(htmlPage[c(10,20,30,100)])

# Get fixed-file format
NOAA <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
destination <- "NOAA.for"
download.file(NOAA, destination)

x <- read.fwf(
  file=destination,
  skip=4,
  widths=c(10, 9, 4, 9, 4, 9, 4, 9, 4))
