###############################################################################
## Project: EDA - Individual Household electric power consumption
## Analyst: Larry
## Date: October 10, 2020
## Goal: Examine how household energy usage varies over a 2-day period in 
## February, 2007. Plots will be used for exploratory data analysis.
## Plot Number: 3
###############################################################################

## load libraries
library(data.table)
library(dplyr)

## Get System and Package Information:
sessionInfo()	 ## list the version of R and the versions of the packages used
## R version 4.0.2 (2020-06-22), Platform: x86_64-w64-mingw32/x64 (64-bit)
## Running under: Windows 10 x64 (build 19041)
## Packages: data.table 1.13.0 is used to read the input file
##   dplyr_1.0.2 is used for datat manipulation and transformation 

## setup the working directory
getwd()
setwd("C:/Users/Larry/Documents/Coursera/Johns_Hopkins/Project_EDA")


## download files from internet to working directory and unzip the files
myUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
workDir <- getwd()
fileDest <- paste(workDir, "exdata_data_household_power_consumption.zip", sep ="/")  ## create destination
## download and unzip files only if it hasn't been already been downloaded 
if(!file.exists(fileDest)) {
  download.file(url = myUrl, destfile = fileDest)
  dateDownloaded <- date()  ## get the date and time for the data download
  unzip(fileDest)  
}
fileNM <- paste(workDir, "household_power_consumption.txt", sep ="/")  ## create destination
## Data was downloaded on: Fri Oct 09 18:19:56 2020


## Rough estimate of how much memory the dataset will require in memory
## 1MB = 2^20 bytes
est_bytes_per_numeric <- 8  ## assume 8 bytes also for characters & dates
num_rows <- 2075259 
num_cols <- 9

est_bytes_needed_MB <- (num_rows * num_cols * est_bytes_per_numeric) / (2^20) / 1000
print(paste("Estimated MBs Needed = ", round(est_bytes_needed_MB, 1)))

## Read the file into the power data frame and look at its structure
power <- fread(file=fileNM, sep = ";", header = TRUE)
str(power)


## DATA SCRUBBING AND TRANSFORMATION:

## convert to tibble for easier use by dplyr to manipulate
tpower <- as_tibble(power)  
## rm(power)  ## free some memory

## Filter for 2-day period in Feb-2007 (2007-02-01 and 2007-02-02).  
## Code book says Date: Date is in format dd/mm/yyyy. 
## Convert Date and Time variables as date and POSIXlt formats respectively.
## Convert the other 7 variables to numeric format
## the ?s used for missing values are converted to NAs by coercion
tpower2 <- tpower %>% 
           filter(Date %in% c("1/2/2007", "2/2/2007")) %>%
           mutate(dtTime = paste(Date, Time),
                  Global_active_power = as.numeric(Global_active_power),
                  Global_reactive_power = as.numeric(Global_reactive_power),
                  Voltage = as.numeric(Voltage),
                  Global_intensity  = as.numeric(Global_intensity),
                  Sub_metering_1 = as.numeric(Sub_metering_1),
                  Sub_metering_2 = as.numeric(Sub_metering_2),
                  Sub_metering_3 = as.numeric(Sub_metering_3))
## convert dtTime to date format                  
tpower2$dtTime <- as.POSIXct(strptime(x = tpower2$dtTime, format = "%d/%m/%Y %H:%M:%S"))

           
rm(tpower)  ## free some memory  
str(tpower2)  ## basic structure


## Plot 3: Energy sub-metering (in watt-hour of active energy) vs. Datetime 
## ------------------------------------------------------------------------

png(filename = "C:/Users/Larry/Documents/Coursera/ExData_Plotting1/plot3.png", 
                width = 480, height = 480)

  plot(tpower2$dtTime, tpower2$Sub_metering_1, type = "l",
       xlab = "", ylab = "Energy sub metering")
  lines(tpower2$dtTime, tpower2$Sub_metering_2, col = "red")  # add series #2
  lines(tpower2$dtTime, tpower2$Sub_metering_3, col = "blue")  # add series #3
  par(oma = c(0,0,1,0))  ## default outer margin is no margin i.e. (0,0,0,0)
  title(main = "Plot 3", outer = TRUE, adj = 0)  #add left aligned title
  box()  ## draw box around plot
  legend("topright", col = c("black", "red", "blue"),
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         lty = 1, bty = "n", cex = 0.85)
dev.off()  ## close
