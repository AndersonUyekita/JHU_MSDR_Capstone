context("test-eq_map")

test_that("multiplication works", {

       # Path to raw data
       raw_data_path <- system.file("extdata", "signif.txt", package = "msdr")

       # Loading the raw data
       raw_data <- readr::read_delim(file = raw_data_path, delim = "\t")

       # Cleaning.
       df_clean <- raw_data %>% eq_clean_data()

       # Creating a map
       curious <- df_clean %>% eq_map('DATE')

       # Checking the object.
       expect_that(class(curious)[1], equals("leaflet"))
       })
