
# first, read relatd RDS files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# check whether input files are uploaded properly
head(NEI,2)
head(SCC,2)

# extract related data for Baltimore City emissions
BaltimoreCityEmission = subset(NEI, fips==24510)

# get total emissions in Baltimore City in the year of  1999, 2002, 2005 and 2008
totalEmission = aggregate(Emissions ~ year, data=BaltimoreCityEmission, sum)

# plotting the graph
png(filename="plot2.png", width=480, height=480, units="px")
plot(totalEmission$Emissions, type="b", 
     xaxt="n",  xlab="Year", 
     ylab=expression(PM[2.5]~Emissions~(`in`~tons)), 
     main=expression(Total~PM[2.5]~Emissions~`in`~Baltimore~City))
axis(1, at=c(1:4), labels=c("1999", "2002", "2005", "2008"))
dev.off()
