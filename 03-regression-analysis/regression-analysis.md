Characteristics of Recent Mexican Immigrants to the US
================
Ben 10
November 14, 2019

    ## ── Attaching packages ────────────────────────────── tidyverse 1.2.1 ──

    ## ✔ ggplot2 3.2.1     ✔ purrr   0.3.2
    ## ✔ tibble  2.1.3     ✔ dplyr   0.8.3
    ## ✔ tidyr   0.8.3     ✔ stringr 1.4.0
    ## ✔ readr   1.3.1     ✔ forcats 0.4.0

    ## ── Conflicts ───────────────────────────────── tidyverse_conflicts() ──
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
household, reported in $USD.

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

621196.928

</td>

<td style="text-align:right;">

2807528.636

</td>

<td style="text-align:right;">

0.221

</td>

<td style="text-align:right;">

0.825

</td>

</tr>

<tr>

<td style="text-align:left;">

sexM

</td>

<td style="text-align:right;">

5909.997

</td>

<td style="text-align:right;">

29477.760

</td>

<td style="text-align:right;">

0.200

</td>

<td style="text-align:right;">

0.841

</td>

</tr>

<tr>

<td style="text-align:left;">

age

</td>

<td style="text-align:right;">

\-646.511

</td>

<td style="text-align:right;">

1453.181

</td>

<td style="text-align:right;">

\-0.445

</td>

<td style="text-align:right;">

0.656

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnCampeche

</td>

<td style="text-align:right;">

\-15544.881

</td>

<td style="text-align:right;">

173155.563

</td>

<td style="text-align:right;">

\-0.090

</td>

<td style="text-align:right;">

0.928

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnChihuahua

</td>

<td style="text-align:right;">

\-492.233

</td>

<td style="text-align:right;">

166783.192

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

statebrnCoahuila

</td>

<td style="text-align:right;">

\-32799.192

</td>

<td style="text-align:right;">

118834.851

</td>

<td style="text-align:right;">

\-0.276

</td>

<td style="text-align:right;">

0.783

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnColima

</td>

<td style="text-align:right;">

\-17281.117

</td>

<td style="text-align:right;">

86730.022

</td>

<td style="text-align:right;">

\-0.199

</td>

<td style="text-align:right;">

0.842

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnDurango

</td>

<td style="text-align:right;">

23602.440

</td>

<td style="text-align:right;">

118739.409

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

statebrnGuanajuato

</td>

<td style="text-align:right;">

\-776.203

</td>

<td style="text-align:right;">

84703.251

</td>

<td style="text-align:right;">

\-0.009

</td>

<td style="text-align:right;">

0.993

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnGuerrero

</td>

<td style="text-align:right;">

\-2232.110

</td>

<td style="text-align:right;">

88072.126

</td>

<td style="text-align:right;">

\-0.025

</td>

<td style="text-align:right;">

0.980

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnJalisco

</td>

<td style="text-align:right;">

2299.740

</td>

<td style="text-align:right;">

84255.805

</td>

<td style="text-align:right;">

0.027

</td>

<td style="text-align:right;">

0.978

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnMéxico

</td>

<td style="text-align:right;">

\-26758.850

</td>

<td style="text-align:right;">

167141.002

</td>

<td style="text-align:right;">

\-0.160

</td>

<td style="text-align:right;">

0.873

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnMexico City

</td>

<td style="text-align:right;">

3482.798

</td>

<td style="text-align:right;">

92421.694

</td>

<td style="text-align:right;">

0.038

</td>

<td style="text-align:right;">

0.970

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnMichoacán

</td>

<td style="text-align:right;">

90.079

</td>

<td style="text-align:right;">

84357.484

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

statebrnMorelos

</td>

<td style="text-align:right;">

\-54081.365

</td>

<td style="text-align:right;">

168737.909

</td>

<td style="text-align:right;">

\-0.321

</td>

<td style="text-align:right;">

0.749

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnNayarit

</td>

<td style="text-align:right;">

6246.744

</td>

<td style="text-align:right;">

85330.480

</td>

<td style="text-align:right;">

0.073

</td>

<td style="text-align:right;">

0.942

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnNuevo Leon

</td>

<td style="text-align:right;">

\-20319.574

