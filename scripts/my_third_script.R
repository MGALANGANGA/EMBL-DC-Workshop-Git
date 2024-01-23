#We will be talking about data.frames

#Let's import some data
download.file(url = "https://ndownloader.figshare.com/files/2292169",
              destfile = "data_raw/portal_data_joined.csv")

library(tidyverse)

surveys <- read_csv("data_raw/portal_data_joined.csv")

head(surveys)
View(surveys)

str(surveys)

dim(surveys)
nrow(surveys)
ncol(surveys)

tail(surveys)

colnames(surveys)
rownames(surveys)

summary(surveys)

#Indexing and subsetting
surveys[1,6]

surveys[1,]
surveys[,1]

surveys[c(1,2,3), c(5,6)]

surveys[1:3, 5:6]

surveys[, -1]

surveys[, "sex"]
surveys["sex"]

surveys$plot_id


#Challenge
surveys_200 <- surveys[200,]
nrow(surveys)
surveys[nrow(surveys),] #This would get the last row
nrow(surveys)/2 #This will get the middle row
surveys[nrow(surveys)/2,]

#Lists in R
my_list <- list(names = c("Nora", "Lisanna", "Francesco"),
                money = c(1, 6, 7, 3, 5, 8))
str(my_list)
