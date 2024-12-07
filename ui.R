#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define UI
shinyUI(fluidPage(
  titlePanel("Car Fuel Efficiency Predictor"),
  
  sidebarLayout(
    sidebarPanel(
      h4("Input Car Specifications"),
      sliderInput("wt", "Weight (1000 lbs):", 
                  min = 1, max = 6, value = 3, step = 0.1),
      sliderInput("hp", "Horsepower:", 
                  min = 50, max = 400, value = 150, step = 10),
      selectInput("am", "Transmission:", 
                  choices = list("Automatic" = 0, "Manual" = 1), selected = 0),
      actionButton("predict", "Predict MPG")
    ),
    
    mainPanel(
      h4("Predicted Fuel Efficiency"),
      verbatimTextOutput("prediction"),
      plotOutput("mpgPlot")
    )
  )
))