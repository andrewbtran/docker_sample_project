
packages <- c("shiny", "tidyverse", "stringr", "lubridate", "DT")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())), repos = "http://cran.us.r-project.org")  
}

library(shiny)
library(tidyverse)
library(stringr)
library(lubridate)
library(DT)

# read the data

ff <- read_csv("https://github.com/washingtonpost/data-police-shootings/raw/master/fatal-police-shootings-data.csv")

ff <- ff %>% 
  mutate(year=year(date)) %>% 
  arrange(state)

# Generating a list of states and years to use in the pulldown menu in ui.R
states_list <- unique(ff$state)

years_list <- unique(ff$year)

ui <- fluidPage(
  
  navbarPage(
    title=("Fatal Force Explorer"),
    tabPanel("States",
             sidebarLayout(
               sidebarPanel(
                 h4("Select State"),
                 selectInput(
                   inputId = "StatePicker", 
                   label = NULL, 
                   choices = states_list, 
                   selected = "FL"),
                 h4("Select Year"),
                 selectInput(
                   inputId = "YearPicker", 
                   label = NULL, 
                   choices = years_list, 
                   selected = 2021
                 ),
                 
                 
               ),
               
               mainPanel(
                 tabsetPanel(
                   tabPanel("Chart", 
                            plotOutput("top_chart", height="300px")
                            
                            
                            
                   ),
                   tabPanel("Table",
                            
                            dataTableOutput("top_table")
                            
                   ))))
    )
  )
)