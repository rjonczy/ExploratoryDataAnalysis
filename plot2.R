# load data from rds files
NEI <- readRDS("summarySCC_PM25.rds")

# subset only Baltimore (fips = '24510')
NEI.baltimore <- NEI[NEI$fips == '24510',]

# sum all Emissions and aggregate by year
totals <- aggregate(Emissions ~ year, NEI.baltimore, FUN = sum)

# setup file to be used for plotting
png(filename = "plot2.png")

# use barplot to plot total emission per year for all sources
barplot(
    totals$Emissions,
    names.arg = totals$year,
    col = c('red', 'green', 'blue', 'yellow'),
    xlab = "Year",
    ylab = "Total Emmission [Tons]",
    main = expression("PM"[2.5]*" emission between 1999-2008 (Baltimore)")
)

dev.off()

