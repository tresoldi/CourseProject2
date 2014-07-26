# Coursera's "Exploratory Data Analysis", Course Project 2, Question 1

# loads data; checking with file.exists() and uncompressing on-the-fly with
# unz() would add unnecessary complexities
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# collect data (/10^6 for having it in millions)
NEI$Emissions <- NEI$Emissions / 10^6
emissions <- aggregate(NEI$Emissions ~ NEI$year, NEI, sum) 
names(emissions) <- c("Year", "Emissions")

# plot to png file
png(filename="plot1.png", width=480, height=480)
plot(emissions, xlab="Year", ylab="Emissions (millions of tons)", type="b", pch=19, lty=1, col="red")
title(main=expression(PM[2.5] * " Total Emissions"))
dev.off();