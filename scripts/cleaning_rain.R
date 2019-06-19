
library(tidyverse)
library(lubridate)
library(data.table)

# Load in all files as a list
rain_stationer <- list.files(path="data/rain_gotland")

raindata <- tibble(station = rain_stationer) %>% # create a data frame  holding the file names
  mutate(file_contents = map(station,          # read files into
                             ~ fread(file.path("data/rain_gotland", .), header=T, sep=","))) # a new data column

rain_got <- unnest(raindata) # un-list the data

# see average rain amount
rain_got %>% 
  group_by(station) %>% 
  summarise(avg = mean(na.omit(Nederbördsmängd)))



# Rename and seperate columns in proper dates
rain_got <- rain_got %>%  
  rename("Time1" = "Representativ månad",
         "Rain" = "Nederbördsmängd") %>% 
  separate(Time1, 
           into = c("year", "month"),
           sep = "-")

write.csv(rain_got, file = "./data/rain_gotland.csv")
