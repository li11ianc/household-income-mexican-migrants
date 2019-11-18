Characteristics of Recent Mexican Immigrants to the United States that
Influence Household Income
================
Ben 10
November 20, 2019

<<<<<<< HEAD
    ## ── Attaching packages ────────────────────────────────────────────────────────── tidyverse 1.2.1 ──
=======
    ## ── Attaching packages ───────────────────────────────── tidyverse 1.2.1 ──
>>>>>>> bf340854b3317a590baadf142556c012628451b7

    ## ✔ ggplot2 3.2.1     ✔ purrr   0.3.2
    ## ✔ tibble  2.1.3     ✔ dplyr   0.8.3
    ## ✔ tidyr   0.8.3     ✔ stringr 1.4.0
    ## ✔ readr   1.3.1     ✔ forcats 0.4.0

<<<<<<< HEAD
    ## ── Conflicts ───────────────────────────────────────────────────────────── tidyverse_conflicts() ──
=======
    ## ── Conflicts ──────────────────────────────────── tidyverse_conflicts() ──
>>>>>>> bf340854b3317a590baadf142556c012628451b7
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

    ## Parsed with column specification:
    ## cols(
    ##   X1 = col_double(),
    ##   sex = col_character(),
    ##   relhead = col_double(),
    ##   yrborn = col_double(),
    ##   age = col_double(),
    ##   statebrn = col_character(),
    ##   marstat = col_character(),
    ##   edyrs = col_double(),
    ##   occ = col_double(),
    ##   hhincome = col_double(),
    ##   usstate1 = col_character(),
    ##   usstatel = col_character(),
    ##   usplace1 = col_double(),
    ##   usplacel = col_double(),
    ##   usdur1 = col_double(),
    ##   usdurl = col_double(),
    ##   usdoc1 = col_character(),
    ##   occtype = col_character(),
    ##   uscity = col_character()
    ## )

    ## # A tibble: 2,805 x 19
    ##       X1 sex   relhead yrborn   age statebrn marstat edyrs   occ hhincome
    ##    <dbl> <chr>   <dbl>  <dbl> <dbl> <chr>    <chr>   <dbl> <dbl>    <dbl>
    ##  1     1 M           1   1938    49 Guanaju… Married     3   522   250000
    ##  2     2 M           1   1928    59 Guanaju… Married     3   522   200000
    ##  3     3 M           1   1950    37 Guanaju… Never …     6   410  1440000
    ##  4     4 M           1   1946    41 Guanaju… Married     6   522   300000
    ##  5     5 M           1   1956    31 Guanaju… Married     6   142   300000
    ##  6     6 M           1   1921    66 Jalisco  Married     0   529   200000
    ##  7     7 M           1   1914    73 Guanaju… Married     0   830   240000
    ##  8     8 M           1   1932    55 Guanaju… Married     6   719    90000
    ##  9     9 M           1   1945    42 Guanaju… Consen…     6   559   200000
    ## 10    10 M           1   1945    42 Guanaju… Married     6   819   300000
    ## # … with 2,795 more rows, and 9 more variables: usstate1 <chr>,
    ## #   usstatel <chr>, usplace1 <dbl>, usplacel <dbl>, usdur1 <dbl>,
    ## #   usdurl <dbl>, usdoc1 <chr>, occtype <chr>, uscity <chr>

## 1\. Introduction

We are aiming to discover what characteristics of Mexican immmigrants to
the United States, specifically California, influence their projected
household income. We will be building a multiple linear regression model
to predict household income considering the following variables: `sex`,
`relhead`, `age`, `statebrn`, `marstat`, `edyrs`, `occtype`, `usdur1`,
`usdurl`, `usdoc1`, `uscity`, `yrborn`.

Our response variable is household income: the total income for a single
household, reported in
    $USD.

