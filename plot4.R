

# first, read relatd RDS files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# check whether input files are uploaded properly
head(NEI,2)
head(SCC,2)

# Find coal combustion-related sources
coalIndex = which(
        grepl("coal", SCC$SCC.Level.Three, ignore.case=TRUE) |
                grepl("lignite", SCC$SCC.Level.Three, ignore.case=TRUE)
)

# extract coal related SCC number
coalSCC = SCC[coalIndex, 1]

# extract coal related NEI
coalNEI = subset(NEI, SCC %in% coalSCC)

# calculte total emissions in 1999, 2002, 2005, 2008
coalTotalEmission = aggregate(Emissions ~ year, data=coalNEI, sum)

#plotting the graph
png(filename="plot4.png", width=480, height=480, units="px")
barplot(coalTotalEmission$Emissions,
        main=expression(Total~PM[2.5]~Emissions~from~Coal~Combustion-related~Sources),
        xlab="Year",
        ylab=expression(PM[2.5]~Emissions~(`in`~tons))
)
axis(1, at=c(1:4), labels=c("1999", "2002", "2005", "2008"))
dev.off()

