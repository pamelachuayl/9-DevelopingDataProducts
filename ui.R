# Load library and data
library(shiny)
library(caret)
data(cars)

shinyUI(pageWithSidebar(
  headerPanel("Car chooser based on 2005 GM models"),
  
  # Sidebar Panel for user to choose from various parameters
  sidebarPanel(
    sliderInput(inputId="price", "Price", min=min(cars$Price), max=max(cars$Price), value=c((max(cars$Price)+min(cars$Price))/4,3*(max(cars$Price)+min(cars$Price))/4)),
    sliderInput(inputId="mileage", "Max Mileage", min=min(cars$Mileage), max=max(cars$Mileage), value=(max(cars$Mileage)+min(cars$Mileage))/2),
    radioButtons(inputId="cylinder", label = "Num of Cylinders",c(4,6,8),inline=TRUE),
    radioButtons(inputId="doors", label = "Num of Doors", c(2,4),inline=TRUE),
    radioButtons(inputId="leather", label = "Leather Seats", c("Yes","No"),inline=TRUE),
    radioButtons(inputId="cruise", label = "Cruise Control", c("Yes","No"),inline=TRUE),
    radioButtons(inputId="sound", label = "Upgraded Speakers", c("Yes","No"),inline=TRUE)
    ),
  
  # Main Panel that displays the unique car models and also the details
  mainPanel(
    h3('Cars to consider'),
    p('Car models selected:'),
    verbatimTextOutput("models"),
    p('Prices and Mileages of cars: '),
    verbatimTextOutput("details")
    )
))