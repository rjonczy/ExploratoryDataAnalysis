library(ggplot2)

# load data from rds files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subset vehicles data
vehicleL <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
SCC.vehicles <- SCC[vehicleL,]$SCC
NEI.vehicles <- NEI[NEI$SCC %in% SCC.vehicles,]

# subset only to Baltimore
NEI.vehicles.baltimore <- NEI.vehicles[NEI.vehicles$fips == '24510',]

# count totals (sum) for each year
NEI.vehicles.baltimore.totals <- aggregate(Emissions ~ year, NEI.vehicles.baltimore, sum)

# plot
g <- ggplot(aes(factor(year), Emissions), data = NEI.vehicles.baltimore.totals)
g + geom_bar(stat = "identity", fill="red", colour="black", width=0.75)+
    theme_classic()+
    guides(fill = FALSE)+
    labs(x = "Year", y = expression("Total PM"[2.5]*" Emission (Tons)")) + 
    labs(title = expression("PM"[2.5]*" emission from vehicles between 1999-2008 (Baltimore)"))

# save plot to file
ggsave(file = "plot5.png", width = 8, height = 5)
