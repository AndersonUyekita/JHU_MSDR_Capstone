context("test-gromtimelinelabel")

test_that("Checking the GeomTimelineLabel", {

       # Checking the class of GeomTimeline.
       expect_is(GeomTimelineLabel, "Geom")
       expect_is(GeomTimelineLabel, "ggproto")
       expect_is(GeomTimelineLabel, "gg")
})
