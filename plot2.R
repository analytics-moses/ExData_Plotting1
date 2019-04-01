# load prerequisite packages
library(grDevices)
library(data.table)
library(datasets)


# input data from the Houshold Power Consumption Data Set with its Header row, accounting for the separator
# character ";" and substituing blank (n/a) fields with "?" character
data_set <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")



# create a Sub-set of Data containing only rows for the Feb. 2007
data_subset <-rbind(data_set[data_set$Date=="1/2/2007",],data_set[data_set$Date=="2/2/2007",])

# transform textual dates into R Date format: dd/mm/yyyy
data_subset$Date <- as.Date(data_subset$Date, format="%d/%m/%Y")

# join two columns Data and Time into a single column: DateTime
DateTime <- paste(as.Date(data_subset$Date), data_subset$Time)

#convert Datetime column into POSIXct portable format
data_subset$Datetime <- as.POSIXct(DateTime)

# initiate a graphics device: PNG file
png("plot2.png", width=480, height=480)

# plot a line Graph for the sub-set of data which was defined previously
plot(data_subset$Global_active_power ~ data_subset$Datetime, type="l", xlab= "Week Day", 
     ylab="Global Active Power (KWh)", col = "dark blue")


# close off graphics device which was inititiated previously
dev.off()
