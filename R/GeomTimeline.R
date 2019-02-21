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
#   Function:  GeomTimeline                                                              #
#                                                                                        #
##########################################################################################

## COLOPHON
#
# I have defined all parameters of GeomTimeline before creating it.


# REQUIRED_AES
required_aes = c("x") # DATE

# OPTIONAL_AES
optional_aes = c('y',     # COUNTRY
                 'color', # "Density"
                 'size',  # Point size
                 'alpha') # Transparency

# DEFAULT_AES
default_aes = ggplot2::aes(pch = 21,         # Do not work without it.
                           colour = "black", # Default color
                           size = 0.01,      # Very small circle
                           fill = 'grey',    # Default fill color
                           alpha = 0.4,      # Default transparency
                           stroke = 1)       # Line thickness

# DRAW_PANEL
draw_panel <- function(data,           # Data from aes()
                       panel_params,   # panel_params
                       coord) {

       # Attemp to decrease the size of the circles.
       data$size <- data$size/max(data$size)

       # Changing the "scale" to adapt the plot in the graphic.
       coords <- coord$transform(data, panel_params)

       # Plotting circles as earthquekes.
       grid::circleGrob(
              coords$x,           # The converted X axis
              coords$y,           # For each country there are a line in y axis.
              r = coords$size/25, # Radius of the circle. According to the EQ_PRIMARY.
              gp = grid::gpar(col =      scales::alpha(coords$colour, coords$alpha), # Color with transparency and scaled
                              fill =     scales::alpha(coords$colour, coords$alpha), # Color with transparency and scaled
                              alpha =    coords$alpha,   # Transparency
                              fontsize = coords$size,    # Fontsize
                              lwd =      coords$stroke)) # Line width
}

#' GeomTimeline
#'
#' This functions is the Geom in charge to creates the visuals. You do not need to use the geom_timeline
#' to have the benefits of this function as you can see in the examples. Just uses the `ggplot2::layer`.
#'
#' @importFrom ggplot2 ggproto aes draw_key_point Geom
#'
#' @importFrom grid circleGrob gpar
#'
#' @importFrom scales alpha
#'
#' @return Creates the visuals to be plotted by the geom_timeline.
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
#' # Plotting using layer.
#' ggplot2::ggplot() +
#'     ggplot2::layer(geom = GeomTimeline,
#'                    mapping = aes(x = df_example$DATE,
#'                                  y = df_example$COUNTRY,
#'                                  size = df_example$EQ_PRIMARY,
#'                                  color = df_example$TOTAL_DEATHS),
#'                    data = df_example,
#'                    stat = 'identity',
#'                    position = 'identity',
#'                    show.legend = NA,
#'                    inherit.aes = TRUE,
#'                    params = list(na.rm = FALSE))}
#'
#' @export
GeomTimeline <- ggplot2::ggproto(`_class`     = "GeomTimeline",
                                 `_inherit`   = ggplot2::Geom,
                                 required_aes = required_aes,
                                 optional_aes = optional_aes,
                                 default_aes  = default_aes,
                                 draw_key     = ggplot2::draw_key_point,
                                 draw_panel   = draw_panel)
