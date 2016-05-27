## Question 2
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (𝚏𝚒𝚙𝚜 == "𝟸𝟺𝟻𝟷𝟶") from 1999 to 2008?
## Use the base plotting system to make a plot answering this question.

## if needed, load the data sets expected to be in the same directory as the script.
if(!exists("NEI")) {
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")) {
  SCC <- readRDS("Source_Classification_Code.rds")
}

## Filter the observation for Baltimore only fips == "24510"
subNEI <- NEI[NEI$fips == "24510",]
## Sum up the Emissions for each year
agNEI <- tapply(subNEI$Emissions, subNEI$year, FUN=sum)

## Create the graph
png("plot2.png",  width = 1024, height = 768)
barplot(agNEI, , col = "blue", xlab = "Year", ylab = "Emisions in ton/year",
        main = expression("Total PM"[2.5]*" Emissions for Baltimore City MD for Years 1999 to 2008"))
dev.off()
