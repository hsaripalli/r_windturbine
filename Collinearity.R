
# Load libraries 

library(readxl)
library(ggplot2)

# Import data from the "Collinearity" tab into a data frame 

coll_data <- read_excel("C:\\hS\\GMMA\\860 Acquistion and Management of Data\\Assignment 1\\GMMA860_Assignment1_Data_vf.xlsx", 
                        sheet = "Collinearity")

#Examine data

head(coll_data)
str(coll_data)
summary(coll_data)

#Filter first 25 observations
filtered_data <-filter(coll_data, coll_data$Obs<26)

#Run regression for Y in terms of experience and height for the first 25 observations

reg1 <- lm(Y ~ Experience + Height, filtered_data)
summary(reg1)


#Run regression for Y in terms of experience and weight for the first 25 observations
reg2 <- lm(Y ~ Experience + Weight, filtered_data)
summary(reg2)

# Run regression for Y in terms of experience, height and weight for the first 25 observations
reg3 <- lm(Y ~ Experience + Height + Weight, filtered_data)
summary(reg3)


#Y in terms of experience and height: entire data set
reg4 <- lm(Y ~ Experience + Height, coll_data)
summary(reg4)


#Y in terms of experience and weight: entire data set
reg5 <- lm(Y ~ Experience + Weight, coll_data)
summary(reg5)


#Y in terms of experience, height and weight: entire data set
reg6 <- lm(Y ~ Experience + Height + Weight, coll_data)
summary(reg6)

plot <- ggplot(filtered_data, aes(x = Experience, y = Y)) + 
  geom_point() + 
  ggtitle("Correlation between Weight and Height")
plot




