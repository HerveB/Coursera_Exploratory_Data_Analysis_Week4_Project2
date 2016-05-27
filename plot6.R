## Question 6
## Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County,
## California (𝚏𝚒𝚙𝚜 == "𝟶𝟼𝟶𝟹𝟽"). Which city has seen greater changes over time in motor vehicle emissions?

## if needed, load the data sets expected to be in the same directory as the script.
if(!exists("NEI")) {
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")) {
  SCC <- readRDS("Source_Classification_Code.rds")
}

## Load necessary libraries
library(plyr)
library(ggplot2)

## Filter the SCC codes for Motor Vehicles
subSCC <- unique(SCC[grep("Vehicle", SCC$EI.Sector, ignore.case = TRUE), "SCC"])
## Filter the observation for Baltimore and Los Angeles only fips == "24510" or fips == "06037"
subNEI <- NEI[(NEI$SCC %in% subSCC) & (NEI$fips == "24510" | NEI$fips =="06037"),]
## Summarize Emissions per fips and per year
agNEI <- ddply(subNEI, .(fips, year), summarize, Emissions = sum(Emissions))
## Add the city names that will be use to create the graph
agNEI$City <- ifelse(agNEI$fips == "06037", "Los Angeles (CA)", "Baltimore City (MD)")

## Create the graph
png("plot6.png",  width = 1024, height = 768)
qplot(year, Emissions, data = agNEI, group = City, color = City, geom = c("point", "line"),
      xlab = "Year", ylab = "Emissions in ton/year",
      main = expression("Total PM"[2.5]*" Emissions from Motor Vehicle Sources for Baltimore City MD and Los Angeles CA for Years 1999 to 2008"))
dev.off()

