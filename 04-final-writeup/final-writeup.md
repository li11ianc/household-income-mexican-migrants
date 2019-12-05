Characteristics of Recent Mexican Immigrants to the United States that
Influence Household Income
================
Ben 10
12/05/2019

# \<\<\<\<\<\<\< HEAD

Your project goes here\! Before you submit, make sure your chunks are
turned off with `echo = FALSE`.

You can add sections as you see fit. At a minimum, you should have the
following sections:

> > > > > > > 84c0b5415d0e29f76350b248d5d32f6c9c88fd67 \#\# Section 1:
> > > > > > > Introduction (includes introduction and exploratory data
> > > > > > > analysis) \#\# 1. Introduction

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

“usstate1”: First US migration: State of residence

“usstatel”: Latest US migration: State of residence

“usplace1”: First US migration: City of residence (in place codes)

“usplacel”: Latest US migration: City of residence (in place codes)

“usdur1”: First US migration: Duration (in months)

“usdurl”: Latest US migration: Duration (in months)

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

![](final-writeup_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

Hence, we decided to concentrate on California alone. Since the
originial dataset is large, we have enough data left in California alone
to produce meaningful analysis.

#### 2.2.2 Cut Household Income Groups

Originally, the distribution of log(Household Income)- our response
variable- was bimodal and had a median of 412,647 dollars. It almost
looks like 3 separate distributions:

![](final-writeup_files/figure-gfm/nonfilt-income-plot-1.png)<!-- -->

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
income of those who already have jobs (income).

![](final-writeup_files/figure-gfm/hhincome-distribution-1.png)<!-- -->

Now the distribution of response variable (hhincome) looks like a right
skewed normal
distribution.

<img src="final-writeup_files/figure-gfm/cities-1.png" style="display: block; margin: auto;" />

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
first US migration is 43.99 months (less than 3.5
years).

## Section 2: Regression Analysis (includes the final model and discussion of assumptions)

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

#### 2.2.5 Remove Obvious Collinear Variable

<img src="final-writeup_files/figure-gfm/yrborn-age-1.png" style="display: block; margin: auto;" />

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

<<<<<<< HEAD
## Section 5: Additional Work

augment mig\_output \<- augment(model1) %\>% mutate(obs\_num =
row\_number()) .hat: leverage .cooksd: Cook’s distance .std.resid:
standardized residuals

leverage\_threshold \<- 2\*(5+1)/nrow(tips) ggplot(data = tips\_output,
aes(x = obs\_num,y = .hat)) + geom\_point(alpha = 0.7) +
geom\_hline(yintercept = leverage\_threshold,color = “red”)+ labs(x =
“Observation Number”,y = “Leverage”,title = “Leverage”) +
geom\_text(aes(label=ifelse(.hat \> leverage\_threshold,
as.character(obs\_num), "")), nudge\_x = 4)

tips\_output %\>% filter(.hat \> leverage\_threshold) %\>% select(Party,
Meal, Age)

ggplot(data = tips\_output, aes(x = .fitted,y = .std.resid)) +
geom\_point(alpha = 0.7) + geom\_hline(yintercept = 0,color = “red”) +
geom\_hline(yintercept = -2,color = “red”,linetype = “dotted”) +
geom\_hline(yintercept = 2,color = “red”,linetype = “dotted”) + labs(x
=“Predicted Value”,y =“Standardized Residuals”,title = “Standardized
Residuals vs. Predicted”) + geom\_text(aes(label =
ifelse(abs(.std.resid) \>2,as.character(obs\_num),"")), nudge\_x = 0.3)

Standardized residuals vs. predictors\!\!\! make plots

tips\_output %\>% filter(abs(.std.resid) \> 2) %\>% select(Party, Meal,
Age, Tip)

Estimate of regression standard deviation, σ̂, using all observations

glance(model1)$sigma Estimate of σ̂ without points with large magnitude
standardized residuals

tips\_output %\>% filter(abs(.std.resid) \<= 2) %\>%
summarise(sigma\_est = sqrt(sum(.resid^2)/(n() - 5 - 1)))

Recall that we use σ̂ to calculate the standard errors for all
confidence intervals and p-values, so outliers can affect conclusions
drawn from model

library(rms) tidy(vif(model1))
=======
We observed that the variable selection changed. Specifically, usdur1
and usdoc1 are significant, besides the 4 variables and the 2
interaction terms identified previously. \#\# Section 3: Discussion and
Limitations \#\# Section 4: Conclusion \#\# Section 5: Additional Work
>>>>>>> 84c0b5415d0e29f76350b248d5d32f6c9c88fd67
