## Question 1
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
## Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

## if needed, load the data sets expected to be in the same directory as the script.
if(!exists("NEI")) {
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")) {
  SCC <- readRDS("Source_Classification_Code.rds")
}

## Sum up the Emissions for each year
agNEI <- tapply(NEI$Emissions, NEI$year, FUN=sum)

## Create the graph
png("plot1.png",  width = 1024, height = 768)
barplot(agNEI , col = "blue", xlab = "Year", ylab = "Emisions in ton/year",
        main = expression("Total PM"[2.5]*" Emissions in the USA for Years 1999 to 2008"))
dev.off()
