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
#   Function:  eq_clean_data                                                             #
#                                                                                        #
##########################################################################################

#' eq_clean_data
#'
#' You can use this function in two ways. Assigning the file_name (e.g. ../path/my_file.txt) with path or piping it
#' as sequence of a read_delim.
#'
#' @param file_name You can insert the file_name and path to reach the tsv file or pipe it with a read_delim.
#'
#' @return A DataFrame version of file_name. Have in mind, I have only cleaning few columns:
#'         EQ_PRIMARY, LOCATION_NAME, DATE, and TOTAL_DEATHS.
#'
#' @importFrom magrittr %>%
#'
#' @importFrom dplyr mutate filter
#'
#' @importFrom lubridate ymd
#'
#' @importFrom readr read_delim
#'
#' @importFrom rlang .data
#'
#' @examples
#'
#' \dontrun{
#' # Loading using a third party function and then cleaning teh DataFrame.
#' readr::read_delim("inst/extdata/signif.txt",
#'                   delim = "\t") %>%
#'                           eq_clean_data()
#'
#' # Piping a DataFrame.
#' any_dataframe %>% eq_clean_data()
#'
#' # Assigning a file_name
#' eq_clean_data(file_name = "my_folder/signif.txt")}
#'
#' @export
eq_clean_data <- function(file_name = rlang::.data) {

       # Work loading the txt file.
       if (class(file_name) == "character") {

              # Reading the file.
              df_a <- readr::read_delim(file = file_name,   # file's names
                                      delim = '\t',       # Kind of delimiter
                                      col_names = TRUE,   #
                                      progress = FALSE,   #
                                      col_types = readr::cols()) #
       }

       # Work cleaning the data.
       else
              df_a <- file_name


       # 1. Uniting YEAR, MONTH, and DAY in one column, then convering in Date.
       df_a <- df_a %>%
              dplyr::mutate(DATE = lubridate::ymd(paste(.data$YEAR,      # YEAR column
                                                        .data$MONTH,     # MONTH column
                                                        .data$DAY,       # DAY column
                                                        sep = "/")))     # YYYY/MM/DD

       # 2. Converting LATITUDE and LONGITUDE columns to numerics.
       df_a <- df_a %>%
              dplyr::mutate(LONGITUDE = as.numeric(.data$LONGITUDE)) %>%  # Converting LONGITUDE to numeric
              dplyr::mutate(LATITUDE  = as.numeric(.data$LATITUDE))        # Converting LATITUDE to numeric

       ## Data Cleaning.

       # Removing Tsunamis observations.
       df_a <- df_a %>% dplyr::filter(is.na(.data$FLAG_TSUNAMI))

       # Converting Character in Numeric. EARTHQUAKE.
       df_a <- df_a %>% dplyr::mutate(EQ_PRIMARY = as.numeric(.data$EQ_PRIMARY))

       # Converting Character in Numeric. TOTAL DEATH
       df_a <- df_a %>% dplyr::mutate(TOTAL_DEATHS = as.numeric(.data$TOTAL_DEATHS))

       # Removing all Earthquakes with EQ_PRIMARY equal to NaN.
       df_a <- df_a[!is.na(df_a$EQ_PRIMARY),]

       # Removing all Earthquakes with no DATE.
       df_a <- df_a[!is.na(df_a$DATE),]

       # Converting NaN in zero.
       df_a$TOTAL_DEATHS[is.na(df_a$TOTAL_DEATHS)] <- 0


       # Adding the LOCATION column.
       eq_location_clean(df_a)
}
