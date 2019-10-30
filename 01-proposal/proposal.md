Characteristics of Immigrants to the US by Type of Immigration Status
================
Ben 10
October 27, 2019

``` r
library(readr)
library(knitr)
library(tidyverse)
```

    ## ── Attaching packages ───────────────────────────────── tidyverse 1.2.1 ──

    ## ✔ ggplot2 3.2.1     ✔ purrr   0.3.2
    ## ✔ tibble  2.1.3     ✔ dplyr   0.8.3
    ## ✔ tidyr   0.8.3     ✔ stringr 1.4.0
    ## ✔ ggplot2 3.2.1     ✔ forcats 0.4.0

    ## ── Conflicts ──────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

``` r
library(dplyr)
```

## Section 1. Introduction

In recent years, immigration has been a topic of intense controversy.
Given the complexity of immigration law, we are interested in examining
patterns in immigration since the beginning of the millenia. The U.S.
stance on immigration has grown increasingly strict, not only for
“illegal” immigration, but also for legal immigration: naturalization,
visa use, lawful permanent residency, refugee status, and asylum
seekers. For example, the number of refugees accepted to the US fell to
22,491 in 2018 from 84,994 in 2016 according to the Department of State,
likely as a result of hard line policies against refugees coming to the
US. As immigration policies seem likely to tighten in the lead up to the
2020 elections,\#\#\#logistic regression on whetehr they got citizenship
or not of those who applied… (what prop applied compared to overall. It
would be interesting to see what contributed to who applies
(Tackett)\#\#\#

Given the variety of ways to immigrate legally, and the varying
processes and timelines for each, we would expect that the
characteristics of immigrants using each pathway to differ. By examining
the demographics of each immigration pathway, we can determine the
trends, if any, that exist in the current immigration infrastructure.

Our research project aims to determine the differences in
characteristics between different classes of legal immigration. We
hypothesize that there exist statistically significant differences in
the populations which recieve different types of visa, and we
particularly are interested in region of origin as a way to identify
populations that may be targeted by federal policy.

## Section 2: Exploratory Data Analysis

## Section 2. Analysis plan

``` r
data <- read_csv(paste0("/cloud/project/02-data/data.csv"))
```

    ## Warning: Missing column names filled in: 'X1' [1]

    ## Parsed with column specification:
    ## cols(
    ##   X1 = col_double(),
    ##   sex = col_double(),
    ##   relhead = col_double(),
    ##   yrborn = col_double(),
    ##   age = col_double(),
    ##   statebrn = col_double(),
    ##   marstat = col_double(),
    ##   edyrs = col_double(),
    ##   occ = col_double(),
    ##   hhincome = col_double(),
    ##   usstate1 = col_double(),
    ##   usstatel = col_double(),
    ##   usplace1 = col_double(),
    ##   usplacel = col_double(),
    ##   usdur1 = col_double(),
    ##   usdurl = col_double()
    ## )

``` r
data
```

    ## # A tibble: 2,840 x 16
    ##       X1   sex relhead yrborn   age statebrn marstat edyrs   occ hhincome
    ##    <dbl> <dbl>   <dbl>  <dbl> <dbl>    <dbl>   <dbl> <dbl> <dbl>    <dbl>
    ##  1     1     1       1   1938    49       11       2     3   522   250000
    ##  2     2     1       1   1928    59       11       2     3   522   200000
    ##  3     3     1       1   1950    37       11       1     6   410  1440000
    ##  4     4     1       1   1946    41       11       2     6   522   300000
    ##  5     5     1       1   1956    31       11       2     6   142   300000
    ##  6     6     1       1   1921    66       14       2     0   529   200000
    ##  7     7     1       1   1914    73       11       2     0   830   240000
    ##  8     8     1       1   1932    55       11       2     6   719    90000
    ##  9     9     1       1   1945    42       11       3     6   559   200000
    ## 10    10     1       1   1945    42       11       2     6   819   300000
    ## # … with 2,830 more rows, and 6 more variables: usstate1 <dbl>,
    ## #   usstatel <dbl>, usplace1 <dbl>, usplacel <dbl>, usdur1 <dbl>,
    ## #   usdurl <dbl>

## Section 3. Regression Analysis Plan

Description of the approach you will use to model the data. This
includes

Interactions you will consider Model selection procedure Regression
modeling technique you will use and an explanation about why that method
was chosen.

In an effort to determine which characteristics of candidates influence
their approval of a visa, we will be using a logistic regression model.
Since our response variable is categorical (i.e., approved or denied),
this is the best model at our disposal for us to use.

## Section 4. References

Use the glimpse function print a summary of the data frame at the end of
your proposal. Place your data in the /data folder, and add dimensions
(number of observations and variables) and the data dictionary (a
description of every variable in the dataset) to the README in the
folder. Make sure the data dictionary is neatly formatted and easy to
read.

Sources:

Statistic used in Introduction: RPC. (January 31, 2019). Number of
refugee admissions in the U.S. from the fiscal year of 1990 to the
fiscal year of 2018 \[Graph\]. In Statista. Retrieved October 29, 2019,
from
<https://www-statista-com.proxy.lib.duke.edu/statistics/200061/number-of-refugees-arriving-in-the-us/>

## The Data
