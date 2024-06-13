# load packages ----
library(shiny)

# user interface ----
ui <- fluidPage(
  
  # app title ----
  h1("My App Title"),
  
  # app subtitle ----
  h4(strong("Exploring Antartic Penguin Data")),
  
  # body mass slider input ----
  sliderInput(inputId = "body_mass_input",
              label = "Select a range of body mass(g)",
              min = 2700,
              max = 6300,
              value = c(3000, 4000)),
  
  # body mass plot output ----
  plotOutput(outputId = "bodyMass_scatterplot_output")
)

# server instructions ----
server <- function(input, output){
  
  # filter body masses
  body_mass_df <- reactive({
    penguins %>%
      filter(body_mass_g %in% c(input$body_mass_input[1]:input$body_mass_input[2]))
  })
  
  # render penguin scatterplot ----
  output$bodyMass_scatterplot_output <- renderPlot(ggplot(
    na.omit(body_mass_df()),
    aes(
      x = flipper_length_mm,
      y = bill_length_mm,
      color = species,
      shape = species
    )
  ) +
    geom_point() +
    scale_color_manual(values = c(
      "Adelie" = "darkorange",
      "Chinstrap" = "purple",
      "Gentoo" = "cyan4"
    )) +
    scale_shape_manual(values = c(
      "Adelie" = 19,
      "Chinstrap" = 17,
      "Gentoo" = 15
    )) +
    labs(
      x = "Flipper length (mm)",
      y = "Bill length (mm)",
      color = "Penguin species",
      shape = "Penguin species"
    ) +
    theme_minimal() +
    theme(
      legend.position = c(0.85, 0.2),
      legend.background = element_rect(color = "white")
    ))
  
}

# combine UI & server into an app ----
shinyApp(ui = ui, server = server)
