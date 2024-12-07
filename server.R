#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define server logic
shinyServer(function(input, output) {
  # Reactive prediction logic
  predicted_mpg <- reactive({
    input$predict
    isolate({
      model <- lm(mpg ~ wt + hp + am, data = mtcars)
      newdata <- data.frame(wt = input$wt, hp = input$hp, am = as.numeric(input$am))
      predict(model, newdata = newdata)
    })
  })
  
  # Output predicted MPG
  output$prediction <- renderText({
    req(predicted_mpg())
    paste("Predicted MPG:", round(predicted_mpg(), 2))
  })
  
  # Output plot
  output$mpgPlot <- renderPlot({
    req(predicted_mpg())
    plot(mtcars$wt, mtcars$mpg, 
         xlab = "Weight (1000 lbs)", ylab = "MPG",
         main = "Fuel Efficiency Prediction",
         pch = 19, col = "blue")
    points(input$wt, predicted_mpg(), col = "red", pch = 19, cex = 2)
    legend("topright", legend = c("Actual Data", "Your Car"), col = c("blue", "red"), pch = 19)
  })
})