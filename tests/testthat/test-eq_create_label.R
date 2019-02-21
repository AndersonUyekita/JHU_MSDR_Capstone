context("test-eq_create_label")

test_that("Creating the Label to Popup", {

       # Path to raw data
       raw_data_path <- system.file("extdata", "signif.txt", package = "msdr")

       # Loading the raw data
       raw_data <- readr::read_delim(file = raw_data_path, delim = "\t")

       # Creating Labels to Popup
       labels_popup <- raw_data %>% eq_clean_data() %>% eq_create_label()

       # Should be character
       expect_that(class(labels_popup), equals("character") )
})
