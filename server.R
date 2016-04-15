library(shiny)
# Define server logic for variable selection
pohjd <- read.csv("pohjd.csv")
pohjd$AgeGrp <- as.factor(pohjd$AgeGrp)
library(reshape2)
ohc <- melt(pohjd)
shinyServer(
  function(input, output) {
    output$ovarName <- renderPrint({input$varName})
    # Reactive expression to generate the requested variable.
    # This is called whenever the inputs change. The output
    # functions defined below then all use the value computed from
    # this expression
    data <- reactive({
      dist <- switch(input$varName,
                     "no. of decayed teeth" = pohjd$Decayed,
                     "no. of missing teeth" = pohjd$Missing,
                     "no. of filled teeth" = pohjd$Filled,
                     "total dmft" = pohjd$DMFT)
  })
    # Generate a plot of the data. Also uses the inputs to build
    # the plot label. Note that the dependencies on both the inputs
    # and the data reactive expression are both tracked, and
    # all expressions are called in the sequence implied by the
    # dependency graph
    output$plot <- renderPlot({
    barplot(height = data(), names.arg = c("1-5", "6-10", "11-15", "16-20", "21-25", "26-30"), xlab = "Age Group", ylab = "Count", main = input$varName, col = rainbow(20), cex.axis = 1, cex.names = 1) 
    # Generate a summary of the data
  })  
    output$summary <- renderPrint({
      summary(data())
  }) 
    # Generate an HTML table view of the data
    output$table <- renderTable({
    VarSel <- input$varName
    data.frame(AgeGrp = pohjd$AgeGrp, VariableSelected = data())
  })
  }) 

