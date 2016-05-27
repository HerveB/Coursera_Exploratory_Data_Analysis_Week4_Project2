## Question 5
## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

## if needed, load the data sets expected to be in the same directory as the script.
if(!exists("NEI")) {
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")) {
  SCC <- readRDS("Source_Classification_Code.rds")
}

## Filter the SCC codes for Motor Vehicles
subSCC <- unique(SCC[grep("Vehicle", SCC$EI.Sector, ignore.case = TRUE), "SCC"])
## Use subCC to filter the observations for Motor Vehicle Emissions
subNEI <- NEI[NEI$fips == "24510" & NEI$SCC %in% subSCC,]
## Sum up the Emissions for each year
agNEI <- tapply(subNEI$Emissions, subNEI$year, FUN=sum)

## Create the graph
png("plot5.png", width = 1024, height = 768)
barplot(agNEI, xlab = "Year", ylab = "Emissions in ton/year", col = "blue",
        main = expression("Total PM"[2.5]*" Emissions from Motor Vehicle Sources in Baltimore City MD for Years 1999 to 2008"))
dev.off()
