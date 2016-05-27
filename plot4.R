## Question 4
## Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

## if needed, load the data sets expected to be in the same directory as the script.
if(!exists("NEI")) {
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")) {
  SCC <- readRDS("Source_Classification_Code.rds")
}

## Filter the SCC codes for Coal
subSCC <- unique(SCC[intersect(grep("Coal", SCC$EI.Sector, ignore.case = TRUE), grep("Comb", SCC$EI.Sector, ignore.case = TRUE)), "SCC"])

## Use subCC to filter the observations for Coal Combustion-Related Emissions
subNEI <- NEI[NEI$SCC %in% subSCC,]

## Sum up the Emissions for each year
agNEI <- tapply(subNEI$Emissions, subNEI$year, FUN=sum)

## Create the graph
png("plot4.png", width = 1024, height = 768)
barplot(agNEI, xlab = "Year", ylab = "Emissions in ton/year", col = "blue",
        main = expression("Total PM"[2.5]*" Emissions from Coal Combustion-Related Sources in the USA for Years 1999 to 2008"))
dev.off()
