library(shiny)
library(ggplot2)
library(gganimate)
library(tidyverse)
library(data.table)

shinyApp(
  ui=fluidPage(
    selectInput(inputId = "selectVariable", label = "Select the orchid",
                choices = c("family","genus","species")),
    imageOutput("output_plot")
    ),
  
  server = function(input, output) {
    fn_plot <- reactive({ 
      orchids <-as_tibble(fread("data/orchids_gotland/orchidsgotland.csv"))
      outfile <- tempfile(fileext='.gif')
      p1 <- orchids %>% ggplot(aes(decimalLongitude, decimalLatitude)) +
        geom_point(aes(col = input$selectVariable), alpha = 0.4)
      anim <- p1 + 
        transition_states(year,
                          transition_length = 2,
                          state_length = 1)
      
      # save
      anim_save("outfile.gif", animate(anim)) 
      # return a list
      list(src = "outfile.gif",
           contentType = 'image/gif'
         
      )})
    #})
    output$output_plot <- renderImage(fn_plot())
     
  })