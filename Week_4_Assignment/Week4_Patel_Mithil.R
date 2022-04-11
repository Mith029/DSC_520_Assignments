# Assignment: ASSIGNMENT 4
# Name: Patel, Mithil
# Date: 2022-04-08

setwd("desktop")
# What are the observational units in this study?
# A) Students attending both section of the class.

# Identify the variables mentioned in the narrative paragraph and determine which are categorical and quantitative?
# A) Score(quantitative), number of students (quantitative), sections of class (categorical)

# Reading CSV file
ds <- read.csv("scores-2.csv")

# Creating subset of the original dataset by different sections in Section column
reg_score <- ds[ds$Section == "Regular",]
spor_score <- ds[ds$Section == "Sports",]
ds$Section = as.factor(ds$Section)

# A count vs score graph of students in Regular section
plot(spor_score$Score, spor_score$Count, ylab = "Number of Students", xlab= "Scores",
     main= "Students performance in Sport Section", pch = 20)
# A score vs count graph of students in Sports section
plot(reg_score$Score, reg_score$Count, ylab = "Number of Students", xlab= "Scores",
     main= "Students performance in Regular Section", xlim = c(200,400), pch = 20)

library (pastecs)
# Descriptive statistics of students in Regular section
stat.desc(reg_score$Score,basic = FALSE, norm = TRUE)
# Stats:- Mean: 327.63, SD: 33.27, Median: 325

# Descriptive statistics of students in Sports section
stat.desc(spor_score$Score, basic = FALSE, norm= TRUE)
# Stats:- Mean: 307.37, SD: 58.03, Median: 315

# Comparing and contrasting the point distributions between the two section, looking at both tendency and consistency: 
# Can you say that one section tended to score more points than the other? Justify and explain your answer.
# A) By visually analyzing both graphs, regular section and sports section, one can conclude that there 
#    exist no general trend in students performance. However, students in regular section appear more
#    consistent compare to their counterparts as their scores are much closer to each others. In addition,
#    by analyzing descriptive statistics using stat.desc() function (shown above), one can conclude that 
#    the students in regular section are on average more likely to score more points than students in sports section.

# Did every student in one section score more points than every student in the other section? 
# If not, explain what a statistical tendency means in this context.
# A) No, every student in one section does not score more points than every student in the other section. 
#    Although previously concluded that students in regular section score more point than students in sports
#    section, the highest score earned were by students in sports section. A statistical tendency simply provides 
#    an insight into students collective performance in each group, in addition to a quantitative summary of the data. 
#    A group with higher mean value (regular section) and lower standard deviation (regular section) would imply  
#    students in that group have consistently earned higher score than group with lower mean value (sports section)
#    and higher standard deviation (sports section).

# What could be one additional variable that was not mentioned in the narrative that could be influencing 
# the point distributions between the two sections?
# A) The number of hours spent studying can significantly influence the score distribution. The common notion is 
#    that the more hour a student spends studying, the more likely they are to score higher. Another variable that 
#    could also influence student score is the number of examples provided by the instructor in each section. Students
#    have different style of learning and different ways to retain information; therefore, having more examples can help
#    students grasp concept better.