</td>

<td style="text-align:right;">

167047.147

</td>

<td style="text-align:right;">

\-0.122

</td>

<td style="text-align:right;">

0.903

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnOaxaca

</td>

<td style="text-align:right;">

\-7866.032

</td>

<td style="text-align:right;">

87488.302

</td>

<td style="text-align:right;">

\-0.090

</td>

<td style="text-align:right;">

0.928

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnPuebla

</td>

<td style="text-align:right;">

\-19999.181

</td>

<td style="text-align:right;">

166387.839

</td>

<td style="text-align:right;">

\-0.120

</td>

<td style="text-align:right;">

0.904

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnQuerétaro

</td>

<td style="text-align:right;">

33662.860

</td>

<td style="text-align:right;">

168392.228

</td>

<td style="text-align:right;">

0.200

</td>

<td style="text-align:right;">

0.842

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnSan Luis Potosí

</td>

<td style="text-align:right;">

\-15980.231

</td>

<td style="text-align:right;">

85464.120

</td>

<td style="text-align:right;">

\-0.187

</td>

<td style="text-align:right;">

0.852

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnSonora

</td>

<td style="text-align:right;">

4930.751

</td>

<td style="text-align:right;">

172741.077

</td>

<td style="text-align:right;">

0.029

</td>

<td style="text-align:right;">

0.977

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnTamaulipas

</td>

<td style="text-align:right;">

\-10390.137

</td>

<td style="text-align:right;">

166509.975

</td>

<td style="text-align:right;">

\-0.062

</td>

<td style="text-align:right;">

0.950

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnVeracruz

</td>

<td style="text-align:right;">

26996.329

</td>

<td style="text-align:right;">

111272.039

</td>

<td style="text-align:right;">

0.243

</td>

<td style="text-align:right;">

0.808

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnZacatecas

</td>

<td style="text-align:right;">

23117.824

</td>

<td style="text-align:right;">

84557.378

</td>

<td style="text-align:right;">

0.273

</td>

<td style="text-align:right;">

0.785

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatDivorced

</td>

<td style="text-align:right;">

\-10296.204

</td>

<td style="text-align:right;">

40366.226

</td>

<td style="text-align:right;">

\-0.255

</td>

<td style="text-align:right;">

0.799

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatMarried

</td>

<td style="text-align:right;">

2001.412

</td>

<td style="text-align:right;">

20288.307

</td>

<td style="text-align:right;">

0.099

</td>

<td style="text-align:right;">

0.921

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatNever married

</td>

<td style="text-align:right;">

843.879

</td>

<td style="text-align:right;">

29815.433

</td>

<td style="text-align:right;">

0.028

</td>

<td style="text-align:right;">

0.977

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatSeparated

</td>

<td style="text-align:right;">

5445.171

</td>

<td style="text-align:right;">

38477.144

</td>

<td style="text-align:right;">

0.142

</td>

<td style="text-align:right;">

0.887

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatWidowed

</td>

<td style="text-align:right;">

\-4670.827

</td>

<td style="text-align:right;">

33188.099

</td>

<td style="text-align:right;">

\-0.141

</td>

<td style="text-align:right;">

0.888

</td>

</tr>

<tr>

<td style="text-align:left;">

edyrs

</td>

<td style="text-align:right;">

\-433.187

</td>

<td style="text-align:right;">

1362.353

</td>

<td style="text-align:right;">

\-0.318

</td>

<td style="text-align:right;">

0.751

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeAdministrator

</td>

<td style="text-align:right;">

8455.282

</td>

<td style="text-align:right;">

45999.213

</td>

<td style="text-align:right;">

0.184

</td>

<td style="text-align:right;">

0.854

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeAgriculture

</td>

<td style="text-align:right;">

4005.805

</td>

<td style="text-align:right;">

25989.288

</td>

<td style="text-align:right;">

0.154

</td>

<td style="text-align:right;">

0.878

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeArts

</td>

<td style="text-align:right;">

\-25052.608

</td>

<td style="text-align:right;">

87342.835

</td>

<td style="text-align:right;">

\-0.287

</td>

<td style="text-align:right;">

0.774

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeEducator

</td>

<td style="text-align:right;">

11126.233

</td>

