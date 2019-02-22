[![Build Status](https://travis-ci.org/AndersonUyekita/JHU_MSDR_Capstone.svg?branch=master)](https://travis-ci.org/AndersonUyekita/JHU_MSDR_Capstone)

# Mastering Software Development in R Specialization Capstone

#### Tags
* Author       : AH Uyekita
* Date         : 21/fev/2019
* Course       : Mastering Software Development in R Specialization Capstone
* Project      : Capstone Project
    * COD      : MSDR
    * Instructor: Roger D. Peng
    * Instructor: Brooke Anderson

#### Installation

You can use this package installing it by the use of [`devtools`][url_devtools] library from R.

```
# R terminal
devtools::install_github("AndersonUyekita/JHU_MSDR_Capstone")
```

[url_devtools]: https://cran.r-project.org/web/packages/devtools/index.html

#### Vignettes

I have disclosed the principal Vignette in the RPubs.

* <a href="http://rpubs.com/AndersonUyekita/vignette_mastering_software_development_in_r" target="_blank">MSDR Vignette</a>

#### Bookdown

_Underconstruction._

********************************************************************************

## Introduction

This package is the outcome of the Mastering Software Development in R Capstone.

#### Description

The package is tailored to work with the [NOAA][noaa_website] (National Oceanic Atmospheric Administration) [Earthquake database][noaa_earthquake].

[noaa_website]: https://www.ngdc.noaa.gov
[noaa_earthquake]: https://www.ngdc.noaa.gov/nndc/struts/form?t=101650&s=1&d=1

#### Objectivies

Development a new package capable to plot a timeline using the ggplot2 as bedrock. I have also created a function to deal with maps ([OpenStreet maps][openstreet_url]) and earthquake information.

[openstreet_url]: https://www.openstreetmap.org

## Examples

Some simple examples using the package.

#### Timeline

This example shows how to use `eq_clean_data`, `geom_timeline`, `geom_timeline_label`, and `theme_msdr`.

```r
# Loading the data.
df_clean <- eq_clean_data(file_name = raw_data_path)

# Subsetting the df_clean to select some countries in Asia.
df_asia <- df_clean %>%
       dplyr::filter(COUNTRY %in% c("INDONESIA","THAILAND", "MYANMAR (BURMA)", "JAPAN"),
                     YEAR > 2000 & YEAR <= 2019)

# Plotting.
df_asia %>%
       ggplot2::ggplot() +
              # Defining the aes.
              geom_timeline(aes(x = DATE,
                                y = COUNTRY,
                                size = EQ_PRIMARY,
                                color = TOTAL_DEATHS) +
       # Adding theme
       msdr::theme_msdr() +
              # Editing the legends' titles
              labs(color = "# deaths",
                   size = "Richter scale value") +

       # Adding annotations
       geom_timeline_label(aes(x = DATE,
                               label = LOCATION,
                               y = COUNTRY,
                               mag = EQ_PRIMARY,
                               n_max = 10))
```

<img src="01-img/01.png"/>

You can find more examples of use in the vignette.

#### OpenStreet Maps and Annotations

This example makes use of `eq_map` and `eq_create_label`.

```r
# Creating a new data.
df_america <- df_clean %>% dplyr::filter(COUNTRY %in% c('USA','MEXICO','CANADA'),
                                         YEAR > 1990 & YEAR < 2019)

# Creating a complex texts using the eq_create_label.
df_america %>%
       dplyr::mutate(popup_text = eq_create_label(.)) %>%
              eq_map(annot_col = 'popup_text')
```
<img src="01-img/02.png"/>

You can also find more examples in the vignette.

***

## References

Soon I will move it to the Bookdown.

#### The Complete ggplot2 Tutorial - Part 2 | How To Customize ggplot2 (Full R code)

[Source][ref_19]

[ref_19]: http://r-statistics.co/Complete-Ggplot2-Tutorial-Part2-Customizing-Theme-With-R-Code.html

#### Extension of ggplot2

This post is the most informative. Has a lot of examples. The best one is that of new points_geom.

[Source][ref_16]

[ref_16]: https://cran.r-project.org/web/packages/ggplot2/vignettes/extending-ggplot2.html


#### Write your own R package, Part Two

[Source][ref_15]

[ref_15]: http://stat545.com/packages05_foofactors-package-02.html


#### Line Grob

The simplest documentation aboute Line Grob.

[Source][ref_14]

[ref_14]: https://stat.ethz.ch/R-manual/R-devel/library/grid/html/grid.lines.html

#### Theme

General information about theme. It is very good because has all components names.

[Source 1][ref_17]
[Source 2][ref_18]

[ref_17]: https://ggplot2.tidyverse.org/reference/element.html
[ref_18]: https://ggplot2.tidyverse.org/reference/theme.html


#### Build a plot layer by layer

This post in RPubs was very informative to understand how to plot a `Geom` without the use of a `geom_*`.

The excert I have read:

```r
p + layer(
  mapping = NULL,
  data = NULL,
  geom = "point", geom_params = list(),
  stat = "identity", stat_params = list(),
  position = "identity"
)
```
I have plotted some graphics in this way above.

>mapping: A set of aesthetic mappings, specified using the aes() function and combined with the plot defaults as described in aesthetic mappings. If NULL, uses the default mapping set in ggplot().

This part is the most important for me. We I have realized how to plot my own `geoms` using `ggplot2::layer()`.

[Source][ref_07]

[ref_07]: https://rpubs.com/hadley/ggplot2-layers


#### Data in Packages

I have read something interesting in the Karl Broman website about how to store raw data in a Package.

[Source 1][ref_03]
[Source 2][ref_04]

[ref_03]: http://kbroman.org/pkg_primer/pages/data.html
[ref_04]: https://github.com/kbroman/qtlcharts/tree/master/R

Other source I have found is the Hadley website. This one talk about the raw data and internal data.

[Source 3][ref_05]

[ref_05]: http://r-pkgs.had.co.nz/data.html

Kassambara also has a good site.

[Source 4][ref_06]

[ref_06]: http://www.sthda.com/english/wiki/saving-data-into-r-data-format-rds-and-rdata

#### testthat

```r
# Creates a generic test file.
usethis::use_test("name")
```

[testthat][ref_01]

[ref_01]: https://testthat.r-lib.org

I have tested my package using the function:

```r
# Run all test files in the path `tests/testthat`
test_dir(path = 'tests/testthat')
```
Reading the book from Peng R. I have used this part to create my own tests.

```r
test_that("model fitting", {
        data(airquality)
        fit <- lm(Ozone ~ Wind, data = airquality)
        expect_that(fit, is_a("lm"))
        expect_that(1 + 1, equals(2))
})
```
[Source - 3.6.1][ref_08]

[ref_08]: https://bookdown.org/rdpeng/RProgDA/software-testing-framework-for-r-packages.html


#### Tracis CI

I have added manually the file `.travis.yml` using the terminal

```
touch .travis.yml
```
Later I have edited this file and inserted
```
# R for travis: see documentation at https://docs.travis-ci.com/user/languages/r

language: R
sudo: false
cache: packages
```
[source][ref_02]

[ref_02]: https://docs.travis-ci.com/user/languages/r

After insert this file the `devtools::check` start to show a `Note`, but you can eliminate this `Note` adding to the `.Rbuildignore` the Travis file.

```
^LICENSE\.md$
^.*\.Rproj$
^\.Rproj\.user$
.travis.yml
```

#### Vignettes

You can create a vignette using the command

```r
# Creates a vignette called `my-vignette`
devtools::use_vignette("my-vignette")
```
I have prefered create a vignette using the `File > New File > RMarkdown > From Template > Lightweight and Pretty Vignette (HTML)`. This vignette template is nicer than the generic and oldfashioned original template.

However, there is a shortcomming of using prettydoc, because you need to add the package prettydoc in the `DESCRIPTION`, if not the TRAVIS CI will fail, due to the lack of this package when the vignettes will be create.

#### Leaflet

This package is in charge of plot maps. Generic plot:

```r
m <- leaflet()
m <- addTiles(m)
m <- addMarkers(m, lng=174.768, lat=-36.852, popup="The birthplace of R")
m
```
[Source][ref_09]

[ref_09]: http://rstudio.github.io/leaflet/

*Plotting Circles*

This site shows how to plot circles.

```r
leaflet(cities) %>% addTiles() %>%
  addCircles(lng = ~Long, lat = ~Lat, weight = 1,
    radius = ~sqrt(Pop) * 30, popup = ~City
  )
```
[Source 1][ref_10]
[Source 2][ref_11]

[ref_10]: https://rstudio.github.io/leaflet/shapes.html
[ref_11]: https://rstudio.github.io/leaflet/markers.html

*Content in Popup*

This website shows how to plot several information in a bubble.

```
content <- paste(sep = "<br/>",
  "<b><a href='http://www.samurainoodle.com'>Samurai Noodle</a></b>",
  "606 5th Ave. S",
  "Seattle, WA 98138"
)

leaflet() %>% addTiles() %>%
  addPopups(-122.327298, 47.597131, content,
    options = popupOptions(closeButton = FALSE)
  )
```

As you can see, I need to use html to write all of the content.

[Source][ref_12]

[ref_12]: https://rstudio.github.io/leaflet/popups.html

#### devtools

Good guide to follow.

[devtools README][ref_21]

[ref_21]: https://github.com/r-lib/devtools/blob/master/README.md
