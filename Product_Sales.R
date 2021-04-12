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


sales$Price_num <- as.numeric(str_remove(sales$Price, "\\$"))

str(sales$Price_num)

