# Course: Exploratory Data Analysis
# Assignment: Peer-graded Assignment: Course Project 1.1

# This assignment uses data from the UC Irvine Machine Learning Repository, a 
# popular repository for machine learning datasets. In particular, we will be 
# using the "Individual household electric power consumption Data Set."
# 
# Our overall goal here is simply to examine how household energy usage varies 
# over a 2-day period in February, 2007. Your task is to reconstruct the 
# following plots below, all of which were constructed using the base plotting 
# system.

# GitHub and Stack Overflow were consulted extensively for this project. Any
# similarities in code were not intended but could be artifacts of the code 
# observed within these repositories. 

# Load neccessary libraries for code to function properly

library(tidyverse)
library(readr)
library(data.table)

# Set the working directory

setwd("C:/User/Desktop/Temp")

# Injest household_power_consumption.txt and assign to Global Active Power (GAP)
# variable, convert missing values from ? to null, and ensure all data are
# binned into proper classes
GAP <- read.table("household_power_consumption.txt", header=TRUE, sep=";"
            , na.strings = "?", colClasses = c('character','character','numeric'
            ,'numeric','numeric','numeric','numeric','numeric','numeric'))

# Convert Date variables to Date classes
GAP$Date <- as.Date(GAP$Date, "%d/%m/%Y")

# Subset data to the date range between 2007-02-01 and 2007-02-02
GAP <- subset(GAP, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

# Tidy dataset by removing incomplete data strings
GAP <- GAP[complete.cases(GAP),]

# Cosolidate date and time into single cells
DT <- paste(GAP$Date, GAP$Time)
DT <- setNames(DT, "Date_Time")

# Remove individual Date and Time columns from data frame
GAP <- GAP[ ,!(names(GAP) %in% c("Date","Time"))]

# Insert individual Date_Time column into data frame
GAP <- cbind(DT, GAP)

# Convert Date_Time to POSIX format
GAP$DT <- as.POSIXct(DT)

# Construct Global Active Power histogram with proper labels and colors
hist(GAP$Global_active_power, main="Global Active Power"
     , xlab = "Global Active Power (kilowatts)", col="red")

# Copy Global Active Power histogram to png file with proper dimensions
dev.copy(png,"plot1.png", width=480, height=480)

# Terminate png device to close device and save plot1.png
dev.off()

