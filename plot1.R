# Course: Exploratory Data Analysis
# Assignment: Peer-graded Assignment: Course Project 1

# This assignment uses data from the UC Irvine Machine Learning Repository, a 
# popular repository for machine learning datasets. In particular, we will be 
# using the "Individual household electric power consumption Data Set."
# 
# Our overall goal here is simply to examine how household energy usage varies 
# over a 2-day period in February, 2007. Your task is to reconstruct the 
# following plots below, all of which were constructed using the base plotting 
# system.

# GitHub and Stack Overflow were consulted extensively for this project. Any
# similarities in code were not intended but could be could be artifacts of
# the code observed from these repositories. 

# Load neccessary libraries for code to function properly

library(tidyverse)
library(readr)
library(data.table)

# Set working directory

setwd("C:/User/Desktop/Temp")

#Reads in data from file then subsets data for specified dates
powerDT <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# Prevents histogram from printing in scientific notation
powerDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Change Date Column to Date Type
powerDT[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Filter Dates for 2007-02-01 and 2007-02-02
powerDT <- powerDT[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

# png("plot1.png", width=480, height=480)

## Plot 1
hist(powerDT[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.copy(png, filename = "plot1.png", width=480, height=480)

dev.off()
