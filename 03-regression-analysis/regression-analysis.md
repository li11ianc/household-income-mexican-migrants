Characteristics of Recent Mexican Immigrants to the United States that
Influence Household Income
================
Ben 10
November 20, 2019

    ## ── Attaching packages ────────────────────────────────────────────────────────── tidyverse 1.2.1 ──

    ## ✔ ggplot2 3.2.1     ✔ purrr   0.3.2
    ## ✔ tibble  2.1.3     ✔ dplyr   0.8.3
    ## ✔ tidyr   0.8.3     ✔ stringr 1.4.0
    ## ✔ readr   1.3.1     ✔ forcats 0.4.0

    ## ── Conflicts ───────────────────────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

    ## Loading required package: Hmisc

    ## Loading required package: lattice

    ## Loading required package: survival

    ## Loading required package: Formula

    ## 
    ## Attaching package: 'Hmisc'

    ## The following objects are masked from 'package:dplyr':
    ## 
    ##     src, summarize

    ## The following objects are masked from 'package:base':
    ## 
    ##     format.pval, units

    ## Loading required package: SparseM

    ## 
    ## Attaching package: 'SparseM'

    ## The following object is masked from 'package:base':
    ## 
    ##     backsolve

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

## 1\. Introduction

### 1.1 Objective

We are aiming to build a model to determine which characteristics of
Mexican immmigrants to the United States, specifically California,
well-explain variation in household income.

### 1.2 Description of Dataset

The dataset is from The Mexican Migration Project (MMP, \*see References
below for confidentiality terms). It was created in 1982 by an
interdisciplinary team of researchers to further our understanding of
the complex process of Mexican migration to the United States. The
project is a binational research effort co-directed by Jorge Durand,
professor of Social Anthropology at the University of Guadalajara
(Mexico), and Douglas S. Massey, professor of Sociology and Public
Affairs, with a joint appointment in the Woodrow Wilson School, at
Princeton University (US).

Since its inception, the MMP’s main focus has been to gather social as
well as economic information on Mexican-US migration. The data collected
has been compiled in a comprehensive database that is available to the
public free of charge for research and educational purposes through its
web-site. The MMP uses the ethnosurvey approach to gather data: in
winter months, they randomly sample households in communities throughout
Mexico, surveying household heads and members about their first and last
trip to the US, as well as economic and demographic information. They
then conduct the same survey in destination areas in the US, sampling
migrants from the same communities they survey in Mexico but who have
not returned to Mexico. Thus, the sample of migrants includes residents
in both Mexico and the US.

The MMP170 Database contains an initial file with general demographic,
economic, and migratory information for each member of a surveyed
household (PERS). Pers170 has 132 variables and 176701 observations,and
hence it is very large. Therefore, we selected 17 meaningful variables
and filtered out rows that contain N/A’s to create a new dataset labeled
`data`.

### 1.3 Method

We will build a multiple linear regression model to predict household
income considering the following variables: `sex`, `relhead`, `age`,
`statebrn`, `marstat`, `edyrs`, `occtype`, `usdur1`, `usdurl`, `usdoc1`,
`uscity`, `yrborn`.

“X1”: Number of observation

“sex”: Sex

“relhead”: Relationship to household head

“yrborn”: Year of birth

“age”: Age

“statebrn”: State of birth

“marstat”: Marital status

“edyrs”: School years completed

“occ”: Principal occupation

“hhincome” : Household income

“usstate1”: First US mig: State of residence

“usstatel”: Latest US mig: State of residence

“usplace1”: First US mig: City of residence (in place codes)

“usplacel”: Latest US mig: City of residence (in place codes)

“usdur1”: First US mig: Duration (in months)

“usdurl”: Latest US mig: Duration (in months)

“usdoc1”: Type of documentation

“occtype”: Category of occupation

“uscity”: City of residence during first US migration

Our response variable is household income: the total income for a single
household, reported in $USD. We chose to use the multiple linear
regression because our response variable is numeric, and there are
multiple predictor variables.

## 2\. Exploratory Data Analysis

### 2.1 Data Cleaning

Due to the complexity of our original data, we did not include data
cleaning in the analysis. For more information, please see our proposal,
where all the data cleaning happens.

However, we did make some adjustment according to the feedback that
there is large imbalance of the amount of data between regions, and that
the distribution of the response variable is not normal. Below is the
update on our data cleaning:

### 2.2 Updated Data Exploration

#### 2.2.1 Filter Only Immigrants in California

Accoridng to our previous data exploration, we found that the
overwhelming majority of immigrants settled in California, as shown in
the graph below:

