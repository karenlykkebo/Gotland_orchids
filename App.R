library(shiny)
library(ggplot2)
library(gganimate)
shinyApp(
  ui=fluidPage(
    selectInput(inputId = "selectVariable", label = "Select the orchid",
                choices = c("family","genus","species")),
    imageOutput("output_plot")
  ),
  
  server = function(input, output) {
    fn_plot <- reactive({ 
      #validate(need(input$orchidsgotland.csv), "Please select an option")
      orchids<-as_tibble(fread("data/orchids_gotland/orchidsgotland.csv"))
      p1 <- orchids %>% ggplot(aes(decimalLongitude, decimalLatitude)) +
        geom_point(aes(col = input$selectVariable), alpha = 0.4)
      anim <- p1 + 
        transition_states(year,
                          transition_length = 2,
                          state_length = 1)
    return(anim)
    })
    
    output$output_plot <- renderPlot(fn_plot())
     
  })