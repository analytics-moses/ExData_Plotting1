# load prerequisite packages
library(grDevices)
library(data.table)
library(datasets)


# get current Working Directory path and set it to 'curr_path'
curr_path <- getwd()

# name the directory where to store data for our project
data_path <- "exdata_data_household_power_consumption"

# Set the Working Directory to the allocated sub-directory for the project's the Data Set  
setwd(file.path(curr_path, data_path))


# input data from the Houshold Power Consumption Data Set with its Header row, accounting for the separator
# character ";" and substituing blank (n/a) fields with "?" character
data_set <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")

# create a Sub-set of Data containing only rows for the Feb. 2007
data_subset <-rbind(data_set[data_set$Date=="1/2/2007",],data_set[data_set$Date=="2/2/2007",])

# transform textual dates into R Date format: dd/mm/yyyy
data_subset$Date <- as.Date(data_subset$Date, format="%d/%m/%Y")

# initiate a graphics device: PNG file
png("plot1.png", width=480, height=480)

# plot a Histogram given the generated sub-set of data and specifying x & y Axes, labels and etc.
hist(data_subset$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (KWh)", ylab="Frequency", col="deeppink2")


# close off graphics device which was inititiated previously
dev.off()