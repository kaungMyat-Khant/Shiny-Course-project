#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(rsconnect)
library(ggplot2)
#' Define UI for application that predict the diamond price 
#' based on cut, color, clarity and carat
fluidPage(

    # Application title
    titlePanel(title = "Diamond price by color, clarity and carat"),

    # Sidebar with a input to predict the diamond price
    sidebarLayout(
        sidebarPanel(
            helpText("This application predict the diamond price by color, 
                     clarity and carat of diamonds for a specific cut"),
            checkboxGroupInput(
                inputId = "cut",
                label = "First, please select the diamond's cut",
                choices = list("Fair" = "Fair",
                               "Good" = "Good",
                               "Very Good" = "Very Good",
                               "Premium" = "Premium",
                               "Ideal" = "Ideal"),
                selected = "Ideal",
                inline = TRUE,
            ),
            helpText("Select the color, clarity and caret of the diamond"),
            selectInput(
                inputId = "color",
                label = "Color of diamond",
                choices = list(
                    "D" = "D",
                    "E" = "E",
                    "F" = "F",
                    "G" = "G",
                    "H" = "H",
                    "I" = "I",
                    "J" = "J"
                ),
                selected = "D"
            ),
            selectInput(
                inputId = "clarity",
                label = "Clarity of diamond",
                choices = list(
                    "I1" = "I1" ,
                    "SI2" = "SI2", 
                    "SI1" = "SI1",
                    "VS2" = "VS2",
                    "VS1" = "VS1",
                    "VVS2" = "VVS2",
                    "VVS1" = "VVS1",
                    "IF" = "IF"
                ),
            ),
            sliderInput(
                inputId = "carat",
                label = "Carat",
                min = 0.2,
                max = 6.0,
                value = 0.7,
                step = 0.05
            ),
            submitButton("Predict")
        ),

        
        mainPanel(
            textOutput("cut_selected") , # Show the text for selected cut
            plotOutput("plot"),
            h3("Predicted price of the diamond is:"),
            p(textOutput("result"))
        )
    )
)
