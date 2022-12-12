
source("app_ui.R")
source("app_server.R")
#library("rsconnect")
library(tidyverse)
library(ggplot2)
library(plotly)
library(lintr)
library(shiny)

CO2 <- read.csv("owid-co2-data.csv", stringsAsFactors = FALSE)

# Run the application 
shinyApp(ui = ui, server = server)
