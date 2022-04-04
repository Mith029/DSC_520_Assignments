# Assignment: ASSIGNMENT 3
# Name: Patel, Mithil
# Date: 2022-04-03

setwd("desktop")

# Reading csv file from computer and calling it "ds" variable
ds <- read.csv("acs-14-1yr-s0201.csv")

# Data elements: Id(chr): Nominal, Id2(int): Nominal, Geography(chr): Nominal, HSDegree(num): Ratio,
#                BachDegree(num): Ratio, RacesReported(int): Ratio, PopGroupID(int): Nominal   

# Struture of the dataset
str(ds)

# displays number of columns in database
ncol(ds)

# displays number of rows in database
nrow(ds)

# importing ggplot2
library(ggplot2)

# Creating a histogram of HSDegree using 20 bins with 0.8 binwidth and a normal curve
ggplot(ds, aes(x = HSDegree)) + ggtitle("Distribution of High School Degree") + 
  geom_histogram(aes(y = ..count..), bins=20, colour='black', binwidth = .8) +
  xlab("Percent of HS Degree") + ylab("Density") +
  geom_density(aes(y=1.8*..count..),  adjust=5) + scale_x_continuous(limits = c(50, 100))

# Based on what you see in this histogram, is the data distribution unimodal?
# A) Based on the generated histogram with 20 bins and 0.8 binwidth, there does exist 
#    one peak at x = 90 in a graph; therefore, the distribution is unimodal. 

# Is it approximately symmetrical?
# A) The distribution is not symmetrical. 

# Is it approximately bell-shaped?
# A) Based on curve line, the distribution is not approximately bell-shaped.

# Is it approximately normal?
# A) No, the distribution is rather skewed than normal.  

# If not normal, is the distribution skewed? If so, in which direction?
# A) Yes, the distribution is skewed to the left because the left tail end is longer and
#    pointing toward the negative x-axis side. 

# Explain whether a normal distribution can accurately be used as a model for this data.
# A) The data is not symmetrically distributed nor the curve follows a bell-shaped curve. 
#    In addition, the data is not clustered around the center; therefore, a normal distribution 
#    cannot be used to accurately represent as a model. 

# Importing "ggplot2" and "qqplotr" library
library(ggplot2)
library(qqplotr)

# Creating a dataframe of the "HSDegree" column
dat <- data.frame(x = ds$HSDegree)

# Generating a Q-Q plot of "HSDegree"
ggplot(dat, aes(sample = x)) + geom_qq() + geom_qq_line()

# Based on what you see in this probability plot, is the distribution approximately normal? Explain how you know.
# A) Based on probability plot generated using Q-Q plot, it is safe to conclude the distribution 
#    is not normal because most of the data points deviate from the line rather than overlapping. 
#    For normal distribution, the graph should follow a straight line -- it does not follow in our case.

# If not normal, is the distribution skewed? If so, in which direction? Explain how you know.
# A) The distribution is slighted negatively (left) skewed because large portion of data points are in
##   upper half of the graph (above the qq line). Additionally, the data takes a shape of a concave down
##   instead of a straight line. 

# Now that you have looked at this data visually for normality, you will now quantify normality with 
# numbers using the stat.desc() function. Include a screen capture of the results produced.
library (pastecs)
stat.desc(ds$HSDegree,basic = FALSE, norm = TRUE)

# In several sentences provide an explanation of the result produced for skew, kurtosis, and z-scores. 
# In addition, explain how a change in the sample size may change your explanation?
# A) Analyzing the HS Degree column data using stat. desc function can help describe the characteristic 
#    of a distribution. A negative skewness value (-1.678) and a positive kurtosis value (4.353) indicate 
#    that the distribution is skewed to the left with higher peaks and pointy tails compared to the normal 
#    distribution. If the value of skew.2SE(-4.030) or kurt.2SE(5.274) is greater than 1 then the value is 
#    statistically significant, which suggests that the data is not normal. This also implies that z is 
#    also significant. With larger sample size, the level of significant is at 0.01 > p, or z => 2.58. 
#    In addition, it is important to look at the values of the skewness and kurtosis as well as the shape 
#    of the distribution to evaluate the normality of the distribution.