## 2\. Exploratory Data Analysis

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](regression-analysis_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

Originally, the distribution of log(Household Income)- our response
variable- was bimodal and had a mean of 412,647 dollars. We determined
that this is an absurdly high median income for a survey of largely
undocumented immigrants in the US and believe that a significant chunk
of the high incomes were actually recorded in pesos. We will filter out
the incomes above 60,000 to remove what appears to be a second
distribution of incomes in pesos. We will also remove incomes of zero
from our
    dataset.

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](regression-analysis_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

![](regression-analysis_files/figure-gfm/cities-1.png)<!-- --> These
immigrants to California arrived to the following cities: Los
Angeles-Long Beach, San Francisco, San Diego, Santa Cruz-Watsonville,
Bakersfield, Fresno, Merced, Orange County, Riverside-San Bernardino,
Sacramento, San Jose, Santa Barbara-Santa Maria-Lompoc,
Vallejo-Fairfield-Napa, and Ventura. Given the comparatively small
number of cases in which no city was reported, we deleted these
instances. This leaves 15 unique locations in California. The majority
of immigrants went to LA-Long Beach area.

It turned out that all values from relhead in our cleaned data were “1”
or head. So we will remove this variable, as well as state variables
since we are only using California data. We will also remove place data
since we are using uscity, and occ since we are using occtype.

## 2\. Multiple Linear Regression Model

In an effort to determine which characteristics of candidates influence
their household income, we will be using a multiple linear regression
model. Since our response variable is numerical with mulitple potential
predictors, this is the best model at our disposal for us to use.

We will consider the potential interaction between principal occupation
and number of years of school completed, since those are generally
interconnected. We may also consider the interaction between
documentation type and occupation type, although the effect may be
insignificant.

We will select our model using AIC criteria, because since we’re dealing
with people, we want to build a model that accounts for volatile human
nature and the ever-changing socioeconomic and political climate that
could influence someone’s household income. AIC is used when we would
rather say a variable is a relevant predictor, when in reality it might
not be and so in this case, we would rather err on the side of a false
positive because we are dealing with a constantly fluctuating issue.

### 2.1 Full Model

<table>

<thead>

<tr>

<th style="text-align:left;">

term

</th>

<th style="text-align:right;">

estimate

</th>

<th style="text-align:right;">

std.error

</th>

<th style="text-align:right;">

statistic

</th>

<th style="text-align:right;">

p.value

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

(Intercept)

</td>

<td style="text-align:right;">

52154.401

</td>

<td style="text-align:right;">

28709.846

</td>

<td style="text-align:right;">

1.817

</td>

<td style="text-align:right;">

0.070

</td>

</tr>

<tr>

<td style="text-align:left;">

X1

</td>

<td style="text-align:right;">

\-0.143

</td>

<td style="text-align:right;">

0.064

</td>

<td style="text-align:right;">

\-2.239

</td>

<td style="text-align:right;">

0.026

</td>

</tr>

<tr>

<td style="text-align:left;">

sexM

</td>

<td style="text-align:right;">

311.825

</td>

<td style="text-align:right;">

185.401

</td>

<td style="text-align:right;">

1.682

</td>

<td style="text-align:right;">

0.093

</td>

</tr>

<tr>

<td style="text-align:left;">

yrborn

</td>

<td style="text-align:right;">

\-25.954

</td>

<td style="text-align:right;">

14.446

</td>

<td style="text-align:right;">

\-1.797

</td>

<td style="text-align:right;">

0.073

</td>

</tr>

<tr>

<td style="text-align:left;">

age

</td>

<td style="text-align:right;">

\-18.359

</td>

<td style="text-align:right;">

14.809

</td>

<td style="text-align:right;">

\-1.240

</td>

<td style="text-align:right;">

0.216

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnChihuahua

</td>

<td style="text-align:right;">

\-147.000

</td>

<td style="text-align:right;">

626.866

</td>

<td style="text-align:right;">

\-0.234

</td>

<td style="text-align:right;">

0.815

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnCoahuila

</td>

<td style="text-align:right;">

1527.583

</td>

<td style="text-align:right;">

812.616

</td>

<td style="text-align:right;">

1.880

</td>

<td style="text-align:right;">

0.061

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnColima

</td>

<td style="text-align:right;">

75.450

</td>

<td style="text-align:right;">

375.507

</td>

<td style="text-align:right;">

0.201

</td>

<td style="text-align:right;">

0.841

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnGuanajuato

</td>

<td style="text-align:right;">

\-44.063

</td>

<td style="text-align:right;">

381.527

</td>

<td style="text-align:right;">

\-0.115

</td>

<td style="text-align:right;">

0.908

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnGuerrero

</td>

<td style="text-align:right;">

528.551

</td>

<td style="text-align:right;">

393.076

</td>

<td style="text-align:right;">

1.345

</td>

<td style="text-align:right;">

0.179

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnJalisco

</td>

<td style="text-align:right;">

61.352

</td>

<td style="text-align:right;">

374.920

</td>

<td style="text-align:right;">

0.164

</td>

<td style="text-align:right;">

0.870

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnMexico City

</td>

<td style="text-align:right;">

379.421

</td>

<td style="text-align:right;">

441.742

</td>

<td style="text-align:right;">

0.859

</td>

<td style="text-align:right;">

0.391

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnMichoacán

</td>

<td style="text-align:right;">

21.365

</td>

<td style="text-align:right;">

373.902

</td>

<td style="text-align:right;">

0.057

</td>

<td style="text-align:right;">

0.954

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnNayarit

</td>

<td style="text-align:right;">

162.949

</td>

<td style="text-align:right;">

380.642

</td>

<td style="text-align:right;">

0.428

</td>

<td style="text-align:right;">

0.669

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnOaxaca

</td>

<td style="text-align:right;">

616.645

</td>

<td style="text-align:right;">

389.246

</td>

<td style="text-align:right;">

1.584

</td>

<td style="text-align:right;">

0.114

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnPuebla

</td>

<td style="text-align:right;">

400.104

</td>

<td style="text-align:right;">

620.948

</td>

<td style="text-align:right;">

0.644

</td>

<td style="text-align:right;">

0.520

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnSan Luis Potosí

</td>

<td style="text-align:right;">

369.232

</td>

<td style="text-align:right;">

380.919

</td>

<td style="text-align:right;">

0.969

</td>

<td style="text-align:right;">

0.333

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnTamaulipas

</td>

<td style="text-align:right;">

\-1.552

</td>

<td style="text-align:right;">

622.034

</td>

<td style="text-align:right;">

\-0.002

</td>

<td style="text-align:right;">

0.998

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnVeracruz

</td>

<td style="text-align:right;">

548.069

</td>

<td style="text-align:right;">

525.278

</td>

<td style="text-align:right;">

1.043

</td>

<td style="text-align:right;">

0.297

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnZacatecas

</td>

<td style="text-align:right;">

476.895

</td>

<td style="text-align:right;">

371.658

</td>

<td style="text-align:right;">

1.283

</td>

<td style="text-align:right;">

0.200

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatDivorced

</td>

<td style="text-align:right;">

92.603

</td>

<td style="text-align:right;">

217.609

</td>

<td style="text-align:right;">

0.426

</td>

<td style="text-align:right;">

0.671

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatMarried

</td>

<td style="text-align:right;">

41.287

</td>

<td style="text-align:right;">

116.258

</td>

<td style="text-align:right;">

0.355

</td>

<td style="text-align:right;">

0.723

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatNever married

</td>

<td style="text-align:right;">

\-184.547

</td>

<td style="text-align:right;">

161.941

</td>

<td style="text-align:right;">

\-1.140

</td>

<td style="text-align:right;">

0.255

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatSeparated

</td>

<td style="text-align:right;">

49.557

</td>

<td style="text-align:right;">

231.409

</td>

<td style="text-align:right;">

0.214

</td>

<td style="text-align:right;">

0.831

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatWidowed

</td>

<td style="text-align:right;">

84.934

</td>

<td style="text-align:right;">

242.984

</td>

<td style="text-align:right;">

0.350

</td>

<td style="text-align:right;">

0.727

</td>

</tr>

<tr>

<td style="text-align:left;">

edyrs

</td>

<td style="text-align:right;">

16.118

</td>

<td style="text-align:right;">

8.050

</td>

<td style="text-align:right;">

2.002

</td>

<td style="text-align:right;">

0.046

</td>

</tr>

<tr>

<td style="text-align:left;">

usdur1

</td>

<td style="text-align:right;">

\-0.074

</td>

<td style="text-align:right;">

0.425

</td>

<td style="text-align:right;">

\-0.175

</td>

<td style="text-align:right;">

0.861

</td>

</tr>

<tr>

<td style="text-align:left;">

usdurl

</td>

<td style="text-align:right;">

0.535

</td>

<td style="text-align:right;">

0.377

</td>

<td style="text-align:right;">

1.421

</td>

<td style="text-align:right;">

0.156

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Legal resident

</td>

<td style="text-align:right;">

87.121

</td>

<td style="text-align:right;">

152.863

</td>

<td style="text-align:right;">

0.570

</td>

<td style="text-align:right;">

0.569

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Temporary: Tourist/visitor

</td>

<td style="text-align:right;">

13.013

</td>

<td style="text-align:right;">

156.097

</td>

<td style="text-align:right;">

0.083

</td>

<td style="text-align:right;">

0.934

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Undocumented

</td>

<td style="text-align:right;">

11.711

</td>

<td style="text-align:right;">

125.106

</td>

<td style="text-align:right;">

0.094

</td>

<td style="text-align:right;">

0.925

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeAdministrator

</td>

<td style="text-align:right;">

57.419

</td>

<td style="text-align:right;">

264.926

</td>

<td style="text-align:right;">

0.217

</td>

<td style="text-align:right;">

0.829

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeAgriculture

</td>

<td style="text-align:right;">

\-366.419

</td>

<td style="text-align:right;">

137.630

</td>

<td style="text-align:right;">

\-2.662

</td>

<td style="text-align:right;">

0.008

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeArts

</td>

<td style="text-align:right;">

\-708.181

</td>

<td style="text-align:right;">

518.805

</td>

<td style="text-align:right;">

\-1.365

</td>

<td style="text-align:right;">

0.173

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeEducator

</td>

<td style="text-align:right;">

247.890

</td>

<td style="text-align:right;">

327.488

</td>

<td style="text-align:right;">

0.757

</td>

<td style="text-align:right;">

0.449

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeHomemaker

</td>

<td style="text-align:right;">

\-558.092

</td>

<td style="text-align:right;">

561.399

</td>

<td style="text-align:right;">

\-0.994

</td>

<td style="text-align:right;">

0.321

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeManufacturing (skilled)

</td>

<td style="text-align:right;">

\-173.914

</td>

<td style="text-align:right;">

133.455

</td>

<td style="text-align:right;">

\-1.303

</td>

<td style="text-align:right;">

0.193

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeManufacturing (unskilled)

</td>

<td style="text-align:right;">

\-265.703

</td>

<td style="text-align:right;">

136.773

</td>

<td style="text-align:right;">

\-1.943

</td>

<td style="text-align:right;">

0.053

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeOther, unspecified (disabled, incarcerated, tourist and other)

</td>

<td style="text-align:right;">

\-755.847

</td>

<td style="text-align:right;">

428.824

</td>

<td style="text-align:right;">

\-1.763

</td>

<td style="text-align:right;">

0.079

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeProfessional

</td>

<td style="text-align:right;">

\-427.945

</td>

<td style="text-align:right;">

532.229

</td>

<td style="text-align:right;">

\-0.804

</td>

<td style="text-align:right;">

0.422

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeProtection

</td>

<td style="text-align:right;">

\-317.194

</td>

<td style="text-align:right;">

390.563

</td>

<td style="text-align:right;">

\-0.812

</td>

<td style="text-align:right;">

0.417

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeRetired

</td>

<td style="text-align:right;">

\-662.447

</td>

<td style="text-align:right;">

235.006

</td>

<td style="text-align:right;">

\-2.819

</td>

<td style="text-align:right;">

0.005

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeSales

</td>

<td style="text-align:right;">

\-147.864

</td>

<td style="text-align:right;">

144.311

</td>

<td style="text-align:right;">

\-1.025

</td>

<td style="text-align:right;">

0.306

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeServices

</td>

<td style="text-align:right;">

\-206.414

</td>

<td style="text-align:right;">

140.739

</td>

<td style="text-align:right;">

\-1.467

</td>

<td style="text-align:right;">

0.143

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeStudent

</td>

<td style="text-align:right;">

\-212.484

</td>

<td style="text-align:right;">

542.759

</td>

<td style="text-align:right;">

\-0.391

</td>

<td style="text-align:right;">

0.696

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeTechnical Worker

</td>

<td style="text-align:right;">

\-213.915

</td>

<td style="text-align:right;">

242.488

</td>

<td style="text-align:right;">

\-0.882

</td>

<td style="text-align:right;">

0.378

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeTransportation

</td>

<td style="text-align:right;">

\-182.782

</td>

<td style="text-align:right;">

162.258

</td>

<td style="text-align:right;">

\-1.126

</td>

<td style="text-align:right;">

0.261

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeUnemployed (seeking work)

</td>

<td style="text-align:right;">

\-605.647

</td>

<td style="text-align:right;">

328.755

</td>

<td style="text-align:right;">

\-1.842

</td>

<td style="text-align:right;">

0.066

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityFresno, CA

</td>

<td style="text-align:right;">

\-78.681

</td>

<td style="text-align:right;">

318.447

</td>

<td style="text-align:right;">

\-0.247

</td>

<td style="text-align:right;">

0.805

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityLos Angeles-Long Beach, CA

</td>

<td style="text-align:right;">

\-170.806

</td>

<td style="text-align:right;">

305.408

</td>

<td style="text-align:right;">

\-0.559

</td>

<td style="text-align:right;">

0.576

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityMerced, CA

</td>

<td style="text-align:right;">

\-219.558

</td>

<td style="text-align:right;">

322.971

</td>

<td style="text-align:right;">

\-0.680

</td>

<td style="text-align:right;">

0.497

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityOrange County, CA

</td>

<td style="text-align:right;">

2.366

</td>

<td style="text-align:right;">

312.689

</td>

<td style="text-align:right;">

0.008

</td>

<td style="text-align:right;">

0.994

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityRiverside-San Bernardino, CA

</td>

<td style="text-align:right;">

\-145.056

</td>

<td style="text-align:right;">

318.477

</td>

<td style="text-align:right;">

\-0.455

</td>

<td style="text-align:right;">

0.649

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySacramento, CA

</td>

<td style="text-align:right;">

\-152.713

</td>

<td style="text-align:right;">

362.406

</td>

<td style="text-align:right;">

\-0.421

</td>

<td style="text-align:right;">

0.674

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySan Diego, CA

</td>

<td style="text-align:right;">

\-24.051

</td>

<td style="text-align:right;">

316.365

</td>

<td style="text-align:right;">

\-0.076

</td>

<td style="text-align:right;">

0.939

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySan Francisco, CA

</td>

<td style="text-align:right;">

\-449.331

</td>

<td style="text-align:right;">

353.496

</td>

<td style="text-align:right;">

\-1.271

</td>

<td style="text-align:right;">

0.204

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySan Jose, CA

</td>

<td style="text-align:right;">

\-238.464

</td>

<td style="text-align:right;">

329.335

</td>

<td style="text-align:right;">

\-0.724

</td>

<td style="text-align:right;">

0.469

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySanta Barbara-Santa Maria-Lompoc, CA

</td>

<td style="text-align:right;">

\-192.518

</td>

<td style="text-align:right;">

338.536

</td>

<td style="text-align:right;">

\-0.569

</td>

<td style="text-align:right;">

0.570

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySanta Cruz-Watsonville, CA

</td>

<td style="text-align:right;">

\-260.454

</td>

<td style="text-align:right;">

357.194

</td>

<td style="text-align:right;">

\-0.729

</td>

<td style="text-align:right;">

0.466

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityVallejo-Fairfield-Napa, CA

</td>

<td style="text-align:right;">

255.279

</td>

<td style="text-align:right;">

354.951

</td>

<td style="text-align:right;">

0.719

</td>

<td style="text-align:right;">

0.472

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityVentura, CA

</td>

<td style="text-align:right;">

\-91.718

</td>

<td style="text-align:right;">

338.861

</td>

<td style="text-align:right;">

\-0.271

</td>

<td style="text-align:right;">

0.787

</td>

</tr>

</tbody>

</table>

### 2.2 Backward selection

### 2.3 Interactions

### 2.4 F-test

## 3\. Check Assumtpions

## 4\. Interpretations

## 5\. Additional Work

Your regression analysis results go here. At a minimum, the regression
analysis should include the following:

  - Statement of the research question and modeling obejctive
    (prediction, inference, etc.)

  - Description of the response variable

  - Updated exploratory data analysis, incorporating any feedback from
    the proposal

  - Explanation of the modeling process and why you chose those metohds,
    incorporating any feedback from the proposal

  - Output of the final model

  - Discussion of the assumptions for the final model

  - Interpretations / interesting findings from the model coefficients

  - Additional work of other models or analylsis not included in the
    final model.

*Use proper headings as needed.*
