# pollution plot 3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen 
# decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? 
library("ggplot2")
baltimore <- filter(NEI, fips=="24510")
summary2 <- summarise(group_by(baltimore,year,type), Emissions = sum(Emissions))
#baltimore <- transform(baltimore, year = factor(year))
#baltimore <- transform(baltimore, type = factor(type))
plot1 <- ggplot(summary2, aes(year, Emissions))
png("myplot.png", width=580, height=580, units="px", pointsize = 8, type = "quartz")
plot1 + geom_point(color = c("red","blue","blue","red"),size=6) + facet_grid(. ~ type) + geom_smooth(method="lm", se=FALSE) +labs(title = "Baltimore City Emissions 1999-2008 \n Showing Decreases for All Source Types Except POINT")
dev.off()

### NOTE: I used RED for the start and end values for each Source to make it even more obvious that the trend is down or up