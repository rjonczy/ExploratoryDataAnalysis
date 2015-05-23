# load data from rds files
NEI <- readRDS("summarySCC_PM25.rds")

# sum all Emissions and aggregate by year
totals <- aggregate(Emissions ~ year, NEI, FUN = sum)

# setup file to be used for plotting
png(filename = "plot1.png")

# use barplot to plot total emission per year for all sources
barplot(
    totals$Emissions / 1000000,
    names.arg = totals$year,
    col = c('red', 'green', 'blue', 'yellow'),
    xlab = "Year",
    ylab = "Total Emmission in [mln of Tones]",
    main = "PM2.5 emission between 1999-2008"
)

dev.off()


