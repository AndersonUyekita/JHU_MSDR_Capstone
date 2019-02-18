##########################################################################################
#                                                                                        #
#   Author:    Anderson Hitoshi Uyekita                                                  #
#   Project:   Mastering Software Development in R Specialization Capstone Project       #
#   Date:      15/02/2019                                                                #
#   Version:   1.0                                                                       #
#                                                                                        #
#   Class:                                                                               #
#                                                                                        #
##########################################################################################

#'
#'
#'
#'
#'
#'
#'
#'
#' @importFrom ggplot2 ggproto aes draw_key_polygon Geom
#'
#'
#'
#'
#'
#' @export

# Defining required_aes
aa <- c("xmin",
        "xmax")

# Defining default_aes
bb <- ggplot2::aes(colour = 'blue',  # Defining a default color.
                   size   = '10',    # Defining a default circle size.
                   alpha  = '0.5')   # Defining a standard circle's tansparency.

# Defining draw_key
cc <- ggplot2::draw_key_polygon

# Defining draw_group
dd <- function(data, panel_scales, coord) {




}


# Creating the new Geom using ggproto and each of the previous parts I have so far defined.
GeomTimeline <- ggplot2::ggproto(`_class` = "GeomTimeline",
                                 `_inherit` = ggplot2::Geom,
                                 required_aes = aa,
                                 default_aes = bb,
                                 draw_key = cc,
                                 draw_group = dd)
