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
#   Function:  theme_msdr                                                                #
#                                                                                        #
##########################################################################################

#' theme_msdr
#'
#' I used this theme to change the overall visuals of the ggplot2 to became more likely to the
#' examples.
#'
#' @importFrom ggplot2 theme element_blank element_line
#'
#' @return Remove the gray background, the grid, the panel border, etc. Turns the
#'         plot clean.
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
#'     theme_msdr()}
#'
#' @export
theme_msdr <- function() {

ggplot2::theme(axis.line.x  = ggplot2::element_line(colour = "black",
                                                    size = 1,
                                                    linetype = "solid"),
               axis.ticks.x.bottom = ggplot2::element_line(colour = "black",
                                                           size = 1,
                                                           linetype = "solid"),
               panel.grid.major.y = ggplot2::element_line(colour = "gray",
                                                          size = 2,
                                                          linetype = "solid"),
               axis.text.y.left = ggplot2::element_text(size = 14),            # Countries names
               legend.position = "bottom",
               axis.ticks.y = ggplot2::element_blank(),
               panel.background = ggplot2::element_blank(),
               plot.background = ggplot2::element_blank(),
               panel.border = ggplot2::element_blank(),
               axis.title.y.left = ggplot2::element_blank())
}
