# Vectors
# Matrices and Arrays
# Factors
# Lists
# Data Frame

# Vectors:
#   Ordered
#   Homogeneous
#   Linear

# Use c() to concatenate
# Use : to create a sequence of numbers
# Use seq() to create more complex sequences
# Use rep() to create replicates of values
# Use sort() and order() for ordering elements in a vector
#   sort(x, decreasing=TRUE)

c(3,2,1)
c(2,3,1)                # Order elements
x <- c(3,2,1)           # Assign index 
x[1]                    # Access with index
x <- c(raj=1, radha=2, raghu=3) # Name elements
x['raj']                # Access by name

x <- c(7,1,3)           # Make vector with concat
rep(x, 2)               # Repeat vector twice
rep(x, c(3,2,1))        # Repeat each element a specified no. times
rep(x, c(2,1))          # Arrrgh!

# seq(from, to)
# seq(from, to, by=)
# seq(from, to, length=)

seq(1,19)               # seq(from, to, by=1)
seq(1,19,by=2)          # seq(from, to, by=) 
seq(1,19, length=10)    # seq(from, to, length=)
seq(1,19,2)             # by=2
seq(1,19,10)            # by=10? length=10?
seq(1,length=10,by=2)
seq(1,19, length=10, by=2)  # Arrrrgh!
seq(1, length=10, 2)    # Assignment of unnamed args follow the order
seq(1, length=10, 19)   # Assignment of unnamed agrs ..

# Vectorized operations
x <- c(1.2,1,3)
2+x                     # Vectorization: Operate on each element
x^2
x+c(2,3)                # Recycling

# Subsetting
# Divide data into groups for comparison
# Extract elements by index or position
# Use the [] operator

# Five ways to subset .. 
x <- c(2,3,1)
x[2]                    # Use the position
x[-2]                   # Use exclusion
names(x) <- c("raj", "radha", "raghu")
x["radha"]              # Use name
x[c(TRUE, FALSE, FALSE)]  # Use binary selection
x[]                     # Get/set all elements
x[] = 0                 # 
x=0                     # How is this different?

# Use position ..
x <- c(11,30,2,14)
x[3]                    # 2
x[2:4]                  # Extract a slice of elements from 2 through 4
x[c(4,2)]               # Extract elements #4, #2 -- in what order?
x[11]                   # Exceed index -- error? NA?
x[0]                    # Use 0th position -- empty? error?
x[c(4,0,1)]             # What is the length of the extract?
ii <- c(3,2)   
y <- x[ii]              # What is y?
x[ii] <- 17             # What is x?
# Use logicals ..
x <- c(arun=1, akshay=2, aditi=6,x=13)
x[c(T,T,F,T)]           # What is the length of the extract?
x[!c(T,T,T,F)]          # Which does the exclamation mark do?
x[c(T,F)]               # Remember the recycling rule?
x[F]                    # Same as x[0]?
x[x>3]                  # What does the inner expression evaluate to?
                              # Conditional selection
# Use name ..
x["arun"]               # 
x[aditi]                # Is there a variable named aditi in the workspace?
x[-"aditi"]             # Can we negate names?
x[c("arun", "aditi", "x")]
x[x]                    # What two roles does x play here

# Matrices:
#   Homogeneous
#   Ordered
#   Two-dimensional

# Use matrix() to construct matrices
# Use dim() to access dimensions
# Use nrow(), ncol() to access row and column nos.
# Use dimnames(), rownames(), colnames() for naming

x <- matrix(1:15, nrow=3, byrow=TRUE)
dim(x)
nrow(x)
ncol(x)

rownames(x) <- letters[1:3]
colnames(x) <- letters[4:8]

# Is letters a function or variable?
# What if you want capital letters?
# How to use dim instead of hard-coded numbers for naming?

matrix(1:15, nrow=3)
matrix(1:15, ncol=3)
matrix(1:15, nrow=3, byrow=TRUE)  # Goes filling one row at a time

matrix(1:15, nrow=4)      # Whatever happened to recycling?

# Subsetting
# Use the [] operator

x <- matrix(1:15, nrow=3, byrow=TRUE)
m <- nrow(x)
n <- ncol(x)
rownames(x) <- letters[1:m]
colnames(x) <- letters[(m+1):(m+n)]

x[1:2,]                   # Extract contents of 1st two rows
x[,3:4]                   # Extract contents of cols 3 through 4
x[c(2,3),c(4,1)]          # Extract a two-two matrix - note the order

# Arrays
array(1:24, c(4,3,2))
array(1:48, c(4,3,2))     # What happens?
array(1:3, c(4,3,2))      # Recycling .. is back!

# Subsetting carries over in the same way
x <- array(1:24, c(4,3,2))
x[c(4,3),1:2,2]

# Lists
# Think about lists as a vector-like container for heterogeneous elements
# Elements of a list can be:
#   primitives ..
#   containers ..
# key-value pairs
# Composition
#   Ordered
#   Heterogeneous
#   Nested

myList <- list(a=1:10, b="Arjun", c(TRUE, FALSE, TRUE))

length(myList)            # What is the length of the list? 
class(myList)             # Type 'list'
names(myList)             # keys: a, b and empty
# Extract contents ..in which return type is the type of the stashed object
myList[[1]]               # Extract contents .. by position
myList$a                  # Extract contents .. by name/label
myList[["a"]]             # Extract contents .. by name/label
length(myList[[1]])       # What is the length? 1? 10?
# Subset .. in which return type is a smaller list
myList[1]                 # Subset 
myList["a"]               # Ditto
length(myList["a"])       # Why is the length 1? not 10?

# Data Frame
# Think of a data frame as a spreadsheet
#   Ordered 
#   Heterogeneous
#   Two-dimensional
# Think of a data frame as a list, 
#   with vectors of same length
data(iris)
names(iris)
dim(iris)                 # What's the size?
length(iris)              # Think list
iris[[1]]                 # Extract by position
iris[["Sepal.Length"]]    # Extract by label
length(iris[[1]])         # What is it? 150? 1?
length(iris[1])           # Why is it 1?
class(iris$Species)       # factor

# Exercise

giveMe(iris)              # data.frame, 5, 150x5
giveMe(iris[1])           # data.frame, 1, 150x1
giveMe(iris[[1]])         # numeric, 150, NULL
dim(iris[[1]])            # NULL
giveMe(iris[,1])          # numeric, 150, NULL
giveMe(iris["Species"])   # data.frame, 1, 150x1
giveMe(iris[,"Species"])  # factor, 150, NULL
giveMe(iris$Species)      # factor, 150

giveMe <- function(x) {
  c(class(x), length(x), dim(x))
}
# Next:
# apply
# mapply
# lapply
# tapply
