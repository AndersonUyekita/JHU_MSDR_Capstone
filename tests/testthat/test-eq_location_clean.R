context("test-eq_location_clean")

test_that("Creates the LOCATION column", {

       # Path to raw data
       raw_data_path <- system.file("extdata", "signif.txt", package = "msdr")

       # Loading the raw data
       raw_data <- readr::read_delim(file = raw_data_path, delim = "\t")

       # Adding LOCATION column
       data_location <- raw_data %>% eq_location_clean

       # Checking if the LOCATION is character class.
       expect_that(class(data_location$LOCATION), equals("character") )
})
