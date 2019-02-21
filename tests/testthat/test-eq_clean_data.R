context("test-eq_clean_data")

test_that("Observations results after Cleaning Process", {

       # Path to raw data
       raw_data_path <- system.file("extdata", "signif.txt", package = "msdr")

       # Cleaning the raw data.
       df_clean <- eq_clean_data(file_name = raw_data_path )

       # Loading data to see the dimensions.
       dimensions <- dim(df_clean)

       # Confirming the number of observations.
       expect_that(dimensions[1], equals(2840) )

       # Confirming the number of features.
       expect_that(dimensions[2], equals(49))

       # Checking character to numeric conversions.
       expect_that(class(df_clean$EQ_PRIMARY), equals("numeric") )
       expect_that(class(df_clean$TOTAL_DEATHS), equals("numeric") )
       expect_that(class(df_clean$LONGITUDE), equals("numeric") )
       expect_that(class(df_clean$LATITUDE), equals("numeric") )
       })
