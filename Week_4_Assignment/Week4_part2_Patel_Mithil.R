# Assignment: ASSIGNMENT 4 part 2
# Name: Patel, Mithil
# Date: 2022-04-08

setwd("desktop")

#Importing library to read excel file
library(readxl)

# Reading excel file
df <- read_excel("week-6-housing.xlsx")
View(df)
# Created a table of sale price column from the dataframe
sale_price <- df[,c("Sale Price")]

# Use the apply function on a variable in your dataset
# Calculated mean sale price using apply() function
mean_price <- apply(X= sale_price, MARGIN= 2, FUN = mean, na.rm = TRUE)

# Use the aggregate function on a variable in your dataset
# Calculated mean sale price by 'current_zone' column using aggregate() function
mean_byZone <- aggregate(df$`Sale Price` ~ current_zoning, df, mean)

# Use the plyr function on a variable in your dataset – more specifically, I want 
# to see you split some data, perform a modification to the data, and then bring it back together
library(dplyr)
library(plyr)
# Split data by houses with only 4 bedrooms
data_four_bedrooms <- filter(df, bedrooms == 4)

# Adding a column to the original dataframe which calculates dollar price per square feet
dollar_sq_feet_ <- mutate(df, 
                    dollar_per_sq_feet_ = `Sale Price`/square_feet_total_living)

# Calculating the average sale price by bedrooms and building_grade
avg_bedrooms_grade <- ddply(df, .(bedrooms,building_grade), summarise, mean_bedroom = mean(`Sale Price`))


# Check distributions of the data
# Constructing a histogram using "ggplot2" to check for distribution 
library(ggplot2)
hist_of_sale_price <- ggplot(df, aes(x = `Sale Price`)) + xlab("Sale Price") + ylab("Density") +
  geom_histogram(aes(y = ..count..), bins = 30) +
  ggtitle("Distribution of House Sales Price") +
  geom_density(aes(y=2e+05*..count..),  adjust=5)
# Based on the histogram, the distribution is right skewed, not normal. Consideration the large
# dataset, visual analysis is a viable option than quantitative analysis using stats.desc() function
# to conclude data distribution.

# Identify if there are any outliers
# Constructing a boxplot to detect outliers
ggplot(df, aes(y = `Sale Price`)) + geom_boxplot() + coord_flip()

# Yes, there exist outliers in our data, which may have resulted in skewed distribution.
# To calculate the number of outliers, we can use quantile(), IQR(), and sum() function
left_bound = sum(df$`Sale Price` < quantile(df$`Sale Price`, p= 0.25)-1.5 * IQR(df$`Sale Price`))
right_bound = sum(df$`Sale Price` > quantile(df$`Sale Price`, p= 0.75)+1.5 * IQR(df$`Sale Price`))
print(left_bound + right_bound)

# Total number of outliers: 633 
