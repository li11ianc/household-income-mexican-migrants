Characteristics of Recent Mexican Immigrants to the United States that
Influence Household Income
================
Ben 10
November 20, 2019

<<<<<<< HEAD
    ## ── Attaching packages ────────────────────────────────────────────────────────── tidyverse 1.2.1 ──
=======
    ## ── Attaching packages ────────────────────────────── tidyverse 1.2.1 ──
>>>>>>> b2c09b3604acc818686a2e04a841e249fedf8c4e

    ## ✔ ggplot2 3.2.1     ✔ purrr   0.3.2
    ## ✔ tibble  2.1.3     ✔ dplyr   0.8.3
    ## ✔ tidyr   0.8.3     ✔ stringr 1.4.0
    ## ✔ readr   1.3.1     ✔ forcats 0.4.0

<<<<<<< HEAD
    ## ── Conflicts ───────────────────────────────────────────────────────────── tidyverse_conflicts() ──
=======
    ## ── Conflicts ───────────────────────────────── tidyverse_conflicts() ──
>>>>>>> b2c09b3604acc818686a2e04a841e249fedf8c4e
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

<<<<<<< HEAD
WHAT WE NEED TO DO: -Statement of the research question and modeling
obejctive (prediction, inference, etc.) -Description of the response
variable -Updated exploratory data analysis, incorporating any feedback
from the proposal -Explanation of the modeling process and why you chose
those metohds, incorporating any feedback from the proposal -Output of
the final model -Discussion of the assumptions for the final model
-Interpretations / interesting findings from the model coefficients
-Additional work of other models or analylsis not included in the final
model.

## 1\. Multiple Linear Regression Model

### 1.1 Full Model

### 1.2 Backward selection

### 1.3 Interactions

### 1.4 F-test

## 2\. Check Assumtpions
=======
## 1\. Introduction
>>>>>>> b2c09b3604acc818686a2e04a841e249fedf8c4e

We are aiming to discover what characteristics of Mexican immmigrants to
the United States, specifically California, influence their projected
household income. We will be building a multiple linear regression model
to predict household income considering the following variables: `sex`,
`relhead`, `age`, `statebrn`, `marstat`, `edyrs`, `occtype`, `usdur1`,
`usdurl`, `usdoc1`, `uscity`, `yrborn`.

<<<<<<< HEAD
## 4\. Additional Work
=======
Our response variable is household income: the total income for a single
household, reported in $USD.
>>>>>>> b2c09b3604acc818686a2e04a841e249fedf8c4e

## 2\. Exploratory Data Analysis

    ## # A tibble: 1,778 x 19
    ##       X1 sex   relhead yrborn   age statebrn marstat edyrs   occ hhincome
    ##    <dbl> <chr>   <dbl>  <dbl> <dbl> <chr>    <chr>   <dbl> <dbl>    <dbl>
    ##  1     2 M           1   1928    59 Guanaju… Married     3   522   10288.
    ##  2     5 M           1   1956    31 Guanaju… Married     6   142   15432.
    ##  3     6 M           1   1921    66 Jalisco  Married     0   529   10288.
    ##  4     9 M           1   1945    42 Guanaju… Consen…     6   559   10288.
    ##  5    10 M           1   1945    42 Guanaju… Married     6   819   15432.
    ##  6    11 M           1   1936    51 Guanaju… Widowed     3   522   12346.
    ##  7    12 M           1   1951    36 Guanaju… Married     2   529    9259.
    ##  8    13 M           1   1946    41 Guanaju… Married     6   419   12346.
    ##  9    18 M           1   1952    35 Guanaju… Married     6   559   20576.
    ## 10    19 M           1   1947    40 Guanaju… Married     3   410    9259.
    ## # … with 1,768 more rows, and 9 more variables: usstate1 <chr>,
    ## #   usstatel <chr>, usplace1 <dbl>, usplacel <dbl>, usdur1 <dbl>,
    ## #   usdurl <dbl>, usdoc1 <chr>, occtype <chr>, uscity <chr>

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
<<<<<<< HEAD
since we are using uscity
=======
since we are using uscity, and occ since we are using occtype.
>>>>>>> b2c09b3604acc818686a2e04a841e249fedf8c4e

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
<<<<<<< HEAD
positive because we are dealing with a constantly fluctuating
    issue.
=======
positive because we are dealing with a constantly fluctuating issue.
>>>>>>> b2c09b3604acc818686a2e04a841e249fedf8c4e

