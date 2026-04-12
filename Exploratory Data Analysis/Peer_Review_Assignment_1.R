library(here)
library(tidyverse)

file <- file.path(here(), "Data/Exploratory_Data","household_power_consumption.txt")

power <- read.table(file, sep = ";", header = TRUE)

power_subset <- power %>%
  mutate(Date = dmy(Date), Time = hms(Time)) %>%
  mutate(month = month(Date), #I used mutate function twice rather than just making the same function longer
         day = day(Date),
         year = year(Date),
         Time = minute(Time)) %>%
  filter(year == 2007 & month == 2 & day < 3) 





#PNG1

#I am using base R instead of DPLYR just to show that I know how to use both even though dplyr is probably easier to read.
power_subset$Global_active_power <- as.numeric(power_subset$Global_active_power)

png(file = file.path(here(),"Exploratory Data Analysis","plot1.png" ),   
    width = 480, # 480 pixels
    height = 480) # 480 pixels

 hist(x = power_subset$Global_active_power, 
      xlab = "Global Active Power (Kilowatts)", 
      col = "red",
      main = "Global Active Power")
 
 dev.off()
 
 
 
 
 #PNG2
 
 
 png(file = file.path(here(),"Exploratory Data Analysis","plot2.png" ),   
     width = 480, # 480 pixels
     height = 480) # 480 pixels
 
 power_3 <- power_subset %>%
   mutate(day_of_week = wday(Date, label = TRUE)) %>%
   mutate(Time = c(1:length(power_subset$Time)))
 
 with(power_3, plot(Time, Global_active_power, type = "l", xaxt = "n", ylab = "Global Active Power (Kilowatts)"))
 axis(side = 1, at = c(0,1440,2880), labels = c("Thur","Fri","Sat"))
 
 dev.off()
 
 
 #PNG3

 png(file = file.path(here(),"Exploratory Data Analysis","plot3.png" ),   
     width = 480, # 480 pixels
     height = 480) # 480 pixels
 
 with(power_3, plot(Time, Sub_metering_1, type = "l", xaxt = "n", xlab = "Energy Sub metering"))
 points(power_3$Time, power_3$Sub_metering_2, col = "red", type = "l")
 points(power_3$Time, power_3$Sub_metering_3, col = "blue", type = "l")
 legend("topright", legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
        col = c("black","red","blue"), lty = 1)
 
 dev.off()
 
 
 #PNG4
 
 png(file = file.path(here(),"Exploratory Data Analysis","plot4.png" ),   
     width = 480, # 480 pixels
     height = 480) # 480 pixels
 
 par(mfrow = c(2,2))
 
 with(power_3, plot(Time, Global_active_power, type = "l", xaxt = "n", xlab = "Global Active Power (Kilowatts)"))
 axis(side = 1, at = c(0,1440,2880), labels = c("Thur","Fri","Sat"))
 
 with(power_3, plot(Time, Voltage, type = "l", xaxt = "n", xlab = "datetime"))
 axis(side = 1, at = c(0,1440,2880), labels = c("Thur","Fri","Sat"))
 
 with(power_3, plot(Time, Sub_metering_1, type = "l", xaxt = "n", xlab = "Energy Sub metering"))
 points(power_3$Time, power_3$Sub_metering_2, col = "red", type = "l")
 points(power_3$Time, power_3$Sub_metering_3, col = "blue", type = "l")
 legend("topright", legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
        col = c("black","red","blue"), lty = 1)
 
 with(power_3, plot(Time, Global_reactive_power, type = "l", xaxt = "n", xlab = "datetime"))
 axis(side = 1, at = c(0,1440,2880), labels = c("Thur","Fri","Sat"))
 
 dev.off()
 
 
 
 
