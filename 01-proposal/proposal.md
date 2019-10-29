Characteristics of Immigrants to the US by Type of Immigration Status
================
Ben 10
October 27, 2019

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

``` r
library(readxl)
dat <- readxl::read_xlsx(paste0("/cloud/project/02-data/fy2017_immsuptable1d.xlsx"))
```

    ## New names:
    ## * `` -> ...2
    ## * `` -> ...3
    ## * `` -> ...4
    ## * `` -> ...5
    ## * `` -> ...6
    ## * … and 52 more problems

``` r
dat
```

    ## # A tibble: 236 x 58
    ##    `Supplemental T… ...2  ...3  ...4  ...5  ...6  ...7  ...8  ...9  ...10
    ##    <chr>            <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr>
    ##  1 PERSONS OBTAINI… <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA> 
    ##  2 <NA>             <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA> 
    ##  3 Region and coun… Total Alab… Alas… Ariz… Arka… Cali… Colo… Conn… Dela…
    ##  4 REGION           <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA> 
    ##  5 Total            1127… 3801  1547  19344 3071  2142… 14520 11938 2244 
    ##  6 Africa           1188… 395   198   1932  182   6938  2371  1077  431  
    ##  7 Asia             4247… 1894  730   5178  1116  1105… 4834  3728  802  
    ##  8 Europe           84335 268   203   854   134   13617 1192  1614  157  
    ##  9 North America    4136… 1047  306   10786 1502  75427 5460  3649  731  
    ## 10 Oceania          5071  15    40    82    8     1802  115   38    D    
    ## # … with 226 more rows, and 48 more variables: ...11 <chr>, ...12 <chr>,
    ## #   ...13 <chr>, ...14 <chr>, ...15 <chr>, ...16 <chr>, ...17 <chr>,
    ## #   ...18 <chr>, ...19 <chr>, ...20 <chr>, ...21 <chr>, ...22 <chr>,
    ## #   ...23 <chr>, ...24 <chr>, ...25 <chr>, ...26 <chr>, ...27 <chr>,
    ## #   ...28 <chr>, ...29 <chr>, ...30 <chr>, ...31 <chr>, ...32 <chr>,
    ## #   ...33 <chr>, ...34 <chr>, ...35 <chr>, ...36 <chr>, ...37 <chr>,
    ## #   ...38 <chr>, ...39 <chr>, ...40 <chr>, ...41 <chr>, ...42 <chr>,
    ## #   ...43 <chr>, ...44 <chr>, ...45 <chr>, ...46 <chr>, ...47 <chr>,
    ## #   ...48 <chr>, ...49 <chr>, ...50 <chr>, ...51 <chr>, ...52 <chr>,
    ## #   ...53 <chr>, ...54 <chr>, ...55 <chr>, ...56 <chr>, ...57 <chr>,
    ## #   ...58 <chr>

## Section 2. Analysis plan

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
