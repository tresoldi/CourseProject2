# Coursera's "Exploratory Data Analysis", Course Project 2, Question 6

library(ggplot2)
library(plyr)

# loads data; checking with file.exists() and uncompressing on-the-fly with
# unz() would add unnecessary complexities
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# collect data for baltimore (24510) and los angeles (06037)
NEI_BL <- NEI[grepl("24510|06037", NEI$fips),]
SCC_onroad <- SCC[grepl("Mobile - On-Road", SCC$EI.Sector),]
onroad <- NEI_BL[NEI_BL$SCC %in% SCC_onroad$SCC,]

onroad$fips_year <- with(onroad, paste(fips, year))
onroad <- with(onroad, tapply(Emissions, fips_year, sum))
onroad <- data.frame(onroad)
names(onroad) <- "Emissions"

fips_year <- matrix(unlist(strsplit(rownames(onroad), " ")), ncol=2, byrow=TRUE)
onroad$fips <- fips_year[,1]
onroad$year <- fips_year[,2]
base <- rep(onroad$Emissions[c(1, 5)], each=4)
onroad$ratio <- onroad$Emissions / base
onroad$year <- as.numeric(onroad$year)

# Add location name for plot
onroad$location[onroad$fips=="24510"] <- "Baltimore"
onroad$location[onroad$fips=="06037"] <- "Los Angeles"

# plot to png file
g <- ggplot(onroad, aes(year, ratio))
g <- g + labs(y = "Emissions (Ratio)")
g <- g + ggtitle("Variation of emissions in Los Angeles and Baltimore (1999-2008)")
g <- g + geom_line(aes(color=location))
g <- g + geom_point(aes(color=location))
ggsave(filename="plot6.png",plot=g)