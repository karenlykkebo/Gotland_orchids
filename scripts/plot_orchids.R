

library(tidyverse)
library(ggmap)
library(sf)
library(Hmisc)
library(gganimate)

gotland <- st_read("gotland.shp")
orchids <- fread("./data/orchids_gotland/orchidsgotland.csv")

orchids <- orchids %>% 
  rename("lat" = "decimalLatitude",
         "long" = "decimalLongitude")

# Write small function that maps gotland and adds data with long, lat and observations.
orchidsmap <- function(my_df, x1, y1, z1) {
  
  ggplot(my_df) +
    geom_sf(data = gotland) +
    geom_point(aes_string(x1, y1, col = z1), size = 3, alpha = 0.8) +
    theme_bw() +
    labs(x = "Longitude", y = "Latitude", col = capitalize(z1))
    
}

orchids %>% 
orchidsmap("long", "lat", "genus") +
  transition_states(year, 
                    transition_length = 0.5,
                    state_length = 1)







