library(ggplot2)

# load data from rds files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# grep and select 'combustion' related from SCC
combL <- grepl( "comb", SCC$SCC.Level.One, ignore.case=TRUE)
# grep and select 'coal' related from SCC
coalL <- grepl( "coal", SCC$SCC.Level.Four, ignore.case=TRUE)

# subset combustion and coal related from NEI dataset
SCC.coal.combustion <- SCC[ combL & coalL,]$SCC
NEI.coal.combustion <- NEI[ NEI$SCC %in% SCC.coal.combustion,]

# count totals (sum) for each year
NEI.coal.combustion.totals <- aggregate(Emissions ~ year, NEI.coal.combustion, sum)

# plot
g <- ggplot(aes(factor(year), Emissions / 1000000), data = NEI.coal.combustion.totals)
g + geom_bar(stat = "identity", fill="red", colour="black", width=0.75)+
    theme_classic()+
    #guides(fill = TRUE)+
    labs(x = "Year", y = expression("Total PM"[2.5]*" Emission (mln of Tons)")) + 
    labs(title = expression("PM"[2.5]*" emission from combusion and coal sources between 1999-2008 (all US)"))

# Save the file to plot4.png
ggsave(file = "plot4.png", width = 8, height = 5)