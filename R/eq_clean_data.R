##########################################################################################
#                                                                                        #
#   Author:    Anderson Hitoshi Uyekita                                                  #
#   Project:   Mastering Software Development in R Specialization Capstone Project       #
#   Date:      15/02/2019                                                                #
#   Version:   1.0                                                                       #
#                                                                                        #
#   Function:  eq_clean_data                                                             #
#                                                                                        #
##########################################################################################


#' DESCRIPTION:
#'
#'
#'
#'
#'
#'
#'
#'
#'
#'
#'
#'


eq_clean_data <- function(file_name) {

       # Loading dependencies
       library(readr)
       library(lubridate)
       library(dplyr)

       # Reading the file.
       df <- readr::read_delim(file = file_name,   # file's names
                               delim = '\t',       # Kind of delimiter
                               col_names = TRUE,   #
                               progress = FALSE,   #
                               col_types = cols()) #

       # 1. Uniting YEAR, MONTH, and DAY in one column, then convering in Date.
       df <- df %>%
              mutate(DATE = lubridate::ymd(paste(df$YEAR,      # YEAR column
                                                 df$MONTH,     # MONTH column
                                                 df$DAY,       # DAY column
                                                 sep = "/")))  # YYYY/MM/DD

       # 2. Converting LATITUDE and LONGITUDE columns to numerics.
       df <- df %>%
              mutate(LONGITUDE = as.numeric(df$LONGITUDE)) %>%  # Converting LONGITUDE to numeric
              mutate(LATITUDE = as.numeric(df$LATITUDE))        # Converting LATITUDE to numeric

       ## Data Cleaning.

       # Removing Tsunamis observations.
       df <- df %>% filter(is.na(FLAG_TSUNAMI))

}


df <- eq_clean_data(file_name = 'signif.txt')


df

