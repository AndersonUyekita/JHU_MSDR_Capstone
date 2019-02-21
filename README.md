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

#### RPubs



#### Bookdown



********************************************************************************

##




##



## References


#### testthat

```r
# Creates a generic test file.
usethis::use_test("name")
```

[testthat][ref_01]

[ref_01]: https://testthat.r-lib.org

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

After insert this file the `devtools::check` start to show a `Note` problem.
