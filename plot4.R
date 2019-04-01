# load prerequisite packages
library(grDevices)
library(data.table)
library(datasets)
library(graphics)

# get current Working Directory path and set it to 'curr_path'
curr_path <- getwd()

# set Project's URL to a variable
project_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# name the directory where to store data for our project
data_path <- "exdata_data_household_power_consumption"

# use a variable for the file name of a zip file we are about to download
data_file <- "exdata_data_household_power_consumption.zip" 

# if a compressed file containing the Data Set for this project had NOT been downloaded previously
# THEN download it
if (!file.exists(data_file)) {
        download.file(project_url, data_file, mode = "wb")
        
        # decompress the (downloaded) data_file which contains the Data Set for our project
        unzip(data_file)
} 

# decompress the (downloaded) data_file which contains the Data Set for our project
unzip(data_file)

# Set the Working Directory to the allocated sub-directory for the project's the Data Set  
setwd(file.path(curr_path, data_path))


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
png("plot4.png", width=480, height=480)

# specify 2 plots for eahc of the two rows
par(mfrow=c(2,2))

plot(data_subset$Global_active_power ~ data_subset$Datetime, type="l", xlab= "Week Day", ylab="Global Active Power (KWh)")
plot(data_subset$Voltage ~ data_subset$Datetime, type="l",xlab= "Week Day", ylab="Voltage (V)")

# given the current sub-set of data, plot a line graph for Datatime values representing X axis
# starting with Sub_metering_1 as Y variable...
with(data_subset, {plot(Sub_metering_1 ~ Datetime, type="l", xlab= "Week Day",
                        ylab="Energy Sub-metering")})
# followed by Sub_metering_2 and Sub_metering_3 as Y values
lines(data_subset$Sub_metering_2 ~ data_subset$Datetime, col = 'dark red')
lines(data_subset$Sub_metering_3 ~ data_subset$Datetime, col = 'dark blue')

# make a 'legend' to ensure this graph is going to readable
# proportional to the graph's size
legend("topright", lty=c(1,1), lwd =c(1,1), col=c("black","dark red","dark blue"), 
       bty="o", cex=.5, legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


plot(data_subset$Global_reactive_power ~ data_subset$Datetime, type="l",
     ylab="Global Reactive Power (KWh)",xlab="Week Day")

# close off graphics device which was inititiated previously
dev.off()

# At the end of the script reset the Working Directory to its original setting for the sake of 
# preserving uniformity if in the future iterations of this script are going to be required
setwd('./..')