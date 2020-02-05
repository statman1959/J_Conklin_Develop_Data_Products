#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that plots and fits iris species width against length
library(shiny)

shinyUI(fluidPage(

    h1(id="main_heading","Predict Iris Width from Iris Length"),
    tags$style(HTML("#main_heading{color: red;}")),

    h2(id="sub_heading","Brush Points to Find Different
       Prediction Models of Iris Width from Iris Length"),
    tags$style(HTML("#sub_heading{color: blue;}")),
    
    #Dropbox to choose iris species
    
    selectInput("Iris", "Choose Iris Species", 
                choices=c("setosa", "versicolor", "virginica")),
    
    #Dropbox to select part of iris to analyze
    
    selectInput("Iris_Part", "Choose Iris Part", 
                choices=c("Petal", "Sepal")),

    # Output plot and results of fitting prediction model
    # from brushed points
    
    sidebarLayout(
        sidebarPanel(
            
            h3("Slope"),
            textOutput("slopeOut"),
            h3("Intercept"),
            textOutput("intOut")
            
        ),
        
        mainPanel(
            plotOutput("plot", brush = brushOpts(id = "brush1"))
            
        )
    )

   ))
