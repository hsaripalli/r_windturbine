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

#tidy data
str(sales)
tidy_sales <- gather(sales, year, sales_by_year, Sales_2016, Sales_2017)
tidy_sales$year <- as.numeric(str_remove(tidy_sales$year, "Sales_"))
str(tidy_sales$year)


theme_set(theme_bw())  # pre-set the bw theme.


plot1 <- ggplot(tidy_sales, aes(Price)) + 
  geom_histogram(binwidth = 5, color = "black", fill = "cornflowerblue") + 
  labs(title = "Price Distribution", x = "Price, $",  y = "Observations") + 
  scale_x_continuous(breaks = seq(0,80,5))
plot1

plot2 <- ggplot(tidy_sales, aes(x =Price, y = sales_by_year, color = factor(year))) + 
  geom_point() + 
  labs(title = "Total sales versus Price", x = "Price, $",  y = "Total Sales, $", color = "Year")
plot2

plot3 <- ggplot(tidy_sales, aes(x = Num_Retailers, y =Price )) + 
  geom_point() + 
  labs(title = "Price versus number of retailers", x = "No. of retailers", y = "Price, $")
plot3

cor <- cor(tidy_sales$Price, tidy_sales$Num_Retailers)
cor
