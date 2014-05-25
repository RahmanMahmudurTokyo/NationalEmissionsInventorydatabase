
# first, read relatd RDS files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# check whether input files are uploaded properly
head(NEI,2)
head(SCC,2)

# Get the subset Baltimore City emissions with fips=24510 
BaltimoreCityMotorEmission = subset(NEI, fips==24510 & type =="ON-ROAD")

# Calculate total emissions in Baltimore City in the year of 1999, 2002, 2005 and 2008
totalEmission = aggregate(Emissions ~ year, data=BaltimoreCityMotorEmission, sum)

# plotting the graph
png(filename="plot5.png", width=480, height=480, units="px")
barplot(totalEmission$Emissions, 
        main=expression(Total~PM[2.5]~Emissions~from~Motor~Vehicle~Sources~In~Baltimore~City),
        xlab="Year", 
        ylab=expression(PM[2.5]~Emissions~(`in`~tons))
)
axis(1, at=c(1:4), labels=c("1999", "2002", "2005", "2008"))
dev.off()

