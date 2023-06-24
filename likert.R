library(readxl)
library(dplyr)
library(likert)

survey_data <- read_excel("//172.16.3.123/ime/ICT-Developers/Vazirian/Sadeghi/Chart/survey_data.xlsx")
data <- survey_data[, 9:16] %>% 
  mutate(Q1 = factor(Q1, levels = c("Extremely important", "Moderately important", "Not at all important", "Slightly important", "Very important")),
         Q2 = factor(Q2, levels = c("Extremely important", "Moderately important", "Not at all important", "Slightly important", "Very important")),
         Q3 = factor(Q3, levels = c("Extremely important", "Moderately important", "Not at all important", "Slightly important", "Very important")),
         Q4 = factor(Q4, levels = c("Extremely important", "Moderately important", "Not at all important", "Slightly important", "Very important")),
         Q5 = factor(Q5, levels = c("Extremely important", "Moderately important", "Not at all important", "Slightly important", "Very important")),
         Q6 = factor(Q6, levels = c("Extremely important", "Moderately important", "Not at all important", "Slightly important", "Very important")),
         Q7 = factor(Q7, levels = c("Extremely important", "Moderately important", "Not at all important", "Slightly important", "Very important")),
         Q8 = factor(Q8, levels = c("Extremely important", "Moderately important", "Not at all important", "Slightly important", "Very important"))) %>% 
  as.data.frame()

likerted <- likert(data)
plot(likerted, ordered = FALSE)