library(data.table)
library(tidyverse)
library(ggplot2)
library(ggmap)
library(gganimate)
library(sf)
library(ggpubr)

##Listing files from data folder containing temperature data pr month
stationer<-list.files(path="data/temp_gotland/month/dat_latlon")

##Creating tibble with all station data as list form:
tempdata <- # create a data frame holding the file names
          tibble(station = stationer) %>% 
          # read files into tibble from list.files
          mutate(file_contents = map(station,         
           ~ fread(file.path("data/temp_gotland/month/dat_latlon", .),
                   header=T,sep=",")))

#unlist tibble
temp_got<-unnest(tempdata)

#check summarise works and data is working:
temp_got %>% group_by(station) %>% 
  summarise(avg=mean(na.omit(Lufttemperatur)))


#Clean time
library(lubridate)

temp_got<-rename(temp_got,"Time1"="Från Datum Tid (UTC)")

#temp_got1<-temp_got %>% mutate(Time2=if_else(str_detect(Time1,"/"),mdy_hm(Time1),ymd_hm(Time1)))

temp_got1<-temp_got %>% separate(`Representativ månad`,
                                 into=c("year","month"),
                                 sep="-")

#write new file
fwrite(temp_got1,"data/temp_gotland/month/temp_gotland_clean.csv")  