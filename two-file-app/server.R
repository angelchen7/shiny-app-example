# Defining server instructions ----

server <- function(input, output){
  
  # render leaflet map with palmer station location ----
  output$palmer_station_map <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(providers$OpenStreetMap) %>% 
      addMarkers(lng = -64.05384063012775,
                 lat = -64.77413239299318,
                 popup = "Palmer Station")
  }) # END palmer station map
  
  # filter for island ----
  island_df <- reactive({
    
    penguins %>%  
      filter(island %in% input$penguin_island_input)
    
  })
  
  # render the flipper length histogram ----
  output$flipperLength_histogram_output <- renderPlot({
    
    ggplot(na.omit(island_df()), aes(x = flipper_length_mm, fill = species)) +
      geom_histogram(alpha = 0.6, position = "identity", bins = input$bin_num_input) +
      scale_fill_manual(values = c("Adelie" = "#FEA346", "Chinstrap" = "#B251F1", "Gentoo" = "#4BA4A4")) +
      labs(x = "Flipper length (mm)", y = "Frequency",
           fill = "Penguin species") +
      theme_light() +
      theme(axis.text = element_text(color = "black", size = 12),
            axis.title = element_text(size = 14, face = "bold"),
            legend.title = element_text(size = 14, face = "bold"),
            legend.text = element_text(size = 13),
            legend.position = "bottom",
            panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.7))
    
  })
  
  # Render penguin complete data table ----
  penguins_years <- reactive({
    penguins %>% 
      filter(year %in% c(input$year_select))
  })
  
  output$interactive_table_output <- DT::renderDataTable(
    
    DT::datatable(penguins_years(),
                  options = list(pagelength = 10),
                  rownames = FALSE)
  )
}