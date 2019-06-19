

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

# use function 
orchids %>% 
  filter(year == 2015) %>% 
  orchidsmap("long", "lat", "genus") 


monthlabel <- c(month.abb)

# Make graph of rain
rain_got %>%
  filter(year > 1990) %>% 
  ggplot() +
  geom_density(aes(Rain, fill = month), alpha = 0.6) +
  scale_y_discrete(expand = c(0.01, 0.01))



# Save plot for presentation 
dat <- orchids
p1 <- dat %>% 
  orchidsmap("long", "lat", "genus") +
  transition_states(year, transition_length = 3, state_length = 1) +
  labs(title = "year:{closest_state}")

anim_save("orchids.gif",p1)


flowerp(2015)
