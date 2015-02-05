# Pollution Plot 1
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, 
# make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
library(dplyr)
summary <- summarise(group_by(NEI,year), sum(Emissions))
names(summary) <- c("year","Emissions")
summary$Emissions <- summary$Emissions/1000000  # show millions of tons
png("plot1.png", width=480, height=480, units="px", pointsize = 12, type = "quartz")
par(mar=c(5,5,7,3))
plot(summary$year, summary$Emissions, ylab = "Total pollution, millions of tons", xlab = "year", main = "Total PM2.5 Emission for All Sources,\n 1999, 2002, 2005, 2008 Showing decrease over time")

model <- lm(Emissions ~ year, summary)
abline(model, lwd=2)
dev.off()