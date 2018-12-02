

#0 - Set up --------

#Remove Objects
rm(list = ls())

#Clear Memory
gc(reset = TRUE)

#Set Working Directory
setwd("/Users/JamesW/Desktop/Final 140 Project")

require(stringr)
require(tidyverse)
require(dplyr)		#Data frame functions
require(data.table)
require(dtplyr)
require(stringi)
require(ggplot2)		#Graphics
require(lubridate)
require(readxl)
require(reshape2)
require(rgdal)



#I. Read in the files --------
listings_summary <- read_csv("listings.csv")
# reviews_summary <- read_csv("reviews.csv")

listings <- read_csv(
  "listings 2.csv",
  col_types = cols(.default = "c"),
  na = c("", " ", "NA")
  ) %>%
  # convert all variable names to lower
  rename_all(.funs = ~ tolower(.)) 

reviews <- read_csv(
  "reviews 2.csv",
  col_types = cols(.default = "c"),
  na = c("", " ", "NA")
) %>%
  # convert all variable names to lower
  rename_all(.funs = ~ tolower(.)) 


listings %>% colnames()

listings %>% filter(str_detect(amenities, "Host greets you")) %>% nrow()

no_interaction <- listings %>% filter(!(str_detect(amenities, "Host greets you"))) %>% 
  select(accommodates,guests_included,extra_people) %>% 
  mutate(extra_people = as.numeric(gsub("[\\$,]", "", extra_people)),
         accommodates = as.numeric(accommodates),
         guests_included = as.numeric(guests_included))

no_interaction %>% filter(extra_people == 0) %>% nrow()
# Of 36510 listings without host interaction, roughlt half (0.4897562 % /// 17881 listings) 
# do not charge for extra people 

no_list_w_charge <- no_interaction %>% filter(extra_people != 0) 
no_list_w_charge <- no_list_w_charge %>% mutate(lost_revenue = (accommodates - guests_included)*extra_people)
boxplot(no_list_w_charge$lost_revenue) ## issue - might be that the charge is for going over accomidation ?

neg <- no_list_w_charge %>% filter(lost_revenue < 0) # encoding error? 
boxplot(neg$lost_revenue) 

posit <- no_list_w_charge %>% filter(lost_revenue > 0)

summary(posit$lost_revenue) #of positive losses, average of $60 per night lost in revenue 
boxplot(posit$lost_revenue)





