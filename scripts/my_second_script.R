weight_g <- c(50, 60, 65, 82)

animals <- c("mouse", "rat", "dog")


#Get the length of the vector
length(animals)

#Get the type of data contained in the vector
class(animals)
class(weight_g)

#Structure of the object
str(animals)

#How to add an element to the beginning of a vector
animals <- c("cincilla", animals)
animals <- c(animals, "frog")
animals

typeof(animals)

#Challenge
num_char <- c(1, 2, 3, "a")
num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
tricky <- c(1, 2, 3, "4")

class(num_char)
class(num_logical)
num_logical
class(char_logical)
char_logical
class(tricky)
tricky

#logical -> numeric -> character
#logical -> character

#Subsetting a vector
animals[2]
animals[c(1, 2)]

more_animals <- animals[c(1, 2, 3, 2, 1, 4)]
more_animals

#Subsetting with logical operators
weight_g
weight_g[c(FALSE, FALSE, TRUE, TRUE)]
weight_g > 63
weight_g[weight_g > 63]
weight_g[weight_g > 63 & weight_g < 80]
weight_g[weight_g < 58 | weight_g > 80]

#Operators <, >, ==, !=, <=, >=

#More subsetting with operators
weight_g==65
animals[animals =="rat" | animals =="frog"]

#%in% will help us to find all elements corresponding to a vector of elements of our choice
animals %in% c("rat", "frog", "cat", "duck", "dog")
animals

#An example of a vector with missing data
heights <- c(2, 4, 4, NA, 6)
mean(heights)
mean(heights, na.rm = T)
max(heights, na.rm=T)

#Identify which are the misssing data (a.k. a NA)
is.na(heights)
heights[!is.na(heights)]

#Omit the missing data
na.omit(heights)

#extract the complete cases
heights[complete.cases(heights)]

#Challenge
heights <- c(63, 69, 60, 65, NA, 68, 61)
heights_no_na <- na.omit(heights)
heights_no_na <- heights[!is.na(heights)]
heights_no_na

median(heights, na.rm = T)

heights_no_na[heights_no_na > 67]
length(heights_no_na[heights_no_na > 67])

sum(heights_no_na > 67)
heights_no_na > 67