<td style="text-align:right;">

34984.751

</td>

<td style="text-align:right;">

0.318

</td>

<td style="text-align:right;">

0.751

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeHomemaker

</td>

<td style="text-align:right;">

\-24984.313

</td>

<td style="text-align:right;">

41100.768

</td>

<td style="text-align:right;">

\-0.608

</td>

<td style="text-align:right;">

0.543

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeIdle

</td>

<td style="text-align:right;">

\-18641.968

</td>

<td style="text-align:right;">

146972.008

</td>

<td style="text-align:right;">

\-0.127

</td>

<td style="text-align:right;">

0.899

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeManufacturing (skilled)

</td>

<td style="text-align:right;">

\-9109.021

</td>

<td style="text-align:right;">

25875.595

</td>

<td style="text-align:right;">

\-0.352

</td>

<td style="text-align:right;">

0.725

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeManufacturing (unskilled)

</td>

<td style="text-align:right;">

\-7049.079

</td>

<td style="text-align:right;">

26089.515

</td>

<td style="text-align:right;">

\-0.270

</td>

<td style="text-align:right;">

0.787

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeOther, unspecified (disabled, incarcerated, tourist and other)

</td>

<td style="text-align:right;">

\-22755.974

</td>

<td style="text-align:right;">

49101.720

</td>

<td style="text-align:right;">

\-0.463

</td>

<td style="text-align:right;">

0.643

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeProfessional

</td>

<td style="text-align:right;">

\-10919.647

</td>

<td style="text-align:right;">

50905.026

</td>

<td style="text-align:right;">

\-0.215

</td>

<td style="text-align:right;">

0.830

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeProtection

</td>

<td style="text-align:right;">

\-18139.019

</td>

<td style="text-align:right;">

52464.458

</td>

<td style="text-align:right;">

\-0.346

</td>

<td style="text-align:right;">

0.730

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeRetired

</td>

<td style="text-align:right;">

\-6801.472

</td>

<td style="text-align:right;">

34016.000

</td>

<td style="text-align:right;">

\-0.200

</td>

<td style="text-align:right;">

0.842

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeSales

</td>

<td style="text-align:right;">

\-4917.408

</td>

<td style="text-align:right;">

27040.219

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

occtypeServices

</td>

<td style="text-align:right;">

\-15057.171

</td>

<td style="text-align:right;">

27751.669

</td>

<td style="text-align:right;">

\-0.543

</td>

<td style="text-align:right;">

0.588

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeStudent

</td>

<td style="text-align:right;">

\-18776.225

</td>

<td style="text-align:right;">

148521.215

</td>

<td style="text-align:right;">

\-0.126

</td>

<td style="text-align:right;">

0.899

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeTechnical Worker

</td>

<td style="text-align:right;">

\-50724.028

</td>

<td style="text-align:right;">

64197.763

</td>

<td style="text-align:right;">

\-0.790

</td>

<td style="text-align:right;">

0.430

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeTransportation

</td>

<td style="text-align:right;">

\-15135.177

</td>

<td style="text-align:right;">

31267.679

</td>

<td style="text-align:right;">

\-0.484

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

\-27417.847

</td>

<td style="text-align:right;">

32555.695

</td>

<td style="text-align:right;">

\-0.842

</td>

<td style="text-align:right;">

0.400

</td>

</tr>

<tr>

<td style="text-align:left;">

usdur1

</td>

<td style="text-align:right;">

\-283.839

</td>

<td style="text-align:right;">

94.575

</td>

<td style="text-align:right;">

\-3.001

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

206.907

</td>

<td style="text-align:right;">

79.057

</td>

<td style="text-align:right;">

2.617

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

64708.973

</td>

<td style="text-align:right;">

21508.320

</td>

<td style="text-align:right;">

3.009

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

\-9755.126

</td>

<td style="text-align:right;">

146875.917

</td>

<td style="text-align:right;">

\-0.066

</td>

<td style="text-align:right;">

0.947

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Temporary: Tourist/visitor

</td>

<td style="text-align:right;">

6981.358

</td>

<td style="text-align:right;">

21641.836

</td>

<td style="text-align:right;">

0.323

</td>

<td style="text-align:right;">

0.747

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Undocumented

