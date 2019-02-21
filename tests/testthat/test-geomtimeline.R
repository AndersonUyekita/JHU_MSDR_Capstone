context("test-geomtimeline")

test_that("Checking the GeomTimeline", {

       # Checking the class of GeomTimeline.
       expect_is(GeomTimeline, "Geom")
       expect_is(GeomTimeline, "ggproto")
       expect_is(GeomTimeline, "gg")
})
