library(plotly)
library(shiny)
library(tidyverse)
library(rworldmap)
library(arsenal)
library(leaflet)
library(rworldmap) 
library(countrycode)  # Gets country code 
library(viridis)

ui <- shinyUI(fluidPage(
  titlePanel("Years"),
  sidebarPanel(
    sliderInput("year", "Year:", min = 2011, max = 2018, value = 1)
  ),
  mainPanel(
    plotlyOutput("trendPlot")
  )
))