### 2.1 Full Model

<table>

<thead>

<<<<<<< HEAD
Originally, the distribution of log(Household Income)- our response
variable- was bimodal and had a mean of 412,647 dollars. We determined
that this is an absurdly high median income for a survey of largely
undocumented immigrants in the US and believe that a significant chunk
of the high incomes were actually recorded in pesos. We will filter out
the incomes above 60,000 to remove what appears to be a second
distribution of incomes in pesos. We will also remove incomes of zero
from our
    dataset.
=======
<tr>

<th style="text-align:left;">
>>>>>>> b2c09b3604acc818686a2e04a841e249fedf8c4e

term

<<<<<<< HEAD
![](regression-analysis_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->
=======
</th>
>>>>>>> b2c09b3604acc818686a2e04a841e249fedf8c4e

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

\-198228.026

</td>

<td style="text-align:right;">

2863622.538

</td>

<td style="text-align:right;">

\-0.069

</td>

<td style="text-align:right;">

0.945

</td>

</tr>

<tr>

<td style="text-align:left;">

X1

</td>

<td style="text-align:right;">

\-10.638

</td>

<td style="text-align:right;">

7.394

</td>

<td style="text-align:right;">

\-1.439

</td>

<td style="text-align:right;">

0.150

</td>

</tr>

<tr>

<td style="text-align:left;">

sexM

</td>

<td style="text-align:right;">

3669.944

</td>

<td style="text-align:right;">

29507.187

</td>

<td style="text-align:right;">

0.124

</td>

<td style="text-align:right;">

0.901

</td>

</tr>

<tr>

<td style="text-align:left;">

yrborn

</td>

<td style="text-align:right;">

125.596

</td>

<td style="text-align:right;">

1440.479

</td>

<td style="text-align:right;">

0.087

</td>

<td style="text-align:right;">

0.931

</td>

</tr>

<tr>

<td style="text-align:left;">

age

</td>

<td style="text-align:right;">

\-191.717

</td>

<td style="text-align:right;">

1486.600

</td>

<td style="text-align:right;">

\-0.129

</td>

<td style="text-align:right;">

0.897

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnCampeche

</td>

<td style="text-align:right;">

\-16230.932

</td>

<td style="text-align:right;">

173087.634

</td>

<td style="text-align:right;">

\-0.094

</td>

<td style="text-align:right;">

0.925

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnChihuahua

</td>

<td style="text-align:right;">

\-9853.773

</td>

<td style="text-align:right;">

166844.049

</td>

<td style="text-align:right;">

\-0.059

</td>

<td style="text-align:right;">

0.953

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnCoahuila

</td>

<td style="text-align:right;">

\-36777.204

</td>

<td style="text-align:right;">

118819.953

</td>

<td style="text-align:right;">

\-0.310

</td>

<td style="text-align:right;">

0.757

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnColima

</td>

<td style="text-align:right;">

\-11707.068

</td>

<td style="text-align:right;">

86782.186

</td>

<td style="text-align:right;">

\-0.135

</td>

<td style="text-align:right;">

0.893

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnDurango

</td>

<td style="text-align:right;">

17701.052

</td>

<td style="text-align:right;">

118763.226

</td>

<td style="text-align:right;">

0.149

</td>

<td style="text-align:right;">

0.882

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnGuanajuato

</td>

<td style="text-align:right;">

\-7378.649

</td>

<td style="text-align:right;">

84793.963

</td>

<td style="text-align:right;">

\-0.087

</td>

<td style="text-align:right;">

0.931

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnGuerrero

</td>

<td style="text-align:right;">

5802.140

</td>

<td style="text-align:right;">

88214.157

</td>

<td style="text-align:right;">

0.066

</td>

<td style="text-align:right;">

0.948

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnJalisco

</td>

<td style="text-align:right;">

\-240.560

</td>

<td style="text-align:right;">

84240.936

</td>

<td style="text-align:right;">

\-0.003

</td>

<td style="text-align:right;">

0.998

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnMéxico

</td>

<td style="text-align:right;">

\-21018.122

</td>

<td style="text-align:right;">

167122.434

</td>

<td style="text-align:right;">

\-0.126

</td>

<td style="text-align:right;">

0.900

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnMexico City

</td>

<td style="text-align:right;">

\-1356.084

</td>

<td style="text-align:right;">

92446.282

</td>

<td style="text-align:right;">

\-0.015

</td>

<td style="text-align:right;">

0.988

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnMichoacán

</td>

<td style="text-align:right;">

\-2947.257

</td>

<td style="text-align:right;">

84350.491

</td>

<td style="text-align:right;">

\-0.035

</td>

<td style="text-align:right;">

0.972

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnMorelos

</td>

<td style="text-align:right;">

\-62024.831

</td>

<td style="text-align:right;">

168761.404

</td>

<td style="text-align:right;">

\-0.368

</td>

<td style="text-align:right;">

0.713

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnNayarit

</td>

<td style="text-align:right;">

448.991

</td>

<td style="text-align:right;">

85391.813

</td>

<td style="text-align:right;">

0.005

</td>

<td style="text-align:right;">

0.996

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnNuevo Leon

</td>

<td style="text-align:right;">

\-9007.822

</td>

<td style="text-align:right;">

167165.963

</td>

<td style="text-align:right;">

\-0.054

</td>

<td style="text-align:right;">

0.957

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnOaxaca

</td>

<td style="text-align:right;">

5096.207

</td>

<td style="text-align:right;">

87916.470

</td>

<td style="text-align:right;">

0.058

</td>

<td style="text-align:right;">

0.954

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnPuebla

</td>

<td style="text-align:right;">

\-16462.721

</td>

<td style="text-align:right;">

166340.094

</td>

<td style="text-align:right;">

\-0.099

</td>

<td style="text-align:right;">

0.921

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnQuerétaro

</td>

<td style="text-align:right;">

23032.154

</td>

<td style="text-align:right;">

168487.613

</td>

<td style="text-align:right;">

0.137

</td>

<td style="text-align:right;">

0.891

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnSan Luis Potosí

</td>

<td style="text-align:right;">

\-6218.100

</td>

<td style="text-align:right;">

85699.281

</td>

<td style="text-align:right;">

\-0.073

</td>

<td style="text-align:right;">

0.942

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnSonora

</td>

<td style="text-align:right;">

558.178

</td>

<td style="text-align:right;">

172699.397

</td>

<td style="text-align:right;">

0.003

</td>

<td style="text-align:right;">

0.997

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnTamaulipas

</td>

<td style="text-align:right;">

115.422

</td>

<td style="text-align:right;">

166604.102

</td>

<td style="text-align:right;">

0.001

</td>

<td style="text-align:right;">

0.999

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnVeracruz

</td>

<td style="text-align:right;">

33113.564

</td>

<td style="text-align:right;">

111309.194

</td>

<td style="text-align:right;">

0.297

</td>

<td style="text-align:right;">

0.766

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnZacatecas

</td>

<td style="text-align:right;">

28191.256

</td>

<td style="text-align:right;">

84597.406

</td>

<td style="text-align:right;">

0.333

</td>

<td style="text-align:right;">

0.739

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatDivorced

</td>

<td style="text-align:right;">

\-11776.665

</td>

<td style="text-align:right;">

40363.355

</td>

<td style="text-align:right;">

\-0.292

</td>

<td style="text-align:right;">

0.771

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatMarried

</td>

<td style="text-align:right;">

2589.447

</td>

<td style="text-align:right;">

20284.389

</td>

<td style="text-align:right;">

0.128

</td>

<td style="text-align:right;">

0.898

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatNever married

</td>

<td style="text-align:right;">

561.116

</td>

<td style="text-align:right;">

29804.271

</td>

<td style="text-align:right;">

0.019

</td>

<td style="text-align:right;">

0.985

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatSeparated

</td>

<td style="text-align:right;">

6043.965

</td>

<td style="text-align:right;">

38464.155

</td>

<td style="text-align:right;">

0.157

</td>

<td style="text-align:right;">

0.875

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatWidowed

</td>

<td style="text-align:right;">

\-5009.391

</td>

<td style="text-align:right;">

33175.788

</td>

<td style="text-align:right;">

\-0.151

</td>

<td style="text-align:right;">

0.880

</td>

</tr>

<tr>

<td style="text-align:left;">

edyrs

</td>

<td style="text-align:right;">

\-258.874

</td>

<td style="text-align:right;">

1367.192

</td>

<td style="text-align:right;">

\-0.189

</td>

<td style="text-align:right;">

0.850

</td>

</tr>

<tr>

<td style="text-align:left;">

usdur1

</td>

<td style="text-align:right;">

\-284.076

</td>

<td style="text-align:right;">

94.537

</td>

<td style="text-align:right;">

\-3.005

</td>

<td style="text-align:right;">

0.003

</td>

</tr>

<tr>

<td style="text-align:left;">

usdurl

</td>

<td style="text-align:right;">

206.620

</td>

<td style="text-align:right;">

79.026

</td>

<td style="text-align:right;">

2.615

</td>

<td style="text-align:right;">

0.009

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Legal resident

</td>

<td style="text-align:right;">

64247.793

</td>

<td style="text-align:right;">

21502.190

</td>

<td style="text-align:right;">

2.988

</td>

<td style="text-align:right;">

0.003

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Silva Letter

</td>

<td style="text-align:right;">

\-2511.382

</td>

<td style="text-align:right;">

146904.038

</td>

<td style="text-align:right;">

\-0.017

</td>

<td style="text-align:right;">

0.986

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Temporary: Tourist/visitor

</td>

<td style="text-align:right;">

8043.940

</td>

<td style="text-align:right;">

21645.866

</td>

<td style="text-align:right;">

0.372

</td>

<td style="text-align:right;">

0.710

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Undocumented

</td>

<td style="text-align:right;">

\-1521.134

</td>

<td style="text-align:right;">

14958.981

</td>

<td style="text-align:right;">

\-0.102

</td>

<td style="text-align:right;">

0.919

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeAdministrator

</td>

<td style="text-align:right;">

6623.096

</td>

<td style="text-align:right;">

45998.623

</td>

<td style="text-align:right;">

0.144

</td>

<td style="text-align:right;">

0.886

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeAgriculture

</td>

<td style="text-align:right;">

5175.619

</td>

<td style="text-align:right;">

25991.713

</td>

<td style="text-align:right;">

0.199

</td>

<td style="text-align:right;">

0.842

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeArts

</td>

<td style="text-align:right;">

\-28366.338

</td>

<td style="text-align:right;">

87338.612

</td>

<td style="text-align:right;">

\-0.325

</td>

<td style="text-align:right;">

0.745

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeEducator

</td>

<td style="text-align:right;">

9518.979

</td>

<td style="text-align:right;">

34988.731

</td>

<td style="text-align:right;">

0.272

</td>

<td style="text-align:right;">

0.786

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeHomemaker

</td>

<td style="text-align:right;">

\-26592.844

</td>

<td style="text-align:right;">

41099.696

</td>

<td style="text-align:right;">

\-0.647

</td>

<td style="text-align:right;">

0.518

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeIdle

</td>

<td style="text-align:right;">

\-20045.366

</td>

<td style="text-align:right;">

146917.030

</td>

<td style="text-align:right;">

\-0.136

</td>

<td style="text-align:right;">

0.891

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeManufacturing (skilled)

</td>

<td style="text-align:right;">

\-9718.463

</td>

<td style="text-align:right;">

25868.813

</td>

<td style="text-align:right;">

\-0.376

</td>

<td style="text-align:right;">

0.707

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeManufacturing (unskilled)

</td>

<td style="text-align:right;">

\-8563.201

</td>

<td style="text-align:right;">

26100.405

</td>

<td style="text-align:right;">

\-0.328

</td>

<td style="text-align:right;">

0.743

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeOther, unspecified (disabled, incarcerated, tourist and other)

</td>

<td style="text-align:right;">

\-22356.934

</td>

<td style="text-align:right;">

49083.054

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

occtypeProfessional

</td>

<td style="text-align:right;">

\-11416.931

</td>

<td style="text-align:right;">

50886.036

</td>

<td style="text-align:right;">

\-0.224

</td>

<td style="text-align:right;">

0.823

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeProtection

</td>

<td style="text-align:right;">

\-15097.756

</td>

<td style="text-align:right;">

52486.258

</td>

<td style="text-align:right;">

\-0.288

</td>

<td style="text-align:right;">

0.774

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeRetired

</td>

<td style="text-align:right;">

\-8563.815

</td>

<td style="text-align:right;">

34024.581

</td>

<td style="text-align:right;">

\-0.252

</td>

<td style="text-align:right;">

0.801

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeSales

</td>

<td style="text-align:right;">

\-4466.980

</td>

<td style="text-align:right;">

27031.322

</td>

<td style="text-align:right;">

\-0.165

</td>

<td style="text-align:right;">

0.869

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeServices

</td>

<td style="text-align:right;">

\-16153.327

</td>

<td style="text-align:right;">

27751.136

</td>

<td style="text-align:right;">

\-0.582

</td>

<td style="text-align:right;">

0.561

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeStudent

</td>

<td style="text-align:right;">

\-21763.720

</td>

<td style="text-align:right;">

148476.906

</td>

<td style="text-align:right;">

\-0.147

</td>

<td style="text-align:right;">

0.883

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeTechnical Worker

</td>

<td style="text-align:right;">

\-48181.912

</td>

<td style="text-align:right;">

64196.653

</td>

<td style="text-align:right;">

\-0.751

</td>

<td style="text-align:right;">

0.453

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeTransportation

</td>

<td style="text-align:right;">

\-15149.859

</td>

<td style="text-align:right;">

31255.295

</td>

<td style="text-align:right;">

\-0.485

</td>

<td style="text-align:right;">

0.628

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeUnemployed (seeking work)

</td>

<td style="text-align:right;">

\-27139.134

</td>

<td style="text-align:right;">

32543.376

</td>

<td style="text-align:right;">

\-0.834

</td>

<td style="text-align:right;">

0.404

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityFresno, CA

</td>

<td style="text-align:right;">

\-15223.206

</td>

<td style="text-align:right;">

34611.575

</td>

<td style="text-align:right;">

\-0.440

</td>

<td style="text-align:right;">

0.660

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityLos Angeles-Long Beach, CA

</td>

<td style="text-align:right;">

1792.472

</td>

<td style="text-align:right;">

32387.226

</td>

<td style="text-align:right;">

0.055

</td>

<td style="text-align:right;">

0.956

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityMerced, CA

</td>

<td style="text-align:right;">

\-7987.753

</td>

<td style="text-align:right;">

35858.084

</td>

<td style="text-align:right;">

\-0.223

</td>

<td style="text-align:right;">

0.824

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityOrange County, CA

</td>

<td style="text-align:right;">

\-15141.180

</td>

<td style="text-align:right;">

35470.777

</td>

<td style="text-align:right;">

\-0.427

</td>

<td style="text-align:right;">

0.670

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityRiverside-San Bernardino, CA

</td>

<td style="text-align:right;">

\-6598.519

</td>

<td style="text-align:right;">

34920.559

</td>

<td style="text-align:right;">

\-0.189

</td>

<td style="text-align:right;">

0.850

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySacramento, CA

</td>

<td style="text-align:right;">

6195.592

</td>

<td style="text-align:right;">

37585.133

</td>

<td style="text-align:right;">

0.165

</td>

<td style="text-align:right;">

0.869

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySan Diego, CA

</td>

<td style="text-align:right;">

1824.543

</td>

<td style="text-align:right;">

35126.668

</td>

<td style="text-align:right;">

0.052

</td>

<td style="text-align:right;">

0.959

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySan Francisco, CA

</td>

<td style="text-align:right;">

\-11627.018

</td>

<td style="text-align:right;">

40354.850

</td>

<td style="text-align:right;">

\-0.288

</td>

<td style="text-align:right;">

0.773

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySan Jose, CA

</td>

<td style="text-align:right;">

\-11137.066

</td>

<td style="text-align:right;">

38713.559

</td>

<td style="text-align:right;">

\-0.288

</td>

<td style="text-align:right;">

0.774

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySanta Barbara-Santa Maria-Lompoc, CA

</td>

<td style="text-align:right;">

\-16135.377

</td>

<td style="text-align:right;">

40565.061

</td>

<td style="text-align:right;">

\-0.398

</td>

<td style="text-align:right;">

0.691

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySanta Cruz-Watsonville, CA

</td>

<td style="text-align:right;">

\-6686.829

</td>

<td style="text-align:right;">

36829.562

</td>

<td style="text-align:right;">

\-0.182

</td>

<td style="text-align:right;">

0.856

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityVallejo-Fairfield-Napa, CA

</td>

<td style="text-align:right;">

\-27826.340

</td>

<td style="text-align:right;">

40919.106

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

uscityVentura,
    CA

</td>

<td style="text-align:right;">

\-18513.612

</td>

<td style="text-align:right;">

39365.029

</td>

<td style="text-align:right;">

\-0.470

</td>

<td style="text-align:right;">

0.638

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

#### Lilly

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](regression-analysis_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](regression-analysis_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](regression-analysis_files/figure-gfm/unnamed-chunk-3-2.png)<!-- -->

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
