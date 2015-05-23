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
NEI.vehicles.baltimore$city <- "Baltimore"

# subset only to Los Angeles
NEI.vehicles.la <- NEI.vehicles[NEI.vehicles$fips == '06037',]
NEI.vehicles.la$city <- "Los Angeles"

# put into one dataset Baltimore and Los Angeles
NEI.vehicles.both <- rbind(NEI.vehicles.la, NEI.vehicles.baltimore)

# plot
g <- ggplot(aes(factor(year), Emissions, fill = city), data = NEI.vehicles.both)
g + geom_bar(stat = "identity", aes(fill=year))+
    facet_grid(.~city)+
    theme_classic()+
    guides(fill = FALSE)+
    labs(x = "Year", y = expression("Total PM"[2.5]*" Emission (Tons)")) + 
    labs(title = expression("PM"[2.5]*" emission from vehicles between 1999-2008 (Baltimore & Los Angeles)"))

# save plot to file
ggsave(file = "plot6.png", width = 8, height = 5)
