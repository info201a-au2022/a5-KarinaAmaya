library(tidyverse)
library(ggplot2)
library(plotly)
library(lintr)
library(shiny)


 page_1 <-tabPanel("Introduction Page",
  h2("Introduction: Carbon Dioxide Emissions"),

  p("Climate change has had huge impacts around the world. It has affected environments, animals, and even people. This report analyzes data of carbon  dioxide around the world. It is important to notice the differences carbon  dioxide has on environments depending on where people are located in the world. With countries having very little carbon dioxide produced and other  places that emit so much carbon dioxide that it has affected its populations  in negative ways."), 

p("As the amount of carbon dioxide emissions increases, so does the Earth’s temperature. The rise in temperature has also increased catastrophic weather events. The main contributor to global warming is greenhouse emissions from human activities."), 

p("The data used in this report helps us to better understand the impacts of carbon dioxide and visualize how much is being produced by different areas in the world. The data also includes the different types of ways that carbon dioxide is being produced. We focus on specific parts of the data to better understand it. For example, focusing on the total cumulative production-based emissions of carbon dioxide. This includes land-use change and is measured in million tones. The average value of cumulative production-based emissions of carbon dioxide is 53,105.51, across all countries. Cumulative production based emissions is highest in North America at 237,384 and lowest in Monserrat at -.484. If we focus on a ten year span from 2018 and 2008 we can see that it has a difference of 888.3. It is important to note that if we focus on a decade difference of the data it varies.")
)
#---------------------------------------------------------------------------------------------------------------------------


page_2 <- tabPanel("Greenhouse Gas Distribution ",
                   titlePanel("Greenhouse Gas Distribution in Central America"),
sidebarLayout(
  sidebarPanel(
    uiOutput("selectCountry"),
    uiOutput("selectyear")
    ,
  ),
mainPanel(
  plotlyOutput(outputId = "caPlot"),

))
)

 
 
#---------------------------------------------------------------------------------------------

 
 ui <- navbarPage("Carbon Dioxide in the World and Greenhouse Gases in Central America",
theme = shinythemes::shinytheme("sandstone"),
page_1,
page_2
)

