# Assignment: ASSIGNMENT 5 
# Name: Patel, Mithil
# Date: 2022-04-17

#importing libraries
library(readxl)
library(dplyr)
library(purrr)

df <- read_excel("week-6-housing.xlsx")
# dplyr function -> column: select(), mutate()
#                   row: filter(), distinct(), arrange()
#                   group: group_by(), summarise(), count()

# Transformed the original dataframe by deplaying few column, adding new living room per 
# bedroom and bathroom space, and filtering year_bulit by greater than 2010.
new_df <- df %>% 
  select(`Sale Date`,`Sale Price`,building_grade:year_built,lon, lat, sq_ft_lot) %>% 
  mutate(bedroom_bathroom_size = square_feet_total_living/(bedrooms + bath_full_count)) %>% 
  select(`Sale Date`,`Sale Price`, building_grade, bedroom_bathroom_size, everything()) %>%
  filter(year_built >= 2010) %>% arrange(desc(year_built))

#Geological coordinates of each houses
coordinate <- new_df %>% select(lon,lat)

# subset of original dataset containing only houses built in 2009
house_2009 <- df %>% 
  select(`Sale Date`,`Sale Price`,building_grade:year_built,lon, lat, sq_ft_lot) %>% 
  mutate(bedroom_bathroom_size = square_feet_total_living/(bedrooms + bath_full_count)) %>% 
  select(`Sale Date`,`Sale Price`, building_grade, bedroom_bathroom_size, everything()) %>%
  filter(year_built >= 2010) %>% arrange(desc(year_built))

# Updated dataframe by replacing inf values with na to avoid getting error when computing mean
df_na_removed <- new_df %>% 
  mutate_if(is.numeric, list(~na_if(., Inf)))

# group data by building grade to find mean room(bedroom or bathroom) size
# By analyzing the data, the average room size tend to increase with building grade
df_na_removed %>%
  group_by(building_grade) %>% summarise(mean(bedroom_bathroom_size, na.rm = TRUE))

# function for outlier 
outlier_fun <- function(x){ x > quantile(df$`Sale Price`, p= 0.75)+1.5 * IQR(df$`Sale Price`) || 
    x < quantile(df$`Sale Price`, p= 0.25)-1.5 * IQR(df$`Sale Price`)}

# Using map function to detect outliers
df_without_outlier <- df_na_removed %>%
  mutate( is_a_outlier = map(.x= new_df$`Sale Price`, .f = outlier_fun))

# Discarding Null values from 'bedroom_bathroom_size' column using discard()
discard(df_without_outlier$bedroom_bathroom_size,is.na)

# Using () adding 'lon' and 'lat' column to the dataframe 
cbind(df_without_outlier, coordinate)

# Using rbind() adding houses built in 2009 to the dataframe with the outlier indicator column
rbind(df_without_outlier[-c(14)], house_2009)

# Splitting a string by space
split_by_address = str_split(df$addr_full, " ")

# Since the column was split by list of elemnts, we can concatenate using sapply()
# Note: it will return a single string how we initially had 
sapply(split_by_address, paste, collapse= " ")

# Another way of joining the previously split string back together
# Note that this will return a vector, not a single string
View(paste(split_by_address, sep= "",collapse = NULL))

# Splitting a single string and then join back together
sin_str <- "This is a single string that we will split"
split_the_string <- strsplit(sin_str," ")[[1]]
paste(split_the_string, collapse = " ")
