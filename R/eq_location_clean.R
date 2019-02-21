##########################################################################################
#                                                                                        #
#   Author:    Anderson Hitoshi Uyekita                                                  #
#                                                                                        #
#   Course:    Mastering Software Development in R Specialization                        #
#   Project:   Capstone Project                                                          #
#                                                                                        #
#   Date:      15/02/2019                                                                #
#   Version:   1.0                                                                       #
#                                                                                        #
#   Function:  eq_location_clean                                                         #
#                                                                                        #
##########################################################################################

#' eq_location_clean
#'
#' This function is a intermediate step to clean the raw data. The `eq_clean_data` will use it behind
#' the scenes to insert the column LOCATION.
#'
#' @param df_2 A DataFrame with LOCATION_NAME column.
#'
#' @importFrom stringr str_split str_to_title
#'
#' @importFrom rlang .data
#'
#' @return Adds a new column to the DataFrame called LOCATION, following the specifications:
#'         Title Case and without country name.
#'
#' @examples
#'
#' \dontrun{
#' # Piping a DataFrame with LOCATION_NAME to be converted in LOCATION.
#' readr::read_delim("inst/extdata/signif.txt",
#'                   delim = "\t") %>%
#'                       eq_location_clean()}
#'
#' @export
eq_location_clean <- function(df_2 = rlang::.data) {

       # Creating subset to work
       teste <- stringr::str_split(df_2$LOCATION_NAME, ";", simplify = TRUE)

       # Temporaly variable to store the cities names.
       cities = vector()

       # Loop to varies the columns
       for (col in 1:dim(teste)[2]) {

              # Loop to varies the rows.
              for (row in 1:dim(teste)[1]) {
                     temp <- stringr::str_split(teste[row,col], ":",
                                                simplify = TRUE)
                     temp <- trimws(temp, which = 'left')  # Removing space on left.
                     temp <- stringr::str_to_title(temp)            # Convering title case.
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
                                   cities[row] <- paste(cities[row],
                                                        temp[length(temp)],
                                                        sep = ", ")
                            }
                     }
              }

       # Adding new column with cities names in Title Case.
       df_2['LOCATION'] <- cities

       # Returning an updated DataFrame
       return(df_2)
}
