library(readxl)
library(dplyr)
library(ggplot2)
library(lubridate)
library(stringr)


# Import sheet Product_Sales

coll_data <- read_excel("C:\\hS\\GMMA\\860 Acquistion and Management of Data\\Assignment 1\\GMMA860_Assignment1_Data_vf.xlsx", 
                    sheet = "Collinearity")

head(coll_data)
str(coll_data)
summary(coll_data)

filtered_data <-filter(coll_data, coll_data$Obs<26)
filtered_data

?lm


#Y in terms of exp and height: 1st 25 observations

reg1 <- lm(Y ~ Experience + Height, filtered_data)
summary(reg1)
plot(reg1)

#Y in terms of exp and height: entire data set
reg2 <- lm(Y ~ Experience + Height, coll_data)
summary(reg2)
plot(reg2)

#Y in terms of exp and weight: 1st 25 observations
reg3 <- lm(Y ~ Experience + Weight, filtered_data)
reg3

#Y in terms of exp and weight: entire data set
reg4 <- lm(Y ~ Experience + Weight, coll_data)
reg4


#Y in terms of exp, height and weight: first 25 observations

reg5 <- lm(Y ~ Experience + Height + Weight, filtered_data)
reg5


#Y in terms of exp, height and weight: entire data set
reg6 <- lm(Y ~ Experience + Height + Weight, coll_data)
reg6