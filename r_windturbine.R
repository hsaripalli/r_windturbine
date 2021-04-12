library(readxl)
library(dplyr)
library(ggplot2)
library(lubridate)


# Import sheet1

data1 <- read_excel("C:\\hS\\GMMA\\860 Acquistion and Management of Data\\Assignment 1\\GMMA860_Assignment1_Data_vf.xlsx", 
                    sheet = "Windfarm Turbine Locations")

#Import sheet2 

data2 <- read_excel("C:\\hS\\GMMA\\860 Acquistion and Management of Data\\Assignment 1\\GMMA860_Assignment1_Data_vf.xlsx", 
                    sheet = "Turbine Specifications")

#import sheet3, skip first 16 rows

data3 <- read_excel("C:\\hS\\GMMA\\860 Acquistion and Management of Data\\Assignment 1\\GMMA860_Assignment1_Data_vf.xlsx", 
                    sheet = "Island Airport Weather",
                    skip = 16)

turbine_swept_area <- 13273.23
turbine_nominal_power <- 4000000
max_power_coef <- 0.35


#summary of data3 data frame
head(data3)
summary(data3)
str(data3)

#adding a column fAir density to the df

data3$"fAir density (kg/m3)" = data3$"Stn Press (kPa)"*1000/(287.05*(data3$"Temp (°C)" + 273.15))  

#print first 5 rows of the df and new column fAir density
head(data3, n = 5)
head(data3$"fAir density (kg/m3)", n = 5)


#add a new variable for wind speed in m/s and print first 5 records
data3$"Wind Spd (m/s)" = data3$"Wind Spd (km/h)"*0.277778
head(data3, n = 5)
head(data3$"Wind Spd (m/s)", n = 5)

summary(data3$"Wind Spd (m/s)")


data3 
filter1 <- filter(data3, data3$"Wind Spd (m/s)" >= 4,  data3$"Wind Spd (m/s)" <= 16 ) 
summary(filter1$"Wind Spd (m/s)")

filter1$"power(watts)" <- filter1$"fAir density (kg/m3)"*turbine_swept_area*0.5*(filter1$"Wind Spd (m/s)")^3*max_power_coef


filter1$"power_actual (watts)" <- ifelse(filter1$"power(watts)" > turbine_nominal_power, turbine_nominal_power, filter1$"power(watts)")
head(filter1, n = 5)
head(filter1$"power_actual (watts)", n = 5)


filter1$"power_actual (MW)" <- filter1$"power_actual (watts)"/1000000
jan_mw <- sum(filter1$"power_actual (MW)")
jan_mw



str(filter1$Day)
theme_set(theme_bw())  # pre-set the bw theme.
plot <- ggplot(filter1, aes(x = as.factor(filter1$Day), y = filter1$"power_actual (MW)")) + 
  geom_bar(stat = 'identity') + 
  labs(title = "Power (MW) produced per day", x = "Day", y = "Power (MW)") + 
  scale_y_continuous(breaks = seq(0,100,5))
plot

