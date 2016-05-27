## Question 3
## Of the four types of sources indicated by the 𝚝𝚢𝚙𝚎 (point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
## Which have seen increases in emissions from 1999–2008?
## Use the ggplot2 plotting system to make a plot answer this question.

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

## Filter the observation for Baltimore only fips == "24510"
subNEI <- NEI[NEI$fips == "24510",]
## Summarize Emissions per type and per year
agNEI <- ddply(subNEI, .(type, year), summarize, Emissions = sum(Emissions))

## Create the graph
png("plot3.png", width = 1024, height = 768)
qplot(year, Emissions, data = agNEI, group = type, color = type,
      geom = c("point", "line"), xlab = "Year",ylab = "Emissions in ton/year", 
      main = expression("Total PM"[2.5]*" Emissions in Baltimore City MD by Type of Pollutant for Years 1999 to 2008"))
dev.off()

