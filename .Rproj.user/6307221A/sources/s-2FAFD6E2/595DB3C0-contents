
packages <- c("shiny", "tidyverse", "stringr", "lubridate", "DT")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())), repos = "http://cran.us.r-project.org")  
}

library(shiny)
library(tidyverse)
library(stringr)
library(lubridate)
library(DT)

ff <- read_csv("https://github.com/washingtonpost/data-police-shootings/raw/master/fatal-police-shootings-data.csv")

ff <- ff %>% 
  mutate(year=year(date))

# Generating a list of states to use in the pulldown menu in ui.R
states_list <- unique(ff$state)

ff_state_annual <- ff %>% 
  mutate(year=year(date)) %>% 
  count(year, state, name="total")


server <- function(input, output) {
  
  ## Plot under States
  output$top_chart <- renderPlot({
    
    ff_state_annual %>% 
      filter(state %in% input$StatePicker) %>% 
      ggplot(aes(x=year, y=total)) +
      geom_col() +
      facet_wrap(~state) +
      labs(title=paste0("Police shootings over time in ", input$StatePicker),
           caption="Data: The Washington Post")
  })
  
  ## Table under Countries - Table
  output$top_table <- renderDataTable(
    
    ff %>% 
      filter(state %in% input$StatePicker) %>% 
      filter(year %in% input$YearPicker) %>% 
      select(id, date, manner_of_death, armed, age, gender, race, city, state)
  )
  
  
}