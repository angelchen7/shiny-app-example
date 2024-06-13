# Navigation bar ----
ui <- navbarPage(
  
  title = "Palmer Penguins Data Explorer",
  
  # Page 1 - About this app
  tabPanel(title = "About this app",
           
           # adding fluid row with about text ----
           fluidRow(
             column(1),
             column(10, includeMarkdown("text/about.md")),
             column(1)
           ), # END of fluid row with about this app
           
           fluidRow(
             column(2),
             column(8, leafletOutput(outputId = "palmer_station_map")),
             column(2)
           )
           
           ), # END of page 1 - About this app
  
  # Page 2 - Data exploration
  tabPanel(title = "Explore the Data",
           
           fluidPage(
             
             # Penguin plot sidebar layout ----
             sidebarLayout(
               
               sidebarPanel(
                 
                 # island pickerInput ----
                 pickerInput(inputId = "penguin_island_input", 
                             label = "Select an island(s):",
                             choices = c("Torgersen", "Dream", "Biscoe"),
                             selected = c("Torgersen", "Dream", "Biscoe"),
                             options = pickerOptions(actionsBox = TRUE),
                             multiple = TRUE), # END island pickerInput
                 
                 # bin number sliderInput ----
                 sliderInput(inputId = "bin_num_input", label = "Select number of bins:",
                             value = 25, max = 100, min = 1), # END bin number sliderInput
               ),
               
               mainPanel(
                 plotOutput(outputId = "flipperLength_histogram_output")
               )
               
             ), # END of penguin plot sidebar layout
             
             # Penguin table sidebar layout
             sidebarLayout(
               sidebarPanel(
                 # year checkbox input ----
                 checkboxGroupInput(inputId = "year_select", 
                                    label = "Select year(s)" ,
                                    choices = c(2007, 2008, 2009),
                                    selected = c(2007, 2008)), # END checkbox input
               ),
               
               mainPanel(
                 DT::dataTableOutput(outputId = "interactive_table_output") 
               )
             )
             
           ) # END of fluidPage
           
           ) # END of tabPanel
  
) # END of Navbar