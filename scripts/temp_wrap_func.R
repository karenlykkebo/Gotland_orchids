#' Description for temperature mapwrapper for Gotland
#' 
#' Part of the package oRchid on github karenlykkebo/oRchid
#' 
#' @param my_df your dataframe - shp file included in the package with temperature data and gotland shape
#' @param x1 response variable (temperature)
#' @param y1 filtering and facet variable.
#' 
#' @example 
#' gtempWrap(temp_got,"avgyear","year","2000")
#'  
#' 

library(sf)
library(ggplot2)
library(gganimate)
library(ggpubr)
library(roxygen2)


temp_got<-st_read("data/gotland_shp_temp.shp")



gtempWrap<-function(my_df,x1,y1,y2){
  require(ggplot2)
  require(ggpubr)
  
  my_df %>% filter(!!as.name(y1) > y2) %>% 
    ggplot() +
    geom_sf(aes(fill=!!as.name(x1))) +
    scale_fill_continuous(low="yellow",high="red") +
    theme_pubclean() +
    labs(fill = "Temperature")+
    facet_wrap(y1)
  
}



