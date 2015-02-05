# Pollution Plot 2
# Have total emissions from PM2.5 decreased in Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Using the base plotting system, 
# make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
library(dplyr)
baltimore <- filter(NEI, fips=="24510")
summary <- summarise(group_by(baltimore,year), Emissions = sum(Emissions))
png("plot2.png", width=480, height=480, units="px", pointsize = 12, type = "quartz")
par(mar=c(5,5,7,3))
plot(summary$year, summary$Emissions,pch=20, ylab = "Total Emissions, tons", xlab = "year", 
     main = "Total PM2.5 Emissions for Baltimore City,\n 1999, 2002, 2005, 2008 Showing General Decrease Over Time")

model <- lm(Emissions ~ year, summary)
abline(model, lwd=2)
dev.off()