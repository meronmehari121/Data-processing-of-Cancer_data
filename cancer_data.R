    ## WHAT: The current NHS Cancer elective service stipulates that patients should not wait for more than 18 weeks to see a specialist.  
    # HOW: Here, CCG level data will aid in analysing years 2015 & 2016 trends against the targets using the 
    # data of the NHS cancer patients waiting more than one 18 weeks between diagnosis and treatment 
    
    pacman::p_load(rio, tidyverse)
    url <- 'https://files.digital.nhs.uk/75/FF3AD0/LBOI_13.05_11_10_V1_D.xls'
    
    table_15 <- rio::import(file = url, which = 2, skip = 4) 
    
    table_15 <- table_15 %>% 
      select(Code,Organisation,Proportion_2015 = Proportion) %>%
      rename_all(tolower) %>% 
      slice(-c(304:306)) 
    head(table_15)
    
    
    table_16 <- rio::import(file = url, which = 3, skip = 4)
    
    table_16 <- table_16 %>%
      select(Code,Organisation, proportion_2016="Percentage Waiting > 1 Month") %>% 
      rename_all(tolower) 
    head(table_16)
    
    # Joining 2015 & 2016 datasets 
    full <-  full_join(table_15,table_16, by = c("code", "organisation"))
    View(full)

    # plotting proportion of patients across time 
     ggplot(table_15) + aes(x = code, y = proportion_2015) + geom_col(fill = "#440154") +
     labs(x = "Proportion of waitlist", y = "CCGs", title = "CCG by Waiting times", subtitle = "Data for the year 2015") +
     theme_minimal()

     ggplot(table_16) + aes(x = code, y = proportion_2016) + geom_col(fill = "#440154") +
     labs(x = "Proportion of waitlist", y = "CCGs", title = "CCG by Waiting times", subtitle = "Data for the year 2016") +
     theme_minimal()

