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
#'
#'
#'
#'
#'

geom_timeline <- function(mapping = NULL,
                           data = NULL,
                           stat = "identity",
                           position = "identity",
                           na.rm = FALSE,
                           show.legend = NA,
                           inherit.aes = TRUE, ...){

       ggplot2::layer(geom = GeomTimeline,
                      mapping = mapping,
                      data = data,
                      stat = stat,
                      position = position,
                      show.legend = show.legend,
                      inherit.aes = inherit.aes,
                      params = list(na.rm = na.rm,...)
       )
}
