#Pollution Plot 6 
## Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?
## The rate of change over time is the slope of the lm. dx is 10 years, I guess. 
## The slopes of lm are -26 for Baltimore, indicating a decrease, and +28 for Los Angeles County, indicating an increase. These are so similar that only the LM calculation
## of the slope reveals which is greater. Of course, an increase in Los Angeles County is so much more pollution, in tons, than the decrease in Baltimore City, that it is 
## somewhat humourous to look at them together on the same scale
library("ggplot2")
compares <- filter(NEI, fips=="24510" | fips=="06037")
#motorNames <- filter(SCC, grepl(".*Motor.*",Short.Name))
motorNames2 <- filter(SCC, Data.Category == "Onroad")  # better than short name, gets buses etc
mcompares <- merge(compares, motorNames2, by = "SCC") # inner join
fips <- c("24510","06037")
City <- c("Baltimore City","Los Angeles County")
cities <- data.frame(fips, City, stringsAsFactors = FALSE)
citycompare <- merge(mcompares, cities, by.mcompares = fips, by.cities = fips)
summary6 <- summarise(group_by(citycompare,City,year), Emissions = sum(Emissions))

## Have a look at the slope of the lm line for each city
coeff.baltimore <- lm(Emissions ~ year, data = filter(summary6, City == "Baltimore City"))
slope.baltimore <- coeff.baltimore$coefficients[2]   ## This is -26
coeff.lacounty <- lm(Emissions ~ year, data = filter(summary6, City == "Los Angeles County"))
slope.lacounty <- coeff.lacounty$coefficients[2]   ## This is +28
plot6 <- ggplot(summary6, aes(year, Emissions))
png("plot6.png", width=580, height=580, units="px", pointsize = 12, type = "quartz")
plot6 + geom_point(color = c("red","blue","blue","red"),size=6) + geom_smooth(method="lm", se=FALSE) +
  labs(title = "Baltimore City and Los Angeles County On-Road Emissions 1999-2008 \n Showing Changes Over Time: Baltimore decreases slightly while LA increases.
       The slopes are -26 for Baltimore and +28 for LA." ) +
  labs(y = "Emissions, in tons") +
  facet_grid(. ~ City)
dev.off()
