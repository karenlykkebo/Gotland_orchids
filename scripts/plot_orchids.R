

library(tidyverse)
library(ggmap)
library(sf)
library(Hmisc)

gotland <- st_read("gotland.shp")
orchids <- fread("./data/orchids_gotland/orchidsgotland.csv")

# Write small function that maps gotland and adds data with long, lat and observations.
orchidsmap <- function(my_df, x1, y1, z1) {
  
  ggplot(my_df) +
    geom_sf(data = gotland) +
    geom_point(aes_string(x1, y1, col = z1)) +
    theme_bw() +
    labs(x = "Longitude", y = "Latitude", col = capitalize(z1)) 
}


orchids %>% 
  filter(year == 2015) %>% 
  orchidsmap("decimalLongitude", "decimalLatitude", "species")





