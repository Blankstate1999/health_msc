library(tidyverse)

# Import data
imd_2019 <- read_csv("imd_2019.csv")

# Rename columns
tidy_imd <- imd_2019 %>%
  rename(lsoa_code = "LSOA code (2011)",
         lsoa_name = "LSOA name (2011)",
         dist_code = "Local Authority District code (2019)",
         dist_name = "Local Authority District name (2019)",
         imd_rank = "Index of Multiple Deprivation (IMD) Rank",
         imd_dec = "Index of Multiple Deprivation (IMD) Decile")
  
# Rename value labels
tidy_imd[tidy_imd == "Bath and North East Somerset"] <- "BANES"

# Convert to data frame
imd_df <- as.data.frame(tidy_imd)

# Extra local data
imd_local <- subset(imd_df, 
                    dist_name == "Cheltenham" | dist_name == "Swindon" | 
                      dist_name == "Gloucester" | dist_name == "BANES")

# Order data by IMD rank
rank_order <- imd_local[order(imd_local$imd_rank, decreasing = FALSE),]

# Slice highest 50 district
top_50 <- rank_order %>% slice(1:50)

# Remove unwanted columns
top_50 <- subset(top_50, select = -lsoa_name)
top_50 <- subset(top_50, select = -dist_code)