</td>

<td style="text-align:right;">

\-2249.263

</td>

<td style="text-align:right;">

14956.343

</td>

<td style="text-align:right;">

\-0.150

</td>

<td style="text-align:right;">

0.880

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityFresno, CA

</td>

<td style="text-align:right;">

\-17795.009

</td>

<td style="text-align:right;">

34579.085

</td>

<td style="text-align:right;">

\-0.515

</td>

<td style="text-align:right;">

0.607

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityLos Angeles-Long Beach, CA

</td>

<td style="text-align:right;">

967.582

</td>

<td style="text-align:right;">

32394.983

</td>

<td style="text-align:right;">

0.030

</td>

<td style="text-align:right;">

0.976

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityMerced, CA

</td>

<td style="text-align:right;">

\-9157.122

</td>

<td style="text-align:right;">

35863.077

</td>

<td style="text-align:right;">

\-0.255

</td>

<td style="text-align:right;">

0.799

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityOrange County, CA

</td>

<td style="text-align:right;">

\-16047.702

</td>

<td style="text-align:right;">

35479.234

</td>

<td style="text-align:right;">

\-0.452

</td>

<td style="text-align:right;">

0.651

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityRiverside-San Bernardino, CA

</td>

<td style="text-align:right;">

\-9636.106

</td>

<td style="text-align:right;">

34870.493

</td>

<td style="text-align:right;">

\-0.276

</td>

<td style="text-align:right;">

0.782

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySacramento, CA

</td>

<td style="text-align:right;">

4750.280

</td>

<td style="text-align:right;">

37586.594

</td>

<td style="text-align:right;">

0.126

</td>

<td style="text-align:right;">

0.899

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySan Diego, CA

</td>

<td style="text-align:right;">

1368.797

</td>

<td style="text-align:right;">

35139.158

</td>

<td style="text-align:right;">

0.039

</td>

<td style="text-align:right;">

0.969

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySan Francisco, CA

</td>

<td style="text-align:right;">

\-13286.318

</td>

<td style="text-align:right;">

40354.352

</td>

<td style="text-align:right;">

\-0.329

</td>

<td style="text-align:right;">

0.742

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySan Jose, CA

</td>

<td style="text-align:right;">

\-13239.692

</td>

<td style="text-align:right;">

38701.296

</td>

<td style="text-align:right;">

\-0.342

</td>

<td style="text-align:right;">

0.732

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySanta Barbara-Santa Maria-Lompoc, CA

</td>

<td style="text-align:right;">

\-14673.670

</td>

<td style="text-align:right;">

40568.406

</td>

<td style="text-align:right;">

\-0.362

</td>

<td style="text-align:right;">

0.718

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySanta Cruz-Watsonville, CA

</td>

<td style="text-align:right;">

\-9830.989

</td>

<td style="text-align:right;">

36779.241

</td>

<td style="text-align:right;">

\-0.267

</td>

<td style="text-align:right;">

0.789

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityVallejo-Fairfield-Napa, CA

</td>

<td style="text-align:right;">

\-28534.131

</td>

<td style="text-align:right;">

40932.362

</td>

<td style="text-align:right;">

\-0.697

</td>

<td style="text-align:right;">

0.486

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityVentura,
    CA

</td>

<td style="text-align:right;">

\-17190.689

</td>

<td style="text-align:right;">

39369.884

</td>

<td style="text-align:right;">

\-0.437

</td>

<td style="text-align:right;">

0.662

</td>

</tr>

<tr>

<td style="text-align:left;">

yrborn

</td>

<td style="text-align:right;">

\-292.159

</td>

<td style="text-align:right;">

1411.472

</td>

<td style="text-align:right;">

\-0.207

</td>

<td style="text-align:right;">

0.836

</td>

</tr>

</tbody>

</table>

### 2.2 Backward selection

### 2.3 Interactions

### 2.4 F-test

## 2\. Check Assumtpions

## 3\. Interpretations

## 4\. Additional Work

#### Qintian

#### Thea

#### Rachel

#### Lilly

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](regression-analysis_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](regression-analysis_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](regression-analysis_files/figure-gfm/unnamed-chunk-4-2.png)<!-- -->

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
