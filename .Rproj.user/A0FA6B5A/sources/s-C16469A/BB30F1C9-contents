##########################################################################################
#                                                                                        #
#   Author:    Anderson Hitoshi Uyekita                                                  #
#   Project:   Mastering Software Development in R Specialization Capstone Project       #
#   Date:      15/02/2019                                                                #
#   Version:   1.0                                                                       #
#                                                                                        #
#   Function:  eq_location_data                                                          #
#                                                                                        #
##########################################################################################


#' DESCRIPTION:
#'
#'
#' COUNTRY; COUNTRY : REGION : City
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


library(stringr)


eq_clean_location <- function(df) {

       # Creating subset to work
       df$LOCATION_NAME %>% stringr::str_split(., ";", simplify = TRUE) -> teste

       # Temporaly variable to store the cities names.
       cities = vector()

       # Loop to varies the columns
       for (col in 1:dim(teste)[2]) {
              # Loop to varies the rows.
              for (row in 1:dim(teste)[1]) {
                     temp <- stringr::str_split(teste[row,col], ":", simplify = TRUE)
                     temp <- trimws(temp, which = 'left')  # Removing space on left.
                     temp <- str_to_title(temp)            # Convering title case.
                     # Initialize the vector.
                     if (col == 1) {
                            cities[row] <- temp[length(temp)]     # Assigning values.
                            }
                     # Adding new cities preserving the other city.
                     else {
                            # Preventing to add "" and comas.
                            if (temp == '')
                                   next
                            # Adding new cities after coma.
                            else
                                   cities[row] <- paste(cities[row], temp[length(temp)], sep = ", ")
                            }
                     }
              }

       # Adding new column with cities names in title case.
       df['LOCATION'] <- cities

       # Returning an updated DataFrame
       return(df)
}


df <- eq_clean_location(df)
