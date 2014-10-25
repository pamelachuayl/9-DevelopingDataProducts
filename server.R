library(shiny)
library(dplyr)
library(caret)
library(reshape2)
data(cars)

shinyServer(
  function(input, output){
    output$models <- renderPrint(chooseCars(input, "models"))
    output$details <- renderPrint(chooseCars(input, "details"))
  })

# Function to choose cars based on input parameters
chooseCars <- function(input, type){
  
  # Filter data based on input
  carsToDisplay <- cars %>% 
          filter(Price >= input$price[1], Price <= input$price[2], 
            Mileage <= input$mileage,
             Cylinder == input$cylinder,
              Doors == input$doors,
                Leather == convertToNum(input$leather),
                  Cruise == convertToNum(input$cruise),
                    Sound == convertToNum(input$sound))
  
  # Return message if no car met the selected criteria
  if(count(carsToDisplay) == 0) return("There isn't any car with selected criteria")
  
  # Reshape the data for presentation: returning data with Model, Price, Mileage
  meltcars <- melt(carsToDisplay, id=c("Price", "Mileage"),
                   measure.vars=c("Buick","Cadillac","Chevy","Pontiac","Saab","Saturn"))
  carsChoose <- filter(meltcars, value == 1)
  if(type == "models") return (as.character(unique(carsChoose$variable)))
  carsChoose <- carsChoose[,c("variable", "Price", "Mileage")]
  names(carsChoose) <- c("Model", "Price", "Mileage")
  return(arrange(carsChoose, Model, Price, Mileage))
}

# Function to convert "Yes"/"No" to 1/0 as in the data
convertToNum <- function(yesNo){
  if(yesNo == "Yes")
    return(1)
  return(0)
}