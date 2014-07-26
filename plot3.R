# Coursera's "Exploratory Data Analysis", Course Project 2, Question 3

library(ggplot2)

# loads data; checking with file.exists() and uncompressing on-the-fly with
# unz() would add unnecessary complexities
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# collect data for baltimore
baltimore <- NEI[(NEI$fips == "24510"),]
baltimore$year <- factor(baltimore$year, levels=c(1999, 2002, 2005, 2008))

# plot to png file
p <- qplot(year, Emissions, data=baltimore)
p <- p + ggtitle("Pollution from different types of sources in Baltimore")
p <- p + facet_grid( . ~ type)
p <- p + xlab('Year')
p <- p + ylab(expression(PM[2.5] * "Emissions (tons)"))
p <- p + geom_line()

ggsave(filename="plot3.png",plot=p)