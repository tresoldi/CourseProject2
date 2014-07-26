# Coursera's "Exploratory Data Analysis", Course Project 2, Question 2

# loads data; checking with file.exists() and uncompressing on-the-fly with
# unz() would add unnecessary complexities
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# collect data for baltimore
NEIB <- NEI[(NEI$fips == "24510"),]
emissions <- aggregate(NEIB$Emissions ~ NEIB$year, NEIB, sum)
names(emissions) <- c("Year", "Emissions")

# plot to png file
png(filename="plot2.png", width=480, height=480)
plot(emissions, xlab="Year", ylab=expression(PM[2.5] * " Emissions (tons)"), type="b", pch=19, lty=1, col="red")
title(main=expression(PM[2.5] * " Emissions in Baltimore"))
dev.off();