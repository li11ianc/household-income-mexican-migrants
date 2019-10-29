Characteristics of Immigrants to the US by Type of Immigration Status
================
Ben 10
October 27, 2019

``` r
library(readr)
library(knitr)
library(tidyverse)
```

    ## ── Attaching packages ──────────────────────────────────────────────────────────────────────────────── tidyverse 1.2.1 ──

    ## ✔ ggplot2 3.2.1     ✔ purrr   0.3.2
    ## ✔ tibble  2.1.3     ✔ dplyr   0.8.3
    ## ✔ tidyr   0.8.3     ✔ stringr 1.4.0
    ## ✔ ggplot2 3.2.1     ✔ forcats 0.4.0

    ## ── Conflicts ─────────────────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

## Section 1. Introduction

In recent years, immigration has been a topic of intense controversy.
Given the complexity of immigration law, it is of interest to examine
patterns in immigration since the beginning of the millenia. The US
stance on immigration has grown increasingly strict, not only for
“illegal” immigration, but for legal immigration, such as
naturalization, visa use, lawful permanent residency (also referred to
as green card use), refugee status, and asylum seekers. For example, the
number of refugees accepted to the US fell to 22,491 in 2018 from 84,994
in 2016 according to the Department of State, likely as a result of hard
line policies against refugees coming to the US. As immigration policies
seem likely to tighten in the lead up to the 2020 elections, it seems
likely that selected policies against certain pathways will adversely
affect specific groups of people as opposed to all immigrant groups
equally.

Given the variety of ways to immigrate legally, and the varying
processes and timelines for each, we would expect that the
characteristics of immigrants using each pathway to differ. By examining
the demographics of each immigration pathway, we can determine the
trends, if any, that exist in the current immigration infrastructure.
Determining, for example, those paths to immigration which are most
vital for at risk groups of people, may aid in future analysis of
federal administrative policies.

Our research project aims to determine the differences in
characteristics between different classes of legal immigration. We
hypothesize that there exist statistically significant differences in
the populations which recieve different types of visa, and we
particularly are interested in region of origin as a way to identify
populations that may be targeted by federal policy.

## Section 2: Exploratory Data Analysis

## Section 2. Analysis plan

``` r
pers170 <- read_csv(paste0("/Users/qintianzhang/Downloads/pers170.csv"))
```

    ## Parsed with column specification:
    ## cols(
    ##   .default = col_logical(),
    ##   country = col_double(),
    ##   commun = col_double(),
    ##   surveypl = col_double(),
    ##   surveyyr = col_double(),
    ##   hhnum = col_double(),
    ##   persnum = col_double(),
    ##   inform = col_double(),
    ##   hhmemshp = col_double(),
    ##   weight = col_double(),
    ##   sex = col_double(),
    ##   relhead = col_double(),
    ##   yrborn = col_double(),
    ##   yrdead = col_double(),
    ##   age = col_double(),
    ##   statebrn = col_double(),
    ##   placebrn = col_double(),
    ##   marstat = col_double(),
    ##   edyrs = col_double(),
    ##   occ = col_double(),
    ##   hhincome = col_double()
    ##   # ... with 37 more columns
    ## )

    ## See spec(...) for full column specifications.

    ## Warning: 2830954 parsing failures.
    ##  row      col           expected actual                                        file
    ## 3363 legyrapp 1/0/T/F/TRUE/FALSE   1986 '/Users/qintianzhang/Downloads/pers170.csv'
    ## 3363 legspon  1/0/T/F/TRUE/FALSE   5    '/Users/qintianzhang/Downloads/pers170.csv'
    ## 3364 legyrapp 1/0/T/F/TRUE/FALSE   1964 '/Users/qintianzhang/Downloads/pers170.csv'
    ## 3364 legspon  1/0/T/F/TRUE/FALSE   3    '/Users/qintianzhang/Downloads/pers170.csv'
    ## 3365 legyrapp 1/0/T/F/TRUE/FALSE   8888 '/Users/qintianzhang/Downloads/pers170.csv'
    ## .... ........ .................. ...... ...........................................
    ## See problems(...) for more details.

``` r
imm <- pers170 %>%
  select(sex, relhead, yrborn, age, statebrn, marstat, edyrs, occ, hhincome, ldowage, health, healthly, healthnw)
imm %>%
  filter(hhincome != 9999, hhincome != 8888)
```

    ## # A tibble: 7,351 x 13
    ##      sex relhead yrborn   age statebrn marstat edyrs   occ hhincome ldowage
    ##    <dbl>   <dbl>  <dbl> <dbl>    <dbl>   <dbl> <dbl> <dbl>    <dbl>   <dbl>
    ##  1     1       1   1928    59       11       2     0    50        0      NA
    ##  2     2       1   1932    55       11       4     0    20        0      NA
    ##  3     1       1   1938    49       11       2     3   522   250000      NA
    ##  4     2       1   1914    73       11       1     1   549   700000      NA
    ##  5     1       1   1928    59       11       2     3   522   200000      NA
    ##  6     1       1   1920    67       11       2     0   410   240000      NA
    ##  7     1       1   1944    43       11       2     3   410   240000      NA
    ##  8     1       1   1947    40       11       2     3   529   240000      NA
    ##  9     1       1   1951    36       11       2     3   529   350000      NA
    ## 10     1       1   1950    37       11       1     6   410  1440000      NA
    ## # … with 7,341 more rows, and 3 more variables: health <lgl>,
    ## #   healthly <lgl>, healthnw <lgl>

``` r
imm %>%
  filter(!is.na(health))
```

    ## # A tibble: 46 x 13
    ##      sex relhead yrborn   age statebrn marstat edyrs   occ hhincome ldowage
    ##    <dbl>   <dbl>  <dbl> <dbl>    <dbl>   <dbl> <dbl> <dbl>    <dbl>   <dbl>
    ##  1     2       1   1966    41       17       3    12   721       NA    1000
    ##  2     2       2   1956    51       17       2     6    20       NA       0
    ##  3     2       1   1952    55       17       4     6    20       NA     500
    ##  4     1       1   1970    37       17       2     9   410       NA    9999
    ##  5     1       1   1977    30       17       2    17   113       NA    3000
    ##  6     2       2   1975    32       17       2    12    20       NA    4000
    ##  7     1       1   1964    43       14       2     6   215       NA     200
    ##  8     2       2   1982    25       14       2     4    20       NA    1300
    ##  9     2       1   1953    54       14       6     6    20       NA    9999
    ## 10     2       2   1955    52       14       2    12   710       NA    9999
    ## # … with 36 more rows, and 3 more variables: health <lgl>, healthly <lgl>,
    ## #   healthnw <lgl>

## Section 3. Regression Analysis Plan

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
