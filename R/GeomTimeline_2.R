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

# Defining REQUIRED_AES
aa <- c("x", "size")

# Defining OPTIONAL_AES
ee <- c("y", "color", "alpha", "size")

# Defining default_aes
bb <- ggplot2::aes(colour = 'blue',  # Defining a default color.
                   shape = 21,
                   alpha  = '0.5')   # Defining a standard circle's tansparency.

# Defining draw_key
cc <- ggplot2::draw_key_polygon

# Defining draw_group
dd <- function(data, panel_scale, coord) {

       # Filtering to reduce the number of observations. REMOVE IT.
       data <- data %>% mutate(YEAR = year(x))

       # Gathering the MAX and MIN
       year_min <- min(data$YEAR)
       year_max <- max(data$YEAR)
       year_range <- year_max - year_min

       # Rescaling year.
       data$x <- as.numeric(data$x)
       data$x <- data$x - min(data$x)
       data$x <- data$x/max(data$x)

       # Country List
       countries <- unique(data$y)

       # Converting several values of Richert in 4 Levels.
       data <- data %>% mutate(size2 = case_when(size <= 2 ~ 0.5,
                                                 size  > 2 & size <= 4 ~ 1,
                                                 size  > 4 & size <= 6 ~ 2.0,
                                                 size  > 6 & size <= 8 ~ 3.0,
                                                 size  > 8 ~ 4.0)) %>%
                            select(-size) %>%
                                   rename(size = size2)

       data$size <- as.factor(data$size)

       ## Timeline.

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

       # Removing non scalable variable
       data_w_date <- data %>% select(-y)

       # Initializing variables.
       n_countries <- length(countries)

       heq <- (1.0 - ht)/n_countries

       for (j in 1:n_countries) {
              earthquake_country <- segmentsGrob(x0 = 0.1,
                                     x1 = 0.9,
                                     y0 = 1 - (j) * heq + 2 * pad,
                                     y1 = 1 - (j) * heq + 2 * pad,
                                     gp = gpar(col = 'grey', lty = 1, lwd = 2))

              timeline <- gTree(children = gList(timeline, earthquake_country))

              textGrob(label = countries[j],
                       x =  0.01,
                       y =  1 - (j) * heq + 2 * pad,
                       just = "left") -> text_marker

              timeline <- gTree(children = gList(timeline, text_marker))

              df_temp <- data[countries[j] == data$y,]


              df_temp['y_oi'] <- 1 - (j) * heq + 2 * pad

              circle <- circleGrob(x = 0.1 + 0.8 * df_temp$x ,
                                   y = df_temp$y_oi,
                                   r = df_temp$size,
                                   gp = gpar(col = 'darkgrey',
                                             lwd = 1,
                                             fill = df_temp$colour,
                                             alpha = df_temp$alpha))





              timeline <- gTree(children = gList(timeline, circle))

              print(df_temp)
       }

       # Plotting the timeline.
       #grid.draw(timeline)
       grid::gTree(children = grid::gList(timeline, date_label))
}







# Creating the new Geom using ggproto and each of the previous parts I have so far defined.
GeomTimeline <- ggplot2::ggproto(`_class` = "GeomTimeline",
                                 `_inherit` = ggplot2::Geom,
                                 required_aes = aa,
                                 optional_aes = ee,
                                 default_aes = bb,
                                 draw_key = cc,
                                 draw_group = dd)
