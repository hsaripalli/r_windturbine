library(readxl)
library(dplyr)
library(ggplot2)
library(lubridate)
library(stringr)


# Import sheet Product_Sales

sales <- read_excel("C:\\hS\\GMMA\\860 Acquistion and Management of Data\\Assignment 1\\GMMA860_Assignment1_Data_vf.xlsx", 
                    sheet = "Product_Sales")

head(sales)
str(sales)
summary(sales)


#Remove $ from Price and convert to numeric, check structure of Price column
sales$Price <- as.numeric(str_remove(sales$Price, "\\$"))
str(sales$Price)


#Convert product_id to char of length 3
sales$Product_ID <-str_pad(as.character(sales$Product_ID),3)
str(sales$Product_ID)
nchar(sales$Product_ID)

str(sales)
