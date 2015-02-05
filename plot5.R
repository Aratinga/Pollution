#Pollution Plot 5 -Baltimore motor vehicle emissions
library("ggplot2")
baltimore <- filter(NEI, fips=="24510")
#motorNames <- filter(SCC, grepl(".*Motor.*",Short.Name))
motorNames2 <- filter(SCC, Data.Category == "Onroad")  # better than short name, gets buses etc
mbaltimore <- merge(baltimore, motorNames2, by = "SCC") # inner join
summary5 <- summarise(group_by(mbaltimore,year), Emissions = sum(Emissions))
plot5 <- ggplot(summary5, aes(year, Emissions))
png("plot5.png", width=580, height=580, units="px", pointsize = 12, type = "quartz")
plot5 + geom_point(color = c("red","blue","blue","red"),size=6) + geom_smooth(method="lm", se=FALSE) +
  labs(title = "Baltimore City On-Road Emissions 1999-2008 \n Showing Decrease Over Time") +
  labs(y = "Emissions, in tons")
dev.off()
