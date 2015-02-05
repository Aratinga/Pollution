## Pollution Plot 4
## Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

## FOR the whole NEI, select the coal related SCC

## In SCC, select the rows having coal in the Level 3 column - there are 181

coalNames <- filter(SCC, grepl(".*[cC]oal.*",SCC.Level.Three))
## Now try Short.Name - get a few more
coalNames2 <- filter(SCC, grepl(".*[cC]oal.*",Short.Name))   # 239 for this
## That includes charcoal - get rid of those
coalNames3 <- filter(SCC, grepl(".*Coal.*",Short.Name)) #exclude charcoal! 230 names
## Now inner join with NEI by using merge() result is 51,079 rows, POINT and NONPOINT
## NONPOINT show identical values for 2002 and 2005 when summarized - highly suspicious
##merged <- merge(NEI, coalNames, by = "SCC")
##merged2 <- merge(NEI, coalNames2, by = "SCC")   # 53,400 rows
merged3 <- merge(NEI, coalNames3, by = "SCC")   # 52,711 rows
##summary3 <- summarise(group_by(merged,year,type), Emissions = sum(Emissions))
summary4 <- summarise(group_by(merged3,year,type), Emissions = sum(Emissions)/1000)  ## Thousands of tons
png("plot4.png", width=580, height=580, units="px", pointsize = 8, type = "quartz")
plot4 <- ggplot(summary4, aes(year, Emissions))
plot4 + geom_point(color = c("red","blue","blue","red"),size=6) + facet_grid(. ~ type) + geom_smooth(method="lm", se=FALSE) +labs(title = "National Coal-Combustion-Related Emissions 1999-2008 \n Showing Decline of Pollution Over Time")  +labs(y = expression("Emissions (thousands of tons)"))
dev.off()
## NOTE: Nonpoint data for 2005 and 2002 had identical totals, and point data for those were also suspiciously close. Possibly there was some copying of 2002 to get 2005!
## The nonpoint totals did not change between the two selections.
#Summary 3 (Level 3 Names)
#year     type  Emissions
# 1 1999 NONPOINT  18682.615
# 2 1999    POINT 557516.781
# 3 2002 NONPOINT  68364.623
# 4 2002    POINT 476979.779
# 5 2005 NONPOINT  68364.623
# 6 2005    POINT 479510.027
# 7 2008 NONPOINT   8229.776
# 8 2008    POINT 337196.135

#Summary 4 (Short Names, plotted)
year     type  Emissions
# 1 1999 NONPOINT  18682.615
# 2 1999    POINT 583941.487
# 3 2002 NONPOINT  68364.623
# 4 2002    POINT 496575.374
# 5 2005 NONPOINT  68364.623
# 6 2005    POINT 501290.084
# 7 2008 NONPOINT   8229.776
# 8 2008    POINT 349854.078

#Excluding the charcoal businesses
# year     type  Emissions
# 1 1999 NONPOINT  18.274113
# 2 1999    POINT 578.413835
# 3 2002 NONPOINT  67.814843
# 4 2002    POINT 493.359867
# 5 2005 NONPOINT  67.814843
# 6 2005    POINT 498.886100
# 7 2008 NONPOINT   7.848734
# 8 2008    POINT 348.118935