### How to run the api

#### Run this in console

library(plumber)

root <- pr("api/plumber.R")
root
root %>% pr_run()