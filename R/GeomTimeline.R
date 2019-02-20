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

# REQUIRED_AES
required_aes = c("x")


optional_aes = c('y',
                 'color',
                 'size',
                 'alpha')


default_aes = ggplot2::aes(shape = 21,
                           colour = "black",
                           size = 0.1,
                           fill = 'grey',
                           alpha = 0.4,
                           stroke = 1)




draw_panel <- function(data,
                       panel_params,
                       coord) {


       data$size <- data$size/max(data$size)



       # General configuration of Timeline

       ht <- 0.1      # Height Position
       vt <- 0.1      # Vertical Position
       pad <- 0.05    # Border
       thick <- 0.02  # Markers length

       # Creating the timeline markers.
       year_markers <- c(year_min,
                         round(year_min + (year_range)/3, 0),
                         round(year_min + 2*(year_range)/3, 0),
                         year_max) # Years to be plotted.

       # Default gpar for timeline.
       gpar <- gpar(col = 'black',  # Line Color
                    lty = 1,        # Line Type
                    lwd = 2)        # Line Width

       # Creating the horizontal line.
       horizontal_line <- segmentsGrob(x0 = 0 + pad,
                                       x1 = 1.0 - pad,
                                       y0 = ht,
                                       y1 = ht,
                                       gp = gpar)

       # Initializing the tree.
       timeline <- gTree(children = gList(horizontal_line))

       # Creating the thicks.
       for (i in 1:4) {

              # Creating each marker.
              marker <- segmentsGrob(x0 = vt + (i - 1)*(0.8/3),
                                     x1 = vt + (i - 1)*(0.8/3),
                                     y0 = ht - thick,
                                     y1 = ht,
                                     gp = gpar)

              # Adding to the tree.
              timeline <- gTree(children = gList(timeline, marker))

              # Plotting the year label.
              textGrob(label = year_markers[i],
                       x =  vt + (i - 1)*(0.8/3),
                       y =  ht - thick - 0.01,
                       just = "top") -> text_marker

              # Adding to the tree.
              timeline <- gTree(children = gList(timeline, text_marker))
       }

       # Adding label to the timeline.
       date_label <- textGrob(label = "DATE",
                              x =  0.5,
                              y =  ht/3,
                              just = "bottom")

       timeline <- gTree(children = gList(timeline, date_label))






       coords <- coord$transform(data, panel_params)


       circle <- grid::circleGrob(
              coords$x,
              coords$y,
              r = coords$size/15,
              gp = grid::gpar(col =      alpha(coords$colour, coords$alpha),
                              fill =     alpha(coords$colour, coords$alpha),
                              alpha =    coords$alpha,
                              fontsize = coords$size * .pt + coords$stroke * .stroke / 2,
                              lwd =      coords$stroke * .stroke / 2
              )
       )

       grid::gTree(children = grid::gList(timeline, circle))

}

GeomTimeline <- ggplot2::ggproto(`_class`   = "GeomTimeline",
                                 `_inherit` = ggplot2::Geom,
                                 required_aes = required_aes,
                                 optional_aes = optional_aes,
                                 default_aes = default_aes,
                                 draw_key = ggplot2::draw_key_point,
                                 draw_panel = draw_panel)
