#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(rsconnect)
library(ggplot2)
library(dplyr)
# Define server logic required to draw a histogram
function(input, output) {
    output$plot <- renderPlot({
        data <- diamonds %>% filter(cut %in% unlist(input$cut))
        name_cut <- list(input$cut)
        title <- paste("Price predicted on diamonds with",
                       paste(name_cut,collapse = ", "), "cuts.")
        fit <- lm(price ~ carat+color+clarity, data = data)
        result <- predict(fit, 
                          newdata = data.frame(
                              carat = input$carat,
                              color = input$color,
                              clarity = input$clarity
                          ))
        plot <- 
            ggplot(data = data, aes(x = carat, y = price))+
            geom_point(alpha = 0.3, color ="skyblue")+
            geom_abline(intercept = coef(fit)[1], slope = coef(fit)[2],
                        color = "firebrick", size = 2)+
            geom_point(data = data.frame(x = input$carat, y = result),
                       aes(x, y),size =10, 
                           color = "forestgreen")+
            labs(title = title, x = "Mass of diamond (carat)",
                 y = "Price (US$)")+
            theme_minimal()
        plot
    })
    output$result <- renderText({
        data <- diamonds %>% filter(cut %in% unlist(input$cut))
        fit <- lm(price ~ carat+color+clarity, data = data)
        result <- predict(fit,
                          newdata = data.frame(
                              carat = input$carat,
                              color = input$color,
                              clarity = input$clarity
                          ))
        paste(round(result),"$ for", input$carat,"carats",input$color,"colour", 
              input$clarity,"clarity",".")
    })
    
}
