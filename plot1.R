# load data from rds files
NEI <- readRDS("summarySCC_PM25.rds")

# sum all Emissions and aggregate by year
totals <- aggregate(Emissions ~ year, NEI, FUN = sum)

# use barplot to plot total emission per year for all sources
barplot(
    totals$Emissions / 1000000,
    names.arg = totals$year,
    col = heat.colors(4),
    xlab = "Year",
    ylab = "Total Emmission",
    main = "PM2.5 emission between 1999-2008"
)


