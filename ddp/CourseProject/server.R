#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(Cairo)
library(datasets)

shinyServer(function(input, output) {
    # For storing which rows have been excluded
    vals <- reactiveValues(
        keeprows = rep(TRUE, nrow(mtcars))
    )
    
    output$plot1 <- renderPlot({
        # Plot the kept and excluded points as two separate data sets
        keep    <- mtcars[ vals$keeprows, , drop = FALSE]
        exclude <- mtcars[!vals$keeprows, , drop = FALSE]
        
        output$coef <- renderPrint({
            summary(lm(mpg ~ wt, data=keep))$coef
        })
        
        ggplot(keep, aes(wt, mpg)) + geom_point() +
            geom_smooth(method = lm, fullrange = TRUE, color = "black") +
            geom_point(data = exclude, shape = 21, fill = NA, color = "black", alpha = 0.25) +
            coord_cartesian(xlim = c(1.5, 5.5), ylim = c(5,35))
    })
    
    
    # Toggle points that are clicked
    observeEvent(input$plot1_click, {
        res <- nearPoints(mtcars, input$plot1_click, allRows = TRUE)
        vals$keeprows <- xor(vals$keeprows, res$selected_)
    })
    
    # Add points that are brushed, when button is clicked
    observeEvent(input$samples_add, {
        res <- brushedPoints(mtcars, input$plot1_brush, allRows = TRUE)
        vals$keeprows <- vals$keeprows | res$selected_
    })
    
    # Remove points that are brushed, when button is clicked
    observeEvent(input$samples_exclude, {
        res <- brushedPoints(mtcars, input$plot1_brush, allRows = TRUE)
        vals$keeprows <- vals$keeprows & !res$selected_
    })
    
    # Reset all points
    observeEvent(input$samples_reset, {
        vals$keeprows <- rep(TRUE, nrow(mtcars))
    })

})