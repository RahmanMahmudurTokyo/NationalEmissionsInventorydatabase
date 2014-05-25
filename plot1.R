
getwd()

# First, read relted RDS files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# check whether input data has been uploaded into R properly
head(NEI,2)
head(SCC,2)

# Find total emissions in the year of 1999, 2002, 2005 and 2008
totalEmission = aggregate(Emissions ~ year, data=NEI, sum)

# ploting the graph
png(filename="plot1.png", width=480, height=480, units="px")
plot(totalEmission$Emissions, type="b", 
     xaxt="n",  xlab="Year",
     ylab=expression(PM[2.5]~Emissions~(`in`~tons)), 
     main=expression(Total~PM[2.5]~Emissions~`in`~United~States))
axis(1, at=c(1:4), labels=c("1999", "2002", "2005", "2008"))
dev.off()
