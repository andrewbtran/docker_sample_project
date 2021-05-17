#* @apiTitle Fatal Force API
#* @apiDescription Example of an API using fatal force data

packages <- c("plumber", "tidyverse")

if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())), repos = "http://cran.us.r-project.org")  
}

library(plumber)
library(tidyverse)

# read the data
ff <- read_csv("https://github.com/washingtonpost/data-police-shootings/raw/master/fatal-police-shootings-data.csv")

## fatal force data by state

#' Return json of data by state
#' @param state If provided, filter the data to only this state (e.g. "NY")
#' 
#' @tag raw
#' @get state_data
function(state){
  
  
  state_abb <- str_to_upper(state)
  
  df <- filter(ff, state==state_abb)
  
  return(df)
  
  
}


## fatal force data by city and state

#' Return json of data by state
#' @param state If provided, filter the data to only this state (e.g. "NY")
#' @param city If provided, filter the data to only this city (e.g. "New York")
#' 
#' @tag raw
#' @get city_state
function(state, city){
  
  if (!missing(state)) {
    state_abb <- str_to_upper(state)
    
    df <- filter(ff, state==state_abb)
  }
  
  
  if (!missing(city)) {
    city_filter <- str_to_title(city)
    city_filter <- gsub("%20", " ", city_filter)
    
    df <- filter(ff, city==city_filter)
  }
  
  
  return(df)
  
  
}

