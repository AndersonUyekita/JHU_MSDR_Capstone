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
#   Function:  eq_create_label                                                           #
#                                                                                        #
##########################################################################################

#' eq_create_label
#'
#' This function creates content to be displayed inside of the popups plotted by the eq_map function.
#'
#' @param df_create_label DataFrame with information about earthquakes, must have LOCATION,
#'                        EQ_PRIMARY, and TOTAL_DEATHS columns
#'
#' @importFrom rlang .data
#'
#' @return Vector with content to be used by eq_map function.
#'
#' @examples
#'
#' \dontrun{
#' # Full example using eq_clean_data, eq_create_label, and eq_map.
#' readr::read_delim("inst/extdata/signif.txt",
#'                   delim = "\t") %>%
#'                        eq_clean_data() %>%
#'                             dplyr::filter(COUNTRY == "MEXICO" &
#'                                           lubridate::year(DATE) >= 2000) %>%
#'                                                dplyr::mutate(popup_text = eq_create_label(.)) %>%
#'                                                    eq_map(annot_col = "popup_text")
#'
#' # From a given dataframe (assuming my_dataframe has LOCATION, EQ_PRIMARY, and TOTAL_DEATHS columns).
#' my_dataframe %>%
#'     plyr::mutate(popup_text = eq_create_label(.)) %>%
#'         eq_map(annot_col = "popup_text")}
#'
#' @export
eq_create_label <- function(df_create_label = rlang::.data) {
       paste("<b>Location: </b>",df_create_label$LOCATION,"<br>",
             "<b>Magnitude: </b>",df_create_label$EQ_PRIMARY,"<br>",
             "<b>Total deaths: </b>",df_create_label$TOTAL_DEATHS, sep ="")
}
