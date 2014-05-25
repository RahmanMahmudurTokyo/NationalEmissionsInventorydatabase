
# first, read relatd RDS files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# check whether input files are uploaded properly
head(NEI,2)
head(SCC,2)

# extract related data for Baltimore City emissions
BaltimoreCityEmission = subset(NEI, fips==24510)


# download reshape2 and related packages
install.packages(c("reshape2", "plyr","stringr"), type = "source") 
library(reshape2)


# melt the data frame using melt()
BaltimoreCityEmissionMelt = melt(BaltimoreCityEmission, id.vars=c("year", "type"), measure.vars=c("Emissions"))

# summarize by related variables using dcast
BaltimoreCityEmissionSummary = dcast(BaltimoreCityEmissionMelt, type+year ~ variable, fun.aggregate=sum)

# plotting ggplot graph
install.packages("ggplot2")
library(ggplot2)

png(filename="plot3.png", width=480, height=480, units="px")
p = ggplot(BaltimoreCityEmissionSummary, aes(x=year, y=Emissions, group=type))

p + geom_line(aes(color=type)) +     
        geom_point() +
        xlab("Year") +
        ylab(expression(Total~PM[2.5]~Emissions~(`in`~tons))) +
        ggtitle(expression(Total~PM[2.5]~Emission~`in`~Baltimore~City)) +
        scale_colour_discrete(name="Type", breaks=c("NON-ROAD", "NONPOINT", "ON-ROAD", "POINT"), labels=c("Non-road", "Non-point", "On-road", "Point"))

dev.off()



