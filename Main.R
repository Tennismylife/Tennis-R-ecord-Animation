library(tidyverse)

source("Reader.R")
source("Animator.R")
source("Formatter.R")
source("DataRetriever.R")

#Read database from csv
db <- ParallelReader()

#Get all data from a specific category with all winners tourney-by-tourney
M1000Roll <- Retrieve()

#Format the data to create a ordered and ranked dataframe
M1000RollFormatted <- Formatter(M1000Roll)

#Create an animation from your data
animation(M1000RollFormatted)
