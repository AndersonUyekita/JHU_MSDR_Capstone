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
#   Function:  GeomTimelineLabel                                                         #
#                                                                                        #
##########################################################################################

## COLOPHON
#
# I have defined all parameters of GeomTimelineLabel before create it.

# REQUIRED_AES
required_aes = c("x")  # DATE

# OPTIONAL_AES
optional_aes = c('label',  # LOCATION
                 'y',      # COUNTRY
                 'mag',    # EQ_PRIMARY
                 'color',  # Color
                 'alpha',  # Transparency
                 'n_max')  # Max number of Earthquake. Plot the n_max most deadly earthquake.

# DEFAULT_AES
default_aes = ggplot2::aes(shape = 21,
                           colour = "black",
                           size = 15.0,
                           n_max = 5,
                           fill = 'black',
                           alpha = 0.4,
                           stroke = 2)

# Where the magic happens.
draw_panel <- function(data,           # Data defined in aes()
                       panel_params,   # panel_params
                       coord) {

       # Sorting the Data. Highest to lowest.
       data <- data %>% dplyr::arrange(dplyr::desc(.data$mag))

       # Filtering the 5 highest EQ_PRIMARY.
       data <- utils::head(data, unique(data$n_max))

       # Converting the coordinates to be properly displayed.
       coords <- coord$transform(data, panel_params)

       # Plotting vertical lines from the center of the circle.
       lines <- grid::segmentsGrob(x0 = coords$x,
                                   y0 = coords$y,
                                   x1 = coords$x,
                                   y1 = coords$y + 0.15,
                                   default.units = "npc",
                                   gp = grid::gpar(col =      coords$colour,
                                                   alpha =    coords$alpha,
                                                   fontsize = coords$size,
                                                   lwd =      coords$stroke))

       # Plotting text. The earthquake location.
       texts <- grid::textGrob(label = coords$label, # Text to be plotted.
                               x = coords$x,         # X axis coordinates.
                               y = coords$y + 0.15,  # Generic vertical line.
                               just = "left",        # Justify to left.
                               rot = 45,             # Text rotation.
                               check.overlap = TRUE, # Only display one of the overlaped text.
                               default.units = "npc",# Default units.
                               gp = grid::gpar(col =      coords$colour,
                                               fontsize = coords$size,
                                               lwd =      coords$stroke))

       # Creates a tree and plot all together.
       grid::gTree(children = grid::gList(lines, texts))
}

#' GeomTimelineLabel
#'
#' This function creates a line from the center of the top deadly earthquake and label it with the location.
#'
#' @importFrom magrittr %>%
#'
#' @importFrom rlang .data
#'
#' @importFrom ggplot2 ggproto aes draw_key_polygon Geom
#'
#' @importFrom grid textGrob gTree gpar gList segmentsGrob
#'
#' @importFrom dplyr arrange desc
#'
#' @importFrom utils head
#'
#' @return Plots the n_max most deadly earthquakes from a given dataset.
#'
#' @examples
#'
#' \dontrun{
#' # Creating a Dataset.
#' df_example <- eq_clean_data(file_name = 'inst/extdata/signif.txt') %>%
#'     dplyr::filter(YEAR > 2010,
#'                   COUNTRY %in% c("CHINA",
#'                                  "JAPAN")) %>%
#'             dplyr::select(DATE,
#'                           COUNTRY,
#'                           EQ_PRIMARY,
#'                           TOTAL_DEATHS,
#'                           LOCATION)
#'
#'
#'df_example %>%
#'    ggplot2::ggplot() +
#'        geom_timeline(aes(x = DATE,
#'                          y = COUNTRY,
#'                          size = EQ_PRIMARY,
#'                          color = TOTAL_DEATHS)) +
#'            ggplot2::layer(geom = GeomTimelineLabel,
#'                           mapping = aes(x = DATE,
#'                                         label = LOCATION,
#'                                         y = COUNTRY,
#'                                         mag = EQ_PRIMARY,
#'                                         color = TOTAL_DEATHS),
#'                           stat = 'identity',
#'                           position = 'identity',
#'                           show.legend = NA,
#'                           inherit.aes = TRUE,
#'                           params = list(na.rm = FALSE))}
#'
#' @export
GeomTimelineLabel <- ggplot2::ggproto(`_class`     = "GeomTimelineLabel",
                                      `_inherit`   = ggplot2::Geom,
                                      required_aes = required_aes,
                                      optional_aes = optional_aes,
                                      default_aes  = default_aes,
                                      draw_key     = ggplot2::draw_key_point,
                                      draw_panel   = draw_panel)
