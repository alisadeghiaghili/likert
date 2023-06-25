# Load the required packages
library(readxl)
library(dplyr)
library(naniar)
library(FactoMineR)
library(factoextra)
library(ggplot2)

data <- read_excel("//172.16.3.123/ime/ICT-Developers/Vazirian/Sadeghi/Chart/survey_data.xlsx")


dataNumericed <- data[3:ncol(data)] %>% 
  select(-2) %>% 
  mutate(across(everything(), as.factor)) %>% 
  mutate(Q7 = factor(Q7, levels = c("Extremely important", "Moderately important", "Not at all important", "Slightly important", "Very important"))) %>% 
  mutate(across(everything(), as.numeric)) %>% 
  bind_cols(YearBorn = data$YearBorn) %>% 
  mutate(age = as.numeric(format(Sys.Date(), "%Y")) - YearBorn)

vis_miss(dataNumericed)

na_prop <- colMeans(is.na(dataNumericed))
na_threshold <- 0.2
columns_to_remove <- names(na_prop[na_prop > na_threshold])

dataCleaned <- dataNumericed %>% select(-c(one_of(columns_to_remove),YearBorn, Country)) %>% 
  filter(!is.na(`Annual Income`))
  
pca_result <- prcomp(x = dataCleaned, scale. = TRUE)

variance_explained <- (pca_result$sdev^2) / sum(pca_result$sdev^2)


scree_data <- data.frame(
  PC = paste0("PC", 1:length(variance_explained)),
  VarianceExplained = variance_explained
)


scree_plot <- ggplot(scree_data, aes(x = PC, y = VarianceExplained)) +
  geom_point(size = 3, color = "steelblue") +
  geom_path(color = "steelblue") +
  xlab("Principal Component") +
  ylab("Variance Explained") +
  ggtitle("Scree Plot") +
  theme_minimal()

print(scree_plot)
