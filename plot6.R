
# first, read relatd RDS files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# check whether input files are uploaded properly
head(NEI,2)
head(SCC,2)

# Get the subset of Baltimore City with fips= 24510 and LA with fips= 06037) motor vehicle emissions
motorEmission = subset(NEI, (type=="ON-ROAD" & (fips=="24510" | fips=="06037")))

# Calculate total emissions in Baltimore City in the year of 1999, 2002, 2005 and 2008
totalEmission = aggregate(Emissions ~ year + fips, data=motorEmission, sum)

# In order to figure out Which city has seen greater changes over time in motor vehicle emissions
# Get absolute change for following periods
# 1) 1999 - 2002 2) 2002 - 2005 and  3) 2005 - 2009

# create a new data named DifferenceEmission
DifferenceEmission = totalEmission
DifferenceEmission['difference'] = 0      #form a new column named difference

# Get the absolute difference in each period
DifferenceEmission$difference[2:4] = abs(diff(totalEmission$Emissions[1:4]))
DifferenceEmission$difference[6:8] = abs(diff(totalEmission$Emissions[5:8]))

# Delete irrevelant rows and columns
DifferenceEmission = DifferenceEmission[-c(1, 5),]    # deleting irrevelant rows
DifferenceEmission = DifferenceEmission[, -c(1, 3)]           # deleting irrevelant columns

# Add the Period column
DifferenceEmission ['Period'] = rep(c("1999-2002", "2002-2005", "2005-2008"), 2)


# plotting the graph
library(ggplot2)
png(filename="plot6.png", width=480, height=480, units="px")
p = ggplot(DifferenceEmission, aes(x=fips, y=difference, fill=Period))
p + geom_bar(stat="identity")+
        xlab("Location") +
        ylab(expression(Absolute~Change~of~PM[2.5]~Emissions~(`in`~tons)))+
        ggtitle(expression(Absolute~Change~of~PM[2.5]~ Emission))+
        scale_x_discrete(breaks=c("06037", "24510"), labels=c("Los Angeles County", "Baltimore City"))+
        scale_fill_discrete(name="Period")
dev.off()

