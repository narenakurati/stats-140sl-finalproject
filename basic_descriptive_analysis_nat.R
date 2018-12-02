
length(which(!is.na(listings$name)))/nrow(listings) # % with name - 99.99%
length(which(!is.na(listings$summary)))/nrow(listings) # % with summary - 96.57%
length(which(!is.na(listings$space)))/nrow(listings) # % with space - 71.80%
length(which(!is.na(listings$description)))/nrow(listings) # % with description - 98.38%
length(which(!is.na(listings$neighborhood_overview)))/nrow(listings) # % with neighborhood overview - 62.68%
length(which(!is.na(listings$notes)))/nrow(listings) # % with notes - 49.65%
length(which(!is.na(listings$transit)))/nrow(listings) # % with transit - 59.38%
length(which(!is.na(listings$access)))/nrow(listings) # % with access - 62.83%
length(which(!is.na(listings$house_rules)))/nrow(listings) # % with house rules - 68.25%
length(which(!is.na(listings$host_about)))/nrow(listings) # % with about host - 64.68%

### percent of listings that are instant_bookable and no_interaction (and also possible have extra people option)
no_interact_instant_book <- listings %>% filter(!(str_detect(amenities, "Host greets you"))) %>% 
  select(accommodates,guests_included,extra_people,instant_bookable) %>% 
  mutate(extra_people = as.numeric(gsub("[\\$,]", "", extra_people)),
         accommodates = as.numeric(accommodates),
         guests_included = as.numeric(guests_included),
         instant_bookable = as.character(instant_bookable))

no_interact_instant_book %>% filter(extra_people == 0, instant_bookable == "t") %>% nrow()
no_interact_instant_book %>% filter(extra_people != 0, instant_bookable == "t") %>% nrow()
# Of the 36510 listings with no host interaction, 7803 (21.37%) of them don't charge for extra people and are instantly bookable
# Of the 36510 listings with no host interaction, 8179 (22.40%) of them do charge for extra people and are instantly bookable

### types of cancellation policies
table(listings$cancellation_policy)

### security deposit - I'm just trying to get general summary values for this but it's a character, and for some reason I can't remove the "$" sign
security_dep <- listings %>% select(security_deposit) %>% mutate(security_deposit = as.numeric(gsub("$", "", security_deposit)))

