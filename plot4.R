# Coursera's "Exploratory Data Analysis", Course Project 2, Question 4

# loads data; checking with file.exists() and uncompressing on-the-fly with
# unz() would add unnecessary complexities
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# collect data
scc_coal <- SCC[grep("coal", SCC$Short.Name, ignore.case = TRUE),]
coal_em <- NEI[(NEI$SCC %in% scc_coal$SCC),]
total_coal <- aggregate(coal_em$Emissions ~ coal_em$year, coal_em,sum)

# plot to png file
png(filename="plot4.png")
plot(total_coal, xlab="Year", ylab="Coal Emissions", type="b", pch=19, lty=1, col="red")
title(main=expression(PM[2.5] * " Emissions of Coal Combustion"))

dev.off();