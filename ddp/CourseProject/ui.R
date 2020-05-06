#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application
shinyUI(fluidPage(

    # Application title
    titlePanel("Adding and Deleting Points"),
    
    fluidRow(
        wellPanel(
            helpText("This app demonstrates how points can be deleted and added incrementally.
                     First select a group of active (solid black) pixels and hit the 'Delete points'
                     button. The selected pixels will be deleted and appear gray and hollow. 
                     Now select one or more deleted pixels and press 'Add points'. The point 
                     will be added again. The reset button restores all points."),
            actionButton("samples_add", "Add points"),
            actionButton("samples_exclude", "Delete points"),
            actionButton("samples_reset", "Reset")
        )
    ),
    fluidRow(
        column(width = 6,
               plotOutput("plot1", height = 350,
                          click = "plot1_click",
                          brush = brushOpts(
                              id = "plot1_brush"
                          )
               )
        )
    ),
    fluidRow(
        wellPanel(
            
        )
    ),
    mainPanel(
        h3("Model"),
        helpText("lm(mpg ~ wt, data = mtcars)"),
        h4("Coefficients"),
        verbatimTextOutput("coef")
    )
))




