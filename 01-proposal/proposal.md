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

``` r
library(dplyr)
```

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
seem likely to tighten in the lead up to the 2020
elections,\#\#\#logistic regression on whetehr they got citizenship or
not of those who applied… (what prop applied compared to overall. It
would be interesting to see what contributed to who applies
(Tackett)\#\#\#

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
  select(sex, relhead, yrborn, age, statebrn, marstat, edyrs, occ, hhincome, usstate1, usstatel, usplace1, usplacel, usdur1, usdurl, usdur1)%>%
  filter(hhincome != 9999 ,
           usstate1 != 9999,
         usstatel != 9999,
         usdur1 != 9999,
         usdurl != 9999)
imm
```

    ## # A tibble: 63,631 x 15
    ##      sex relhead yrborn   age statebrn marstat edyrs   occ hhincome
    ##    <dbl>   <dbl>  <dbl> <dbl>    <dbl>   <dbl> <dbl> <dbl>    <dbl>
    ##  1     2       2   1957    30       11       2     6    20     8888
    ##  2     2       3   1978     9       11       1     4    42     8888
    ##  3     2       3   1980     7       11       1     3    42     8888
    ##  4     2       3   1984     3       11       1     0    41     8888
    ##  5     2       3   1985     2       11       1     0    41     8888
    ##  6     2       3   1952    35       11       1     6   522     8888
    ##  7     1       3   1956    31       11       2     6   522     8888
    ##  8     1       3   1958    29       11       2     6   549     8888
    ##  9     2       3   1964    23       11       2     3    20     8888
    ## 10     2       3   1966    21       11       2     5    20     8888
    ## # … with 63,621 more rows, and 6 more variables: usstate1 <dbl>,
    ## #   usstatel <dbl>, usplace1 <dbl>, usplacel <dbl>, usdur1 <dbl>,
    ## #   usdurl <dbl>

``` r
data
```

    ## function (..., list = character(), package = NULL, lib.loc = NULL, 
    ##     verbose = getOption("verbose"), envir = .GlobalEnv, overwrite = TRUE) 
    ## {
    ##     fileExt <- function(x) {
    ##         db <- grepl("\\.[^.]+\\.(gz|bz2|xz)$", x)
    ##         ans <- sub(".*\\.", "", x)
    ##         ans[db] <- sub(".*\\.([^.]+\\.)(gz|bz2|xz)$", "\\1\\2", 
    ##             x[db])
    ##         ans
    ##     }
    ##     names <- c(as.character(substitute(list(...))[-1L]), list)
    ##     if (!is.null(package)) {
    ##         if (!is.character(package)) 
    ##             stop("'package' must be a character string or NULL")
    ##         if (any(package %in% "base")) 
    ##             warning("datasets have been moved from package 'base' to package 'datasets'")
    ##         if (any(package %in% "stats")) 
    ##             warning("datasets have been moved from package 'stats' to package 'datasets'")
    ##         package[package %in% c("base", "stats")] <- "datasets"
    ##     }
    ##     paths <- find.package(package, lib.loc, verbose = verbose)
    ##     if (is.null(lib.loc)) 
    ##         paths <- c(path.package(package, TRUE), if (!length(package)) getwd(), 
    ##             paths)
    ##     paths <- unique(normalizePath(paths[file.exists(paths)]))
    ##     paths <- paths[dir.exists(file.path(paths, "data"))]
    ##     dataExts <- tools:::.make_file_exts("data")
    ##     if (length(names) == 0L) {
    ##         db <- matrix(character(), nrow = 0L, ncol = 4L)
    ##         for (path in paths) {
    ##             entries <- NULL
    ##             packageName <- if (file_test("-f", file.path(path, 
    ##                 "DESCRIPTION"))) 
    ##                 basename(path)
    ##             else "."
    ##             if (file_test("-f", INDEX <- file.path(path, "Meta", 
    ##                 "data.rds"))) {
    ##                 entries <- readRDS(INDEX)
    ##             }
    ##             else {
    ##                 dataDir <- file.path(path, "data")
    ##                 entries <- tools::list_files_with_type(dataDir, 
    ##                   "data")
    ##                 if (length(entries)) {
    ##                   entries <- unique(tools::file_path_sans_ext(basename(entries)))
    ##                   entries <- cbind(entries, "")
    ##                 }
    ##             }
    ##             if (NROW(entries)) {
    ##                 if (is.matrix(entries) && ncol(entries) == 2L) 
    ##                   db <- rbind(db, cbind(packageName, dirname(path), 
    ##                     entries))
    ##                 else warning(gettextf("data index for package %s is invalid and will be ignored", 
    ##                   sQuote(packageName)), domain = NA, call. = FALSE)
    ##             }
    ##         }
    ##         colnames(db) <- c("Package", "LibPath", "Item", "Title")
    ##         footer <- if (missing(package)) 
    ##             paste0("Use ", sQuote(paste("data(package =", ".packages(all.available = TRUE))")), 
    ##                 "\n", "to list the data sets in all *available* packages.")
    ##         else NULL
    ##         y <- list(title = "Data sets", header = NULL, results = db, 
    ##             footer = footer)
    ##         class(y) <- "packageIQR"
    ##         return(y)
    ##     }
    ##     paths <- file.path(paths, "data")
    ##     for (name in names) {
    ##         found <- FALSE
    ##         for (p in paths) {
    ##             tmp_env <- if (overwrite) 
    ##                 envir
    ##             else new.env()
    ##             if (file_test("-f", file.path(p, "Rdata.rds"))) {
    ##                 rds <- readRDS(file.path(p, "Rdata.rds"))
    ##                 if (name %in% names(rds)) {
    ##                   found <- TRUE
    ##                   if (verbose) 
    ##                     message(sprintf("name=%s:\t found in Rdata.rds", 
    ##                       name), domain = NA)
    ##                   thispkg <- sub(".*/([^/]*)/data$", "\\1", p)
    ##                   thispkg <- sub("_.*$", "", thispkg)
    ##                   thispkg <- paste0("package:", thispkg)
    ##                   objs <- rds[[name]]
    ##                   lazyLoad(file.path(p, "Rdata"), envir = tmp_env, 
    ##                     filter = function(x) x %in% objs)
    ##                   break
    ##                 }
    ##                 else if (verbose) 
    ##                   message(sprintf("name=%s:\t NOT found in names() of Rdata.rds, i.e.,\n\t%s\n", 
    ##                     name, paste(names(rds), collapse = ",")), 
    ##                     domain = NA)
    ##             }
    ##             if (file_test("-f", file.path(p, "Rdata.zip"))) {
    ##                 warning("zipped data found for package ", sQuote(basename(dirname(p))), 
    ##                   ".\nThat is defunct, so please re-install the package.", 
    ##                   domain = NA)
    ##                 if (file_test("-f", fp <- file.path(p, "filelist"))) 
    ##                   files <- file.path(p, scan(fp, what = "", quiet = TRUE))
    ##                 else {
    ##                   warning(gettextf("file 'filelist' is missing for directory %s", 
    ##                     sQuote(p)), domain = NA)
    ##                   next
    ##                 }
    ##             }
    ##             else {
    ##                 files <- list.files(p, full.names = TRUE)
    ##             }
    ##             files <- files[grep(name, files, fixed = TRUE)]
    ##             if (length(files) > 1L) {
    ##                 o <- match(fileExt(files), dataExts, nomatch = 100L)
    ##                 paths0 <- dirname(files)
    ##                 paths0 <- factor(paths0, levels = unique(paths0))
    ##                 files <- files[order(paths0, o)]
    ##             }
    ##             if (length(files)) {
    ##                 for (file in files) {
    ##                   if (verbose) 
    ##                     message("name=", name, ":\t file= ...", .Platform$file.sep, 
    ##                       basename(file), "::\t", appendLF = FALSE, 
    ##                       domain = NA)
    ##                   ext <- fileExt(file)
    ##                   if (basename(file) != paste0(name, ".", ext)) 
    ##                     found <- FALSE
    ##                   else {
    ##                     found <- TRUE
    ##                     zfile <- file
    ##                     zipname <- file.path(dirname(file), "Rdata.zip")
    ##                     if (file.exists(zipname)) {
    ##                       Rdatadir <- tempfile("Rdata")
    ##                       dir.create(Rdatadir, showWarnings = FALSE)
    ##                       topic <- basename(file)
    ##                       rc <- .External(C_unzip, zipname, topic, 
    ##                         Rdatadir, FALSE, TRUE, FALSE, FALSE)
    ##                       if (rc == 0L) 
    ##                         zfile <- file.path(Rdatadir, topic)
    ##                     }
    ##                     if (zfile != file) 
    ##                       on.exit(unlink(zfile))
    ##                     switch(ext, R = , r = {
    ##                       library("utils")
    ##                       sys.source(zfile, chdir = TRUE, envir = tmp_env)
    ##                     }, RData = , rdata = , rda = load(zfile, 
    ##                       envir = tmp_env), TXT = , txt = , tab = , 
    ##                       tab.gz = , tab.bz2 = , tab.xz = , txt.gz = , 
    ##                       txt.bz2 = , txt.xz = assign(name, read.table(zfile, 
    ##                         header = TRUE, as.is = FALSE), envir = tmp_env), 
    ##                       CSV = , csv = , csv.gz = , csv.bz2 = , 
    ##                       csv.xz = assign(name, read.table(zfile, 
    ##                         header = TRUE, sep = ";", as.is = FALSE), 
    ##                         envir = tmp_env), found <- FALSE)
    ##                   }
    ##                   if (found) 
    ##                     break
    ##                 }
    ##                 if (verbose) 
    ##                   message(if (!found) 
    ##                     "*NOT* ", "found", domain = NA)
    ##             }
    ##             if (found) 
    ##                 break
    ##         }
    ##         if (!found) {
    ##             warning(gettextf("data set %s not found", sQuote(name)), 
    ##                 domain = NA)
    ##         }
    ##         else if (!overwrite) {
    ##             for (o in ls(envir = tmp_env, all.names = TRUE)) {
    ##                 if (exists(o, envir = envir, inherits = FALSE)) 
    ##                   warning(gettextf("an object named %s already exists and will not be overwritten", 
    ##                     sQuote(o)))
    ##                 else assign(o, get(o, envir = tmp_env, inherits = FALSE), 
    ##                   envir = envir)
    ##             }
    ##             rm(tmp_env)
    ##         }
    ##     }
    ##     invisible(names)
    ## }
    ## <bytecode: 0x7ffb6e4ea640>
    ## <environment: namespace:utils>

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