![](regression-analysis_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

Hence, we decided to concentrate on California alone. Since the
originial dataset is large, we have enough data left in California alone
to produce meaningful analysis.

#### 2.2.2 Cut Household Income Groups

Originally, the distribution of log(Household Income)- our response
variable- was bimodal and had a median of 412,647 dollars. It almost
looks like 3 separate
distributions:

![](regression-analysis_files/figure-gfm/nonfilt-income-plot-1.png)<!-- -->

We determined that 412,647 dollars is an absurdly high median income for
a survey of largely undocumented immigrants in the US and believe that a
significant chunk of the high incomes were actually recorded in pesos.
The documentation for the data from the Mexican Migration Project does
not specify unit of hhincome; however, the project site details that
researchers surveyed communities in Mexico, then traveled to the US to
survey communities there. It seems likely that the communities surveyed
in Mexico would report income in pesos and those surveyed in the US
would report income in USD. However, the data was collected over a
period of 10 years, during which the exchange rate between pesos and USD
changed significantly. Hence, we cannot simply convert all the incomes
that appear to be recorded in pesos into USD.

Therefore, we decided to filter out the incomes above 60,000 to remove
what appears to be a second distribution of incomes in pesos. We will
also remove incomes of zero from our dataset, because it will interfere
with our model accuracy. However, this compromises our model’s
predicative range: our model will only be able to predict the household
income of those who already have jobs
(income).

![](regression-analysis_files/figure-gfm/hhincome-distribution-1.png)<!-- -->

Now the distribution of response variable (hhincome) looks like a right
skewed normal
distribution.

<img src="regression-analysis_files/figure-gfm/cities-1.png" style="display: block; margin: auto;" />

These immigrants to California arrived to the following cities: Los
Angeles-Long Beach, San Francisco, San Diego, Santa Cruz-Watsonville,
Bakersfield, Fresno, Merced, Orange County, Riverside-San Bernardino,
Sacramento, San Jose, Santa Barbara-Santa Maria-Lompoc,
Vallejo-Fairfield-Napa, and Ventura. Given the comparatively small
number of cases in which no city was reported, we deleted these
instances. This leaves 15 unique locations in California. The majority
of immigrants went to LA-Long Beach area.

#### 2.2.3 Remove Variable “relhead”

It turned out that all values from relhead (relationship to head of
household) in our cleaned data were “1” or head. So we will remove this
variable, as well as state variables since we are only using California
data. We will also remove place data since we are using uscity, and occ
since we are using occtype.

#### 2.2.4 Mean-center “age” , “usdur1” and “usdurl”

We must center age and usdurl in order to have a useful model intercept
interpretation.

    ## [1] 39.42495

    ## [1] 60.27096

    ## [1] 43.98635

The mean age in the dataset is 39.43 years ; the mean duration of last
US migration is 60.27 months (about 5 years); and the mean duration of
first US migration is 43.99 months (less than 3.5 years).

## 2\. Multiple Linear Regression Model

In an effort to explain which characteristics of migrants influence
their household income, we will use a multiple linear regression model.
Since our response variable is numerical with mulitple potential
predictors, this is the best model at our disposal.

We will consider the potential interaction between principal occupation
and number of years of school completed, since those are generally
interconnected. We may also consider the interaction between
documentation type and occupation type, although the effect may be
insignificant. However, if the variables occtype, edyrs, or usdoc1 don’t
make it through the process of inital model selection, we will not
include these interactions in the model as that would not be prudent.

We will select our model using AIC criteria, because since we’re dealing
with people, we want to build a model that accounts for volatile human
nature and the ever-changing socioeconomic and political climate that
could influence someone’s household income. AIC is used when we would
rather say a variable is a relevant predictor, when in reality it might
not be and so in this case, we would rather err on the side of a false
positive because we are dealing with a constantly fluctuating
issue.

# \#\#\# 2.1 Full Model

#### 2.2.5 Remove Obvious Collinear Variable

<img src="regression-analysis_files/figure-gfm/yrborn-age-1.png" style="display: block; margin: auto;" />

`yrborn` and `age` provide the same information and are perfectly
linear, therefore we decided to remove `yrborn` from consideration in
the model.

## 3\. Multiple Linear Regression Model

In an effort to explain which characteristics of candidates influence
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

### 3.1 Full Model

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

545.964

</td>

<td style="text-align:right;">

564.845

</td>

<td style="text-align:right;">

0.967

</td>

<td style="text-align:right;">

0.334

</td>

</tr>

<tr>

<td style="text-align:left;">

sexM

</td>

<td style="text-align:right;">

376.588

</td>

<td style="text-align:right;">

187.385

</td>

<td style="text-align:right;">

2.010

</td>

<td style="text-align:right;">

0.045

</td>

</tr>

<tr>

<td style="text-align:left;">

age

</td>

<td style="text-align:right;">

6.675

</td>

<td style="text-align:right;">

2.904

</td>

<td style="text-align:right;">

2.298

</td>

<td style="text-align:right;">

0.022

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnChihuahua

</td>

<td style="text-align:right;">

134.111

</td>

<td style="text-align:right;">

631.661

</td>

<td style="text-align:right;">

0.212

</td>

<td style="text-align:right;">

0.832

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnCoahuila

</td>

<td style="text-align:right;">

1752.485

</td>

<td style="text-align:right;">

822.587

</td>

<td style="text-align:right;">

2.130

</td>

<td style="text-align:right;">

0.034

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnColima

</td>

<td style="text-align:right;">

1.565

</td>

<td style="text-align:right;">

380.356

</td>

<td style="text-align:right;">

0.004

</td>

<td style="text-align:right;">

0.997

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnGuanajuato

</td>

<td style="text-align:right;">

175.475

</td>

<td style="text-align:right;">

381.494

</td>

<td style="text-align:right;">

0.460

</td>

<td style="text-align:right;">

0.646

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnGuerrero

</td>

<td style="text-align:right;">

382.830

</td>

<td style="text-align:right;">

397.108

</td>

<td style="text-align:right;">

0.964

</td>

<td style="text-align:right;">

0.336

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnJalisco

</td>

<td style="text-align:right;">

206.635

</td>

<td style="text-align:right;">

378.413

</td>

<td style="text-align:right;">

0.546

</td>

<td style="text-align:right;">

0.585

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnMexico City

</td>

<td style="text-align:right;">

563.499

</td>

<td style="text-align:right;">

443.766

</td>

<td style="text-align:right;">

1.270

</td>

<td style="text-align:right;">

0.205

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnMichoacán

</td>

<td style="text-align:right;">

179.532

</td>

<td style="text-align:right;">

377.053

</td>

<td style="text-align:right;">

0.476

</td>

<td style="text-align:right;">

0.634

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnNayarit

</td>

<td style="text-align:right;">

361.040

</td>

<td style="text-align:right;">

381.550

</td>

<td style="text-align:right;">

0.946

</td>

<td style="text-align:right;">

0.345

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnOaxaca

</td>

<td style="text-align:right;">

383.588

</td>

<td style="text-align:right;">

390.390

</td>

<td style="text-align:right;">

0.983

</td>

<td style="text-align:right;">

0.326

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnPuebla

</td>

<td style="text-align:right;">

430.374

</td>

<td style="text-align:right;">

630.097

</td>

<td style="text-align:right;">

0.683

</td>

<td style="text-align:right;">

0.495

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnSan Luis Potosí

</td>

<td style="text-align:right;">

214.682

</td>

<td style="text-align:right;">

384.490

</td>

<td style="text-align:right;">

0.558

</td>

<td style="text-align:right;">

0.577

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnTamaulipas

</td>

<td style="text-align:right;">

\-161.674

</td>

<td style="text-align:right;">

629.901

</td>

<td style="text-align:right;">

\-0.257

</td>

<td style="text-align:right;">

0.798

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnVeracruz

</td>

<td style="text-align:right;">

411.163

</td>

<td style="text-align:right;">

531.769

</td>

<td style="text-align:right;">

0.773

</td>

<td style="text-align:right;">

0.440

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnZacatecas

</td>

<td style="text-align:right;">

348.941

</td>

<td style="text-align:right;">

375.679

</td>

<td style="text-align:right;">

0.929

</td>

<td style="text-align:right;">

0.353

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatDivorced

</td>

<td style="text-align:right;">

171.792

</td>

<td style="text-align:right;">

219.802

</td>

<td style="text-align:right;">

0.782

</td>

<td style="text-align:right;">

0.435

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatMarried

</td>

<td style="text-align:right;">

43.241

</td>

<td style="text-align:right;">

117.730

</td>

<td style="text-align:right;">

0.367

</td>

<td style="text-align:right;">

0.714

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatNever married

</td>

<td style="text-align:right;">

\-151.650

</td>

<td style="text-align:right;">

164.118

</td>

<td style="text-align:right;">

\-0.924

</td>

<td style="text-align:right;">

0.356

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatSeparated

</td>

<td style="text-align:right;">

97.680

</td>

<td style="text-align:right;">

234.443

</td>

<td style="text-align:right;">

0.417

</td>

<td style="text-align:right;">

0.677

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatWidowed

</td>

<td style="text-align:right;">

117.059

</td>

<td style="text-align:right;">

245.574

</td>

<td style="text-align:right;">

0.477

</td>

<td style="text-align:right;">

0.634

</td>

</tr>

<tr>

<td style="text-align:left;">

edyrs

</td>

<td style="text-align:right;">

11.795

</td>

<td style="text-align:right;">

8.093

</td>

<td style="text-align:right;">

1.457

</td>

<td style="text-align:right;">

0.146

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeAdministrator

</td>

<td style="text-align:right;">

41.773

</td>

<td style="text-align:right;">

268.820

</td>

<td style="text-align:right;">

0.155

</td>

<td style="text-align:right;">

0.877

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeAgriculture

</td>

<td style="text-align:right;">

\-338.593

</td>

<td style="text-align:right;">

139.252

</td>

<td style="text-align:right;">

\-2.432

</td>

<td style="text-align:right;">

0.015

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeArts

</td>

<td style="text-align:right;">

\-734.762

</td>

<td style="text-align:right;">

526.443

</td>

<td style="text-align:right;">

\-1.396

</td>

<td style="text-align:right;">

0.163

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeEducator

</td>

<td style="text-align:right;">

330.280

</td>

<td style="text-align:right;">

331.637

</td>

<td style="text-align:right;">

0.996

</td>

<td style="text-align:right;">

0.320

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeHomemaker

</td>

<td style="text-align:right;">

\-293.640

</td>

<td style="text-align:right;">

562.972

</td>

<td style="text-align:right;">

\-0.522

</td>

<td style="text-align:right;">

0.602

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeManufacturing (skilled)

</td>

<td style="text-align:right;">

\-155.087

</td>

<td style="text-align:right;">

135.147

</td>

<td style="text-align:right;">

\-1.148

</td>

<td style="text-align:right;">

0.252

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeManufacturing (unskilled)

</td>

<td style="text-align:right;">

\-228.939

</td>

<td style="text-align:right;">

137.949

</td>

<td style="text-align:right;">

\-1.660

</td>

<td style="text-align:right;">

0.098

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeOther, unspecified (disabled, incarcerated, tourist and other)

</td>

<td style="text-align:right;">

\-842.711

</td>

<td style="text-align:right;">

434.370

</td>

<td style="text-align:right;">

\-1.940

</td>

<td style="text-align:right;">

0.053

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeProfessional

</td>

<td style="text-align:right;">

\-693.183

</td>

<td style="text-align:right;">

535.468

</td>

<td style="text-align:right;">

\-1.295

</td>

<td style="text-align:right;">

0.196

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeProtection

</td>

<td style="text-align:right;">

\-333.922

</td>

<td style="text-align:right;">

395.800

</td>

<td style="text-align:right;">

\-0.844

</td>

<td style="text-align:right;">

0.399

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeRetired

</td>

<td style="text-align:right;">

\-672.350

</td>

<td style="text-align:right;">

238.185

</td>

<td style="text-align:right;">

\-2.823

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

\-147.089

</td>

<td style="text-align:right;">

146.366

</td>

<td style="text-align:right;">

\-1.005

</td>

<td style="text-align:right;">

0.315

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeServices

</td>

<td style="text-align:right;">

\-160.247

</td>

<td style="text-align:right;">

142.047

</td>

<td style="text-align:right;">

\-1.128

</td>

<td style="text-align:right;">

0.260

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeStudent

</td>

<td style="text-align:right;">

\-104.454

</td>

<td style="text-align:right;">

550.065

</td>

<td style="text-align:right;">

\-0.190

</td>

<td style="text-align:right;">

0.849

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeTechnical Worker

</td>

<td style="text-align:right;">

\-227.092

</td>

<td style="text-align:right;">

246.055

</td>

<td style="text-align:right;">

\-0.923

</td>

<td style="text-align:right;">

0.357

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeTransportation

</td>

<td style="text-align:right;">

\-173.407

</td>

<td style="text-align:right;">

164.617

</td>

<td style="text-align:right;">

\-1.053

</td>

<td style="text-align:right;">

0.293

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeUnemployed (seeking work)

</td>

<td style="text-align:right;">

\-584.815

</td>

<td style="text-align:right;">

333.223

</td>

<td style="text-align:right;">

\-1.755

</td>

<td style="text-align:right;">

0.080

</td>

</tr>

<tr>

<td style="text-align:left;">

usdur1

</td>

<td style="text-align:right;">

\-0.091

</td>

<td style="text-align:right;">

0.432

</td>

<td style="text-align:right;">

\-0.211

</td>

<td style="text-align:right;">

0.833

</td>

</tr>

<tr>

<td style="text-align:left;">

usdurl

</td>

<td style="text-align:right;">

0.552

</td>

<td style="text-align:right;">

0.377

</td>

<td style="text-align:right;">

1.464

</td>

<td style="text-align:right;">

0.144

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Legal resident

</td>

<td style="text-align:right;">

132.060

</td>

<td style="text-align:right;">

154.369

</td>

<td style="text-align:right;">

0.855

</td>

<td style="text-align:right;">

0.393

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Temporary: Tourist/visitor

</td>

<td style="text-align:right;">

\-29.045

</td>

<td style="text-align:right;">

158.039

</td>

<td style="text-align:right;">

\-0.184

</td>

<td style="text-align:right;">

0.854

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Undocumented

</td>

<td style="text-align:right;">

2.133

</td>

<td style="text-align:right;">

126.931

</td>

<td style="text-align:right;">

0.017

</td>

<td style="text-align:right;">

0.987

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityFresno, CA

</td>

<td style="text-align:right;">

\-163.479

</td>

<td style="text-align:right;">

322.090

</td>

<td style="text-align:right;">

\-0.508

</td>

<td style="text-align:right;">

0.612

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityLos Angeles-Long Beach, CA

</td>

<td style="text-align:right;">

\-259.508

</td>

<td style="text-align:right;">

308.021

</td>

<td style="text-align:right;">

\-0.843

</td>

<td style="text-align:right;">

0.400

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityMerced, CA

</td>

<td style="text-align:right;">

\-287.166

</td>

<td style="text-align:right;">

326.559

</td>

<td style="text-align:right;">

\-0.879

</td>

<td style="text-align:right;">

0.380

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityOrange County, CA

</td>

<td style="text-align:right;">

\-125.722

</td>

<td style="text-align:right;">

314.562

</td>

<td style="text-align:right;">

\-0.400

</td>

<td style="text-align:right;">

0.690

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityRiverside-San Bernardino, CA

</td>

<td style="text-align:right;">

\-263.118

</td>

<td style="text-align:right;">

321.640

</td>

<td style="text-align:right;">

\-0.818

</td>

<td style="text-align:right;">

0.414

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySacramento, CA

</td>

<td style="text-align:right;">

\-200.982

</td>

<td style="text-align:right;">

367.300

</td>

<td style="text-align:right;">

\-0.547

</td>

<td style="text-align:right;">

0.585

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySan Diego, CA

</td>

<td style="text-align:right;">

\-125.923

</td>

<td style="text-align:right;">

318.718

</td>

<td style="text-align:right;">

\-0.395

</td>

<td style="text-align:right;">

0.693

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySan Francisco, CA

</td>

<td style="text-align:right;">

\-495.832

</td>

<td style="text-align:right;">

358.362

</td>

<td style="text-align:right;">

\-1.384

</td>

<td style="text-align:right;">

0.167

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySan Jose, CA

</td>

<td style="text-align:right;">

\-369.569

</td>

<td style="text-align:right;">

331.701

</td>

<td style="text-align:right;">

\-1.114

</td>

<td style="text-align:right;">

0.266

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySanta Barbara-Santa Maria-Lompoc, CA

</td>

<td style="text-align:right;">

\-252.569

</td>

<td style="text-align:right;">

341.026

</td>

<td style="text-align:right;">

\-0.741

</td>

<td style="text-align:right;">

0.459

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySanta Cruz-Watsonville, CA

</td>

<td style="text-align:right;">

\-372.233

</td>

<td style="text-align:right;">

361.301

</td>

<td style="text-align:right;">

\-1.030

</td>

<td style="text-align:right;">

0.303

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityVallejo-Fairfield-Napa, CA

</td>

<td style="text-align:right;">

77.491

</td>

<td style="text-align:right;">

357.028

</td>

<td style="text-align:right;">

0.217

</td>

<td style="text-align:right;">

0.828

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityVentura, CA

</td>

<td style="text-align:right;">

\-154.193

</td>

<td style="text-align:right;">

341.941

</td>

<td style="text-align:right;">

\-0.451

</td>

<td style="text-align:right;">

0.652

</td>

</tr>

</tbody>

</table>

### 3.2 Backward selection

    ## Start:  AIC=6442.92
    ## hhincome ~ sex + age + statebrn + marstat + edyrs + occtype + 
    ##     usdur1 + usdurl + usdoc1 + uscity
    ## 
    ##            Df Sum of Sq       RSS    AIC
    ## - uscity   13   3071711 119125190 6430.3
    ## - occtype  17   6282840 122336319 6436.0
    ## - marstat   5    831232 116884711 6436.6
    ## - usdoc1    3    505808 116559287 6439.2
    ## - statebrn 15   6094016 122147495 6439.2
    ## - usdur1    1     11365 116064844 6441.0
    ## <none>                  116053479 6442.9
    ## - edyrs     1    542908 116596387 6443.3
    ## - usdurl    1    547562 116601041 6443.3
    ## - sex       1   1032440 117085919 6445.5
    ## - age       1   1350282 117403761 6446.9
    ## 
    ## Step:  AIC=6430.33
    ## hhincome ~ sex + age + statebrn + marstat + edyrs + occtype + 
    ##     usdur1 + usdurl + usdoc1
    ## 
    ##            Df Sum of Sq       RSS    AIC
    ## - occtype  17   5845224 124970414 6420.9
    ## - marstat   5   1083209 120208399 6425.0
    ## - statebrn 15   6724549 125849739 6428.5
    ## - usdoc1    3    975015 120100205 6428.5
    ## - usdur1    1     81050 119206241 6428.7
    ## <none>                  119125190 6430.3
    ## - edyrs     1    471056 119596246 6430.3
    ## - usdurl    1    898034 120023224 6432.2
    ## - sex       1    900647 120025837 6432.2
    ## - age       1    931697 120056887 6432.3
    ## 
    ## Step:  AIC=6420.9
    ## hhincome ~ sex + age + statebrn + marstat + edyrs + usdur1 + 
    ##     usdurl + usdoc1
    ## 
    ##            Df Sum of Sq       RSS    AIC
    ## - marstat   5    777612 125748026 6414.1
    ## - statebrn 15   6347181 131317596 6416.3
    ## - usdoc1    3    830148 125800562 6418.3
    ## - usdur1    1    155180 125125594 6419.5
    ## <none>                  124970414 6420.9
    ## - sex       1    570931 125541345 6421.2
    ## - age       1    602177 125572591 6421.4
    ## - usdurl    1   1428461 126398876 6424.7
    ## - edyrs     1   1682731 126653145 6425.8
    ## 
    ## Step:  AIC=6414.08
    ## hhincome ~ sex + age + statebrn + edyrs + usdur1 + usdurl + usdoc1
    ## 
    ##            Df Sum of Sq       RSS    AIC
    ## - statebrn 15   6699887 132447914 6410.7
    ## - usdoc1    3    868576 126616602 6411.6
    ## - usdur1    1    147884 125895910 6412.7
    ## <none>                  125748026 6414.1
    ## - age       1    849920 126597946 6415.5
    ## - sex       1   1355291 127103317 6417.6
    ## - usdurl    1   1442401 127190427 6417.9
    ## - edyrs     1   1576632 127324658 6418.5
    ## 
    ## Step:  AIC=6410.71
    ## hhincome ~ sex + age + edyrs + usdur1 + usdurl + usdoc1
    ## 
    ##          Df Sum of Sq       RSS    AIC
    ## - usdur1  1    299052 132746966 6409.9
    ## <none>                132447914 6410.7
    ## - usdoc1  3   1634456 134082370 6411.0
    ## - sex     1    790805 133238718 6411.8
    ## - usdurl  1   1541739 133989652 6414.6
    ## - age     1   1835768 134283682 6415.8
    ## - edyrs   1   2538651 134986564 6418.5
    ## 
    ## Step:  AIC=6409.87
    ## hhincome ~ sex + age + edyrs + usdurl + usdoc1
    ## 
    ##          Df Sum of Sq       RSS    AIC
    ## - usdoc1  3   1494678 134241644 6409.6
    ## <none>                132746966 6409.9
    ## - sex     1   1016294 133763260 6411.8
    ## - usdurl  1   1375595 134122561 6413.2
    ## - age     1   1956939 134703904 6415.4
    ## - edyrs   1   2620424 135367390 6417.9
    ## 
    ## Step:  AIC=6409.61
    ## hhincome ~ sex + age + edyrs + usdurl
    ## 
    ##          Df Sum of Sq       RSS    AIC
    ## <none>                134241644 6409.6
    ## - sex     1   1249042 135490686 6412.4
    ## - usdurl  1   1733473 135975117 6414.2
    ## - age     1   2491615 136733260 6417.0
    ## - edyrs   1   3203237 137444881 6419.7

| term        | estimate | std.error | statistic | p.value | conf.low | conf.high |
| :---------- | -------: | --------: | --------: | ------: | -------: | --------: |
| (Intercept) |  435.912 |   120.504 |     3.617 |   0.000 |  199.164 |   672.660 |
| sexM        |  241.933 |   111.280 |     2.174 |   0.030 |   23.307 |   460.559 |
| age         |    6.725 |     2.190 |     3.071 |   0.002 |    2.422 |    11.028 |
| edyrs       |   23.641 |     6.790 |     3.482 |   0.001 |   10.301 |    36.982 |
| usdurl      |    0.662 |     0.258 |     2.561 |   0.011 |    0.154 |     1.169 |

Using backward selection based on AIC, we narrowed down to 4 variables:
sex, edyrs, usdurl and age.

### 3.3 Interactions

To find potential interactions between the 4 variables, we used nested-F
test for each of the possible interactions:

After inital backwards selection, we will explore the possible
interactions between remaining variables- edyrs, usdurl, sex, and age-
to determine if any are significant.

| Res.Df |       RSS | Df | Sum of Sq | Pr(\>Chi) |
| -----: | --------: | -: | --------: | --------: |
|    508 | 134241644 | NA |        NA |        NA |
|    507 | 134188199 |  1 |  53444.74 |     0.653 |

| Res.Df |       RSS | Df | Sum of Sq | Pr(\>Chi) |
| -----: | --------: | -: | --------: | --------: |
|    508 | 134241644 | NA |        NA |        NA |
|    507 | 133063129 |  1 |   1178515 |     0.034 |

| Res.Df |       RSS | Df | Sum of Sq | Pr(\>Chi) |
| -----: | --------: | -: | --------: | --------: |
|    508 | 134241644 | NA |        NA |        NA |
|    507 | 133809343 |  1 |  432301.3 |     0.201 |

| Res.Df |       RSS | Df | Sum of Sq | Pr(\>Chi) |
| -----: | --------: | -: | --------: | --------: |
|    508 | 134241644 | NA |        NA |        NA |
|    507 | 133986215 |  1 |  255429.1 |     0.326 |

| Res.Df |       RSS | Df | Sum of Sq | Pr(\>Chi) |
| -----: | --------: | -: | --------: | --------: |
|    508 | 134241644 | NA |        NA |        NA |
|    507 | 128320533 |  1 |   5921111 |         0 |

| Res.Df |       RSS | Df | Sum of Sq | Pr(\>Chi) |
| -----: | --------: | -: | --------: | --------: |
|    508 | 134241644 | NA |        NA |        NA |
|    507 | 134034469 |  1 |  207174.7 |     0.376 |

Through nested F-test, we observed significant interactions between age
& edyrs and between sex & usdurl, with respective p-values of 0 and
0.034.

### 3.4 Model with Interaction

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

435.625

</td>

<td style="text-align:right;">

118.863

</td>

<td style="text-align:right;">

3.665

</td>

<td style="text-align:right;">

0.000

</td>

</tr>

<tr>

<td style="text-align:left;">

sexM

</td>

<td style="text-align:right;">

279.468

</td>

<td style="text-align:right;">

109.513

</td>

<td style="text-align:right;">

2.552

</td>

<td style="text-align:right;">

0.011

</td>

</tr>

<tr>

<td style="text-align:left;">

age

</td>

<td style="text-align:right;">

\-6.969

</td>

<td style="text-align:right;">

3.614

</td>

<td style="text-align:right;">

\-1.928

</td>

<td style="text-align:right;">

0.054

</td>

</tr>

<tr>

<td style="text-align:left;">

edyrs

</td>

<td style="text-align:right;">

25.408

</td>

<td style="text-align:right;">

6.641

</td>

<td style="text-align:right;">

3.826

</td>

<td style="text-align:right;">

0.000

</td>

</tr>

<tr>

<td style="text-align:left;">

usdurl

</td>

<td style="text-align:right;">

1.881

</td>

<td style="text-align:right;">

0.795

</td>

<td style="text-align:right;">

2.366

</td>

<td style="text-align:right;">

0.018

</td>

</tr>

<tr>

<td style="text-align:left;">

age:edyrs

</td>

<td style="text-align:right;">

2.576

</td>

<td style="text-align:right;">

0.549

</td>

<td style="text-align:right;">

4.694

</td>

<td style="text-align:right;">

0.000

</td>

</tr>

<tr>

<td style="text-align:left;">

sexM:usdurl

</td>

<td style="text-align:right;">

\-1.493

</td>

<td style="text-align:right;">

0.833

</td>

<td style="text-align:right;">

\-1.793

</td>

<td style="text-align:right;">

0.074

</td>

</tr>

</tbody>

</table>

### 3.5 Backward Selection with Interaction

Since we observed 2 pairs of significant interactions, we will do the
backward selection again with the new interaction terms.

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

878.026

</td>

<td style="text-align:right;">

557.482

</td>

<td style="text-align:right;">

1.575

</td>

<td style="text-align:right;">

0.116

</td>

</tr>

<tr>

<td style="text-align:left;">

sexM

</td>

<td style="text-align:right;">

345.547

</td>

<td style="text-align:right;">

183.808

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

age

</td>

<td style="text-align:right;">

\-6.990

</td>

<td style="text-align:right;">

4.410

</td>

<td style="text-align:right;">

\-1.585

</td>

<td style="text-align:right;">

0.114

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnChihuahua

</td>

<td style="text-align:right;">

\-37.480

</td>

<td style="text-align:right;">

618.716

</td>

<td style="text-align:right;">

\-0.061

</td>

<td style="text-align:right;">

0.952

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnCoahuila

</td>

<td style="text-align:right;">

1789.955

</td>

<td style="text-align:right;">

804.966

</td>

<td style="text-align:right;">

2.224

</td>

<td style="text-align:right;">

0.027

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnColima

</td>

<td style="text-align:right;">

\-135.045

</td>

<td style="text-align:right;">

372.886

</td>

<td style="text-align:right;">

\-0.362

</td>

<td style="text-align:right;">

0.717

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnGuanajuato

</td>

<td style="text-align:right;">

2.438

</td>

<td style="text-align:right;">

374.644

</td>

<td style="text-align:right;">

0.007

</td>

<td style="text-align:right;">

0.995

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnGuerrero

</td>

<td style="text-align:right;">

169.066

</td>

<td style="text-align:right;">

390.712

</td>

<td style="text-align:right;">

0.433

</td>

<td style="text-align:right;">

0.665

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnJalisco

</td>

<td style="text-align:right;">

12.057

</td>

<td style="text-align:right;">

372.121

</td>

<td style="text-align:right;">

0.032

</td>

<td style="text-align:right;">

0.974

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnMexico City

</td>

<td style="text-align:right;">

358.293

</td>

<td style="text-align:right;">

435.944

</td>

<td style="text-align:right;">

0.822

</td>

<td style="text-align:right;">

0.412

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnMichoacán

</td>

<td style="text-align:right;">

\-2.203

</td>

<td style="text-align:right;">

370.502

</td>

<td style="text-align:right;">

\-0.006

</td>

<td style="text-align:right;">

0.995

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnNayarit

</td>

<td style="text-align:right;">

227.214

</td>

<td style="text-align:right;">

374.049

</td>

<td style="text-align:right;">

0.607

</td>

<td style="text-align:right;">

0.544

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnOaxaca

</td>

<td style="text-align:right;">

213.719

</td>

<td style="text-align:right;">

383.238

</td>

<td style="text-align:right;">

0.558

</td>

<td style="text-align:right;">

0.577

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnPuebla

</td>

<td style="text-align:right;">

181.620

</td>

<td style="text-align:right;">

618.085

</td>

<td style="text-align:right;">

0.294

</td>

<td style="text-align:right;">

0.769

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnSan Luis Potosí

</td>

<td style="text-align:right;">

43.097

</td>

<td style="text-align:right;">

377.536

</td>

<td style="text-align:right;">

0.114

</td>

<td style="text-align:right;">

0.909

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnTamaulipas

</td>

<td style="text-align:right;">

\-396.185

</td>

<td style="text-align:right;">

617.653

</td>

<td style="text-align:right;">

\-0.641

</td>

<td style="text-align:right;">

0.522

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnVeracruz

</td>

<td style="text-align:right;">

179.094

</td>

<td style="text-align:right;">

522.130

</td>

<td style="text-align:right;">

0.343

</td>

<td style="text-align:right;">

0.732

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnZacatecas

</td>

<td style="text-align:right;">

144.806

</td>

<td style="text-align:right;">

369.696

</td>

<td style="text-align:right;">

0.392

</td>

<td style="text-align:right;">

0.695

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatDivorced

</td>

<td style="text-align:right;">

143.693

</td>

<td style="text-align:right;">

215.747

</td>

<td style="text-align:right;">

0.666

</td>

<td style="text-align:right;">

0.506

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatMarried

</td>

<td style="text-align:right;">

38.471

</td>

<td style="text-align:right;">

115.088

</td>

<td style="text-align:right;">

0.334

</td>

<td style="text-align:right;">

0.738

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatNever married

</td>

<td style="text-align:right;">

\-130.913

</td>

<td style="text-align:right;">

160.513

</td>

<td style="text-align:right;">

\-0.816

</td>

<td style="text-align:right;">

0.415

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatSeparated

</td>

<td style="text-align:right;">

34.904

</td>

<td style="text-align:right;">

229.590

</td>

<td style="text-align:right;">

0.152

</td>

<td style="text-align:right;">

0.879

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatWidowed

</td>

<td style="text-align:right;">

58.523

</td>

<td style="text-align:right;">

245.031

</td>

<td style="text-align:right;">

0.239

</td>

<td style="text-align:right;">

0.811

</td>

</tr>

<tr>

<td style="text-align:left;">

edyrs

</td>

<td style="text-align:right;">

11.676

</td>

<td style="text-align:right;">

7.924

</td>

<td style="text-align:right;">

1.473

</td>

<td style="text-align:right;">

0.141

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeAdministrator

</td>

<td style="text-align:right;">

31.642

</td>

<td style="text-align:right;">

263.031

</td>

<td style="text-align:right;">

0.120

</td>

<td style="text-align:right;">

0.904

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeAgriculture

</td>

<td style="text-align:right;">

\-335.870

</td>

<td style="text-align:right;">

136.246

</td>

<td style="text-align:right;">

\-2.465

</td>

<td style="text-align:right;">

0.014

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeArts

</td>

<td style="text-align:right;">

\-820.952

</td>

<td style="text-align:right;">

514.911

</td>

<td style="text-align:right;">

\-1.594

</td>

<td style="text-align:right;">

0.112

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeEducator

</td>

<td style="text-align:right;">

258.917

</td>

<td style="text-align:right;">

325.939

</td>

<td style="text-align:right;">

0.794

</td>

<td style="text-align:right;">

0.427

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeHomemaker

</td>

<td style="text-align:right;">

\-319.429

</td>

<td style="text-align:right;">

560.333

</td>

<td style="text-align:right;">

\-0.570

</td>

<td style="text-align:right;">

0.569

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeManufacturing (skilled)

</td>

<td style="text-align:right;">

\-152.566

</td>

<td style="text-align:right;">

132.116

</td>

<td style="text-align:right;">

\-1.155

</td>

<td style="text-align:right;">

0.249

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeManufacturing (unskilled)

</td>

<td style="text-align:right;">

\-236.765

</td>

<td style="text-align:right;">

134.855

</td>

<td style="text-align:right;">

\-1.756

</td>

<td style="text-align:right;">

0.080

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeOther, unspecified (disabled, incarcerated, tourist and other)

</td>

<td style="text-align:right;">

\-806.150

</td>

<td style="text-align:right;">

424.671

</td>

<td style="text-align:right;">

\-1.898

</td>

<td style="text-align:right;">

0.058

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeProfessional

</td>

<td style="text-align:right;">

\-767.634

</td>

<td style="text-align:right;">

523.651

</td>

<td style="text-align:right;">

\-1.466

</td>

<td style="text-align:right;">

0.143

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeProtection

</td>

<td style="text-align:right;">

\-353.514

</td>

<td style="text-align:right;">

386.923

</td>

<td style="text-align:right;">

\-0.914

</td>

<td style="text-align:right;">

0.361

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeRetired

</td>

<td style="text-align:right;">

\-659.988

</td>

<td style="text-align:right;">

232.957

</td>

<td style="text-align:right;">

\-2.833

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

\-153.140

</td>

<td style="text-align:right;">

143.081

</td>

<td style="text-align:right;">

\-1.070

</td>

<td style="text-align:right;">

0.285

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeServices

</td>

<td style="text-align:right;">

\-159.350

</td>

<td style="text-align:right;">

138.956

</td>

<td style="text-align:right;">

\-1.147

</td>

<td style="text-align:right;">

0.252

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeStudent

</td>

<td style="text-align:right;">

61.907

</td>

<td style="text-align:right;">

539.262

</td>

<td style="text-align:right;">

0.115

</td>

<td style="text-align:right;">

0.909

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeTechnical Worker

</td>

<td style="text-align:right;">

\-242.646

</td>

<td style="text-align:right;">

240.648

</td>

<td style="text-align:right;">

\-1.008

</td>

<td style="text-align:right;">

0.314

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeTransportation

</td>

<td style="text-align:right;">

\-145.071

</td>

<td style="text-align:right;">

161.023

</td>

<td style="text-align:right;">

\-0.901

</td>

<td style="text-align:right;">

0.368

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeUnemployed (seeking work)

</td>

<td style="text-align:right;">

\-513.867

</td>

<td style="text-align:right;">

326.851

</td>

<td style="text-align:right;">

\-1.572

</td>

<td style="text-align:right;">

0.117

</td>

</tr>

<tr>

<td style="text-align:left;">

usdur1

</td>

<td style="text-align:right;">

\-0.325

</td>

<td style="text-align:right;">

0.433

</td>

<td style="text-align:right;">

\-0.750

</td>

<td style="text-align:right;">

0.453

</td>

</tr>

<tr>

<td style="text-align:left;">

usdurl

</td>

<td style="text-align:right;">

2.286

</td>

<td style="text-align:right;">

0.939

</td>

<td style="text-align:right;">

2.434

</td>

<td style="text-align:right;">

0.015

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Legal resident

</td>

<td style="text-align:right;">

88.871

</td>

<td style="text-align:right;">

152.265

</td>

<td style="text-align:right;">

0.584

</td>

<td style="text-align:right;">

0.560

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Temporary: Tourist/visitor

</td>

<td style="text-align:right;">

\-107.696

</td>

<td style="text-align:right;">

156.914

</td>

<td style="text-align:right;">

\-0.686

</td>

<td style="text-align:right;">

0.493

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Undocumented

</td>

<td style="text-align:right;">

\-70.188

</td>

<td style="text-align:right;">

125.321

</td>

<td style="text-align:right;">

\-0.560

</td>

<td style="text-align:right;">

0.576

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityFresno, CA

</td>

<td style="text-align:right;">

\-204.506

</td>

<td style="text-align:right;">

315.081

</td>

<td style="text-align:right;">

\-0.649

</td>

<td style="text-align:right;">

0.517

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityLos Angeles-Long Beach, CA

</td>

<td style="text-align:right;">

\-258.180

</td>

<td style="text-align:right;">

301.203

</td>

<td style="text-align:right;">

\-0.857

</td>

<td style="text-align:right;">

0.392

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityMerced, CA

</td>

<td style="text-align:right;">

\-306.657

</td>

<td style="text-align:right;">

319.297

</td>

<td style="text-align:right;">

\-0.960

</td>

<td style="text-align:right;">

0.337

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityOrange County, CA

</td>

<td style="text-align:right;">

\-144.857

</td>

<td style="text-align:right;">

307.558

</td>

<td style="text-align:right;">

\-0.471

</td>

<td style="text-align:right;">

0.638

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityRiverside-San Bernardino, CA

</td>

<td style="text-align:right;">

\-221.638

</td>

<td style="text-align:right;">

314.530

</td>

<td style="text-align:right;">

\-0.705

</td>

<td style="text-align:right;">

0.481

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySacramento, CA

</td>

<td style="text-align:right;">

\-123.527

</td>

<td style="text-align:right;">

359.503

</td>

<td style="text-align:right;">

\-0.344

</td>

<td style="text-align:right;">

0.731

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySan Diego, CA

</td>

<td style="text-align:right;">

\-168.342

</td>

<td style="text-align:right;">

311.756

</td>

<td style="text-align:right;">

\-0.540

</td>

<td style="text-align:right;">

0.589

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySan Francisco, CA

</td>

<td style="text-align:right;">

\-462.249

</td>

<td style="text-align:right;">

350.417

</td>

<td style="text-align:right;">

\-1.319

</td>

<td style="text-align:right;">

0.188

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySan Jose, CA

</td>

<td style="text-align:right;">

\-388.575

</td>

<td style="text-align:right;">

324.286

</td>

<td style="text-align:right;">

\-1.198

</td>

<td style="text-align:right;">

0.231

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySanta Barbara-Santa Maria-Lompoc, CA

</td>

<td style="text-align:right;">

\-256.314

</td>

<td style="text-align:right;">

333.386

</td>

<td style="text-align:right;">

\-0.769

</td>

<td style="text-align:right;">

0.442

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySanta Cruz-Watsonville, CA

</td>

<td style="text-align:right;">

\-396.712

</td>

<td style="text-align:right;">

353.228

</td>

<td style="text-align:right;">

\-1.123

</td>

<td style="text-align:right;">

0.262

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityVallejo-Fairfield-Napa, CA

</td>

<td style="text-align:right;">

88.063

</td>

<td style="text-align:right;">

349.028

</td>

<td style="text-align:right;">

0.252

</td>

<td style="text-align:right;">

0.801

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityVentura, CA

</td>

<td style="text-align:right;">

\-142.597

</td>

<td style="text-align:right;">

334.260

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

sexM:usdurl

</td>

<td style="text-align:right;">

\-1.890

</td>

<td style="text-align:right;">

0.909

</td>

<td style="text-align:right;">

\-2.080

</td>

<td style="text-align:right;">

0.038

</td>

</tr>

<tr>

<td style="text-align:left;">

age:edyrs

</td>

<td style="text-align:right;">

2.387

</td>

<td style="text-align:right;">

0.594

</td>

<td style="text-align:right;">

4.016

</td>

<td style="text-align:right;">

0.000

</td>

</tr>

</tbody>

</table>

    ## Start:  AIC=6421.31
    ## hhincome ~ sex + age + statebrn + marstat + edyrs + occtype + 
    ##     usdur1 + usdurl + usdoc1 + uscity + sex * usdurl + age * 
    ##     edyrs
    ## 
    ##              Df Sum of Sq       RSS    AIC
    ## - uscity     13   2811402 113212079 6408.2
    ## - marstat     5    595990 110996667 6414.1
    ## - occtype    17   6064369 116465046 6414.7
    ## - statebrn   15   5341529 115742206 6415.5
    ## - usdoc1      3    810695 111211372 6419.1
    ## - usdur1      1    137529 110538206 6419.9
    ## <none>                    110400677 6421.3
    ## - sex:usdurl  1   1056743 111457420 6424.2
    ## - age:edyrs   1   3940159 114340836 6437.3
    ## 
    ## Step:  AIC=6408.21
    ## hhincome ~ sex + age + statebrn + marstat + edyrs + occtype + 
    ##     usdur1 + usdurl + usdoc1 + sex:usdurl + age:edyrs
    ## 
    ##              Df Sum of Sq       RSS    AIC
    ## - occtype    17   5650142 118862221 6399.2
    ## - marstat     5    847604 114059683 6402.0
    ## - statebrn   15   5661656 118873735 6403.2
    ## - usdur1      1    278739 113490818 6407.5
    ## - usdoc1      3   1265186 114477265 6407.9
    ## <none>                    113212079 6408.2
    ## - sex:usdurl  1   1190130 114402209 6411.6
    ## - age:edyrs   1   4007140 117219218 6424.1
    ## 
    ## Step:  AIC=6399.19
    ## hhincome ~ sex + age + statebrn + marstat + edyrs + usdur1 + 
    ##     usdurl + usdoc1 + sex:usdurl + age:edyrs
    ## 
    ##              Df Sum of Sq       RSS    AIC
    ## - marstat     5    597038 119459259 6391.8
    ## - statebrn   15   5434922 124297143 6392.1
    ## - usdoc1      3   1051184 119913405 6397.7
    ## - usdur1      1    344669 119206890 6398.7
    ## <none>                    118862221 6399.2
    ## - sex:usdurl  1    991064 119853285 6401.5
    ## - age:edyrs   1   4571040 123433261 6416.5
    ## 
    ## Step:  AIC=6391.76
    ## hhincome ~ sex + age + statebrn + edyrs + usdur1 + usdurl + usdoc1 + 
    ##     sex:usdurl + age:edyrs
    ## 
    ##              Df Sum of Sq       RSS    AIC
    ## - statebrn   15   5760216 125219475 6385.9
    ## - usdoc1      3   1106287 120565546 6390.5
    ## - usdur1      1    332383 119791642 6391.2
    ## <none>                    119459259 6391.8
    ## - sex:usdurl  1   1027427 120486685 6394.2
    ## - age:edyrs   1   4819288 124278547 6410.1
    ## 
    ## Step:  AIC=6385.92
    ## hhincome ~ sex + age + edyrs + usdur1 + usdurl + usdoc1 + sex:usdurl + 
    ##     age:edyrs
    ## 
    ##              Df Sum of Sq       RSS    AIC
    ## <none>                    125219475 6385.9
    ## - usdur1      1    555672 125775147 6386.2
    ## - usdoc1      3   1943461 127162936 6387.8
    ## - sex:usdurl  1   1177794 126397269 6388.7
    ## - age:edyrs   1   5566474 130785949 6406.2

| term                             |  estimate | std.error | statistic | p.value |  conf.low | conf.high |
| :------------------------------- | --------: | --------: | --------: | ------: | --------: | --------: |
| (Intercept)                      |   543.131 |   171.838 |     3.161 |   0.002 |   205.521 |   880.741 |
| sexM                             |   229.279 |   114.478 |     2.003 |   0.046 |     4.364 |   454.195 |
| age                              |   \-8.312 |     3.922 |   \-2.119 |   0.035 |  \-16.017 |   \-0.606 |
| edyrs                            |    22.975 |     6.806 |     3.376 |   0.001 |     9.604 |    36.345 |
| usdur1                           |   \-0.606 |     0.406 |   \-1.493 |   0.136 |   \-1.403 |     0.192 |
| usdurl                           |     2.508 |     0.881 |     2.846 |   0.005 |     0.777 |     4.240 |
| usdoc1Legal resident             |   165.170 |   137.421 |     1.202 |   0.230 | \-104.822 |   435.162 |
| usdoc1Temporary: Tourist/visitor | \-119.244 |   143.326 |   \-0.832 |   0.406 | \-400.836 |   162.349 |
| usdoc1Undocumented               |  \-60.146 |   113.928 |   \-0.528 |   0.598 | \-283.979 |   163.688 |
| sexM:usdurl                      |   \-1.850 |     0.852 |   \-2.173 |   0.030 |   \-3.523 |   \-0.177 |
| age:edyrs                        |     2.616 |     0.554 |     4.724 |   0.000 |     1.528 |     3.704 |

We observed that the variable selection changed. Specifically, usdur1
and usdoc1 are significant, besides the 4 variables and the 2
interaction terms identified previously.

## 4\. Check Assumtpions

Before interpreting the model, it is essential to check the assumptions.

### 4.1 Linearity

### 4.1.1 Predicted vs. Factors

![](regression-analysis_files/figure-gfm/scatter-pairs-1.png)<!-- -->

![](regression-analysis_files/figure-gfm/income-sex-plot-1.png)<!-- -->

From the above plots, there seems to be a weak linear relationship
between the response and predictor variables. No non-linear patterns
(i.e. quadratic relationships) appear.

We also observe that there is a distinct linear relationship between
usdurl and usdur1, which makes sense, because many people’s first
migration is their last migration. (they have only migrated to the US
once.)

Hence, it is worth looking at VIF of the
    variables:

#### 4.1.2 Multicollinearity

    ##                             sexM                              age 
    ##                         1.154209                         4.458762 
    ##                            edyrs                           usdur1 
    ##                         1.333972                         1.978052 
    ##                           usdurl             usdoc1Legal resident 
    ##                        13.015955                         2.728140 
    ## usdoc1Temporary: Tourist/visitor               usdoc1Undocumented 
    ##                         2.398679                         4.092962 
    ##                      sexM:usdurl                        age:edyrs 
    ##                        10.946675                         3.695115

    ##        sexM         age       edyrs      usdurl   age:edyrs sexM:usdurl 
    ##    1.045536    3.748052    1.257423   10.481876    3.590084   10.364901

The VIF of usdurl and sex:usdurl are greater than 10, which is alarming.
The high VIF of usdurl is likely due to its collinearity with usdur1.
However, looking at the VIF for reduced\_int model, the VIF for usdurl
is still high, meaning that it actually have something to do with the
interaction term "sex\*usdurl".

Hence, we should possibly consider dropping either usdurl or
sex\*usdurl.

\#\#\#\# 4.1.2.1 Drop sex\*usdurl

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

880.069

</td>

<td style="text-align:right;">

559.524

</td>

<td style="text-align:right;">

1.573

</td>

<td style="text-align:right;">

0.116

</td>

</tr>

<tr>

<td style="text-align:left;">

sexM

</td>

<td style="text-align:right;">

325.288

</td>

<td style="text-align:right;">

184.223

</td>

<td style="text-align:right;">

1.766

</td>

<td style="text-align:right;">

0.078

</td>

</tr>

<tr>

<td style="text-align:left;">

age

</td>

<td style="text-align:right;">

\-7.852

</td>

<td style="text-align:right;">

4.406

</td>

<td style="text-align:right;">

\-1.782

</td>

<td style="text-align:right;">

0.075

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnChihuahua

</td>

<td style="text-align:right;">

\-37.691

</td>

<td style="text-align:right;">

620.983

</td>

<td style="text-align:right;">

\-0.061

</td>

<td style="text-align:right;">

0.952

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnCoahuila

</td>

<td style="text-align:right;">

1852.380

</td>

<td style="text-align:right;">

807.355

</td>

<td style="text-align:right;">

2.294

</td>

<td style="text-align:right;">

0.022

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnColima

</td>

<td style="text-align:right;">

\-105.444

</td>

<td style="text-align:right;">

373.980

</td>

<td style="text-align:right;">

\-0.282

</td>

<td style="text-align:right;">

0.778

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnGuanajuato

</td>

<td style="text-align:right;">

31.374

</td>

<td style="text-align:right;">

375.758

</td>

<td style="text-align:right;">

0.083

</td>

<td style="text-align:right;">

0.933

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnGuerrero

</td>

<td style="text-align:right;">

212.895

</td>

<td style="text-align:right;">

391.574

</td>

<td style="text-align:right;">

0.544

</td>

<td style="text-align:right;">

0.587

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnJalisco

</td>

<td style="text-align:right;">

41.486

</td>

<td style="text-align:right;">

373.215

</td>

<td style="text-align:right;">

0.111

</td>

<td style="text-align:right;">

0.912

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnMexico City

</td>

<td style="text-align:right;">

411.515

</td>

<td style="text-align:right;">

436.788

</td>

<td style="text-align:right;">

0.942

</td>

<td style="text-align:right;">

0.347

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnMichoacán

</td>

<td style="text-align:right;">

34.198

</td>

<td style="text-align:right;">

371.445

</td>

<td style="text-align:right;">

0.092

</td>

<td style="text-align:right;">

0.927

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnNayarit

</td>

<td style="text-align:right;">

263.581

</td>

<td style="text-align:right;">

375.009

</td>

<td style="text-align:right;">

0.703

</td>

<td style="text-align:right;">

0.483

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnOaxaca

</td>

<td style="text-align:right;">

248.079

</td>

<td style="text-align:right;">

384.285

</td>

<td style="text-align:right;">

0.646

</td>

<td style="text-align:right;">

0.519

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnPuebla

</td>

<td style="text-align:right;">

228.611

</td>

<td style="text-align:right;">

619.935

</td>

<td style="text-align:right;">

0.369

</td>

<td style="text-align:right;">

0.712

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnSan Luis Potosí

</td>

<td style="text-align:right;">

70.098

</td>

<td style="text-align:right;">

378.695

</td>

<td style="text-align:right;">

0.185

</td>

<td style="text-align:right;">

0.853

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnTamaulipas

</td>

<td style="text-align:right;">

\-353.000

</td>

<td style="text-align:right;">

619.566

</td>

<td style="text-align:right;">

\-0.570

</td>

<td style="text-align:right;">

0.569

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnVeracruz

</td>

<td style="text-align:right;">

203.921

</td>

<td style="text-align:right;">

523.907

</td>

<td style="text-align:right;">

0.389

</td>

<td style="text-align:right;">

0.697

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnZacatecas

</td>

<td style="text-align:right;">

174.461

</td>

<td style="text-align:right;">

370.775

</td>

<td style="text-align:right;">

0.471

</td>

<td style="text-align:right;">

0.638

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatDivorced

</td>

<td style="text-align:right;">

113.873

</td>

<td style="text-align:right;">

216.059

</td>

<td style="text-align:right;">

0.527

</td>

<td style="text-align:right;">

0.598

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatMarried

</td>

<td style="text-align:right;">

40.976

</td>

<td style="text-align:right;">

115.504

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

\-128.895

</td>

<td style="text-align:right;">

161.099

</td>

<td style="text-align:right;">

\-0.800

</td>

<td style="text-align:right;">

0.424

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatSeparated

</td>

<td style="text-align:right;">

37.598

</td>

<td style="text-align:right;">

230.427

</td>

<td style="text-align:right;">

0.163

</td>

<td style="text-align:right;">

0.870

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatWidowed

</td>

<td style="text-align:right;">

158.815

</td>

<td style="text-align:right;">

241.121

</td>

<td style="text-align:right;">

0.659

</td>

<td style="text-align:right;">

0.510

</td>

</tr>

<tr>

<td style="text-align:left;">

edyrs

</td>

<td style="text-align:right;">

12.550

</td>

<td style="text-align:right;">

7.942

</td>

<td style="text-align:right;">

1.580

</td>

<td style="text-align:right;">

0.115

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeAdministrator

</td>

<td style="text-align:right;">

11.952

</td>

<td style="text-align:right;">

263.824

</td>

<td style="text-align:right;">

0.045

</td>

<td style="text-align:right;">

0.964

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeAgriculture

</td>

<td style="text-align:right;">

\-325.359

</td>

<td style="text-align:right;">

136.652

</td>

<td style="text-align:right;">

\-2.381

</td>

<td style="text-align:right;">

0.018

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeArts

</td>

<td style="text-align:right;">

\-808.148

</td>

<td style="text-align:right;">

516.762

</td>

<td style="text-align:right;">

\-1.564

</td>

<td style="text-align:right;">

0.119

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeEducator

</td>

<td style="text-align:right;">

215.142

</td>

<td style="text-align:right;">

326.451

</td>

<td style="text-align:right;">

0.659

</td>

<td style="text-align:right;">

0.510

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeHomemaker

</td>

<td style="text-align:right;">

\-512.299

</td>

<td style="text-align:right;">

554.633

</td>

<td style="text-align:right;">

\-0.924

</td>

<td style="text-align:right;">

0.356

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeManufacturing (skilled)

</td>

<td style="text-align:right;">

\-155.905

</td>

<td style="text-align:right;">

132.590

</td>

<td style="text-align:right;">

\-1.176

</td>

<td style="text-align:right;">

0.240

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeManufacturing (unskilled)

</td>

<td style="text-align:right;">

\-235.010

</td>

<td style="text-align:right;">

135.347

</td>

<td style="text-align:right;">

\-1.736

</td>

<td style="text-align:right;">

0.083

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeOther, unspecified (disabled, incarcerated, tourist and other)

</td>

<td style="text-align:right;">

\-817.851

</td>

<td style="text-align:right;">

426.190

</td>

<td style="text-align:right;">

\-1.919

</td>

<td style="text-align:right;">

0.056

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeProfessional

</td>

<td style="text-align:right;">

\-757.566

</td>

<td style="text-align:right;">

525.548

</td>

<td style="text-align:right;">

\-1.441

</td>

<td style="text-align:right;">

0.150

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeProtection

</td>

<td style="text-align:right;">

\-345.242

</td>

<td style="text-align:right;">

388.320

</td>

<td style="text-align:right;">

\-0.889

</td>

<td style="text-align:right;">

0.374

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeRetired

</td>

<td style="text-align:right;">

\-676.175

</td>

<td style="text-align:right;">

233.681

</td>

<td style="text-align:right;">

\-2.894

</td>

<td style="text-align:right;">

0.004

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeSales

</td>

<td style="text-align:right;">

\-150.434

</td>

<td style="text-align:right;">

143.599

</td>

<td style="text-align:right;">

\-1.048

</td>

<td style="text-align:right;">

0.295

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeServices

</td>

<td style="text-align:right;">

\-169.688

</td>

<td style="text-align:right;">

139.376

</td>

<td style="text-align:right;">

\-1.217

</td>

<td style="text-align:right;">

0.224

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeStudent

</td>

<td style="text-align:right;">

72.778

</td>

<td style="text-align:right;">

541.213

</td>

<td style="text-align:right;">

0.134

</td>

<td style="text-align:right;">

0.893

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeTechnical Worker

</td>

<td style="text-align:right;">

\-253.252

</td>

<td style="text-align:right;">

241.476

</td>

<td style="text-align:right;">

\-1.049

</td>

<td style="text-align:right;">

0.295

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeTransportation

</td>

<td style="text-align:right;">

\-151.808

</td>

<td style="text-align:right;">

161.580

</td>

<td style="text-align:right;">

\-0.940

</td>

<td style="text-align:right;">

0.348

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeUnemployed (seeking work)

</td>

<td style="text-align:right;">

\-569.789

</td>

<td style="text-align:right;">

326.937

</td>

<td style="text-align:right;">

\-1.743

</td>

<td style="text-align:right;">

0.082

</td>

</tr>

<tr>

<td style="text-align:left;">

usdur1

</td>

<td style="text-align:right;">

\-0.122

</td>

<td style="text-align:right;">

0.424

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

usdurl

</td>

<td style="text-align:right;">

0.490

</td>

<td style="text-align:right;">

0.370

</td>

<td style="text-align:right;">

1.323

</td>

<td style="text-align:right;">

0.187

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Legal resident

</td>

<td style="text-align:right;">

62.636

</td>

<td style="text-align:right;">

152.298

</td>

<td style="text-align:right;">

0.411

</td>

<td style="text-align:right;">

0.681

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Temporary: Tourist/visitor

</td>

<td style="text-align:right;">

\-134.504

</td>

<td style="text-align:right;">

156.957

</td>

<td style="text-align:right;">

\-0.857

</td>

<td style="text-align:right;">

0.392

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Undocumented

</td>

<td style="text-align:right;">

\-73.962

</td>

<td style="text-align:right;">

125.768

</td>

<td style="text-align:right;">

\-0.588

</td>

<td style="text-align:right;">

0.557

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityFresno, CA

</td>

<td style="text-align:right;">

\-213.371

</td>

<td style="text-align:right;">

316.207

</td>

<td style="text-align:right;">

\-0.675

</td>

<td style="text-align:right;">

0.500

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityLos Angeles-Long Beach, CA

</td>

<td style="text-align:right;">

\-273.935

</td>

<td style="text-align:right;">

302.211

</td>

<td style="text-align:right;">

\-0.906

</td>

<td style="text-align:right;">

0.365

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityMerced, CA

</td>

<td style="text-align:right;">

\-314.689

</td>

<td style="text-align:right;">

320.443

</td>

<td style="text-align:right;">

\-0.982

</td>

<td style="text-align:right;">

0.327

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityOrange County, CA

</td>

<td style="text-align:right;">

\-151.548

</td>

<td style="text-align:right;">

308.668

</td>

<td style="text-align:right;">

\-0.491

</td>

<td style="text-align:right;">

0.624

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityRiverside-San Bernardino, CA

</td>

<td style="text-align:right;">

\-233.876

</td>

<td style="text-align:right;">

315.627

</td>

<td style="text-align:right;">

\-0.741

</td>

<td style="text-align:right;">

0.459

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySacramento, CA

</td>

<td style="text-align:right;">

\-121.552

</td>

<td style="text-align:right;">

360.819

</td>

<td style="text-align:right;">

\-0.337

</td>

<td style="text-align:right;">

0.736

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySan Diego, CA

</td>

<td style="text-align:right;">

\-174.079

</td>

<td style="text-align:right;">

312.886

</td>

<td style="text-align:right;">

\-0.556

</td>

<td style="text-align:right;">

0.578

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySan Francisco, CA

</td>

<td style="text-align:right;">

\-479.585

</td>

<td style="text-align:right;">

351.602

</td>

<td style="text-align:right;">

\-1.364

</td>

<td style="text-align:right;">

0.173

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySan Jose, CA

</td>

<td style="text-align:right;">

\-392.595

</td>

<td style="text-align:right;">

325.469

</td>

<td style="text-align:right;">

\-1.206

</td>

<td style="text-align:right;">

0.228

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySanta Barbara-Santa Maria-Lompoc, CA

</td>

<td style="text-align:right;">

\-264.490

</td>

<td style="text-align:right;">

334.585

</td>

<td style="text-align:right;">

\-0.791

</td>

<td style="text-align:right;">

0.430

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySanta Cruz-Watsonville, CA

</td>

<td style="text-align:right;">

\-399.300

</td>

<td style="text-align:right;">

354.521

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

uscityVallejo-Fairfield-Napa, CA

</td>

<td style="text-align:right;">

77.769

</td>

<td style="text-align:right;">

350.272

</td>

<td style="text-align:right;">

0.222

</td>

<td style="text-align:right;">

0.824

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityVentura, CA

</td>

<td style="text-align:right;">

\-141.242

</td>

<td style="text-align:right;">

335.484

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

age:edyrs

</td>

<td style="text-align:right;">

2.555

</td>

<td style="text-align:right;">

0.591

</td>

<td style="text-align:right;">

4.322

</td>

<td style="text-align:right;">

0.000

</td>

</tr>

</tbody>

</table>

    ## Start:  AIC=6424.19
    ## hhincome ~ sex + age + statebrn + marstat + edyrs + occtype + 
    ##     usdur1 + usdurl + usdoc1 + uscity + age * edyrs
    ## 
    ##             Df Sum of Sq       RSS    AIC
    ## - uscity    13   2944789 114402209 6411.6
    ## - occtype   17   5944305 117401726 6416.8
    ## - marstat    5    625363 112082784 6417.1
    ## - statebrn  15   5530115 116987535 6419.0
    ## - usdoc1     3    707108 112164528 6421.4
    ## - usdur1     1     20277 111477697 6422.3
    ## - usdurl     1    430446 111887866 6424.2
    ## <none>                   111457420 6424.2
    ## - sex        1    767113 112224533 6425.7
    ## - age:edyrs  1   4596059 116053479 6442.9
    ## 
    ## Step:  AIC=6411.57
    ## hhincome ~ sex + age + statebrn + marstat + edyrs + occtype + 
    ##     usdur1 + usdurl + usdoc1 + age:edyrs
    ## 
    ##             Df Sum of Sq       RSS    AIC
    ## - occtype   17   5451076 119853285 6401.5
    ## - marstat    5    816232 115218441 6405.2
    ## - statebrn  15   5833569 120235778 6407.1
    ## - usdur1     1     90204 114492413 6410.0
    ## - usdoc1     3   1155670 115557879 6410.7
    ## <none>                   114402209 6411.6
    ## - sex        1    686272 115088481 6412.6
    ## - usdurl     1    701994 115104203 6412.7
    ## - age:edyrs  1   4722981 119125190 6430.3
    ## 
    ## Step:  AIC=6401.45
    ## hhincome ~ sex + age + statebrn + marstat + edyrs + usdur1 + 
    ##     usdurl + usdoc1 + age:edyrs
    ## 
    ##             Df Sum of Sq       RSS    AIC
    ## - marstat    5    633401 120486685 6394.2
    ## - statebrn  15   5667297 125520581 6395.2
    ## - usdoc1     3    931385 120784670 6399.4
    ## - usdur1     1    145911 119999196 6400.1
    ## <none>                   119853285 6401.5
    ## - sex        1    493127 120346412 6401.6
    ## - usdurl     1   1105323 120958608 6404.2
    ## - age:edyrs  1   5117130 124970414 6420.9
    ## 
    ## Step:  AIC=6394.16
    ## hhincome ~ sex + age + statebrn + edyrs + usdur1 + usdurl + usdoc1 + 
    ##     age:edyrs
    ## 
    ##             Df Sum of Sq       RSS    AIC
    ## - statebrn  15   5910584 126397269 6388.7
    ## - usdoc1     3    931420 121418105 6392.1
    ## - usdur1     1    141681 120628366 6392.8
    ## <none>                   120486685 6394.2
    ## - usdurl     1   1125556 121612242 6396.9
    ## - sex        1   1279002 121765687 6397.6
    ## - age:edyrs  1   5261341 125748026 6414.1
    ## 
    ## Step:  AIC=6388.72
    ## hhincome ~ sex + age + edyrs + usdur1 + usdurl + usdoc1 + age:edyrs
    ## 
    ##             Df Sum of Sq       RSS    AIC
    ## - usdur1     1    294766 126692035 6387.9
    ## <none>                   126397269 6388.7
    ## - usdoc1     3   1758176 128155446 6389.8
    ## - sex        1    794881 127192151 6389.9
    ## - usdurl     1   1182813 127580083 6391.5
    ## - age:edyrs  1   6050644 132447914 6410.7
    ## 
    ## Step:  AIC=6387.92
    ## hhincome ~ sex + age + edyrs + usdurl + usdoc1 + age:edyrs
    ## 
    ##             Df Sum of Sq       RSS    AIC
    ## <none>                   126692035 6387.9
    ## - usdoc1     3   1628498 128320533 6388.5
    ## - usdurl     1    941939 127633974 6389.7
    ## - sex        1   1019499 127711534 6390.0
    ## - age:edyrs  1   6054931 132746966 6409.9

| term                             |  estimate | std.error | statistic | p.value |  conf.low | conf.high |
| :------------------------------- | --------: | --------: | --------: | ------: | --------: | --------: |
| (Intercept)                      |   560.003 |   170.826 |     3.278 |   0.001 |   224.384 |   895.622 |
| sexM                             |   226.176 |   112.308 |     2.014 |   0.045 |     5.526 |   446.826 |
| age                              |   \-8.500 |     3.929 |   \-2.163 |   0.031 |  \-16.220 |   \-0.781 |
| edyrs                            |    23.304 |     6.825 |     3.414 |   0.001 |     9.894 |    36.713 |
| usdurl                           |     0.498 |     0.257 |     1.936 |   0.053 |   \-0.007 |     1.003 |
| usdoc1Legal resident             |   126.790 |   136.906 |     0.926 |   0.355 | \-142.187 |   395.767 |
| usdoc1Temporary: Tourist/visitor | \-139.059 |   143.474 |   \-0.969 |   0.333 | \-420.940 |   142.823 |
| usdoc1Undocumented               |  \-70.626 |   114.239 |   \-0.618 |   0.537 | \-295.070 |   153.817 |
| age:edyrs                        |     2.719 |     0.554 |     4.908 |   0.000 |     1.630 |     3.807 |

    ##                             sexM                              age 
    ##                         1.102330                         4.441495 
    ##                            edyrs                           usdurl 
    ##                         1.331418                         1.099370 
    ##             usdoc1Legal resident usdoc1Temporary: Tourist/visitor 
    ##                         2.686909                         2.385184 
    ##               usdoc1Undocumented                        age:edyrs 
    ##                         4.083735                         3.668738

#### 4.1.2.2 Drop usdurl and Change usdurl*sex to usdur1*sex

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

813.212

</td>

<td style="text-align:right;">

558.699

</td>

<td style="text-align:right;">

1.456

</td>

<td style="text-align:right;">

0.146

</td>

</tr>

<tr>

<td style="text-align:left;">

sexM

</td>

<td style="text-align:right;">

414.055

</td>

<td style="text-align:right;">

186.710

</td>

<td style="text-align:right;">

2.218

</td>

<td style="text-align:right;">

0.027

</td>

</tr>

<tr>

<td style="text-align:left;">

age

</td>

<td style="text-align:right;">

\-6.302

</td>

<td style="text-align:right;">

4.368

</td>

<td style="text-align:right;">

\-1.443

</td>

<td style="text-align:right;">

0.150

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnChihuahua

</td>

<td style="text-align:right;">

\-33.925

</td>

<td style="text-align:right;">

619.718

</td>

<td style="text-align:right;">

\-0.055

</td>

<td style="text-align:right;">

0.956

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnCoahuila

</td>

<td style="text-align:right;">

1814.429

</td>

<td style="text-align:right;">

806.112

</td>

<td style="text-align:right;">

2.251

</td>

<td style="text-align:right;">

0.025

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnColima

</td>

<td style="text-align:right;">

\-141.510

</td>

<td style="text-align:right;">

373.559

</td>

<td style="text-align:right;">

\-0.379

</td>

<td style="text-align:right;">

0.705

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnGuanajuato

</td>

<td style="text-align:right;">

15.874

</td>

<td style="text-align:right;">

375.168

</td>

<td style="text-align:right;">

0.042

</td>

<td style="text-align:right;">

0.966

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnGuerrero

</td>

<td style="text-align:right;">

164.208

</td>

<td style="text-align:right;">

391.423

</td>

<td style="text-align:right;">

0.420

</td>

<td style="text-align:right;">

0.675

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnJalisco

</td>

<td style="text-align:right;">

17.416

</td>

<td style="text-align:right;">

372.772

</td>

<td style="text-align:right;">

0.047

</td>

<td style="text-align:right;">

0.963

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnMexico City

</td>

<td style="text-align:right;">

392.921

</td>

<td style="text-align:right;">

436.117

</td>

<td style="text-align:right;">

0.901

</td>

<td style="text-align:right;">

0.368

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnMichoacán

</td>

<td style="text-align:right;">

4.939

</td>

<td style="text-align:right;">

371.112

</td>

<td style="text-align:right;">

0.013

</td>

<td style="text-align:right;">

0.989

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnNayarit

</td>

<td style="text-align:right;">

236.718

</td>

<td style="text-align:right;">

374.686

</td>

<td style="text-align:right;">

0.632

</td>

<td style="text-align:right;">

0.528

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnOaxaca

</td>

<td style="text-align:right;">

202.725

</td>

<td style="text-align:right;">

383.729

</td>

<td style="text-align:right;">

0.528

</td>

<td style="text-align:right;">

0.598

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnPuebla

</td>

<td style="text-align:right;">

175.659

</td>

<td style="text-align:right;">

619.079

</td>

<td style="text-align:right;">

0.284

</td>

<td style="text-align:right;">

0.777

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnSan Luis Potosí

</td>

<td style="text-align:right;">

37.832

</td>

<td style="text-align:right;">

378.234

</td>

<td style="text-align:right;">

0.100

</td>

<td style="text-align:right;">

0.920

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnTamaulipas

</td>

<td style="text-align:right;">

\-411.464

</td>

<td style="text-align:right;">

618.409

</td>

<td style="text-align:right;">

\-0.665

</td>

<td style="text-align:right;">

0.506

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnVeracruz

</td>

<td style="text-align:right;">

170.278

</td>

<td style="text-align:right;">

522.971

</td>

<td style="text-align:right;">

0.326

</td>

<td style="text-align:right;">

0.745

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnZacatecas

</td>

<td style="text-align:right;">

144.802

</td>

<td style="text-align:right;">

370.468

</td>

<td style="text-align:right;">

0.391

</td>

<td style="text-align:right;">

0.696

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatDivorced

</td>

<td style="text-align:right;">

91.442

</td>

<td style="text-align:right;">

215.289

</td>

<td style="text-align:right;">

0.425

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

38.721

</td>

<td style="text-align:right;">

115.247

</td>

<td style="text-align:right;">

0.336

</td>

<td style="text-align:right;">

0.737

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatNever married

</td>

<td style="text-align:right;">

\-135.098

</td>

<td style="text-align:right;">

160.685

</td>

<td style="text-align:right;">

\-0.841

</td>

<td style="text-align:right;">

0.401

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatSeparated

</td>

<td style="text-align:right;">

58.057

</td>

<td style="text-align:right;">

230.281

</td>

<td style="text-align:right;">

0.252

</td>

<td style="text-align:right;">

0.801

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatWidowed

</td>

<td style="text-align:right;">

95.936

</td>

<td style="text-align:right;">

243.313

</td>

<td style="text-align:right;">

0.394

</td>

<td style="text-align:right;">

0.694

</td>

</tr>

<tr>

<td style="text-align:left;">

edyrs

</td>

<td style="text-align:right;">

13.216

</td>

<td style="text-align:right;">

7.865

</td>

<td style="text-align:right;">

1.680

</td>

<td style="text-align:right;">

0.094

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeAdministrator

</td>

<td style="text-align:right;">

57.539

</td>

<td style="text-align:right;">

263.311

</td>

<td style="text-align:right;">

0.219

</td>

<td style="text-align:right;">

0.827

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeAgriculture

</td>

<td style="text-align:right;">

\-348.132

</td>

<td style="text-align:right;">

135.991

</td>

<td style="text-align:right;">

\-2.560

</td>

<td style="text-align:right;">

0.011

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeArts

</td>

<td style="text-align:right;">

\-822.561

</td>

<td style="text-align:right;">

515.675

</td>

<td style="text-align:right;">

\-1.595

</td>

<td style="text-align:right;">

0.111

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeEducator

</td>

<td style="text-align:right;">

235.781

</td>

<td style="text-align:right;">

326.137

</td>

<td style="text-align:right;">

0.723

</td>

<td style="text-align:right;">

0.470

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeHomemaker

</td>

<td style="text-align:right;">

\-399.525

</td>

<td style="text-align:right;">

558.127

</td>

<td style="text-align:right;">

\-0.716

</td>

<td style="text-align:right;">

0.474

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeManufacturing (skilled)

</td>

<td style="text-align:right;">

\-153.132

</td>

<td style="text-align:right;">

132.327

</td>

<td style="text-align:right;">

\-1.157

</td>

<td style="text-align:right;">

0.248

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeManufacturing (unskilled)

</td>

<td style="text-align:right;">

\-240.559

</td>

<td style="text-align:right;">

135.053

</td>

<td style="text-align:right;">

\-1.781

</td>

<td style="text-align:right;">

0.076

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeOther, unspecified (disabled, incarcerated, tourist and other)

</td>

<td style="text-align:right;">

\-760.335

</td>

<td style="text-align:right;">

425.926

</td>

<td style="text-align:right;">

\-1.785

</td>

<td style="text-align:right;">

0.075

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeProfessional

</td>

<td style="text-align:right;">

\-783.343

</td>

<td style="text-align:right;">

524.284

</td>

<td style="text-align:right;">

\-1.494

</td>

<td style="text-align:right;">

0.136

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeProtection

</td>

<td style="text-align:right;">

\-370.443

</td>

<td style="text-align:right;">

387.285

</td>

<td style="text-align:right;">

\-0.957

</td>

<td style="text-align:right;">

0.339

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeRetired

</td>

<td style="text-align:right;">

\-663.005

</td>

<td style="text-align:right;">

233.353

</td>

<td style="text-align:right;">

\-2.841

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

\-161.608

</td>

<td style="text-align:right;">

142.877

</td>

<td style="text-align:right;">

\-1.131

</td>

<td style="text-align:right;">

0.259

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeServices

</td>

<td style="text-align:right;">

\-151.918

</td>

<td style="text-align:right;">

139.082

</td>

<td style="text-align:right;">

\-1.092

</td>

<td style="text-align:right;">

0.275

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeStudent

</td>

<td style="text-align:right;">

21.989

</td>

<td style="text-align:right;">

539.360

</td>

<td style="text-align:right;">

0.041

</td>

<td style="text-align:right;">

0.967

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeTechnical Worker

</td>

<td style="text-align:right;">

\-237.393

</td>

<td style="text-align:right;">

241.065

</td>

<td style="text-align:right;">

\-0.985

</td>

<td style="text-align:right;">

0.325

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeTransportation

</td>

<td style="text-align:right;">

\-146.153

</td>

<td style="text-align:right;">

161.297

</td>

<td style="text-align:right;">

\-0.906

</td>

<td style="text-align:right;">

0.365

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeUnemployed (seeking work)

</td>

<td style="text-align:right;">

\-741.020

</td>

<td style="text-align:right;">

334.276

</td>

<td style="text-align:right;">

\-2.217

</td>

<td style="text-align:right;">

0.027

</td>

</tr>

<tr>

<td style="text-align:left;">

usdur1

</td>

<td style="text-align:right;">

1.554

</td>

<td style="text-align:right;">

0.764

</td>

<td style="text-align:right;">

2.034

</td>

<td style="text-align:right;">

0.043

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Legal resident

</td>

<td style="text-align:right;">

81.431

</td>

<td style="text-align:right;">

152.044

</td>

<td style="text-align:right;">

0.536

</td>

<td style="text-align:right;">

0.593

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Temporary: Tourist/visitor

</td>

<td style="text-align:right;">

\-82.484

</td>

<td style="text-align:right;">

156.652

</td>

<td style="text-align:right;">

\-0.527

</td>

<td style="text-align:right;">

0.599

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Undocumented

</td>

<td style="text-align:right;">

\-57.734

</td>

<td style="text-align:right;">

125.192

</td>

<td style="text-align:right;">

\-0.461

</td>

<td style="text-align:right;">

0.645

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityFresno, CA

</td>

<td style="text-align:right;">

\-212.253

</td>

<td style="text-align:right;">

315.556

</td>

<td style="text-align:right;">

\-0.673

</td>

<td style="text-align:right;">

0.502

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityLos Angeles-Long Beach, CA

</td>

<td style="text-align:right;">

\-284.197

</td>

<td style="text-align:right;">

301.332

</td>

<td style="text-align:right;">

\-0.943

</td>

<td style="text-align:right;">

0.346

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityMerced, CA

</td>

<td style="text-align:right;">

\-328.395

</td>

<td style="text-align:right;">

319.542

</td>

<td style="text-align:right;">

\-1.028

</td>

<td style="text-align:right;">

0.305

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityOrange County, CA

</td>

<td style="text-align:right;">

\-152.426

</td>

<td style="text-align:right;">

308.021

</td>

<td style="text-align:right;">

\-0.495

</td>

<td style="text-align:right;">

0.621

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityRiverside-San Bernardino, CA

</td>

<td style="text-align:right;">

\-243.682

</td>

<td style="text-align:right;">

314.826

</td>

<td style="text-align:right;">

\-0.774

</td>

<td style="text-align:right;">

0.439

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySacramento, CA

</td>

<td style="text-align:right;">

\-153.572

</td>

<td style="text-align:right;">

359.705

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

uscitySan Diego, CA

</td>

<td style="text-align:right;">

\-191.842

</td>

<td style="text-align:right;">

311.964

</td>

<td style="text-align:right;">

\-0.615

</td>

<td style="text-align:right;">

0.539

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySan Francisco, CA

</td>

<td style="text-align:right;">

\-489.307

</td>

<td style="text-align:right;">

350.513

</td>

<td style="text-align:right;">

\-1.396

</td>

<td style="text-align:right;">

0.163

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySan Jose, CA

</td>

<td style="text-align:right;">

\-409.300

</td>

<td style="text-align:right;">

324.644

</td>

<td style="text-align:right;">

\-1.261

</td>

<td style="text-align:right;">

0.208

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySanta Barbara-Santa Maria-Lompoc, CA

</td>

<td style="text-align:right;">

\-264.624

</td>

<td style="text-align:right;">

333.898

</td>

<td style="text-align:right;">

\-0.793

</td>

<td style="text-align:right;">

0.428

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySanta Cruz-Watsonville, CA

</td>

<td style="text-align:right;">

\-402.938

</td>

<td style="text-align:right;">

353.813

</td>

<td style="text-align:right;">

\-1.139

</td>

<td style="text-align:right;">

0.255

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityVallejo-Fairfield-Napa, CA

</td>

<td style="text-align:right;">

103.069

</td>

<td style="text-align:right;">

349.434

</td>

<td style="text-align:right;">

0.295

</td>

<td style="text-align:right;">

0.768

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityVentura, CA

</td>

<td style="text-align:right;">

\-167.287

</td>

<td style="text-align:right;">

334.519

</td>

<td style="text-align:right;">

\-0.500

</td>

<td style="text-align:right;">

0.617

</td>

</tr>

<tr>

<td style="text-align:left;">

age:edyrs

</td>

<td style="text-align:right;">

2.431

</td>

<td style="text-align:right;">

0.595

</td>

<td style="text-align:right;">

4.085

</td>

<td style="text-align:right;">

0.000

</td>

</tr>

<tr>

<td style="text-align:left;">

sexM:usdur1

</td>

<td style="text-align:right;">

\-1.594

</td>

<td style="text-align:right;">

0.841

</td>

<td style="text-align:right;">

\-1.896

</td>

<td style="text-align:right;">

0.059

</td>

</tr>

</tbody>

</table>

    ## Start:  AIC=6422.12
    ## hhincome ~ sex + age + statebrn + marstat + edyrs + occtype + 
    ##     usdur1 + usdoc1 + uscity + age * edyrs + sex * usdur1
    ## 
    ##              Df Sum of Sq       RSS    AIC
    ## - uscity     13   3183264 114190375 6410.6
    ## - marstat     5    567657 111574768 6414.7
    ## - statebrn   15   5425427 116432538 6416.6
    ## - occtype    17   6755194 117762305 6418.4
    ## - usdoc1      3    604882 111611994 6418.9
    ## <none>                    111007111 6422.1
    ## - sex:usdur1  1    880755 111887866 6424.2
    ## - age:edyrs   1   4088973 115096084 6438.7
    ## 
    ## Step:  AIC=6410.62
    ## hhincome ~ sex + age + statebrn + marstat + edyrs + occtype + 
    ##     usdur1 + usdoc1 + age:edyrs + sex:usdur1
    ## 
    ##              Df Sum of Sq       RSS    AIC
    ## - marstat     5    755753 114946128 6404.0
    ## - occtype    17   6334851 120525226 6404.3
    ## - statebrn   15   5824099 120014475 6406.1
    ## - usdoc1      3   1028134 115218509 6409.2
    ## <none>                    114190375 6410.6
    ## - sex:usdur1  1    913828 115104203 6412.7
    ## - age:edyrs   1   4272702 118463078 6427.5
    ## 
    ## Step:  AIC=6404.01
    ## hhincome ~ sex + age + statebrn + edyrs + occtype + usdur1 + 
    ##     usdoc1 + age:edyrs + sex:usdur1
    ## 
    ##              Df Sum of Sq       RSS    AIC
    ## - occtype    17   6181338 121127466 6396.9
    ## - statebrn   15   6223597 121169725 6401.1
    ## - usdoc1      3   1091590 116037718 6402.9
    ## <none>                    114946128 6404.0
    ## - sex:usdur1  1    980654 115926782 6406.4
    ## - age:edyrs   1   4590207 119536336 6422.1
    ## 
    ## Step:  AIC=6396.88
    ## hhincome ~ sex + age + statebrn + edyrs + usdur1 + usdoc1 + age:edyrs + 
    ##     sex:usdur1
    ## 
    ##              Df Sum of Sq       RSS    AIC
    ## - statebrn   15   5878589 127006055 6391.2
    ## - usdoc1      3    864972 121992439 6394.5
    ## <none>                    121127466 6396.9
    ## - sex:usdur1  1    484775 121612242 6396.9
    ## - age:edyrs   1   5217405 126344871 6416.5
    ## 
    ## Step:  AIC=6391.19
    ## hhincome ~ sex + age + edyrs + usdur1 + usdoc1 + age:edyrs + 
    ##     sex:usdur1
    ## 
    ##              Df Sum of Sq       RSS    AIC
    ## <none>                    127006055 6391.2
    ## - sex:usdur1  1    574028 127580083 6391.5
    ## - usdoc1      3   1640814 128646869 6391.8
    ## - age:edyrs   1   5990044 132996099 6412.8

| term                             | estimate | std.error | statistic | p.value |  conf.low | conf.high |
| :------------------------------- | -------: | --------: | --------: | ------: | --------: | --------: |
| (Intercept)                      |  456.946 |   174.409 |     2.620 |   0.009 |   114.286 |   799.606 |
| sexM                             |  289.409 |   118.992 |     2.432 |   0.015 |    55.627 |   523.191 |
| age                              |  \-7.630 |     3.927 |   \-1.943 |   0.053 |  \-15.345 |     0.085 |
| edyrs                            |   24.947 |     6.785 |     3.677 |   0.000 |    11.616 |    38.277 |
| usdur1                           |    1.122 |     0.718 |     1.563 |   0.119 |   \-0.289 |     2.533 |
| usdoc1Legal resident             |  166.464 |   137.544 |     1.210 |   0.227 | \-103.767 |   436.695 |
| usdoc1Temporary: Tourist/visitor | \-94.505 |   143.726 |   \-0.658 |   0.511 | \-376.882 |   187.871 |
| usdoc1Undocumented               | \-41.715 |   114.287 |   \-0.365 |   0.715 | \-266.252 |   182.823 |
| age:edyrs                        |    2.712 |     0.557 |     4.871 |   0.000 |     1.618 |     3.805 |
| sexM:usdur1                      |  \-1.184 |     0.785 |   \-1.508 |   0.132 |   \-2.727 |     0.359 |

    ##                             sexM                              age 
    ##                         1.231920                         4.416134 
    ##                            edyrs                           usdur1 
    ##                         1.309849                         6.120565 
    ##             usdoc1Legal resident usdoc1Temporary: Tourist/visitor 
    ##                         2.699919                         2.382893 
    ##               usdoc1Undocumented                        age:edyrs 
    ##                         4.068942                         3.688662 
    ##                      sexM:usdur1 
    ##                         5.919296

We observed that neither new models have large VIF, which is good. To
choose between the two we need to see if the interaction term
sex\*usdur1 is significant enough:

| Res.Df |       RSS | Df | Sum of Sq | Pr(\>Chi) |
| -----: | --------: | -: | --------: | --------: |
|    507 | 135395133 | NA |        NA |        NA |
|    503 | 127006055 |  4 |   8389077 |         0 |

Since the p-value is 0, we have confidence that the interaction
sex\*usdur1 is significant. Also, we agreed to err on the side of false
positive. Hence, we will include more variables, and choose the
reduced\_int\_new\_2 model to proceed.

### 4.2 Constant Variance

### 4.2.1 Residuals vs. Factors

Below is the plots of residuals against each quantitative
predictor:

![](regression-analysis_files/figure-gfm/factor_residual_scatterplot-1.png)<!-- -->

From the pairs plot above, there is a possibility that the constant
variance for ‘usdur1’ is violated, because the scatterplot shows a
reserved-fan shape. However, this could also be due to the fact that we
have more data points on the lower range as compared to the upper range.
Even though, the data looks sparser on the right, the spread is still
large.

We believe that this violation of constant variance may result from
certain migration patterns- seasonal workers which come to the US for a
short period of time would expect to see different household incomes
than long-term migrants. We can examine the distribution of duration of
first US migration.

![](regression-analysis_files/figure-gfm/usdurl-plot-1.png)<!-- -->

    ## # A tibble: 2 x 2
    ##   seasonal     n
    ##   <chr>    <int>
    ## 1 N          411
    ## 2 Y          102

![](regression-analysis_files/figure-gfm/create-seasonal-var-1.png)<!-- -->![](regression-analysis_files/figure-gfm/create-seasonal-var-2.png)<!-- -->

We create a new categorical variable called `seasonal` to classify
migrants with a last US migration shorter than 6 months as seasonal
workers. We chose 6 months because anything longer than that should not
be considered seasonal, and roughly a quarter of the migrants in the
dataset fall into this category.

Hence we fit our new full model:

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

809.976

</td>

<td style="text-align:right;">

560.238

</td>

<td style="text-align:right;">

1.446

</td>

<td style="text-align:right;">

0.149

</td>

</tr>

<tr>

<td style="text-align:left;">

sexM

</td>

<td style="text-align:right;">

415.051

</td>

<td style="text-align:right;">

187.177

</td>

<td style="text-align:right;">

2.217

</td>

<td style="text-align:right;">

0.027

</td>

</tr>

<tr>

<td style="text-align:left;">

age

</td>

<td style="text-align:right;">

\-6.306

</td>

<td style="text-align:right;">

4.373

</td>

<td style="text-align:right;">

\-1.442

</td>

<td style="text-align:right;">

0.150

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnChihuahua

</td>

<td style="text-align:right;">

\-32.384

</td>

<td style="text-align:right;">

620.587

</td>

<td style="text-align:right;">

\-0.052

</td>

<td style="text-align:right;">

0.958

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnCoahuila

</td>

<td style="text-align:right;">

1815.739

</td>

<td style="text-align:right;">

807.100

</td>

<td style="text-align:right;">

2.250

</td>

<td style="text-align:right;">

0.025

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnColima

</td>

<td style="text-align:right;">

\-138.680

</td>

<td style="text-align:right;">

375.028

</td>

<td style="text-align:right;">

\-0.370

</td>

<td style="text-align:right;">

0.712

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnGuanajuato

</td>

<td style="text-align:right;">

18.522

</td>

<td style="text-align:right;">

376.503

</td>

<td style="text-align:right;">

0.049

</td>

<td style="text-align:right;">

0.961

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnGuerrero

</td>

<td style="text-align:right;">

167.286

</td>

<td style="text-align:right;">

393.049

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

statebrnJalisco

</td>

<td style="text-align:right;">

19.785

</td>

<td style="text-align:right;">

373.924

</td>

<td style="text-align:right;">

0.053

</td>

<td style="text-align:right;">

0.958

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnMexico City

</td>

<td style="text-align:right;">

395.188

</td>

<td style="text-align:right;">

437.178

</td>

<td style="text-align:right;">

0.904

</td>

<td style="text-align:right;">

0.367

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnMichoacán

</td>

<td style="text-align:right;">

7.466

</td>

<td style="text-align:right;">

372.369

</td>

<td style="text-align:right;">

0.020

</td>

<td style="text-align:right;">

0.984

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnNayarit

</td>

<td style="text-align:right;">

238.372

</td>

<td style="text-align:right;">

375.458

</td>

<td style="text-align:right;">

0.635

</td>

<td style="text-align:right;">

0.526

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnOaxaca

</td>

<td style="text-align:right;">

206.058

</td>

<td style="text-align:right;">

385.580

</td>

<td style="text-align:right;">

0.534

</td>

<td style="text-align:right;">

0.593

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnPuebla

</td>

<td style="text-align:right;">

179.949

</td>

<td style="text-align:right;">

621.227

</td>

<td style="text-align:right;">

0.290

</td>

<td style="text-align:right;">

0.772

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnSan Luis Potosí

</td>

<td style="text-align:right;">

39.945

</td>

<td style="text-align:right;">

379.232

</td>

<td style="text-align:right;">

0.105

</td>

<td style="text-align:right;">

0.916

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnTamaulipas

</td>

<td style="text-align:right;">

\-407.281

</td>

<td style="text-align:right;">

620.486

</td>

<td style="text-align:right;">

\-0.656

</td>

<td style="text-align:right;">

0.512

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnVeracruz

</td>

<td style="text-align:right;">

174.272

</td>

<td style="text-align:right;">

525.051

</td>

<td style="text-align:right;">

0.332

</td>

<td style="text-align:right;">

0.740

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnZacatecas

</td>

<td style="text-align:right;">

147.548

</td>

<td style="text-align:right;">

371.880

</td>

<td style="text-align:right;">

0.397

</td>

<td style="text-align:right;">

0.692

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatDivorced

</td>

<td style="text-align:right;">

90.314

</td>

<td style="text-align:right;">

215.817

</td>

<td style="text-align:right;">

0.418

</td>

<td style="text-align:right;">

0.676

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatMarried

</td>

<td style="text-align:right;">

37.816

</td>

<td style="text-align:right;">

115.724

</td>

<td style="text-align:right;">

0.327

</td>

<td style="text-align:right;">

0.744

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatNever married

</td>

<td style="text-align:right;">

\-136.532

</td>

<td style="text-align:right;">

161.493

</td>

<td style="text-align:right;">

\-0.845

</td>

<td style="text-align:right;">

0.398

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatSeparated

</td>

<td style="text-align:right;">

57.850

</td>

<td style="text-align:right;">

230.543

</td>

<td style="text-align:right;">

0.251

</td>

<td style="text-align:right;">

0.802

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatWidowed

</td>

<td style="text-align:right;">

95.702

</td>

<td style="text-align:right;">

243.591

</td>

<td style="text-align:right;">

0.393

</td>

<td style="text-align:right;">

0.695

</td>

</tr>

<tr>

<td style="text-align:left;">

edyrs

</td>

<td style="text-align:right;">

13.266

</td>

<td style="text-align:right;">

7.889

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

occtypeAdministrator

</td>

<td style="text-align:right;">

58.786

</td>

<td style="text-align:right;">

263.892

</td>

<td style="text-align:right;">

0.223

</td>

<td style="text-align:right;">

0.824

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeAgriculture

</td>

<td style="text-align:right;">

\-347.462

</td>

<td style="text-align:right;">

136.303

</td>

<td style="text-align:right;">

\-2.549

</td>

<td style="text-align:right;">

0.011

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeArts

</td>

<td style="text-align:right;">

\-820.363

</td>

<td style="text-align:right;">

516.703

</td>

<td style="text-align:right;">

\-1.588

</td>

<td style="text-align:right;">

0.113

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeEducator

</td>

<td style="text-align:right;">

234.445

</td>

<td style="text-align:right;">

326.765

</td>

<td style="text-align:right;">

0.717

</td>

<td style="text-align:right;">

0.473

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeHomemaker

</td>

<td style="text-align:right;">

\-396.718

</td>

<td style="text-align:right;">

559.436

</td>

<td style="text-align:right;">

\-0.709

</td>

<td style="text-align:right;">

0.479

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeManufacturing (skilled)

</td>

<td style="text-align:right;">

\-152.488

</td>

<td style="text-align:right;">

132.627

</td>

<td style="text-align:right;">

\-1.150

</td>

<td style="text-align:right;">

0.251

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeManufacturing (unskilled)

</td>

<td style="text-align:right;">

\-239.145

</td>

<td style="text-align:right;">

135.931

</td>

<td style="text-align:right;">

\-1.759

</td>

<td style="text-align:right;">

0.079

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeOther, unspecified (disabled, incarcerated, tourist and other)

</td>

<td style="text-align:right;">

\-758.902

</td>

<td style="text-align:right;">

426.631

</td>

<td style="text-align:right;">

\-1.779

</td>

<td style="text-align:right;">

0.076

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeProfessional

</td>

<td style="text-align:right;">

\-779.867

</td>

<td style="text-align:right;">

525.998

</td>

<td style="text-align:right;">

\-1.483

</td>

<td style="text-align:right;">

0.139

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeProtection

</td>

<td style="text-align:right;">

\-370.499

</td>

<td style="text-align:right;">

387.709

</td>

<td style="text-align:right;">

\-0.956

</td>

<td style="text-align:right;">

0.340

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeRetired

</td>

<td style="text-align:right;">

\-662.326

</td>

<td style="text-align:right;">

233.706

</td>

<td style="text-align:right;">

\-2.834

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

\-160.588

</td>

<td style="text-align:right;">

143.394

</td>

<td style="text-align:right;">

\-1.120

</td>

<td style="text-align:right;">

0.263

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeServices

</td>

<td style="text-align:right;">

\-150.208

</td>

<td style="text-align:right;">

140.271

</td>

<td style="text-align:right;">

\-1.071

</td>

<td style="text-align:right;">

0.285

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeStudent

</td>

<td style="text-align:right;">

24.869

</td>

<td style="text-align:right;">

540.712

</td>

<td style="text-align:right;">

0.046

</td>

<td style="text-align:right;">

0.963

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeTechnical Worker

</td>

<td style="text-align:right;">

\-235.702

</td>

<td style="text-align:right;">

241.916

</td>

<td style="text-align:right;">

\-0.974

</td>

<td style="text-align:right;">

0.330

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeTransportation

</td>

<td style="text-align:right;">

\-145.487

</td>

<td style="text-align:right;">

161.609

</td>

<td style="text-align:right;">

\-0.900

</td>

<td style="text-align:right;">

0.368

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeUnemployed (seeking work)

</td>

<td style="text-align:right;">

\-738.685

</td>

<td style="text-align:right;">

335.449

</td>

<td style="text-align:right;">

\-2.202

</td>

<td style="text-align:right;">

0.028

</td>

</tr>

<tr>

<td style="text-align:left;">

usdur1

</td>

<td style="text-align:right;">

1.561

</td>

<td style="text-align:right;">

0.768

</td>

<td style="text-align:right;">

2.033

</td>

<td style="text-align:right;">

0.043

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Legal resident

</td>

<td style="text-align:right;">

80.330

</td>

<td style="text-align:right;">

152.605

</td>

<td style="text-align:right;">

0.526

</td>

<td style="text-align:right;">

0.599

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Temporary: Tourist/visitor

</td>

<td style="text-align:right;">

\-83.350

</td>

<td style="text-align:right;">

157.060

</td>

<td style="text-align:right;">

\-0.531

</td>

<td style="text-align:right;">

0.596

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Undocumented

</td>

<td style="text-align:right;">

\-57.815

</td>

<td style="text-align:right;">

125.332

</td>

<td style="text-align:right;">

\-0.461

</td>

<td style="text-align:right;">

0.645

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityFresno, CA

</td>

<td style="text-align:right;">

\-214.415

</td>

<td style="text-align:right;">

316.634

</td>

<td style="text-align:right;">

\-0.677

</td>

<td style="text-align:right;">

0.499

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityLos Angeles-Long Beach, CA

</td>

<td style="text-align:right;">

\-285.863

</td>

<td style="text-align:right;">

302.117

</td>

<td style="text-align:right;">

\-0.946

</td>

<td style="text-align:right;">

0.345

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityMerced, CA

</td>

<td style="text-align:right;">

\-329.199

</td>

<td style="text-align:right;">

319.992

</td>

<td style="text-align:right;">

\-1.029

</td>

<td style="text-align:right;">

0.304

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityOrange County, CA

</td>

<td style="text-align:right;">

\-154.469

</td>

<td style="text-align:right;">

309.028

</td>

<td style="text-align:right;">

\-0.500

</td>

<td style="text-align:right;">

0.617

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityRiverside-San Bernardino, CA

</td>

<td style="text-align:right;">

\-246.384

</td>

<td style="text-align:right;">

316.317

</td>

<td style="text-align:right;">

\-0.779

</td>

<td style="text-align:right;">

0.436

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySacramento, CA

</td>

<td style="text-align:right;">

\-155.657

</td>

<td style="text-align:right;">

360.697

</td>

<td style="text-align:right;">

\-0.432

</td>

<td style="text-align:right;">

0.666

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySan Diego, CA

</td>

<td style="text-align:right;">

\-194.149

</td>

<td style="text-align:right;">

313.150

</td>

<td style="text-align:right;">

\-0.620

</td>

<td style="text-align:right;">

0.536

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySan Francisco, CA

</td>

<td style="text-align:right;">

\-492.260

</td>

<td style="text-align:right;">

352.127

</td>

<td style="text-align:right;">

\-1.398

</td>

<td style="text-align:right;">

0.163

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySan Jose, CA

</td>

<td style="text-align:right;">

\-411.474

</td>

<td style="text-align:right;">

325.720

</td>

<td style="text-align:right;">

\-1.263

</td>

<td style="text-align:right;">

0.207

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySanta Barbara-Santa Maria-Lompoc, CA

</td>

<td style="text-align:right;">

\-266.608

</td>

<td style="text-align:right;">

334.847

</td>

<td style="text-align:right;">

\-0.796

</td>

<td style="text-align:right;">

0.426

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitySanta Cruz-Watsonville, CA

</td>

<td style="text-align:right;">

\-404.905

</td>

<td style="text-align:right;">

354.741

</td>

<td style="text-align:right;">

\-1.141

</td>

<td style="text-align:right;">

0.254

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityVallejo-Fairfield-Napa, CA

</td>

<td style="text-align:right;">

102.188

</td>

<td style="text-align:right;">

349.926

</td>

<td style="text-align:right;">

0.292

</td>

<td style="text-align:right;">

0.770

</td>

</tr>

<tr>

<td style="text-align:left;">

uscityVentura, CA

</td>

<td style="text-align:right;">

\-168.484

</td>

<td style="text-align:right;">

335.097

</td>

<td style="text-align:right;">

\-0.503

</td>

<td style="text-align:right;">

0.615

</td>

</tr>

<tr>

<td style="text-align:left;">

seasonalY

</td>

<td style="text-align:right;">

6.255

</td>

<td style="text-align:right;">

62.287

</td>

<td style="text-align:right;">

0.100

</td>

<td style="text-align:right;">

0.920

</td>

</tr>

<tr>

<td style="text-align:left;">

sexM:usdur1

</td>

<td style="text-align:right;">

\-1.592

</td>

<td style="text-align:right;">

0.842

</td>

<td style="text-align:right;">

\-1.890

</td>

<td style="text-align:right;">

0.059

</td>

</tr>

<tr>

<td style="text-align:left;">

age:edyrs

</td>

<td style="text-align:right;">

2.427

</td>

<td style="text-align:right;">

0.597

</td>

<td style="text-align:right;">

4.064

</td>

<td style="text-align:right;">

0.000

</td>

</tr>

</tbody>

</table>

backward selection:

    ## Start:  AIC=6424.11
    ## hhincome ~ sex + age + statebrn + marstat + edyrs + occtype + 
    ##     usdur1 + usdoc1 + uscity + sex * usdur1 + age * edyrs + seasonal
    ## 
    ##              Df Sum of Sq       RSS    AIC
    ## - uscity     13   3185513 114190148 6412.6
    ## - marstat     5    569580 111574214 6416.7
    ## - statebrn   15   5424137 116428771 6418.6
    ## - occtype    17   6731045 117735680 6420.3
    ## - usdoc1      3    594948 111599583 6420.8
    ## - seasonal    1      2476 111007111 6422.1
    ## <none>                    111004635 6424.1
    ## - sex:usdur1  1    877087 111881722 6426.1
    ## - age:edyrs   1   4056410 115061045 6440.5
    ## 
    ## Step:  AIC=6412.62
    ## hhincome ~ sex + age + statebrn + marstat + edyrs + occtype + 
    ##     usdur1 + usdoc1 + seasonal + sex:usdur1 + age:edyrs
    ## 
    ##              Df Sum of Sq       RSS    AIC
    ## - marstat     5    755844 114945991 6406.0
    ## - occtype    17   6322060 120512208 6406.3
    ## - statebrn   15   5824258 120014406 6408.1
    ## - seasonal    1       228 114190375 6410.6
    ## - usdoc1      3   1019967 115210115 6411.2
    ## <none>                    114190148 6412.6
    ## - sex:usdur1  1    912029 115102177 6414.7
    ## - age:edyrs   1   4248022 118438170 6429.4
    ## 
    ## Step:  AIC=6406
    ## hhincome ~ sex + age + statebrn + edyrs + occtype + usdur1 + 
    ##     usdoc1 + seasonal + sex:usdur1 + age:edyrs
    ## 
    ##              Df Sum of Sq       RSS    AIC
    ## - occtype    17   6174174 121120165 6398.8
    ## - statebrn   15   6223081 121169073 6403.1
    ## - seasonal    1       137 114946128 6404.0
    ## - usdoc1      3   1085054 116031045 6404.8
    ## <none>                    114945991 6406.0
    ## - sex:usdur1  1    980539 115926530 6408.4
    ## - age:edyrs   1   4572470 119518461 6424.0
    ## 
    ## Step:  AIC=6398.85
    ## hhincome ~ sex + age + statebrn + edyrs + usdur1 + usdoc1 + seasonal + 
    ##     sex:usdur1 + age:edyrs
    ## 
    ##              Df Sum of Sq       RSS    AIC
    ## - statebrn   15   5885262 127005428 6393.2
    ## - usdoc1      3    849592 121969758 6396.4
    ## - seasonal    1      7301 121127466 6396.9
    ## <none>                    121120165 6398.8
    ## - sex:usdur1  1    481199 121601365 6398.9
    ## - age:edyrs   1   5176340 126296505 6418.3
    ## 
    ## Step:  AIC=6393.19
    ## hhincome ~ sex + age + edyrs + usdur1 + usdoc1 + seasonal + sex:usdur1 + 
    ##     age:edyrs
    ## 
    ##              Df Sum of Sq       RSS    AIC
    ## - seasonal    1       627 127006055 6391.2
    ## <none>                    127005428 6393.2
    ## - sex:usdur1  1    573047 127578475 6393.5
    ## - usdoc1      3   1632077 128637504 6393.7
    ## - age:edyrs   1   5972382 132977810 6414.8
    ## 
    ## Step:  AIC=6391.19
    ## hhincome ~ sex + age + edyrs + usdur1 + usdoc1 + sex:usdur1 + 
    ##     age:edyrs
    ## 
    ##              Df Sum of Sq       RSS    AIC
    ## <none>                    127006055 6391.2
    ## - sex:usdur1  1    574028 127580083 6391.5
    ## - usdoc1      3   1640814 128646869 6391.8
    ## - age:edyrs   1   5990044 132996099 6412.8

| term                             | estimate | std.error | statistic | p.value |  conf.low | conf.high |
| :------------------------------- | -------: | --------: | --------: | ------: | --------: | --------: |
| (Intercept)                      |  456.946 |   174.409 |     2.620 |   0.009 |   114.286 |   799.606 |
| sexM                             |  289.409 |   118.992 |     2.432 |   0.015 |    55.627 |   523.191 |
| age                              |  \-7.630 |     3.927 |   \-1.943 |   0.053 |  \-15.345 |     0.085 |
| edyrs                            |   24.947 |     6.785 |     3.677 |   0.000 |    11.616 |    38.277 |
| usdur1                           |    1.122 |     0.718 |     1.563 |   0.119 |   \-0.289 |     2.533 |
| usdoc1Legal resident             |  166.464 |   137.544 |     1.210 |   0.227 | \-103.767 |   436.695 |
| usdoc1Temporary: Tourist/visitor | \-94.505 |   143.726 |   \-0.658 |   0.511 | \-376.882 |   187.871 |
| usdoc1Undocumented               | \-41.715 |   114.287 |   \-0.365 |   0.715 | \-266.252 |   182.823 |
| sexM:usdur1                      |  \-1.184 |     0.785 |   \-1.508 |   0.132 |   \-2.727 |     0.359 |
| age:edyrs                        |    2.712 |     0.557 |     4.871 |   0.000 |     1.618 |     3.805 |

The backward selection gave the same output as before, indicating that
the indicator “seasonal” is not significant enough for us to include it
in the final model.

Hence, we proceed with the rest of our assumption checking.

Below is the graph of residuals against categorical
predictor:

![](regression-analysis_files/figure-gfm/floorCat_residual-1.png)<!-- -->![](regression-analysis_files/figure-gfm/floorCat_residual-2.png)<!-- -->

From the boxplot, the median of each category floats around 0. While the
plot of male is relatively symmetrical, that of female is right skewed.
There isn’t any major
concerns

#### 4.2.2 Residual vs. Predicted

![](regression-analysis_files/figure-gfm/residuel-predicted-scatterplot-1.png)<!-- -->

The residual vs. predicted values scatterplot shows no discernible
patterns. There is a clustering of predictions between USD 500 and USD
1000, which makes sense because our input data does not have a lot of
rich households.

Overall, the graphs confirm the constant variance assumption is
satisfied.

### 4.3 Normality

#### 4.3.1 Histogram of Residuals

![](regression-analysis_files/figure-gfm/histogram-residuals-1.png)<!-- -->

#### 4.3.2 Normal-QQ Plot of Residuals

![](regression-analysis_files/figure-gfm/qqplot-1.png)<!-- -->

From the histogram, the shape of distribution of residuals has a right
skew. The Normal-QQ plot supports this finding, as the left half of the
line follows closely the theoretical diagonal, yet the right half
deviates from diagonal, showing that the right tail is skewed. Since we
have 513 observations, the model is robust enough to tolerate deviation
from normal.

### 4.4 Independence

Since we only included observations of heads of household, there will
not be dependence caused by similar demographics between family members.
However, some interdependence may arise since all observations are
geographically close to each other.

## 5\. Interpretations

Our final model is hhincome = 456.946 + 289.409 sexM - 7.630 age +
24.947 edyrs + 1.122 usdur1 + 166.464 usdoc1Legal resident - 94.505
usdoc1Temporary: Tourist/visitor - 41.715 usdoc1Undocumented + 2.712
age:edyrs - 1.184 sexM:usdur1

Intercept: Our model expects an average household income of $456.946 for
female Mexican migrants at age 39 who are contract workers (through the
now-discontinued Bracero program) with no years of education and a
duration of 43.99 months for first US migration, all else held constant.

Coefficient: All else constant, as compared to a female, a male’s
household income increases by $289.409; All else constant, with each
year of increase in age, the household income decreases by $7.630; All
else constant, with each year of increase in years of education, the
household income increases by $24.947; All else constant, with each
month of increase in duration in the US during first migration, the
household income increases by $1.122; All else constant, as compared to
a contract Bracero, the household income of a legal resident increases
by $166.464; All else constant, as compared to a contract Bracero, the
household income of a temporary visitor decreases by $94.505; All else
constant, as compared to a contract Bracero, the household income of an
undocumented person decreases by $41.715.

Interaction:

For every increase of one month in duration of first US migration above
43.99 months, we expect to see an increase of around 1.18 dollars in
household income for women and a (lesser) increase of 1.12 dollars in
income for men.

For every increase of one year of age, we expect to see an increase of
around 2.712+24.947= 27.66 dollars in household income for each year of
increase in education.

We note that being male increases expected income. This may have to do
with the gender wage gap, but more likely has to do with the type of
labour immigrants tend to do: often, this is physical labour that men,
who on average are larger, are more capable of performing. Similarly, we
would expect elderly immigrants to struggle with hard labour, and we
note that income falls as age increases.

As anticipated, more years of education increased income significantly.

The more time an immigrant had been in the US, the more income they
could expect to earn – this may have to do with the advantages of having
networks and stability, as well as overcoming language and cultural
barriers.

## 6\. Additional Work
