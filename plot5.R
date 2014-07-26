# Coursera's "Exploratory Data Analysis", Course Project 2, Question 5

library(ggplot2)
library(plyr)

# loads data; checking with file.exists() and uncompressing on-the-fly with
# unz() would add unnecessary complexities
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# collect data
baltimore_total <- NEI[NEI$fips==24510,]
SCC_onroad <- SCC[grepl("Mobile - On-Road", SCC$EI.Sector),]
baltimore_onroad <- baltimore_total[baltimore_total$SCC %in% SCC_onroad$SCC,]
baltimore_onroad <- with(baltimore_onroad, tapply(Emissions, year, sum))

# plot to png file
png(filename="plot5.png")
plot(names(baltimore_onroad), baltimore_onroad, xlab="Year", ylab="Coal Emissions", type="b", pch=19, lty=1, col="red")
title(main=expression(PM[2.5] * " Emissions of Motor Vehicles in Baltimore"))

dev.off();