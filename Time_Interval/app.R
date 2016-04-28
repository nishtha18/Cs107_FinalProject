#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/

library(dplyr)
library(ggplot2)
library(readr)

goals <- read.csv("C:/Users/nisht/2016_HW/Cs107_FinalProject/Goals")
goals <- goals %>% select(-X)
goals <- goals %>% 
  mutate(time = as.numeric(as.character(time))) %>% 
  filter(!is.na(time)) %>%
  filter(time <= 90)

goals %>% View

library(shiny)

# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(
   
   # Application title
   titlePanel("Goal distribution at different time interval"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("bins",
                     "Number of bins:",
                     min = 1,
                     max = 90,
                     value = 45)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
))

# Define server logic required to draw a histogram
server <- shinyServer(function(input, output) {
   
   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
      x    <- goals[, 3] 
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      # draw the histogram with the specified number of bins
      hist(x, breaks = bins, col = 'darkgray', border = 'white')
   })
})

# Run the application 
shinyApp(ui = ui, server = server)

