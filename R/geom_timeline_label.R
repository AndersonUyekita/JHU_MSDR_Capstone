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
#   Function:  geom_timeline_label                                                       #
#                                                                                        #
##########################################################################################

#' geom_time_label
#'
#' This method acts behind de scenes creating a layer to plot the output of GeomTimelinelabel function.
#'
#' @inheritParams ggplot2::geom_point
#'
#' @importFrom ggplot2 layer
#'
#' @return Creates a layer to plot the GeomTimelineLabel output function. Updates the
#'         graphic inserting new content/visuals.
#'
#' @examples
#'
#' \dontrun{
#' ## Full example of geom_timeline using eq_clean_data function to load the raw data and clean it.
#'
#' # Loading and cleaning. Later subsetting the data.
#' df_earth <- eq_clean_data(file_name = 'inst/extdata/signif.txt') %>%
#'     dplyr::filter(YEAR > 2010,
#'                   COUNTRY %in% c("CHINA","JAPAN")) %>%
#'                        dplyr::select(DATE,
#'                        COUNTRY,
#'                        EQ_PRIMARY,
#'                        TOTAL_DEATHS,
#'                        LOCATION) %>%
#'
#'     ggplot2::ggplot() +
#'         geom_timeline(aes(x = DATE,
#'                           y = COUNTRY,
#'                           size = EQ_PRIMARY,
#'                           color = TOTAL_DEATHS)) +
#'
#'             geom_timeline_label(aes(x = DATE,
#'                                     label = LOCATION,
#'                                     y = COUNTRY,
#'                                     mag = EQ_PRIMARY,
#'                                     n_max = 3))}
#'
#' @export

geom_timeline_label <- function(mapping = NULL,
                          data = NULL,
                          stat = "identity",
                          position = "identity",
                          na.rm = FALSE,
                          show.legend = NA,
                          inherit.aes = TRUE, ...){

       ggplot2::layer(geom = GeomTimelineLabel,
                      mapping = mapping,
                      data = data,
                      stat = stat,
                      position = position,
                      show.legend = show.legend,
                      inherit.aes = inherit.aes,
                      params = list(na.rm = na.rm,...)
       )
}
