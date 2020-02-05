#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

shinyServer(function(input,output){
   
model <- reactive({

    # Extract variables from iris dataset
    
    iris_data <- subset(iris[,c(paste(input$Iris_Part,".Length",sep = ""),
                                paste(input$Iris_Part,".Width",sep = ""))],
                        iris$Species == paste(input$Iris,sep = ""))

    # Select brushed data points
    
    brushed_data <- brushedPoints(iris_data, input$brush1,
                                  xvar = paste(input$Iris_Part,".Length",sep = ""), 
                                  yvar = paste(input$Iris_Part,".Width",sep = ""))

    # Return NULL if less than two points are brushed
    
    if(nrow(brushed_data) < 2){return(NULL)}
        
    # Fit model predicting iris species width from iris species length
    
    lm(brushed_data[,2] ~ brushed_data[,1])
    
    })

output$slopeOut <- renderText({

    # Print value of slope or NULL if insufficient data
        
    if(is.null(model())){"No Model Found"}
        else{model()[[1]][2]}

    })

    # Print value of intercept or NULL if insufficient data
    
output$intOut <- renderText({
        
        if(is.null(model())){"No Model Found"}
            else{model()[[1]][1]}
            
    })
    
output$plot <- renderPlot({
        
    # Extract variables from iris dataset
    
    iris_data <- subset(iris[,c(paste(input$Iris_Part,".Length",sep = ""),
                                paste(input$Iris_Part,".Width",sep = ""))],
                        iris$Species == paste(input$Iris,sep = ""))
    
    # Plot iris species width versus iris species length
    
    plot(iris_data[,1], iris_data[,2],
         xlab = paste(input$Iris_Part," Length", sep = ""),
         ylab = paste(input$Iris_Part, " Width", sep = ""), 
         main = paste("Plot of ", input$Iris, " Width versus ", 
                      input$Iris, " Length", sep = ""),
         col.main = "blue", font.main = 2, cex.main = 1.5, bty = "n", pch = 8,
         xlim = c(min(iris_data[,1]),max(iris_data[,1])), 
         ylim = c(min(iris_data[,2]),max(iris_data[,2])), 
         col = "purple", col.lab = "blue", cex.lab = 1.5, font.lab = 2)
    
    axis(side = 1, font.axis = 2)
    axis(side = 2, font.axis = 2)
    
    # Add prediction line to plot if there is sufficient data
    
    if(!is.null(model()))
        {abline(model(), col = "green", lwd = 2)}
        
    })

})
