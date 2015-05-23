library(ggplot2)
library(plyr)

# load data from rds files
NEI <- readRDS("summarySCC_PM25.rds")

# subset only Baltimore (fips = '24510')
NEI.baltimore <- NEI[NEI$fips == '24510',]

NEI.baltimore.type <- ddply(NEI.baltimore, . (type, year), summarize, Emissions = sum(Emissions) )

# plot
qplot(year, Emissions, data = NEI.baltimore.type,
      group = type, color = type,
      geom = c("point", "line"), 
      xlab = "Year", 
      ylab = "Total Emmission in [Tons]",
      main = expression("PM"[2.5]*" emission between 1999-2008 (Baltimore) by Pollutant Type")
)

# save plot to file
ggsave(file = "plot3.png", width = 8, height = 5)
