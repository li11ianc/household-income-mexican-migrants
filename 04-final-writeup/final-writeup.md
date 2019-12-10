Characteristics of Recent Mexican Immigrants to California, USA, that
Influence Household Income
================
Ben 10
12/05/2019

## Section 1: Introduction (includes introduction and exploratory data analysis)

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
migrants from the same communities they surveyed in Mexico but who have
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

“sex”: Sex of immigrant

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

“usdoc1”: Type of documentation during first US migration

“occtype”: Category of occupation

“uscity”: City of residence during first US migration

Our response variable is household income: the total income for a single
household. We chose to use the multiple linear regression because our
response variable is numeric, and there are multiple predictor
variables.

## 2\. Exploratory Data Analysis

### 2.1 Data Cleaning

Due to the complexity of our original data, we did not include data
cleaning in the analysis. For more information, please see our proposal,
where all the data cleaning happens.

However, we did make some adjustment according to the feedback that
there is large imbalance of the amount of data between regions, and that
the distribution of the response variable is not normal. Below is the
update on our data cleaning:

### 1.4 Updated Data Exploration

#### 1.4.1 Filter Only Immigrants in California

According to our previous data exploration, we found that the
overwhelming majority of immigrants settled in California, as shown in
the graph
below:

![](final-writeup_files/figure-gfm/state-distribution-plot-1.png)<!-- -->

Hence, we decided to concentrate on California alone. Since the
originial dataset is large, we have enough data left in California alone
to produce meaningful analysis.

#### 1.4.2 Cut Household Income Groups

Originally, the distribution of Household Income- our response variable-
was bimodal and had a median of 412,647 dollars. A plot of household
income in natural units reveals very little information, due to a
scattering of very high incomes which blow up the range of the plot.
However, a logged plot reveals that household income almost looks like 3
separate distributions:

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
predictive and explanatory range: our model will only be able to predict
or explain the household income of those who already have jobs with
income.

![](final-writeup_files/figure-gfm/hhincome-distribution-1.png)<!-- -->

Now the distribution of response variable (hhincome) looks like a right
skewed normal
distribution.

#### 1.4.3 Group cities by region

<img src="final-writeup_files/figure-gfm/cities-1.png" style="display: block; margin: auto;" />

These immigrants to California arrived to the following cities:

Bay Area: Vallejo-Fairfield-Napa, San Francisco, San Jose, Santa
Cruz-Watsonville

Central California: Sacramento, Merced, Fresno, Bakersfield

Southern California: Santa Barbara-Santa Maria-Lompoc, Ventura, Los
Angeles-Long Beach, Orange County, Riverside-San Bernardino, and San
Diego.

We decided to simplify these cities into 3 regional categories: Bay
Area, Southern California and Central California.

Given the comparatively small number of cases in which no city was
reported, we deleted these instances. The majority of immigrants went to
LA-Long Beach area in Southern California.

#### 1.4.4 Remove Variable “relhead”

It turned out that all values from relhead (relationship to head of
household) in our cleaned data were “1” or head. So we will remove this
variable, as well as state variables since we are only using California
data. We will also remove place data since we are using uscity, and occ
since we are using occtype.

#### 1.4.5 Mean-center “age” , “usdur1” and “usdurl”

We must center age and usdurl in order to have a useful model intercept
interpretation.

    ## [1] 39.42495

    ## [1] 60.27096

    ## [1] 43.98635

    ## [1] 6.440546

The mean age in the dataset is 39.43 years ; the mean duration of last
US migration is 60.27 months (about 5 years); and the mean duration of
first US migration is 43.99 months (less than 3.5
years).

### 1.4.6 Remove El Salvador Data and regionalize state born variable

<img src="final-writeup_files/figure-gfm/states-1.png" style="display: block; margin: auto;" />

We do not have any data from seven states: Baja California Sur, Chiapas,
Hidalgo, Quintana Roo, Sinaloa, Tlaxcala, and Yucatán. We had a small
amount of non-Mexican data, which we omitted.

We divided the remaining states into the following regions:

South East Mexico: Tabasco, Oaxaca, Campeche, Veracruz

Northern Mexico: Coahuila, Chihuahua, Durango, Nuevo Leon, Sonora,
Tamaulipas, Baja California del Norte

Bajío: Aguascalientes, Guanajuato, Querétaro, San Luis Potosí, Zacatecas

Central Mexico: Mexico City, México, Morelos, Puebla

Pacific Coast: Colima, Guerrero, Jalisco, Michoacán,
Nayarit

#### 1.4.7 Remove Obvious Collinear Variable

<img src="final-writeup_files/figure-gfm/yrborn-age-1.png" style="display: block; margin: auto;" />

`yrborn` and `age` provide the same information and are perfectly
linear, therefore we decided to remove `yrborn` from consideration in
the model.

#### 1.4.8 Simplify Occupation Type

    ## # A tibble: 13 x 2
    ## # Groups:   occtype [13]
    ##    occtype                       n
    ##    <chr>                     <int>
    ##  1 Administrative support       19
    ##  2 Administrator                 5
    ##  3 Agriculture                 115
    ##  4 Arts                          1
    ##  5 Educator                      3
    ##  6 Manufacturing (skilled)     101
    ##  7 Manufacturing (unskilled)   102
    ##  8 Professional                  2
    ##  9 Protection                    2
    ## 10 Sales                        49
    ## 11 Services                     71
    ## 12 Technical Worker              6
    ## 13 Transportation               22

![](final-writeup_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

We first filter out migrants with occupations indicating lack of paid
employment, because our anaylsis focuses only on those
migrants

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
positive because we are dealing with a constantly fluctuating issue.

### 2.1 Description of Methods

In our first multiple linear regression model, we included all 19
variables. Then, we used backwards model selection to reduce the model
to 5 significant variables: edyrs, usdurl, sex, statebrn and age. We
used AIC as the criterion because immigration is a complex social issue,
hence we would prefer a model with many predictors and err on the side
of false-positive, rather than having a leaner model.

After inital backwards selection, we will explore the possible
interactions between remaining variables: edyrs, usdurl, sex, statebrn
and age, to determine if any are significant. The significant
interactions are:

age*edyrs: p = 0 \< 0.05  
(This interaction makes sense, because we expect older immigrants to be
more educated) sex*usdurl: p = 0.0303039 \< 0.05  
(This interaction is surprising, because it suggests that the change in
income with time in the US differs depending on the immigrant’s sex.
This potentially highlight the gender discrimination in workplace.)
statebrn*edyrs: p = 0.0002466 \< 0.05 (This interaction makes sense,
because we expect different region of Mexico have different level of
development and hence access to education.) statebrn*usdurl: p = 0.0012
\< 0.05 (This interaction makes sense, because immigrants from certain
regions in Mexico may have a easier time staying longer in California
because there is already a large community of immigrants from that
region there.)

Therefore, we included these interactions in our original full model,
and did backward selection again to get our final model. Our final model
dropped the interaction between sex\*usdurl, which is the one we found
that didn’t make sense immediately. Hence, we are confident about our
final model.

(Please see “Section 5 : Additional Work” for detailed coding process.)

### 2.2 Full Model after Evaluating Interactions

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

292.093

</td>

<td style="text-align:right;">

266.026

</td>

<td style="text-align:right;">

1.098

</td>

<td style="text-align:right;">

0.273

</td>

</tr>

<tr>

<td style="text-align:left;">

sexM

</td>

<td style="text-align:right;">

355.558

</td>

<td style="text-align:right;">

179.825

</td>

<td style="text-align:right;">

1.977

</td>

<td style="text-align:right;">

0.049

</td>

</tr>

<tr>

<td style="text-align:left;">

age

</td>

<td style="text-align:right;">

\-6.159

</td>

<td style="text-align:right;">

4.379

</td>

<td style="text-align:right;">

\-1.407

</td>

<td style="text-align:right;">

0.160

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnCentral Mexico

</td>

<td style="text-align:right;">

2592.408

</td>

<td style="text-align:right;">

883.726

</td>

<td style="text-align:right;">

2.933

</td>

<td style="text-align:right;">

0.004

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnNorthern Mexico

</td>

<td style="text-align:right;">

\-38.135

</td>

<td style="text-align:right;">

412.600

</td>

<td style="text-align:right;">

\-0.092

</td>

<td style="text-align:right;">

0.926

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnPacific Coast

</td>

<td style="text-align:right;">

145.301

</td>

<td style="text-align:right;">

96.510

</td>

<td style="text-align:right;">

1.506

</td>

<td style="text-align:right;">

0.133

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnSouth East Mexico

</td>

<td style="text-align:right;">

\-323.036

</td>

<td style="text-align:right;">

669.034

</td>

<td style="text-align:right;">

\-0.483

</td>

<td style="text-align:right;">

0.629

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatDivorced

</td>

<td style="text-align:right;">

154.227

</td>

<td style="text-align:right;">

208.087

</td>

<td style="text-align:right;">

0.741

</td>

<td style="text-align:right;">

0.459

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatMarried

</td>

<td style="text-align:right;">

26.483

</td>

<td style="text-align:right;">

111.742

</td>

<td style="text-align:right;">

0.237

</td>

<td style="text-align:right;">

0.813

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatNever married

</td>

<td style="text-align:right;">

\-176.336

</td>

<td style="text-align:right;">

155.478

</td>

<td style="text-align:right;">

\-1.134

</td>

<td style="text-align:right;">

0.257

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatSeparated

</td>

<td style="text-align:right;">

61.779

</td>

<td style="text-align:right;">

220.279

</td>

<td style="text-align:right;">

0.280

</td>

<td style="text-align:right;">

0.779

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatWidowed

</td>

<td style="text-align:right;">

\-65.290

</td>

<td style="text-align:right;">

239.025

</td>

<td style="text-align:right;">

\-0.273

</td>

<td style="text-align:right;">

0.785

</td>

</tr>

<tr>

<td style="text-align:left;">

edyrs

</td>

<td style="text-align:right;">

40.619

</td>

<td style="text-align:right;">

11.654

</td>

<td style="text-align:right;">

3.486

</td>

<td style="text-align:right;">

0.001

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeManufacturing

</td>

<td style="text-align:right;">

96.781

</td>

<td style="text-align:right;">

62.687

</td>

<td style="text-align:right;">

1.544

</td>

<td style="text-align:right;">

0.123

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeProfessional

</td>

<td style="text-align:right;">

206.852

</td>

<td style="text-align:right;">

107.317

</td>

<td style="text-align:right;">

1.927

</td>

<td style="text-align:right;">

0.055

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeService

</td>

<td style="text-align:right;">

158.660

</td>

<td style="text-align:right;">

68.504

</td>

<td style="text-align:right;">

2.316

</td>

<td style="text-align:right;">

0.021

</td>

</tr>

<tr>

<td style="text-align:left;">

usdur1

</td>

<td style="text-align:right;">

1.382

</td>

<td style="text-align:right;">

0.902

</td>

<td style="text-align:right;">

1.532

</td>

<td style="text-align:right;">

0.126

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Legal resident

</td>

<td style="text-align:right;">

\-8.308

</td>

<td style="text-align:right;">

142.493

</td>

<td style="text-align:right;">

\-0.058

</td>

<td style="text-align:right;">

0.954

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Temporary: Tourist/visitor

</td>

<td style="text-align:right;">

\-190.813

</td>

<td style="text-align:right;">

152.086

</td>

<td style="text-align:right;">

\-1.255

</td>

<td style="text-align:right;">

0.210

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Undocumented

</td>

<td style="text-align:right;">

\-153.857

</td>

<td style="text-align:right;">

119.229

</td>

<td style="text-align:right;">

\-1.290

</td>

<td style="text-align:right;">

0.198

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitycentcal

</td>

<td style="text-align:right;">

29.635

</td>

<td style="text-align:right;">

98.773

</td>

<td style="text-align:right;">

0.300

</td>

<td style="text-align:right;">

0.764

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitysocal

</td>

<td style="text-align:right;">

31.966

</td>

<td style="text-align:right;">

79.040

</td>

<td style="text-align:right;">

0.404

</td>

<td style="text-align:right;">

0.686

</td>

</tr>

<tr>

<td style="text-align:left;">

usdurl

</td>

<td style="text-align:right;">

1.125

</td>

<td style="text-align:right;">

0.444

</td>

<td style="text-align:right;">

2.531

</td>

<td style="text-align:right;">

0.012

</td>

</tr>

<tr>

<td style="text-align:left;">

age:edyrs

</td>

<td style="text-align:right;">

2.182

</td>

<td style="text-align:right;">

0.609

</td>

<td style="text-align:right;">

3.584

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

\-1.754

</td>

<td style="text-align:right;">

0.904

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

statebrnCentral Mexico:edyrs

</td>

<td style="text-align:right;">

\-321.323

</td>

<td style="text-align:right;">

116.354

</td>

<td style="text-align:right;">

\-2.762

</td>

<td style="text-align:right;">

0.006

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnNorthern Mexico:edyrs

</td>

<td style="text-align:right;">

28.718

</td>

<td style="text-align:right;">

45.291

</td>

<td style="text-align:right;">

0.634

</td>

<td style="text-align:right;">

0.526

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnPacific Coast:edyrs

</td>

<td style="text-align:right;">

\-35.998

</td>

<td style="text-align:right;">

13.430

</td>

<td style="text-align:right;">

\-2.680

</td>

<td style="text-align:right;">

0.008

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnSouth East Mexico:edyrs

</td>

<td style="text-align:right;">

19.019

</td>

<td style="text-align:right;">

36.078

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

statebrnCentral Mexico:usdurl

</td>

<td style="text-align:right;">

11.046

</td>

<td style="text-align:right;">

6.441

</td>

<td style="text-align:right;">

1.715

</td>

<td style="text-align:right;">

0.087

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnNorthern Mexico:usdurl

</td>

<td style="text-align:right;">

\-5.348

</td>

<td style="text-align:right;">

1.882

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

statebrnPacific Coast:usdurl

</td>

<td style="text-align:right;">

\-1.232

</td>

<td style="text-align:right;">

0.550

</td>

<td style="text-align:right;">

\-2.240

</td>

<td style="text-align:right;">

0.026

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnSouth East Mexico:usdurl

</td>

<td style="text-align:right;">

\-7.038

</td>

<td style="text-align:right;">

11.520

</td>

<td style="text-align:right;">

\-0.611

</td>

<td style="text-align:right;">

0.542

</td>

</tr>

</tbody>

</table>

### 2.3 Final model

    ## Start:  AIC=6197.51
    ## hhincome ~ sex + age + statebrn + marstat + edyrs + occtype + 
    ##     usdur1 + usdoc1 + uscity + age * edyrs + sex * usdur1 + statebrn * 
    ##     edyrs + statebrn * usdurl
    ## 
    ##                   Df Sum of Sq       RSS    AIC
    ## - marstat          5    990853 111749117 6191.9
    ## - uscity           2     39047 110797311 6193.7
    ## - usdoc1           3   1023232 111781496 6196.1
    ## <none>                         110758264 6197.5
    ## - occtype          3   1530017 112288281 6198.3
    ## - sex:usdur1       1    896476 111654740 6199.5
    ## - statebrn:usdurl  4   3624483 114382748 6205.5
    ## - statebrn:edyrs   4   3908846 114667110 6206.8
    ## - age:edyrs        1   3059507 113817771 6209.1
    ## 
    ## Step:  AIC=6191.94
    ## hhincome ~ sex + age + statebrn + edyrs + occtype + usdur1 + 
    ##     usdoc1 + uscity + usdurl + age:edyrs + sex:usdur1 + statebrn:edyrs + 
    ##     statebrn:usdurl
    ## 
    ##                   Df Sum of Sq       RSS    AIC
    ## - uscity           2     57689 111806806 6188.2
    ## - usdoc1           3   1130901 112880018 6191.0
    ## - occtype          3   1351608 113100725 6191.9
    ## <none>                         111749117 6191.9
    ## - sex:usdur1       1    791780 112540897 6193.5
    ## - statebrn:usdurl  4   3623158 115372275 6199.8
    ## - statebrn:edyrs   4   3765065 115514181 6200.4
    ## - age:edyrs        1   3518342 115267459 6205.4
    ## 
    ## Step:  AIC=6188.2
    ## hhincome ~ sex + age + statebrn + edyrs + occtype + usdur1 + 
    ##     usdoc1 + usdurl + age:edyrs + sex:usdur1 + statebrn:edyrs + 
    ##     statebrn:usdurl
    ## 
    ##                   Df Sum of Sq       RSS    AIC
    ## - usdoc1           3   1082077 112888883 6187.0
    ## <none>                         111806806 6188.2
    ## - occtype          3   1392744 113199550 6188.4
    ## - sex:usdur1       1    783093 112589899 6189.7
    ## - statebrn:usdurl  4   3606914 115413719 6196.0
    ## - statebrn:edyrs   4   3817195 115624000 6196.9
    ## - age:edyrs        1   3536160 115342965 6201.7
    ## 
    ## Step:  AIC=6186.99
    ## hhincome ~ sex + age + statebrn + edyrs + occtype + usdur1 + 
    ##     usdurl + age:edyrs + sex:usdur1 + statebrn:edyrs + statebrn:usdurl
    ## 
    ##                   Df Sum of Sq       RSS    AIC
    ## - occtype          3   1232975 114121858 6186.4
    ## <none>                         112888883 6187.0
    ## - sex:usdur1       1    711441 113600324 6188.1
    ## - statebrn:usdurl  4   4051621 116940503 6196.6
    ## - statebrn:edyrs   4   4321243 117210125 6197.7
    ## - age:edyrs        1   3222780 116111663 6199.0
    ## 
    ## Step:  AIC=6186.4
    ## hhincome ~ sex + age + statebrn + edyrs + usdur1 + usdurl + age:edyrs + 
    ##     sex:usdur1 + statebrn:edyrs + statebrn:usdurl
    ## 
    ##                   Df Sum of Sq       RSS    AIC
    ## <none>                         114121858 6186.4
    ## - sex:usdur1       1    486405 114608263 6186.5
    ## - statebrn:usdurl  4   4178233 118300091 6196.3
    ## - statebrn:edyrs   4   4627989 118749847 6198.2
    ## - age:edyrs        1   3624713 117746570 6200.0

| term                             |  estimate | std.error | statistic | p.value |   conf.low | conf.high |
| :------------------------------- | --------: | --------: | --------: | ------: | ---------: | --------: |
| (Intercept)                      |   256.460 |   149.652 |     1.714 |   0.087 |   \-37.598 |   550.518 |
| sexM                             |   349.983 |   120.389 |     2.907 |   0.004 |    113.426 |   586.540 |
| age                              |   \-5.058 |     3.811 |   \-1.327 |   0.185 |   \-12.548 |     2.431 |
| statebrnCentral Mexico           |  2471.655 |   877.546 |     2.817 |   0.005 |    747.331 |  4195.980 |
| statebrnNorthern Mexico          |  \-90.414 |   408.429 |   \-0.221 |   0.825 |  \-892.953 |   712.124 |
| statebrnPacific Coast            |   166.223 |    94.743 |     1.754 |   0.080 |   \-19.942 |   352.388 |
| statebrnSouth East Mexico        | \-253.250 |   662.826 |   \-0.382 |   0.703 | \-1555.663 |  1049.162 |
| edyrs                            |    49.454 |    10.979 |     4.505 |   0.000 |     27.882 |    71.027 |
| usdur1                           |     0.949 |     0.859 |     1.105 |   0.270 |    \-0.738 |     2.637 |
| usdurl                           |     1.276 |     0.432 |     2.955 |   0.003 |      0.427 |     2.124 |
| age:edyrs                        |     2.291 |     0.588 |     3.896 |   0.000 |      1.136 |     3.447 |
| sexM:usdur1                      |   \-1.225 |     0.858 |   \-1.427 |   0.154 |    \-2.910 |     0.461 |
| statebrnCentral Mexico:edyrs     | \-294.518 |   115.138 |   \-2.558 |   0.011 |  \-520.757 |  \-68.279 |
| statebrnNorthern Mexico:edyrs    |    42.055 |    44.537 |     0.944 |   0.346 |   \-45.457 |   129.567 |
| statebrnPacific Coast:edyrs      |  \-40.153 |    13.128 |   \-3.058 |   0.002 |   \-65.949 |  \-14.356 |
| statebrnSouth East Mexico:edyrs  |    21.415 |    35.242 |     0.608 |   0.544 |   \-47.832 |    90.663 |
| statebrnCentral Mexico:usdurl    |    11.167 |     6.422 |     1.739 |   0.083 |    \-1.452 |    23.786 |
| statebrnNorthern Mexico:usdurl   |   \-5.790 |     1.860 |   \-3.113 |   0.002 |    \-9.445 |   \-2.135 |
| statebrnPacific Coast:usdurl     |   \-1.285 |     0.537 |   \-2.393 |   0.017 |    \-2.340 |   \-0.230 |
| statebrnSouth East Mexico:usdurl |   \-5.324 |    11.430 |   \-0.466 |   0.642 |   \-27.782 |    17.135 |

### 2.4 Description of Method in Model Diagnostics

We checked leverage, standardized residuals, estimate of standard
deviation, cook’s distance, VIF and adjusted R-square. (Please see
“Section 5 : Additional Work” for detailed codes and graphs)

#### 2.4.1 Leverage

About a quarter of our observations are high leverage points, meaning
that their combinations of values for the predictor variables are very
far from the typical combinations in the data. Because human
circumstances and economic conditions are often so extremely variable,
we would not expect most migrants to share common values for the
predictor variables.

Of the individuals in the data with high leverage, two have extensive
educations and are relatively young and from Northern Mexico. Two are
closer to the median age, have 5 years of education, and are from
Central Mexico.

These points are potentially, but not certainly, influential points, so
we use other methods to sort out influential points.

#### 2.4.2 Standardized Residuals

The 5% of our observations with standardized residuals of magnitude
greater than 2 should be examined more closely- these are outliers, but
they may not have an impact on the regression line. We can look plots of
the standardized residuals versus all of our predictors. Plots of the
standardized residuals for each predictor variable reveal that, for the
most part, our data satisfies the constant variance assumption.

#### 2.4.3 Estimate of Standard Deviation

The estimate of our regression standard deviation using all observations
is 487.0997, whereas the standard deviation estimate without points with
large magnitude standardized residuals is 387.6239. Removing points with
large magnitude standardized residuals would affect our conclusions by
decreasing the standard error associated with our model coefficients,
however, we do not want to damage our model’s integrity and explanatory
power by removing too much human variability from the observations we
base it on. We will examine Cook’s Distance to see if any observations
have excessive overall impact or significantly affect the estimated
coefficients when removed.

#### 2.4.4 Cook’s Distance

Only one observation has a Cook’s Distance greater than 1. Hence, we
will remove this individual from our analysis because it exerts
significantly greater influence on the final coefficients of our model
and could distort our explanations.

#### 2.4.5 VIF

There are 3 coefficients with high VIFs (\>10):

statebrnCentral Mexico : 19.1 statebrnSouth East Mexico : 33.6
statebrnCentral Mexico:edyrs : 19.6 statebrnSouth East Mexico:usdurl :
24.3

The latter 2 VIFs could be related to the first 2. The first 2
coefficients have high collinearity because when we divided the birth
state into regions, there are very few and very geographically sparse
observations in the South East Mexico, and a lot more observations in
Central Mexico. Hence, in order to make each region more representative,
we included some of the ambiguous states that could possibly be included
in both regions into South East Mexico. Since the geographical regional
divide is subjective and continuous, we expect there to be collinearity.

#### 2.4.6 Adjusted R-squre

The adjusted R-square of our final model is 0.1443861, meaning that our
model explains around 14.4% of the variation in household income. This
is a small percentage. However, given that there are numerous social
determinants of income, and we only included Californian data and those
who have income between 1 and 60,000, the R-square seems reasonable.

## Section 3: Discussion and Limitations

### 3.1 Limitations

In order to complete an effective analysis in the time given, we greatly
simplified our raw data to predict our response variable, household
income. We ended up only analyzing a subgroup of the immigrants and
focused on those who migrated to California because they made up a large
majority of our dataset, anyway. However, because of that, our findings
may not be able to be generalized into other states in the US. If we
were given more time, we would’ve analyzed the entirety of the set.

Additionally, we cut a chunk of the data out because it appeared that
some of the income was reported in pesos and USD, though we are not
definitely sure. Further analysis could investigate why it appeared that
some income was reported in a potentially different currency and adjust
for it so we can include all observations in our analysis. We also cut
off the data with no income to avoid the influence of zero inflation on
the final model, hence biasing the model against immigrants who are
unemployed. Future models should be adjusted for zero inflation.

Moreover, in an attempt to simplify the variable “statebrn”, we grouped
observations into regions. However, in order to arrive at a balanced
grouping in terms of the number of observations in each region, we
artificially divided the regions geographically, rather than dividing
them according to socio-economic characteristics. As a result, the
household income in some regions, such as South East Mexico, has a wide
range. Furthermore, through compromising between geographic integrity
and number of observations in each region, the majority of observations
are still in Pacific Coast and Bajío regions due to the nature of the
data. Further work can look into weighing mechanisms for multiple linear
models.

According to our analysis of leverage and adjusted R-square, we conclude
that there might be many outliers in our data, which makes sense since
the immigrants has drastically different demographics and income. Hence,
our model should only be taken as a reference to analyse general trend,
rather than to predict precise income. Given that wage depends on
numerous socio-econoimic factors, our model is satisfactory, yet it
cannot tell the entire story.

If we could continue to work on the project, we would operate under the
assumption that the household income that is unusual was reported in
pesos and potentially recorded in the Mexico and split the data set into
two and investigate that. I think our model could be stronger if we were
able to include this very valuable data and inform our predictions with
this information.

### 3.2 Prediction

### 3.2.1 Effect of “Gender” on Wage

    ##        fit      lwr      upr
    ## 1 903.1686 833.5162 972.8209

For a male who is 39 years old (average age), has 6 years of education
(average edyrs), first immigrated to the US for 5 years (average
duration), and last immigrated to the US for 3 years and 7 months
(average duration), and was born in the region of “Bajío”, his predicted
wage is $893.32. We are 95% confident that the actual salary falls in
the interval of \[824.88, 961.76\].

    ##        fit      lwr      upr
    ## 1 553.1858 312.8893 793.4824

For a female who is 39 years old (average age), has 6 years of education
(average edyrs), first immigrated to the US for 5 years (average
duration), and last immigrated to the US for 3 years and 7 months
(average duration), and was born in the region of “Bajío”, her predicted
salary is $590.11. We are 95% confident that the actual salary falls in
the interval of \[370.68, 809.54\].

We can see from the prediction that there is a large gender wage gap,
since a male’s predicted wage is much higher than a female of the same
average demographics.

### 3.2.2 Effect of “State born” on Wage

We used male as a model input because the majority of the immigrants in
our data set are male. We used edyrs = 6 as the input because it is the
average number of years of education for the data set. The rest of the
inputs are 0 since those predictors are mean-centered.

    ##        fit      lwr      upr
    ## 1 903.1686 833.5162 972.8209

For a male who is 39 years old (average age), has 6 years of education
(average edyrs), first immigrated to the US for 5 years (average
duration), and last immigrated to the US for 3 years and 7 months
(average duration), and was born in the region of “Bajío”, his predicted
wage is $893.32 We are 95% confident that the actual salary falls in the
interval of \[824.88, 961.76\].

    ##        fit      lwr      upr
    ## 1 1607.715 1095.732 2119.699

For a male who is 39 years old (average age), has 6 years of education
(average edyrs), first immigrated to the US for 5 years (average
duration), and last immigrated to the US for 3 years and 7 months
(average duration), and was born in the region of of “Central Mexico”,
his predicted salary is $1611.19 We are 95% confident that the actual
salary falls in the interval of \[1101.47, 2120.91\].

    ##        fit      lwr      upr
    ## 1 1065.083 586.6262 1543.539

For a male who is 39 years old (average age), has 6 years of education
(average edyrs), first immigrated to the US for 5 years (average
duration), and last immigrated to the US for 3 years and 7 months
(average duration), and was born in the region of of “Northern Mexico”,
his predicted salary is $1056.73 We are 95% confident that the actual
salary falls in the interval of \[580.63, 1532.82\].

    ##        fit       lwr      upr
    ## 1 778.4103 -339.3509 1896.171

For a male who is 39 years old (average age), has 6 years of education
(average edyrs), first immigrated to the US for 5 years (average
duration), and last immigrated to the US for 3 years and 7 months
(average duration), and was born in the region of of “South East
Mexico”, his predicted salary is $788.32 We are 95% confident that the
actual salary falls in the interval of \[-324.9458, 961.76\].

    ##        fit      lwr      upr
    ## 1 828.4753 762.4723 894.4782

For a male who is 39 years old (average age), has 6 years of education
(average edyrs), first immigrated to the US for 5 years (average
duration), and last immigrated to the US for 3 years and 7 months
(average duration), and was born in the region of of “Pacific Coast”,
his predicted salary is $814.86 We are 95% confident that the actual
salary falls in the interval of \[750.97, 750.97\].

The prediction suggest a hierarchy in wage discrimination based on the
regions in Mexico that the immigrants are born in. Immigrants from the
region of Central Mexico has the highest predicted wage, followed by
Northern Mexico, Bajío, Pacific Coast, and South East Mexico has the
lowest average predicted wage. This is supported by literature on
economic inequality in Mexico. Specifically, early industrialization
started in Central and Northern Mexico, allowing more mobility and
opportunity for education and trade in these regions. In fact, in 2012,
the northern border states (6 of the 32) accounted for 52.87% of the
total export value. Therefore, it is possible that as a result,
immigrants from these regions have an easier time earning relative
higher wages than those from other regions.

However, it is worth noting that the confidence interval of South East
Mexico is very large, including as low as 0 and as high as $1901.58.
This could be due to the small sample size, as shown in the histogram
below:

![](final-writeup_files/figure-gfm/unnamed-chunk-9-1.png)<!-- -->

It may also be because this region was artifiically created from 4
distinct cultural/economic/geographic regions in Mexico: the Yucatan
Peninsula, Oaxaca, Veracruz and Chiapas & Tabasco. The regions were
combined in order to be useful for analysis, but with more data we would
have prefered to keep them as seperate regions, especially since
Veracruz is relatively better-off than the rest of the states.

## Section 4: Conclusion

Through our exploration and analysis, we found sex, age, years of
education, duration of last US immigration and region born to be
significant predictors of household income of Mexican immigrant living
in California. Among these, there are significant interactions between
region born and years of education, as well as between region born and
duration of last US stay.

From our predictions, we observe a large gender wage gap: the average
male has predicted wage of 893.32 USD, whereas the average female has
predicted wage of 590.11 USD. It is shocking that the average wage for
males in this sample is almost two times that of females in this sample.

We also observed regional differences in terms of where the immigrant
was born. Immigrants from the region of Central Mexico have the highest
predicted wage, followed by Northern Mexico, Bajío, Pacific Coast, and
South East Mexico has the lowest average predicted wage. However, since
there is a prominent imbalance in number of observations from various
regions, this conclusion should be taken with caution – for example, we
are notably missing data from two of the three states in the Yucatan
Peninsula in the South East of Mexico.

## Section 5: Additional Work

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

336.219

</td>

<td style="text-align:right;">

260.490

</td>

<td style="text-align:right;">

1.291

</td>

<td style="text-align:right;">

0.197

</td>

</tr>

<tr>

<td style="text-align:left;">

sexM

</td>

<td style="text-align:right;">

306.283

</td>

<td style="text-align:right;">

183.313

</td>

<td style="text-align:right;">

1.671

</td>

<td style="text-align:right;">

0.095

</td>

</tr>

<tr>

<td style="text-align:left;">

age

</td>

<td style="text-align:right;">

6.422

</td>

<td style="text-align:right;">

2.789

</td>

<td style="text-align:right;">

2.302

</td>

<td style="text-align:right;">

0.022

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnCentral Mexico

</td>

<td style="text-align:right;">

243.019

</td>

<td style="text-align:right;">

217.955

</td>

<td style="text-align:right;">

1.115

</td>

<td style="text-align:right;">

0.265

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnNorthern Mexico

</td>

<td style="text-align:right;">

\-84.806

</td>

<td style="text-align:right;">

235.097

</td>

<td style="text-align:right;">

\-0.361

</td>

<td style="text-align:right;">

0.718

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnPacific Coast

</td>

<td style="text-align:right;">

\-91.483

</td>

<td style="text-align:right;">

49.246

</td>

<td style="text-align:right;">

\-1.858

</td>

<td style="text-align:right;">

0.064

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnSouth East Mexico

</td>

<td style="text-align:right;">

112.737

</td>

<td style="text-align:right;">

125.783

</td>

<td style="text-align:right;">

0.896

</td>

<td style="text-align:right;">

0.371

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatDivorced

</td>

<td style="text-align:right;">

233.605

</td>

<td style="text-align:right;">

215.615

</td>

<td style="text-align:right;">

1.083

</td>

<td style="text-align:right;">

0.279

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatMarried

</td>

<td style="text-align:right;">

34.821

</td>

<td style="text-align:right;">

116.576

</td>

<td style="text-align:right;">

0.299

</td>

<td style="text-align:right;">

0.765

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatNever married

</td>

<td style="text-align:right;">

\-165.591

</td>

<td style="text-align:right;">

162.346

</td>

<td style="text-align:right;">

\-1.020

</td>

<td style="text-align:right;">

0.308

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatSeparated

</td>

<td style="text-align:right;">

74.747

</td>

<td style="text-align:right;">

229.565

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

marstatWidowed

</td>

<td style="text-align:right;">

95.702

</td>

<td style="text-align:right;">

242.640

</td>

<td style="text-align:right;">

0.394

</td>

<td style="text-align:right;">

0.693

</td>

</tr>

<tr>

<td style="text-align:left;">

edyrs

</td>

<td style="text-align:right;">

15.296

</td>

<td style="text-align:right;">

7.580

</td>

<td style="text-align:right;">

2.018

</td>

<td style="text-align:right;">

0.044

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeManufacturing

</td>

<td style="text-align:right;">

118.000

</td>

<td style="text-align:right;">

64.682

</td>

<td style="text-align:right;">

1.824

</td>

<td style="text-align:right;">

0.069

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeProfessional

</td>

<td style="text-align:right;">

258.447

</td>

<td style="text-align:right;">

108.580

</td>

<td style="text-align:right;">

2.380

</td>

<td style="text-align:right;">

0.018

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeService

</td>

<td style="text-align:right;">

149.976

</td>

<td style="text-align:right;">

70.720

</td>

<td style="text-align:right;">

2.121

</td>

<td style="text-align:right;">

0.034

</td>

</tr>

<tr>

<td style="text-align:left;">

usdur1

</td>

<td style="text-align:right;">

\-0.375

</td>

<td style="text-align:right;">

0.453

</td>

<td style="text-align:right;">

\-0.828

</td>

<td style="text-align:right;">

0.408

</td>

</tr>

<tr>

<td style="text-align:left;">

usdurl

</td>

<td style="text-align:right;">

0.856

</td>

<td style="text-align:right;">

0.388

</td>

<td style="text-align:right;">

2.207

</td>

<td style="text-align:right;">

0.028

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Legal resident

</td>

<td style="text-align:right;">

161.966

</td>

<td style="text-align:right;">

145.344

</td>

<td style="text-align:right;">

1.114

</td>

<td style="text-align:right;">

0.266

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Temporary: Tourist/visitor

</td>

<td style="text-align:right;">

\-144.299

</td>

<td style="text-align:right;">

155.965

</td>

<td style="text-align:right;">

\-0.925

</td>

<td style="text-align:right;">

0.355

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Undocumented

</td>

<td style="text-align:right;">

\-47.150

</td>

<td style="text-align:right;">

121.970

</td>

<td style="text-align:right;">

\-0.387

</td>

<td style="text-align:right;">

0.699

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitycentcal

</td>

<td style="text-align:right;">

39.085

</td>

<td style="text-align:right;">

102.900

</td>

<td style="text-align:right;">

0.380

</td>

<td style="text-align:right;">

0.704

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitysocal

</td>

<td style="text-align:right;">

40.916

</td>

<td style="text-align:right;">

82.303

</td>

<td style="text-align:right;">

0.497

</td>

<td style="text-align:right;">

0.619

</td>

</tr>

</tbody>

</table>

### 2.2 Backward selection

    ## Start:  AIC=6233.96
    ## hhincome ~ sex + age + statebrn + marstat + edyrs + occtype + 
    ##     usdur1 + usdurl + usdoc1 + uscity
    ## 
    ##            Df Sum of Sq       RSS    AIC
    ## - marstat   5   1117380 125170807 6228.4
    ## - uscity    2     64974 124118402 6230.2
    ## - usdur1    1    178991 124232419 6232.7
    ## - statebrn  4   1815643 125869071 6233.2
    ## <none>                  124053428 6234.0
    ## - usdoc1    3   1706651 125760078 6234.8
    ## - sex       1    729080 124782508 6234.9
    ## - occtype   3   1862901 125916329 6235.4
    ## - edyrs     1   1063307 125116735 6236.2
    ## - usdurl    1   1271734 125325161 6237.0
    ## - age       1   1384513 125437941 6237.5
    ## 
    ## Step:  AIC=6228.43
    ## hhincome ~ sex + age + statebrn + edyrs + occtype + usdur1 + 
    ##     usdurl + usdoc1 + uscity
    ## 
    ##            Df Sum of Sq       RSS    AIC
    ## - uscity    2     75805 125246612 6224.7
    ## - usdur1    1    214264 125385071 6227.3
    ## <none>                  125170807 6228.4
    ## - usdoc1    3   1729934 126900742 6229.3
    ## - occtype   3   1755477 126926284 6229.4
    ## - statebrn  4   2273850 127444657 6229.4
    ## - edyrs     1   1108665 126279473 6230.8
    ## - sex       1   1162270 126333077 6231.0
    ## - usdurl    1   1342243 126513050 6231.7
    ## - age       1   1857888 127028695 6233.8
    ## 
    ## Step:  AIC=6224.73
    ## hhincome ~ sex + age + statebrn + edyrs + occtype + usdur1 + 
    ##     usdurl + usdoc1
    ## 
    ##            Df Sum of Sq       RSS    AIC
    ## - usdur1    1    188932 125435544 6223.5
    ## <none>                  125246612 6224.7
    ## - usdoc1    3   1666878 126913490 6225.3
    ## - statebrn  4   2314226 127560838 6225.8
    ## - occtype   3   1814497 127061109 6225.9
    ## - edyrs     1   1094602 126341214 6227.1
    ## - sex       1   1156574 126403186 6227.3
    ## - usdurl    1   1311263 126557875 6227.9
    ## - age       1   1846482 127093094 6230.0
    ## 
    ## Step:  AIC=6223.48
    ## hhincome ~ sex + age + statebrn + edyrs + occtype + usdurl + 
    ##     usdoc1
    ## 
    ##            Df Sum of Sq       RSS    AIC
    ## <none>                  125435544 6223.5
    ## - usdoc1    3   1631114 127066657 6223.9
    ## - occtype   3   1796091 127231634 6224.6
    ## - statebrn  4   2353643 127789187 6224.7
    ## - edyrs     1   1146434 126581977 6226.0
    ## - sex       1   1309985 126745529 6226.7
    ## - usdurl    1   1324851 126760395 6226.7
    ## - age       1   1959638 127395182 6229.2

| term                             |  estimate | std.error | statistic | p.value |  conf.low | conf.high |
| :------------------------------- | --------: | --------: | --------: | ------: | --------: | --------: |
| (Intercept)                      |   426.973 |   187.806 |     2.273 |   0.023 |    57.956 |   795.990 |
| sexM                             |   277.772 |   123.678 |     2.246 |   0.025 |    34.759 |   520.785 |
| age                              |     7.381 |     2.687 |     2.747 |   0.006 |     2.101 |    12.660 |
| statebrnCentral Mexico           |   286.819 |   215.560 |     1.331 |   0.184 | \-136.733 |   710.371 |
| statebrnNorthern Mexico          | \-105.700 |   233.279 |   \-0.453 |   0.651 | \-564.066 |   352.667 |
| statebrnPacific Coast            | \-103.875 |    48.530 |   \-2.140 |   0.033 | \-199.231 |   \-8.519 |
| statebrnSouth East Mexico        |   108.414 |   125.040 |     0.867 |   0.386 | \-137.277 |   354.104 |
| edyrs                            |    15.712 |     7.478 |     2.101 |   0.036 |     1.018 |    30.406 |
| occtypeManufacturing             |   120.484 |    63.986 |     1.883 |   0.060 |   \-5.241 |   246.208 |
| occtypeProfessional              |   253.715 |   107.237 |     2.366 |   0.018 |    43.007 |   464.424 |
| occtypeService                   |   138.278 |    69.463 |     1.991 |   0.047 |     1.790 |   274.766 |
| usdurl                           |     0.646 |     0.286 |     2.259 |   0.024 |     0.084 |     1.207 |
| usdoc1Legal resident             |   176.353 |   144.014 |     1.225 |   0.221 | \-106.619 |   459.324 |
| usdoc1Temporary: Tourist/visitor |  \-90.471 |   150.968 |   \-0.599 |   0.549 | \-387.106 |   206.163 |
| usdoc1Undocumented               |  \-38.190 |   120.305 |   \-0.317 |   0.751 | \-274.576 |   198.197 |

Using backward selection based on AIC, we narrowed down to 6 variables:
sex, edyrs, usdurl, statebrn, occtype and age.

### 2.3 Interactions

To find potential interactions between the 6 variables, we used nested-F
test for each of the possible interactions:

After inital backwards selection, we will explore the possible
interactions between remaining variables: `edyrs`, `usdurl`, `sex`,
`statebrn`, `occtype`, and `age`, to determine if any are significant.

| Res.Df |       RSS |  Df | Sum of Sq | Pr(\>Chi) |
| -----: | --------: | --: | --------: | --------: |
|    483 | 125435544 |  NA |        NA |        NA |
|    485 | 127065556 | \-2 | \-1630012 |     0.043 |

First, we tested the interaction between `edyrs` and `usdurl`. The
p-value for this test was 0.7366925 \> 0.05, therefore we will not
include it in the model.

| Res.Df |       RSS |  Df |  Sum of Sq | Pr(\>Chi) |
| -----: | --------: | --: | ---------: | --------: |
|    483 | 125435544 |  NA |         NA |        NA |
|    485 | 125828875 | \-2 | \-393330.9 |     0.469 |

Then, we tested the interaction between `sex` and `usdurl`. The p-value
for this test was 0.0303039 \< 0.05, therefore we will include it in the
model.

| Res.Df |       RSS |  Df |  Sum of Sq | Pr(\>Chi) |
| -----: | --------: | --: | ---------: | --------: |
|    483 | 125435544 |  NA |         NA |        NA |
|    485 | 125805345 | \-2 | \-369801.2 |     0.491 |

Then, we tested the interaction between `age` and `usdurl`. The p-value
for this test was 0.1936359 \> 0.05, therefore we will not include it in
the model.

| Res.Df |       RSS |  Df | Sum of Sq | Pr(\>Chi) |
| -----: | --------: | --: | --------: | --------: |
|    483 | 125435544 |  NA |        NA |        NA |
|    485 | 126972268 | \-2 | \-1536724 |     0.052 |

Then, we tested the interaction between `sex` and `edyrs`. The p-value
for this test was 0.5024992 \> 0.05, therefore we will not include it in
the model.

| Res.Df |       RSS |  Df | Sum of Sq | Pr(\>Chi) |
| -----: | --------: | --: | --------: | --------: |
|    483 | 125435544 |  NA |        NA |        NA |
|    485 | 121885202 | \-2 |   3550342 |        NA |

Then, we tested the interaction between `age` and `edyrs`. The p-value
for this test was 0 \< 0.05, therefore we will include it in the model.

| Res.Df |       RSS |  Df | Sum of Sq | Pr(\>Chi) |
| -----: | --------: | --: | --------: | --------: |
|    483 | 125435544 |  NA |        NA |        NA |
|    485 | 126693476 | \-2 | \-1257932 |     0.089 |

Then, we tested the interaction between `age` and `sex`. The p-value for
this test was 0.2073624 \> 0.05, therefore we will not include it in the
model.

| Res.Df |       RSS | Df |  Sum of Sq | Pr(\>Chi) |
| -----: | --------: | -: | ---------: | --------: |
|    483 | 125435544 | NA |         NA |        NA |
|    483 | 126294203 |  0 | \-858659.4 |        NA |

Then, we tested the interaction between `statebrn` and `sex`. The
p-value for this test was 0.3796077\> 0.05, therefore we will not
include it in the model.

| Res.Df |       RSS | Df | Sum of Sq | Pr(\>Chi) |
| -----: | --------: | -: | --------: | --------: |
|    483 | 125435544 | NA |        NA |        NA |
|    482 | 125276638 |  1 |    158906 |     0.434 |

Then, we tested the interaction between `statebrn` and `age`. The
p-value for this test was 0.213341\> 0.05, therefore we will not include
it in the model.

| Res.Df |       RSS | Df | Sum of Sq | Pr(\>Chi) |
| -----: | --------: | -: | --------: | --------: |
|    483 | 125435544 | NA |        NA |        NA |
|    482 | 121749659 |  1 |   3685885 |         0 |

Then, we tested the interaction between `statebrn` and `edyrs`. The
p-value for this test was 0.0002466\< 0.05, therefore we will include it
in the model.

| Res.Df |       RSS | Df | Sum of Sq | Pr(\>Chi) |
| -----: | --------: | -: | --------: | --------: |
|    483 | 125435544 | NA |        NA |        NA |
|    482 | 122754658 |  1 |   2680886 |     0.001 |

Then, we tested the interaction between `statebrn` and `usdurl`. The
p-value for this test was 0.0012 \< 0.05, therefore we will include it
in the model.

| Res.Df |       RSS | Df | Sum of Sq | Pr(\>Chi) |
| -----: | --------: | -: | --------: | --------: |
|    483 | 125435544 | NA |        NA |        NA |
|    483 | 126664001 |  0 | \-1228457 |        NA |

Then, we tested the interaction between `occtype` and `sex`. The p-value
for this test was 0.0012 \< 0.05, therefore we will include it in the
model.

| Res.Df |       RSS | Df |  Sum of Sq | Pr(\>Chi) |
| -----: | --------: | -: | ---------: | --------: |
|    483 | 125435544 | NA |         NA |        NA |
|    483 | 125659815 |  0 | \-224271.7 |        NA |

Then, we tested the interaction between `occtype` and `age`. The p-value
for this test was 0.0012 \< 0.05, therefore we will include it in the
model.

| Res.Df |       RSS | Df | Sum of Sq | Pr(\>Chi) |
| -----: | --------: | -: | --------: | --------: |
|    483 | 125435544 | NA |        NA |        NA |
|    477 | 121508441 |  6 |   3927102 |     0.017 |

Then, we tested the interaction between `occtype` and `statebrn`. The
p-value for this test was 0.0012 \< 0.05, therefore we will include it
in the model.

| Res.Df |       RSS | Df |  Sum of Sq | Pr(\>Chi) |
| -----: | --------: | -: | ---------: | --------: |
|    483 | 125435544 | NA |         NA |        NA |
|    483 | 126386369 |  0 | \-950825.3 |        NA |

Then, we tested the interaction between `occtype` and `edyrs`. The
p-value for this test was 0.0012 \< 0.05, therefore we will include it
in the model.

| Res.Df |       RSS | Df |  Sum of Sq | Pr(\>Chi) |
| -----: | --------: | -: | ---------: | --------: |
|    483 | 125435544 | NA |         NA |        NA |
|    483 | 125770836 |  0 | \-335292.2 |        NA |

Then, we tested the interaction between `occtype` and `usdurl`. The
p-value for this test was 0.0012 \< 0.05, therefore we will include it
in the model.

Through nested F-test, we observed significant interactions between age
& edyrs, statebrn & edyrs, statebrn & usdurl, and between sex & usdurl,
with respective p-values of 0, 0.0002466, 0.0012 and 0.034 and will be
including them in our model.

### 2.4 Model with Interaction

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

262.662

</td>

<td style="text-align:right;">

146.350

</td>

<td style="text-align:right;">

1.795

</td>

<td style="text-align:right;">

0.073

</td>

</tr>

<tr>

<td style="text-align:left;">

sexM

</td>

<td style="text-align:right;">

339.082

</td>

<td style="text-align:right;">

117.239

</td>

<td style="text-align:right;">

2.892

</td>

<td style="text-align:right;">

0.004

</td>

</tr>

<tr>

<td style="text-align:left;">

age

</td>

<td style="text-align:right;">

\-4.860

</td>

<td style="text-align:right;">

3.797

</td>

<td style="text-align:right;">

\-1.280

</td>

<td style="text-align:right;">

0.201

</td>

</tr>

<tr>

<td style="text-align:left;">

edyrs

</td>

<td style="text-align:right;">

50.310

</td>

<td style="text-align:right;">

10.901

</td>

<td style="text-align:right;">

4.615

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

2.224

</td>

<td style="text-align:right;">

0.805

</td>

<td style="text-align:right;">

2.763

</td>

<td style="text-align:right;">

0.006

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnCentral Mexico

</td>

<td style="text-align:right;">

2498.073

</td>

<td style="text-align:right;">

876.344

</td>

<td style="text-align:right;">

2.851

</td>

<td style="text-align:right;">

0.005

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnNorthern Mexico

</td>

<td style="text-align:right;">

\-96.798

</td>

<td style="text-align:right;">

407.998

</td>

<td style="text-align:right;">

\-0.237

</td>

<td style="text-align:right;">

0.813

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnPacific Coast

</td>

<td style="text-align:right;">

172.548

</td>

<td style="text-align:right;">

94.159

</td>

<td style="text-align:right;">

1.833

</td>

<td style="text-align:right;">

0.067

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnSouth East Mexico

</td>

<td style="text-align:right;">

\-255.279

</td>

<td style="text-align:right;">

662.354

</td>

<td style="text-align:right;">

\-0.385

</td>

<td style="text-align:right;">

0.700

</td>

</tr>

<tr>

<td style="text-align:left;">

age:edyrs

</td>

<td style="text-align:right;">

2.289

</td>

<td style="text-align:right;">

0.588

</td>

<td style="text-align:right;">

3.895

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

\-1.103

</td>

<td style="text-align:right;">

0.828

</td>

<td style="text-align:right;">

\-1.332

</td>

<td style="text-align:right;">

0.184

</td>

</tr>

<tr>

<td style="text-align:left;">

edyrs:statebrnCentral Mexico

</td>

<td style="text-align:right;">

\-297.930

</td>

<td style="text-align:right;">

115.009

</td>

<td style="text-align:right;">

\-2.590

</td>

<td style="text-align:right;">

0.010

</td>

</tr>

<tr>

<td style="text-align:left;">

edyrs:statebrnNorthern Mexico

</td>

<td style="text-align:right;">

41.745

</td>

<td style="text-align:right;">

44.505

</td>

<td style="text-align:right;">

0.938

</td>

<td style="text-align:right;">

0.349

</td>

</tr>

<tr>

<td style="text-align:left;">

edyrs:statebrnPacific Coast

</td>

<td style="text-align:right;">

\-41.091

</td>

<td style="text-align:right;">

13.047

</td>

<td style="text-align:right;">

\-3.149

</td>

<td style="text-align:right;">

0.002

</td>

</tr>

<tr>

<td style="text-align:left;">

edyrs:statebrnSouth East Mexico

</td>

<td style="text-align:right;">

20.981

</td>

<td style="text-align:right;">

35.210

</td>

<td style="text-align:right;">

0.596

</td>

<td style="text-align:right;">

0.552

</td>

</tr>

<tr>

<td style="text-align:left;">

usdurl:statebrnCentral Mexico

</td>

<td style="text-align:right;">

11.203

</td>

<td style="text-align:right;">

6.415

</td>

<td style="text-align:right;">

1.746

</td>

<td style="text-align:right;">

0.081

</td>

</tr>

<tr>

<td style="text-align:left;">

usdurl:statebrnNorthern Mexico

</td>

<td style="text-align:right;">

\-5.903

</td>

<td style="text-align:right;">

1.849

</td>

<td style="text-align:right;">

\-3.192

</td>

<td style="text-align:right;">

0.002

</td>

</tr>

<tr>

<td style="text-align:left;">

usdurl:statebrnPacific Coast

</td>

<td style="text-align:right;">

\-1.264

</td>

<td style="text-align:right;">

0.536

</td>

<td style="text-align:right;">

\-2.359

</td>

<td style="text-align:right;">

0.019

</td>

</tr>

<tr>

<td style="text-align:left;">

usdurl:statebrnSouth East Mexico

</td>

<td style="text-align:right;">

\-5.422

</td>

<td style="text-align:right;">

11.421

</td>

<td style="text-align:right;">

\-0.475

</td>

<td style="text-align:right;">

0.635

</td>

</tr>

</tbody>

</table>

### 2.5 Backward Selection with Interaction

Since we observed 4 pairs of significant interactions, we will do the
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

318.269

</td>

<td style="text-align:right;">

264.563

</td>

<td style="text-align:right;">

1.203

</td>

<td style="text-align:right;">

0.230

</td>

</tr>

<tr>

<td style="text-align:left;">

sexM

</td>

<td style="text-align:right;">

328.483

</td>

<td style="text-align:right;">

178.348

</td>

<td style="text-align:right;">

1.842

</td>

<td style="text-align:right;">

0.066

</td>

</tr>

<tr>

<td style="text-align:left;">

age

</td>

<td style="text-align:right;">

\-6.170

</td>

<td style="text-align:right;">

4.377

</td>

<td style="text-align:right;">

\-1.410

</td>

<td style="text-align:right;">

0.159

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnCentral Mexico

</td>

<td style="text-align:right;">

2602.534

</td>

<td style="text-align:right;">

883.670

</td>

<td style="text-align:right;">

2.945

</td>

<td style="text-align:right;">

0.003

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnNorthern Mexico

</td>

<td style="text-align:right;">

\-36.669

</td>

<td style="text-align:right;">

412.579

</td>

<td style="text-align:right;">

\-0.089

</td>

<td style="text-align:right;">

0.929

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnPacific Coast

</td>

<td style="text-align:right;">

145.590

</td>

<td style="text-align:right;">

96.498

</td>

<td style="text-align:right;">

1.509

</td>

<td style="text-align:right;">

0.132

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnSouth East Mexico

</td>

<td style="text-align:right;">

\-322.903

</td>

<td style="text-align:right;">

668.980

</td>

<td style="text-align:right;">

\-0.483

</td>

<td style="text-align:right;">

0.630

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatDivorced

</td>

<td style="text-align:right;">

153.644

</td>

<td style="text-align:right;">

208.050

</td>

<td style="text-align:right;">

0.738

</td>

<td style="text-align:right;">

0.461

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatMarried

</td>

<td style="text-align:right;">

26.177

</td>

<td style="text-align:right;">

111.734

</td>

<td style="text-align:right;">

0.234

</td>

<td style="text-align:right;">

0.815

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatNever married

</td>

<td style="text-align:right;">

\-176.472

</td>

<td style="text-align:right;">

155.466

</td>

<td style="text-align:right;">

\-1.135

</td>

<td style="text-align:right;">

0.257

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatSeparated

</td>

<td style="text-align:right;">

59.654

</td>

<td style="text-align:right;">

220.252

</td>

<td style="text-align:right;">

0.271

</td>

<td style="text-align:right;">

0.787

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatWidowed

</td>

<td style="text-align:right;">

\-63.282

</td>

<td style="text-align:right;">

238.724

</td>

<td style="text-align:right;">

\-0.265

</td>

<td style="text-align:right;">

0.791

</td>

</tr>

<tr>

<td style="text-align:left;">

edyrs

</td>

<td style="text-align:right;">

40.724

</td>

<td style="text-align:right;">

11.651

</td>

<td style="text-align:right;">

3.495

</td>

<td style="text-align:right;">

0.001

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeManufacturing

</td>

<td style="text-align:right;">

96.675

</td>

<td style="text-align:right;">

62.671

</td>

<td style="text-align:right;">

1.543

</td>

<td style="text-align:right;">

0.124

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeProfessional

</td>

<td style="text-align:right;">

207.054

</td>

<td style="text-align:right;">

107.310

</td>

<td style="text-align:right;">

1.929

</td>

<td style="text-align:right;">

0.054

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeService

</td>

<td style="text-align:right;">

159.200

</td>

<td style="text-align:right;">

68.524

</td>

<td style="text-align:right;">

2.323

</td>

<td style="text-align:right;">

0.021

</td>

</tr>

<tr>

<td style="text-align:left;">

usdur1

</td>

<td style="text-align:right;">

\-0.373

</td>

<td style="text-align:right;">

0.453

</td>

<td style="text-align:right;">

\-0.824

</td>

<td style="text-align:right;">

0.410

</td>

</tr>

<tr>

<td style="text-align:left;">

usdurl

</td>

<td style="text-align:right;">

2.888

</td>

<td style="text-align:right;">

0.967

</td>

<td style="text-align:right;">

2.985

</td>

<td style="text-align:right;">

0.003

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Legal resident

</td>

<td style="text-align:right;">

\-8.477

</td>

<td style="text-align:right;">

142.468

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

usdoc1Temporary: Tourist/visitor

</td>

<td style="text-align:right;">

\-190.142

</td>

<td style="text-align:right;">

152.096

</td>

<td style="text-align:right;">

\-1.250

</td>

<td style="text-align:right;">

0.212

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Undocumented

</td>

<td style="text-align:right;">

\-154.523

</td>

<td style="text-align:right;">

119.207

</td>

<td style="text-align:right;">

\-1.296

</td>

<td style="text-align:right;">

0.196

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitycentcal

</td>

<td style="text-align:right;">

30.930

</td>

<td style="text-align:right;">

98.764

</td>

<td style="text-align:right;">

0.313

</td>

<td style="text-align:right;">

0.754

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitysocal

</td>

<td style="text-align:right;">

33.346

</td>

<td style="text-align:right;">

79.050

</td>

<td style="text-align:right;">

0.422

</td>

<td style="text-align:right;">

0.673

</td>

</tr>

<tr>

<td style="text-align:left;">

sexM:usdurl

</td>

<td style="text-align:right;">

\-1.766

</td>

<td style="text-align:right;">

0.902

</td>

<td style="text-align:right;">

\-1.957

</td>

<td style="text-align:right;">

0.051

</td>

</tr>

<tr>

<td style="text-align:left;">

age:edyrs

</td>

<td style="text-align:right;">

2.182

</td>

<td style="text-align:right;">

0.609

</td>

<td style="text-align:right;">

3.583

</td>

<td style="text-align:right;">

0.000

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnCentral Mexico:edyrs

</td>

<td style="text-align:right;">

\-323.330

</td>

<td style="text-align:right;">

116.356

</td>

<td style="text-align:right;">

\-2.779

</td>

<td style="text-align:right;">

0.006

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnNorthern Mexico:edyrs

</td>

<td style="text-align:right;">

28.503

</td>

<td style="text-align:right;">

45.290

</td>

<td style="text-align:right;">

0.629

</td>

<td style="text-align:right;">

0.529

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnPacific Coast:edyrs

</td>

<td style="text-align:right;">

\-36.128

</td>

<td style="text-align:right;">

13.429

</td>

<td style="text-align:right;">

\-2.690

</td>

<td style="text-align:right;">

0.007

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnSouth East Mexico:edyrs

</td>

<td style="text-align:right;">

18.868

</td>

<td style="text-align:right;">

36.074

</td>

<td style="text-align:right;">

0.523

</td>

<td style="text-align:right;">

0.601

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnCentral Mexico:usdurl

</td>

<td style="text-align:right;">

10.953

</td>

<td style="text-align:right;">

6.441

</td>

<td style="text-align:right;">

1.701

</td>

<td style="text-align:right;">

0.090

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnNorthern Mexico:usdurl

</td>

<td style="text-align:right;">

\-5.346

</td>

<td style="text-align:right;">

1.882

</td>

<td style="text-align:right;">

\-2.840

</td>

<td style="text-align:right;">

0.005

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnPacific Coast:usdurl

</td>

<td style="text-align:right;">

\-1.229

</td>

<td style="text-align:right;">

0.550

</td>

<td style="text-align:right;">

\-2.235

</td>

<td style="text-align:right;">

0.026

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnSouth East Mexico:usdurl

</td>

<td style="text-align:right;">

\-7.050

</td>

<td style="text-align:right;">

11.520

</td>

<td style="text-align:right;">

\-0.612

</td>

<td style="text-align:right;">

0.541

</td>

</tr>

</tbody>

</table>

    ## Start:  AIC=6197.43
    ## hhincome ~ sex + age + statebrn + marstat + edyrs + occtype + 
    ##     usdur1 + usdurl + usdoc1 + uscity + sex * usdurl + age * 
    ##     edyrs + statebrn * edyrs + statebrn * usdurl
    ## 
    ##                   Df Sum of Sq       RSS    AIC
    ## - marstat          5    984485 111726671 6191.8
    ## - uscity           2     42476 110784662 6193.6
    ## - usdoc1           3   1027057 111769243 6196.0
    ## - usdur1           1    161821 110904007 6196.2
    ## <none>                         110742186 6197.4
    ## - occtype          3   1537524 112279710 6198.3
    ## - sex:usdurl       1    912554 111654740 6199.5
    ## - statebrn:usdurl  4   3603746 114345932 6205.4
    ## - statebrn:edyrs   4   3939449 114681635 6206.8
    ## - age:edyrs        1   3058225 113800411 6209.0
    ## 
    ## Step:  AIC=6191.84
    ## hhincome ~ sex + age + statebrn + edyrs + occtype + usdur1 + 
    ##     usdurl + usdoc1 + uscity + sex:usdurl + age:edyrs + statebrn:edyrs + 
    ##     statebrn:usdurl
    ## 
    ##                   Df Sum of Sq       RSS    AIC
    ## - uscity           2     61419 111788090 6188.1
    ## - usdur1           1    180596 111907267 6190.6
    ## - usdoc1           3   1133921 112860593 6190.9
    ## <none>                         111726671 6191.8
    ## - occtype          3   1359225 113085897 6191.9
    ## - sex:usdurl       1    814226 112540897 6193.5
    ## - statebrn:usdurl  4   3603961 115330632 6199.7
    ## - statebrn:edyrs   4   3796798 115523469 6200.5
    ## - age:edyrs        1   3509462 115236133 6205.2
    ## 
    ## Step:  AIC=6188.11
    ## hhincome ~ sex + age + statebrn + edyrs + occtype + usdur1 + 
    ##     usdurl + usdoc1 + sex:usdurl + age:edyrs + statebrn:edyrs + 
    ##     statebrn:usdurl
    ## 
    ##                   Df Sum of Sq       RSS    AIC
    ## - usdur1           1    158820 111946909 6186.8
    ## - usdoc1           3   1082639 112870729 6186.9
    ## <none>                         111788090 6188.1
    ## - occtype          3   1399881 113187971 6188.3
    ## - sex:usdurl       1    801809 112589899 6189.7
    ## - statebrn:usdurl  4   3587743 115375833 6195.8
    ## - statebrn:edyrs   4   3850396 115638486 6197.0
    ## - age:edyrs        1   3528679 115316769 6201.6
    ## 
    ## Step:  AIC=6186.82
    ## hhincome ~ sex + age + statebrn + edyrs + occtype + usdurl + 
    ##     usdoc1 + sex:usdurl + age:edyrs + statebrn:edyrs + statebrn:usdurl
    ## 
    ##                   Df Sum of Sq       RSS    AIC
    ## - usdoc1           3   1062059 113008968 6185.5
    ## - occtype          3   1349581 113296490 6186.8
    ## <none>                         111946909 6186.8
    ## - sex:usdurl       1    672516 112619426 6187.8
    ## - statebrn:usdurl  4   3706233 115653142 6195.0
    ## - statebrn:edyrs   4   4035734 115982644 6196.5
    ## - age:edyrs        1   3544513 115491422 6200.3
    ## 
    ## Step:  AIC=6185.52
    ## hhincome ~ sex + age + statebrn + edyrs + occtype + usdurl + 
    ##     sex:usdurl + age:edyrs + statebrn:edyrs + statebrn:usdurl
    ## 
    ##                   Df Sum of Sq       RSS    AIC
    ## - occtype          3   1192024 114200993 6184.7
    ## <none>                         113008968 6185.5
    ## - sex:usdurl       1    615000 113623968 6186.2
    ## - statebrn:usdurl  4   4125180 117134148 6195.4
    ## - statebrn:edyrs   4   4540707 117549675 6197.1
    ## - age:edyrs        1   3220785 116229753 6197.5
    ## 
    ## Step:  AIC=6184.75
    ## hhincome ~ sex + age + statebrn + edyrs + usdurl + sex:usdurl + 
    ##     age:edyrs + statebrn:edyrs + statebrn:usdurl
    ## 
    ##                   Df Sum of Sq       RSS    AIC
    ## - sex:usdurl       1    422820 114623813 6184.6
    ## <none>                         114200993 6184.7
    ## - statebrn:usdurl  4   4240105 118441097 6194.9
    ## - statebrn:edyrs   4   4812613 119013605 6197.3
    ## - age:edyrs        1   3617710 117818703 6198.3
    ## 
    ## Step:  AIC=6184.59
    ## hhincome ~ sex + age + statebrn + edyrs + usdurl + age:edyrs + 
    ##     statebrn:edyrs + statebrn:usdurl
    ## 
    ##                   Df Sum of Sq       RSS    AIC
    ## <none>                         114623813 6184.6
    ## - sex              1   1766943 116390756 6190.2
    ## - statebrn:usdurl  4   4400499 119024312 6195.4
    ## - statebrn:edyrs   4   4779441 119403254 6196.9
    ## - age:edyrs        1   3871503 118495316 6199.1

| term                             |  estimate | std.error | statistic | p.value |   conf.low | conf.high |
| :------------------------------- | --------: | --------: | --------: | ------: | ---------: | --------: |
| (Intercept)                      |   288.775 |   145.147 |     1.990 |   0.047 |      3.572 |   573.978 |
| sexM                             |   315.506 |   115.988 |     2.720 |   0.007 |     87.599 |   543.412 |
| age                              |   \-5.173 |     3.792 |   \-1.364 |   0.173 |   \-12.625 |     2.278 |
| statebrnCentral Mexico           |  2491.134 |   877.034 |     2.840 |   0.005 |    767.833 |  4214.435 |
| statebrnNorthern Mexico          | \-100.649 |   408.316 |   \-0.246 |   0.805 |  \-902.958 |   701.659 |
| statebrnPacific Coast            |   174.061 |    94.228 |     1.847 |   0.065 |   \-11.090 |   359.213 |
| statebrnSouth East Mexico        | \-224.425 |   662.482 |   \-0.339 |   0.735 | \-1526.148 |  1077.298 |
| edyrs                            |    49.953 |    10.907 |     4.580 |   0.000 |     28.522 |    71.384 |
| usdurl                           |     1.252 |     0.341 |     3.676 |   0.000 |      0.583 |     1.922 |
| age:edyrs                        |     2.359 |     0.586 |     4.026 |   0.000 |      1.208 |     3.510 |
| statebrnCentral Mexico:edyrs     | \-296.701 |   115.098 |   \-2.578 |   0.010 |  \-522.858 |  \-70.544 |
| statebrnNorthern Mexico:edyrs    |    42.672 |    44.536 |     0.958 |   0.338 |   \-44.837 |   130.181 |
| statebrnPacific Coast:edyrs      |  \-40.966 |    13.057 |   \-3.137 |   0.002 |   \-66.623 |  \-15.310 |
| statebrnSouth East Mexico:edyrs  |    19.807 |    35.228 |     0.562 |   0.574 |   \-49.412 |    89.026 |
| statebrnCentral Mexico:usdurl    |    11.078 |     6.419 |     1.726 |   0.085 |    \-1.535 |    23.691 |
| statebrnNorthern Mexico:usdurl   |   \-6.036 |     1.848 |   \-3.266 |   0.001 |    \-9.668 |   \-2.405 |
| statebrnPacific Coast:usdurl     |   \-1.300 |     0.536 |   \-2.428 |   0.016 |    \-2.352 |   \-0.248 |
| statebrnSouth East Mexico:usdurl |   \-5.007 |    11.426 |   \-0.438 |   0.661 |   \-27.457 |    17.444 |

We observed that the variable selection changed. Specifically, usdur1 is
significant, besides the 4 variables and the 4 interaction terms
identified previously.

### 2.7 Model Diagnostics

![](final-writeup_files/figure-gfm/high-leverage-1.png)<!-- -->

    ## [1] 0.2911647

Just over a quarter of our observations are high leverage points,
meaning that their combinations of values for the predictor variables
are very far from the typical combinations in the data. Because human
circumstances and economic conditions are often so extremely variable,
we would not expect most migrants to share common values for the
predictor variables.

We can look at the four observations with the highest leverage:

    ## # A tibble: 5 x 15
    ##   hhincome sex      age statebrn edyrs usdur1 usdurl .fitted .se.fit
    ##      <dbl> <chr>  <dbl> <chr>    <dbl>  <dbl>  <dbl>   <dbl>   <dbl>
    ## 1     2421 M       6.58 Central…     5  -41.0   41.7   2425.    459.
    ## 2     2606 F      36.6  Bajío        9  526.   510.    2420.    407.
    ## 3     1000 M      -2.42 Central…     5  -38.0  -54.3   1172.    460.
    ## 4       16 M     -10.4  Norther…    14  286.   270.     219.    438.
    ## 5     2000 M      -9.42 Norther…    16  -35.0  -48.3   1910.    479.
    ## # … with 6 more variables: .resid <dbl>, .hat <dbl>, .sigma <dbl>,
    ## #   .cooksd <dbl>, .std.resid <dbl>, obs_num <int>

Of the individuals in the data with high leverage, two men have
extensive educations and are relatively young and from Northern Mexico.
Two men are closer to the median age, have 5 years of education, and are
from Central Mexico. And one woman, much older than the median age and
from the Bajío, has a very long duration of first US migration.

These points are potentially, but not certainly, influential points, so
we use other methods to sort out influential points.

![](final-writeup_files/figure-gfm/standardized-residuals-1.png)<!-- -->

    ## [1] 0.0562249

The 5% of our observations with standardized residuals of magnitude
greater than 2 should be examined more closely- these are outliers, but
they may not have an impact on the regression line. We can look plots of
the standardized residuals versus all of our
predictors.

![](final-writeup_files/figure-gfm/std-resid-predictor-plots-1.png)<!-- -->

Plots of the standardized residuals for each predictor variable reveal
that, for the most part, our data satisfies the constant variance
assumption.

    ## [1] 488.6191

    ## # A tibble: 1 x 1
    ##   sigma_est
    ##       <dbl>
    ## 1      389.

The estimate of our regression standard deviation using all observations
is 488.6191, whereas the standard deviation estimate without points with
large magnitude standardized residuals is 389.2314. Removing points with
large magnitude standardized residuals would affect our conclusions by
decreasing the standard error associated with our model coefficients,
however, we do not want to damage our model’s integrity and explanatory
power by removing too much human variability from the observations we
base it on. We will examine Cook’s Distance to see if any observations
have excessive overall impact or significantly affect the estimated
coefficients when removed.

![](final-writeup_files/figure-gfm/cooks-distance-1.png)<!-- -->

    ## # A tibble: 1 x 15
    ##   hhincome sex     age statebrn edyrs usdur1 usdurl .fitted .se.fit .resid
    ##      <dbl> <chr> <dbl> <chr>    <dbl>  <dbl>  <dbl>   <dbl>   <dbl>  <dbl>
    ## 1     2000 M     -9.42 Norther…    16  -35.0  -48.3   1910.    479.   90.2
    ## # … with 5 more variables: .hat <dbl>, .sigma <dbl>, .cooksd <dbl>,
    ## #   .std.resid <dbl>, obs_num <int>

One observation has a Cook’s Distance greater than 1- a man from
Northern Mexico, nine years younger than the mean age, and with income
$2000, 16 years of education, and a migration about 34 months shorter
than the mean. We will remove this individual from our analysis because
this data point exerts significantly greater influence on the final
coefficients of our model and could distort our explanations.

We remove the observation and now redo model selection.

## Repeated Model Selection

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

342.203

</td>

<td style="text-align:right;">

259.919

</td>

<td style="text-align:right;">

1.317

</td>

<td style="text-align:right;">

0.189

</td>

</tr>

<tr>

<td style="text-align:left;">

sexM

</td>

<td style="text-align:right;">

306.055

</td>

<td style="text-align:right;">

182.895

</td>

<td style="text-align:right;">

1.673

</td>

<td style="text-align:right;">

0.095

</td>

</tr>

<tr>

<td style="text-align:left;">

age

</td>

<td style="text-align:right;">

6.526

</td>

<td style="text-align:right;">

2.783

</td>

<td style="text-align:right;">

2.345

</td>

<td style="text-align:right;">

0.019

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnCentral Mexico

</td>

<td style="text-align:right;">

245.285

</td>

<td style="text-align:right;">

217.462

</td>

<td style="text-align:right;">

1.128

</td>

<td style="text-align:right;">

0.260

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnNorthern Mexico

</td>

<td style="text-align:right;">

\-289.098

</td>

<td style="text-align:right;">

261.117

</td>

<td style="text-align:right;">

\-1.107

</td>

<td style="text-align:right;">

0.269

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnPacific Coast

</td>

<td style="text-align:right;">

\-90.946

</td>

<td style="text-align:right;">

49.135

</td>

<td style="text-align:right;">

\-1.851

</td>

<td style="text-align:right;">

0.065

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnSouth East Mexico

</td>

<td style="text-align:right;">

115.774

</td>

<td style="text-align:right;">

125.508

</td>

<td style="text-align:right;">

0.922

</td>

<td style="text-align:right;">

0.357

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatDivorced

</td>

<td style="text-align:right;">

239.253

</td>

<td style="text-align:right;">

215.148

</td>

<td style="text-align:right;">

1.112

</td>

<td style="text-align:right;">

0.267

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatMarried

</td>

<td style="text-align:right;">

37.951

</td>

<td style="text-align:right;">

116.324

</td>

<td style="text-align:right;">

0.326

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

\-162.494

</td>

<td style="text-align:right;">

161.985

</td>

<td style="text-align:right;">

\-1.003

</td>

<td style="text-align:right;">

0.316

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatSeparated

</td>

<td style="text-align:right;">

75.564

</td>

<td style="text-align:right;">

229.043

</td>

<td style="text-align:right;">

0.330

</td>

<td style="text-align:right;">

0.742

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatWidowed

</td>

<td style="text-align:right;">

88.293

</td>

<td style="text-align:right;">

242.124

</td>

<td style="text-align:right;">

0.365

</td>

<td style="text-align:right;">

0.716

</td>

</tr>

<tr>

<td style="text-align:left;">

edyrs

</td>

<td style="text-align:right;">

14.590

</td>

<td style="text-align:right;">

7.574

</td>

<td style="text-align:right;">

1.926

</td>

<td style="text-align:right;">

0.055

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeManufacturing

</td>

<td style="text-align:right;">

119.341

</td>

<td style="text-align:right;">

64.539

</td>

<td style="text-align:right;">

1.849

</td>

<td style="text-align:right;">

0.065

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeProfessional

</td>

<td style="text-align:right;">

243.235

</td>

<td style="text-align:right;">

108.669

</td>

<td style="text-align:right;">

2.238

</td>

<td style="text-align:right;">

0.026

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeService

</td>

<td style="text-align:right;">

151.469

</td>

<td style="text-align:right;">

70.564

</td>

<td style="text-align:right;">

2.147

</td>

<td style="text-align:right;">

0.032

</td>

</tr>

<tr>

<td style="text-align:left;">

usdur1

</td>

<td style="text-align:right;">

\-0.327

</td>

<td style="text-align:right;">

0.452

</td>

<td style="text-align:right;">

\-0.723

</td>

<td style="text-align:right;">

0.470

</td>

</tr>

<tr>

<td style="text-align:left;">

usdurl

</td>

<td style="text-align:right;">

0.867

</td>

<td style="text-align:right;">

0.387

</td>

<td style="text-align:right;">

2.240

</td>

<td style="text-align:right;">

0.026

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Legal resident

</td>

<td style="text-align:right;">

143.237

</td>

<td style="text-align:right;">

145.394

</td>

<td style="text-align:right;">

0.985

</td>

<td style="text-align:right;">

0.325

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Temporary: Tourist/visitor

</td>

<td style="text-align:right;">

\-139.846

</td>

<td style="text-align:right;">

155.630

</td>

<td style="text-align:right;">

\-0.899

</td>

<td style="text-align:right;">

0.369

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Undocumented

</td>

<td style="text-align:right;">

\-40.506

</td>

<td style="text-align:right;">

121.749

</td>

<td style="text-align:right;">

\-0.333

</td>

<td style="text-align:right;">

0.740

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitycentcal

</td>

<td style="text-align:right;">

28.898

</td>

<td style="text-align:right;">

102.825

</td>

<td style="text-align:right;">

0.281

</td>

<td style="text-align:right;">

0.779

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitysocal

</td>

<td style="text-align:right;">

31.645

</td>

<td style="text-align:right;">

82.281

</td>

<td style="text-align:right;">

0.385

</td>

<td style="text-align:right;">

0.701

</td>

</tr>

</tbody>

</table>

### 2.2 Backward selection

    ## Start:  AIC=6219.22
    ## hhincome ~ sex + age + statebrn + marstat + edyrs + occtype + 
    ##     usdur1 + usdurl + usdoc1 + uscity
    ## 
    ##            Df Sum of Sq       RSS    AIC
    ## - marstat   5   1126711 124355832 6213.7
    ## - uscity    2     38496 123267618 6215.4
    ## - usdur1    1    135935 123365057 6217.8
    ## - usdoc1    3   1359918 124589039 6218.7
    ## <none>                  123229121 6219.2
    ## - statebrn  4   2061338 125290460 6219.5
    ## - sex       1    727994 123957115 6220.1
    ## - occtype   3   1758404 124987525 6220.3
    ## - edyrs     1    964869 124193990 6221.1
    ## - usdurl    1   1303955 124533076 6222.5
    ## - age       1   1429266 124658388 6223.0
    ## 
    ## Step:  AIC=6213.74
    ## hhincome ~ sex + age + statebrn + edyrs + occtype + usdur1 + 
    ##     usdurl + usdoc1 + uscity
    ## 
    ##            Df Sum of Sq       RSS    AIC
    ## - uscity    2     48514 124404346 6209.9
    ## - usdur1    1    168287 124524119 6212.4
    ## - usdoc1    3   1366487 125722319 6213.2
    ## <none>                  124355832 6213.7
    ## - occtype   3   1654181 126010013 6214.3
    ## - statebrn  4   2511006 126866838 6215.7
    ## - edyrs     1   1011036 125366868 6215.8
    ## - sex       1   1187686 125543518 6216.5
    ## - usdurl    1   1374187 125730020 6217.2
    ## - age       1   1900686 126256518 6219.3
    ## 
    ## Step:  AIC=6209.94
    ## hhincome ~ sex + age + statebrn + edyrs + occtype + usdur1 + 
    ##     usdurl + usdoc1
    ## 
    ##            Df Sum of Sq       RSS    AIC
    ## - usdur1    1    149892 124554238 6208.5
    ## - usdoc1    3   1324189 125728535 6209.2
    ## <none>                  124404346 6209.9
    ## - occtype   3   1708551 126112897 6210.7
    ## - edyrs     1   1002365 125406711 6211.9
    ## - statebrn  4   2560182 126964528 6212.1
    ## - sex       1   1182440 125586786 6212.6
    ## - usdurl    1   1350503 125754849 6213.3
    ## - age       1   1893789 126298134 6215.4
    ## 
    ## Step:  AIC=6208.54
    ## hhincome ~ sex + age + statebrn + edyrs + occtype + usdurl + 
    ##     usdoc1
    ## 
    ##            Df Sum of Sq       RSS    AIC
    ## - usdoc1    3   1288104 125842342 6207.6
    ## <none>                  124554238 6208.5
    ## - occtype   3   1691178 126245416 6209.2
    ## - edyrs     1   1044388 125598626 6210.7
    ## - statebrn  4   2631941 127186179 6210.9
    ## - sex       1   1323450 125877688 6211.8
    ## - usdurl    1   1476410 126030648 6212.4
    ## - age       1   1998533 126552771 6214.4
    ## 
    ## Step:  AIC=6207.65
    ## hhincome ~ sex + age + statebrn + edyrs + occtype + usdurl
    ## 
    ##            Df Sum of Sq       RSS    AIC
    ## <none>                  125842342 6207.6
    ## - occtype   3   1651204 127493546 6208.1
    ## - statebrn  4   2841027 128683369 6210.7
    ## - edyrs     1   1363479 127205822 6211.0
    ## - usdurl    1   1675110 127517452 6212.2
    ## - sex       1   1788043 127630385 6212.7
    ## - age       1   2826963 128669305 6216.7

| term                      |  estimate | std.error | statistic | p.value |  conf.low | conf.high |
| :------------------------ | --------: | --------: | --------: | ------: | --------: | --------: |
| (Intercept)               |   370.957 |   138.983 |     2.669 |   0.008 |    97.875 |   644.040 |
| sexM                      |   311.462 |   118.648 |     2.625 |   0.009 |    78.335 |   544.589 |
| age                       |     7.877 |     2.386 |     3.301 |   0.001 |     3.188 |    12.566 |
| statebrnCentral Mexico    |   315.909 |   214.798 |     1.471 |   0.142 | \-106.141 |   737.959 |
| statebrnNorthern Mexico   | \-332.850 |   258.567 |   \-1.287 |   0.199 | \-840.900 |   175.200 |
| statebrnPacific Coast     | \-107.493 |    48.141 |   \-2.233 |   0.026 | \-202.083 |  \-12.903 |
| statebrnSouth East Mexico |    95.330 |   124.761 |     0.764 |   0.445 | \-149.808 |   340.468 |
| edyrs                     |    16.724 |     7.296 |     2.292 |   0.022 |     2.389 |    31.059 |
| occtypeManufacturing      |   115.783 |    63.643 |     1.819 |   0.069 |   \-9.267 |   240.833 |
| occtypeProfessional       |   239.131 |   107.004 |     2.235 |   0.026 |    28.882 |   449.380 |
| occtypeService            |   134.793 |    69.003 |     1.953 |   0.051 |   \-0.789 |   270.374 |
| usdurl                    |     0.722 |     0.284 |     2.541 |   0.011 |     0.164 |     1.280 |

Using backward selection based on AIC, we narrowed down to 5 variables:
sex, edyrs, usdurl, statebrn, and age.

### 2.3 Interactions

To find potential interactions between the 5 variables, we used nested-F
test for each of the possible interactions:

After inital backwards selection, we will explore the possible
interactions between remaining variables: `edyrs`, `usdurl`, `sex`,
`statebrn` and `age`, to determine if any are significant.

| Res.Df |       RSS |  Df | Sum of Sq | Pr(\>Chi) |
| -----: | --------: | --: | --------: | --------: |
|    485 | 125842342 |  NA |        NA |        NA |
|    487 | 127466234 | \-2 | \-1623892 |     0.044 |

First, we tested the interaction between `edyrs` and `usdurl`. The
p-value for this test was 0.7366925 \> 0.05, therefore we will not
include it in the model.

| Res.Df |       RSS |  Df |  Sum of Sq | Pr(\>Chi) |
| -----: | --------: | --: | ---------: | --------: |
|    485 | 125842342 |  NA |         NA |        NA |
|    487 | 126639926 | \-2 | \-797583.6 |     0.215 |

Then, we tested the interaction between `sex` and `usdurl`. The p-value
for this test was 0.0303039 \< 0.05, therefore we will include it in the
model.

| Res.Df |       RSS |  Df |  Sum of Sq | Pr(\>Chi) |
| -----: | --------: | --: | ---------: | --------: |
|    485 | 125842342 |  NA |         NA |        NA |
|    487 | 126633242 | \-2 | \-790899.7 |     0.218 |

Then, we tested the interaction between `age` and `usdurl`. The p-value
for this test was 0.1936359 \> 0.05, therefore we will not include it in
the model.

| Res.Df |       RSS |  Df | Sum of Sq | Pr(\>Chi) |
| -----: | --------: | --: | --------: | --------: |
|    485 | 125842342 |  NA |        NA |        NA |
|    487 | 127354413 | \-2 | \-1512071 |     0.054 |

Then, we tested the interaction between `sex` and `edyrs`. The p-value
for this test was 0.5024992 \> 0.05, therefore we will not include it in
the model.

| Res.Df |       RSS |  Df | Sum of Sq | Pr(\>Chi) |
| -----: | --------: | --: | --------: | --------: |
|    485 | 125842342 |  NA |        NA |        NA |
|    487 | 121474782 | \-2 |   4367561 |        NA |

Then, we tested the interaction between `age` and `edyrs`. The p-value
for this test was 0 \< 0.05, therefore we will include it in the model.

| Res.Df |       RSS |  Df | Sum of Sq | Pr(\>Chi) |
| -----: | --------: | --: | --------: | --------: |
|    485 | 125842342 |  NA |        NA |        NA |
|    487 | 127192281 | \-2 | \-1349938 |     0.074 |

Then, we tested the interaction between `age` and `sex`. The p-value for
this test was 0.2073624 \> 0.05, therefore we will not include it in the
model.

| Res.Df |       RSS | Df |  Sum of Sq | Pr(\>Chi) |
| -----: | --------: | -: | ---------: | --------: |
|    485 | 125842342 | NA |         NA |        NA |
|    485 | 126630094 |  0 | \-787751.2 |        NA |

Then, we tested the interaction between `statebrn` and `sex`. The
p-value for this test was 0.3796077\> 0.05, therefore we will not
include it in the model.

| Res.Df |       RSS | Df | Sum of Sq | Pr(\>Chi) |
| -----: | --------: | -: | --------: | --------: |
|    485 | 125842342 | NA |        NA |        NA |
|    484 | 124532552 |  1 |   1309790 |     0.024 |

Then, we tested the interaction between `statebrn` and `age`. The
p-value for this test was 0.213341\> 0.05, therefore we will not include
it in the model.

| Res.Df |       RSS | Df | Sum of Sq | Pr(\>Chi) |
| -----: | --------: | -: | --------: | --------: |
|    485 | 125842342 | NA |        NA |        NA |
|    484 | 120713072 |  1 |   5129270 |         0 |

Then, we tested the interaction between `statebrn` and `edyrs`. The
p-value for this test was 0.0002466\< 0.05, therefore we will include it
in the model.

| Res.Df |       RSS | Df | Sum of Sq | Pr(\>Chi) |
| -----: | --------: | -: | --------: | --------: |
|    485 | 125842342 | NA |        NA |        NA |
|    484 | 123997777 |  1 |   1844565 |     0.007 |

Then, we tested the interaction between `statebrn` and `usdurl`. The
p-value for this test was 0.0012 \< 0.05, therefore we will include it
in the model.

Through nested F-test, we observed significant interactions between age
& edyrs, statebrn & edyrs, statebrn & usdurl, and between sex & usdurl,
with respective p-values of 0, 0.0002466, 0.0012 and 0.034 and will be
including them in our model.

### 2.4 Model with Interaction

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

261.373

</td>

<td style="text-align:right;">

146.369

</td>

<td style="text-align:right;">

1.786

</td>

<td style="text-align:right;">

0.075

</td>

</tr>

<tr>

<td style="text-align:left;">

sexM

</td>

<td style="text-align:right;">

339.549

</td>

<td style="text-align:right;">

117.250

</td>

<td style="text-align:right;">

2.896

</td>

<td style="text-align:right;">

0.004

</td>

</tr>

<tr>

<td style="text-align:left;">

age

</td>

<td style="text-align:right;">

\-4.710

</td>

<td style="text-align:right;">

3.800

</td>

<td style="text-align:right;">

\-1.239

</td>

<td style="text-align:right;">

0.216

</td>

</tr>

<tr>

<td style="text-align:left;">

edyrs

</td>

<td style="text-align:right;">

50.389

</td>

<td style="text-align:right;">

10.903

</td>

<td style="text-align:right;">

4.622

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

2.226

</td>

<td style="text-align:right;">

0.805

</td>

<td style="text-align:right;">

2.766

</td>

<td style="text-align:right;">

0.006

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnCentral Mexico

</td>

<td style="text-align:right;">

2498.726

</td>

<td style="text-align:right;">

876.420

</td>

<td style="text-align:right;">

2.851

</td>

<td style="text-align:right;">

0.005

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnNorthern Mexico

</td>

<td style="text-align:right;">

606.374

</td>

<td style="text-align:right;">

840.017

</td>

<td style="text-align:right;">

0.722

</td>

<td style="text-align:right;">

0.471

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnPacific Coast

</td>

<td style="text-align:right;">

172.994

</td>

<td style="text-align:right;">

94.169

</td>

<td style="text-align:right;">

1.837

</td>

<td style="text-align:right;">

0.067

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnSouth East Mexico

</td>

<td style="text-align:right;">

\-256.619

</td>

<td style="text-align:right;">

662.413

</td>

<td style="text-align:right;">

\-0.387

</td>

<td style="text-align:right;">

0.699

</td>

</tr>

<tr>

<td style="text-align:left;">

age:edyrs

</td>

<td style="text-align:right;">

2.268

</td>

<td style="text-align:right;">

0.588

</td>

<td style="text-align:right;">

3.855

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

\-1.105

</td>

<td style="text-align:right;">

0.828

</td>

<td style="text-align:right;">

\-1.335

</td>

<td style="text-align:right;">

0.183

</td>

</tr>

<tr>

<td style="text-align:left;">

edyrs:statebrnCentral Mexico

</td>

<td style="text-align:right;">

\-297.996

</td>

<td style="text-align:right;">

115.019

</td>

<td style="text-align:right;">

\-2.591

</td>

<td style="text-align:right;">

0.010

</td>

</tr>

<tr>

<td style="text-align:left;">

edyrs:statebrnNorthern Mexico

</td>

<td style="text-align:right;">

\-130.435

</td>

<td style="text-align:right;">

185.220

</td>

<td style="text-align:right;">

\-0.704

</td>

<td style="text-align:right;">

0.482

</td>

</tr>

<tr>

<td style="text-align:left;">

edyrs:statebrnPacific Coast

</td>

<td style="text-align:right;">

\-41.174

</td>

<td style="text-align:right;">

13.048

</td>

<td style="text-align:right;">

\-3.155

</td>

<td style="text-align:right;">

0.002

</td>

</tr>

<tr>

<td style="text-align:left;">

edyrs:statebrnSouth East Mexico

</td>

<td style="text-align:right;">

21.088

</td>

<td style="text-align:right;">

35.213

</td>

<td style="text-align:right;">

0.599

</td>

<td style="text-align:right;">

0.550

</td>

</tr>

<tr>

<td style="text-align:left;">

usdurl:statebrnCentral Mexico

</td>

<td style="text-align:right;">

11.204

</td>

<td style="text-align:right;">

6.415

</td>

<td style="text-align:right;">

1.746

</td>

<td style="text-align:right;">

0.081

</td>

</tr>

<tr>

<td style="text-align:left;">

usdurl:statebrnNorthern Mexico

</td>

<td style="text-align:right;">

\-0.350

</td>

<td style="text-align:right;">

6.086

</td>

<td style="text-align:right;">

\-0.057

</td>

<td style="text-align:right;">

0.954

</td>

</tr>

<tr>

<td style="text-align:left;">

usdurl:statebrnPacific Coast

</td>

<td style="text-align:right;">

\-1.265

</td>

<td style="text-align:right;">

0.536

</td>

<td style="text-align:right;">

\-2.360

</td>

<td style="text-align:right;">

0.019

</td>

</tr>

<tr>

<td style="text-align:left;">

usdurl:statebrnSouth East Mexico

</td>

<td style="text-align:right;">

\-5.431

</td>

<td style="text-align:right;">

11.422

</td>

<td style="text-align:right;">

\-0.475

</td>

<td style="text-align:right;">

0.635

</td>

</tr>

</tbody>

</table>

### 2.5 Backward Selection with Interaction

Since we observed 4 pairs of significant interactions, we will do the
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

317.827

</td>

<td style="text-align:right;">

264.653

</td>

<td style="text-align:right;">

1.201

</td>

<td style="text-align:right;">

0.230

</td>

</tr>

<tr>

<td style="text-align:left;">

sexM

</td>

<td style="text-align:right;">

328.072

</td>

<td style="text-align:right;">

178.409

</td>

<td style="text-align:right;">

1.839

</td>

<td style="text-align:right;">

0.067

</td>

</tr>

<tr>

<td style="text-align:left;">

age

</td>

<td style="text-align:right;">

\-5.985

</td>

<td style="text-align:right;">

4.384

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

statebrnCentral Mexico

</td>

<td style="text-align:right;">

2597.779

</td>

<td style="text-align:right;">

883.986

</td>

<td style="text-align:right;">

2.939

</td>

<td style="text-align:right;">

0.003

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnNorthern Mexico

</td>

<td style="text-align:right;">

573.183

</td>

<td style="text-align:right;">

843.856

</td>

<td style="text-align:right;">

0.679

</td>

<td style="text-align:right;">

0.497

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnPacific Coast

</td>

<td style="text-align:right;">

145.963

</td>

<td style="text-align:right;">

96.531

</td>

<td style="text-align:right;">

1.512

</td>

<td style="text-align:right;">

0.131

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnSouth East Mexico

</td>

<td style="text-align:right;">

\-321.258

</td>

<td style="text-align:right;">

669.209

</td>

<td style="text-align:right;">

\-0.480

</td>

<td style="text-align:right;">

0.631

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatDivorced

</td>

<td style="text-align:right;">

154.049

</td>

<td style="text-align:right;">

208.120

</td>

<td style="text-align:right;">

0.740

</td>

<td style="text-align:right;">

0.460

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatMarried

</td>

<td style="text-align:right;">

26.585

</td>

<td style="text-align:right;">

111.773

</td>

<td style="text-align:right;">

0.238

</td>

<td style="text-align:right;">

0.812

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatNever married

</td>

<td style="text-align:right;">

\-175.416

</td>

<td style="text-align:right;">

155.524

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

marstatSeparated

</td>

<td style="text-align:right;">

59.773

</td>

<td style="text-align:right;">

220.326

</td>

<td style="text-align:right;">

0.271

</td>

<td style="text-align:right;">

0.786

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatWidowed

</td>

<td style="text-align:right;">

\-63.921

</td>

<td style="text-align:right;">

238.805

</td>

<td style="text-align:right;">

\-0.268

</td>

<td style="text-align:right;">

0.789

</td>

</tr>

<tr>

<td style="text-align:left;">

edyrs

</td>

<td style="text-align:right;">

40.850

</td>

<td style="text-align:right;">

11.655

</td>

<td style="text-align:right;">

3.505

</td>

<td style="text-align:right;">

0.001

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeManufacturing

</td>

<td style="text-align:right;">

98.103

</td>

<td style="text-align:right;">

62.716

</td>

<td style="text-align:right;">

1.564

</td>

<td style="text-align:right;">

0.118

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeProfessional

</td>

<td style="text-align:right;">

210.447

</td>

<td style="text-align:right;">

107.424

</td>

<td style="text-align:right;">

1.959

</td>

<td style="text-align:right;">

0.051

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeService

</td>

<td style="text-align:right;">

156.961

</td>

<td style="text-align:right;">

68.600

</td>

<td style="text-align:right;">

2.288

</td>

<td style="text-align:right;">

0.023

</td>

</tr>

<tr>

<td style="text-align:left;">

usdur1

</td>

<td style="text-align:right;">

\-0.366

</td>

<td style="text-align:right;">

0.453

</td>

<td style="text-align:right;">

\-0.809

</td>

<td style="text-align:right;">

0.419

</td>

</tr>

<tr>

<td style="text-align:left;">

usdurl

</td>

<td style="text-align:right;">

2.883

</td>

<td style="text-align:right;">

0.968

</td>

<td style="text-align:right;">

2.979

</td>

<td style="text-align:right;">

0.003

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Legal resident

</td>

<td style="text-align:right;">

\-9.364

</td>

<td style="text-align:right;">

142.520

</td>

<td style="text-align:right;">

\-0.066

</td>

<td style="text-align:right;">

0.948

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Temporary: Tourist/visitor

</td>

<td style="text-align:right;">

\-187.957

</td>

<td style="text-align:right;">

152.170

</td>

<td style="text-align:right;">

\-1.235

</td>

<td style="text-align:right;">

0.217

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Undocumented

</td>

<td style="text-align:right;">

\-152.124

</td>

<td style="text-align:right;">

119.282

</td>

<td style="text-align:right;">

\-1.275

</td>

<td style="text-align:right;">

0.203

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitycentcal

</td>

<td style="text-align:right;">

28.230

</td>

<td style="text-align:right;">

98.851

</td>

<td style="text-align:right;">

0.286

</td>

<td style="text-align:right;">

0.775

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitysocal

</td>

<td style="text-align:right;">

30.334

</td>

<td style="text-align:right;">

79.160

</td>

<td style="text-align:right;">

0.383

</td>

<td style="text-align:right;">

0.702

</td>

</tr>

<tr>

<td style="text-align:left;">

sexM:usdurl

</td>

<td style="text-align:right;">

\-1.764

</td>

<td style="text-align:right;">

0.902

</td>

<td style="text-align:right;">

\-1.955

</td>

<td style="text-align:right;">

0.051

</td>

</tr>

<tr>

<td style="text-align:left;">

age:edyrs

</td>

<td style="text-align:right;">

2.160

</td>

<td style="text-align:right;">

0.610

</td>

<td style="text-align:right;">

3.544

</td>

<td style="text-align:right;">

0.000

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnCentral Mexico:edyrs

</td>

<td style="text-align:right;">

\-322.479

</td>

<td style="text-align:right;">

116.400

</td>

<td style="text-align:right;">

\-2.770

</td>

<td style="text-align:right;">

0.006

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnNorthern Mexico:edyrs

</td>

<td style="text-align:right;">

\-121.322

</td>

<td style="text-align:right;">

186.415

</td>

<td style="text-align:right;">

\-0.651

</td>

<td style="text-align:right;">

0.515

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnPacific Coast:edyrs

</td>

<td style="text-align:right;">

\-36.232

</td>

<td style="text-align:right;">

13.434

</td>

<td style="text-align:right;">

\-2.697

</td>

<td style="text-align:right;">

0.007

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnSouth East Mexico:edyrs

</td>

<td style="text-align:right;">

18.686

</td>

<td style="text-align:right;">

36.087

</td>

<td style="text-align:right;">

0.518

</td>

<td style="text-align:right;">

0.605

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnCentral Mexico:usdurl

</td>

<td style="text-align:right;">

10.947

</td>

<td style="text-align:right;">

6.443

</td>

<td style="text-align:right;">

1.699

</td>

<td style="text-align:right;">

0.090

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnNorthern Mexico:usdurl

</td>

<td style="text-align:right;">

\-0.516

</td>

<td style="text-align:right;">

6.126

</td>

<td style="text-align:right;">

\-0.084

</td>

<td style="text-align:right;">

0.933

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnPacific Coast:usdurl

</td>

<td style="text-align:right;">

\-1.232

</td>

<td style="text-align:right;">

0.550

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

statebrnSouth East Mexico:usdurl

</td>

<td style="text-align:right;">

\-7.009

</td>

<td style="text-align:right;">

11.524

</td>

<td style="text-align:right;">

\-0.608

</td>

<td style="text-align:right;">

0.543

</td>

</tr>

</tbody>

</table>

    ## Start:  AIC=6185.39
    ## hhincome ~ sex + age + statebrn + marstat + edyrs + occtype + 
    ##     usdur1 + usdurl + usdoc1 + uscity + sex * usdurl + age * 
    ##     edyrs + statebrn * edyrs + statebrn * usdurl
    ## 
    ##                   Df Sum of Sq       RSS    AIC
    ## - marstat          5    981067 111559647 6179.8
    ## - uscity           2     35087 110613668 6181.5
    ## - usdoc1           3    986923 111565503 6183.8
    ## - usdur1           1    155803 110734384 6184.1
    ## <none>                         110578580 6185.4
    ## - occtype          3   1523757 112102337 6186.2
    ## - statebrn:usdurl  4   2014039 112592620 6186.4
    ## - sex:usdurl       1    910543 111489123 6187.5
    ## - statebrn:edyrs   4   3736358 114314938 6193.9
    ## - age:edyrs        1   2993735 113572315 6196.7
    ## 
    ## Step:  AIC=6179.78
    ## hhincome ~ sex + age + statebrn + edyrs + occtype + usdur1 + 
    ##     usdurl + usdoc1 + uscity + sex:usdurl + age:edyrs + statebrn:edyrs + 
    ##     statebrn:usdurl
    ## 
    ##                   Df Sum of Sq       RSS    AIC
    ## - uscity           2     52366 111612014 6176.0
    ## - usdur1           1    174076 111733723 6178.6
    ## - usdoc1           3   1090672 112650320 6178.6
    ## - occtype          3   1353845 112913492 6179.8
    ## <none>                         111559647 6179.8
    ## - statebrn:usdurl  4   2046646 113606293 6180.8
    ## - sex:usdurl       1    811103 112370750 6181.4
    ## - statebrn:edyrs   4   3589492 115149140 6187.5
    ## - age:edyrs        1   3439127 114998774 6192.9
    ## 
    ## Step:  AIC=6176.01
    ## hhincome ~ sex + age + statebrn + edyrs + occtype + usdur1 + 
    ##     usdurl + usdoc1 + sex:usdurl + age:edyrs + statebrn:edyrs + 
    ##     statebrn:usdurl
    ## 
    ##                   Df Sum of Sq       RSS    AIC
    ## - usdoc1           3   1045334 112657348 6174.6
    ## - usdur1           1    154304 111766318 6174.7
    ## <none>                         111612014 6176.0
    ## - occtype          3   1394129 113006143 6176.2
    ## - statebrn:usdurl  4   2031603 113643617 6177.0
    ## - sex:usdurl       1    799618 112411631 6177.6
    ## - statebrn:edyrs   4   3621983 115233997 6183.9
    ## - age:edyrs        1   3454860 115066874 6189.2
    ## 
    ## Step:  AIC=6174.64
    ## hhincome ~ sex + age + statebrn + edyrs + occtype + usdur1 + 
    ##     usdurl + sex:usdurl + age:edyrs + statebrn:edyrs + statebrn:usdurl
    ## 
    ##                   Df Sum of Sq       RSS    AIC
    ## - usdur1           1    134064 112791412 6173.2
    ## - occtype          3   1236939 113894287 6174.1
    ## <none>                         112657348 6174.6
    ## - sex:usdurl       1    729752 113387100 6175.9
    ## - statebrn:usdurl  4   2183765 114841113 6176.2
    ## - statebrn:edyrs   4   3954498 116611846 6183.8
    ## - age:edyrs        1   3144301 115801649 6186.3
    ## 
    ## Step:  AIC=6173.23
    ## hhincome ~ sex + age + statebrn + edyrs + occtype + usdurl + 
    ##     sex:usdurl + age:edyrs + statebrn:edyrs + statebrn:usdurl
    ## 
    ##                   Df Sum of Sq       RSS    AIC
    ## - occtype          3   1190889 113982301 6172.5
    ## <none>                         112791412 6173.2
    ## - sex:usdurl       1    617562 113408974 6173.9
    ## - statebrn:usdurl  4   2156341 114947753 6174.6
    ## - statebrn:edyrs   4   4128478 116919889 6183.1
    ## - age:edyrs        1   3148627 115940039 6184.9
    ## 
    ## Step:  AIC=6172.45
    ## hhincome ~ sex + age + statebrn + edyrs + usdurl + sex:usdurl + 
    ##     age:edyrs + statebrn:edyrs + statebrn:usdurl
    ## 
    ##                   Df Sum of Sq       RSS    AIC
    ## - sex:usdurl       1    424734 114407035 6172.3
    ## <none>                         113982301 6172.5
    ## - statebrn:usdurl  4   2173496 116155797 6173.8
    ## - statebrn:edyrs   4   4275328 118257628 6182.8
    ## - age:edyrs        1   3543915 117526215 6185.7
    ## 
    ## Step:  AIC=6172.3
    ## hhincome ~ sex + age + statebrn + edyrs + usdurl + age:edyrs + 
    ##     statebrn:edyrs + statebrn:usdurl
    ## 
    ##                   Df Sum of Sq       RSS    AIC
    ## <none>                         114407035 6172.3
    ## - statebrn:usdurl  4   2230095 116637130 6173.9
    ## - sex              1   1771529 116178565 6177.9
    ## - statebrn:edyrs   4   4225388 118632423 6182.3
    ## - age:edyrs        1   3795537 118202572 6186.5

| term                             |  estimate | std.error | statistic | p.value |   conf.low | conf.high |
| :------------------------------- | --------: | --------: | --------: | ------: | ---------: | --------: |
| (Intercept)                      |   287.551 |   145.167 |     1.981 |   0.048 |      2.308 |   572.794 |
| sexM                             |   315.917 |   116.000 |     2.723 |   0.007 |     87.986 |   543.848 |
| age                              |   \-5.024 |     3.796 |   \-1.324 |   0.186 |   \-12.483 |     2.435 |
| statebrnCentral Mexico           |  2491.768 |   877.119 |     2.841 |   0.005 |    768.291 |  4215.245 |
| statebrnNorthern Mexico          |   599.426 |   840.685 |     0.713 |   0.476 | \-1052.461 |  2251.313 |
| statebrnPacific Coast            |   174.508 |    94.239 |     1.852 |   0.065 |   \-10.664 |   359.681 |
| statebrnSouth East Mexico        | \-225.689 |   662.547 |   \-0.341 |   0.734 | \-1527.547 |  1076.168 |
| edyrs                            |    50.031 |    10.908 |     4.587 |   0.000 |     28.597 |    71.465 |
| usdurl                           |     1.253 |     0.341 |     3.677 |   0.000 |      0.583 |     1.922 |
| age:edyrs                        |     2.337 |     0.586 |     3.986 |   0.000 |      1.185 |     3.490 |
| statebrnCentral Mexico:edyrs     | \-296.764 |   115.109 |   \-2.578 |   0.010 |  \-522.944 |  \-70.584 |
| statebrnNorthern Mexico:edyrs    | \-128.750 |   185.366 |   \-0.695 |   0.488 |  \-492.982 |   235.482 |
| statebrnPacific Coast:edyrs      |  \-41.048 |    13.059 |   \-3.143 |   0.002 |   \-66.708 |  \-15.389 |
| statebrnSouth East Mexico:edyrs  |    19.911 |    35.231 |     0.565 |   0.572 |   \-49.315 |    89.138 |
| statebrnCentral Mexico:usdurl    |    11.079 |     6.420 |     1.726 |   0.085 |    \-1.535 |    23.693 |
| statebrnNorthern Mexico:usdurl   |   \-0.508 |     6.090 |   \-0.083 |   0.934 |   \-12.475 |    11.458 |
| statebrnPacific Coast:usdurl     |   \-1.301 |     0.536 |   \-2.429 |   0.016 |    \-2.353 |   \-0.248 |
| statebrnSouth East Mexico:usdurl |   \-5.014 |    11.427 |   \-0.439 |   0.661 |   \-27.467 |    17.439 |

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

291.651

</td>

<td style="text-align:right;">

266.115

</td>

<td style="text-align:right;">

1.096

</td>

<td style="text-align:right;">

0.274

</td>

</tr>

<tr>

<td style="text-align:left;">

sexM

</td>

<td style="text-align:right;">

355.137

</td>

<td style="text-align:right;">

179.886

</td>

<td style="text-align:right;">

1.974

</td>

<td style="text-align:right;">

0.049

</td>

</tr>

<tr>

<td style="text-align:left;">

age

</td>

<td style="text-align:right;">

\-5.972

</td>

<td style="text-align:right;">

4.386

</td>

<td style="text-align:right;">

\-1.362

</td>

<td style="text-align:right;">

0.174

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnCentral Mexico

</td>

<td style="text-align:right;">

2587.653

</td>

<td style="text-align:right;">

884.040

</td>

<td style="text-align:right;">

2.927

</td>

<td style="text-align:right;">

0.004

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnNorthern Mexico

</td>

<td style="text-align:right;">

573.124

</td>

<td style="text-align:right;">

843.914

</td>

<td style="text-align:right;">

0.679

</td>

<td style="text-align:right;">

0.497

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnPacific Coast

</td>

<td style="text-align:right;">

145.672

</td>

<td style="text-align:right;">

96.543

</td>

<td style="text-align:right;">

1.509

</td>

<td style="text-align:right;">

0.132

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnSouth East Mexico

</td>

<td style="text-align:right;">

\-321.400

</td>

<td style="text-align:right;">

669.260

</td>

<td style="text-align:right;">

\-0.480

</td>

<td style="text-align:right;">

0.631

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatDivorced

</td>

<td style="text-align:right;">

154.641

</td>

<td style="text-align:right;">

208.157

</td>

<td style="text-align:right;">

0.743

</td>

<td style="text-align:right;">

0.458

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatMarried

</td>

<td style="text-align:right;">

26.890

</td>

<td style="text-align:right;">

111.780

</td>

<td style="text-align:right;">

0.241

</td>

<td style="text-align:right;">

0.810

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatNever married

</td>

<td style="text-align:right;">

\-175.277

</td>

<td style="text-align:right;">

155.535

</td>

<td style="text-align:right;">

\-1.127

</td>

<td style="text-align:right;">

0.260

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatSeparated

</td>

<td style="text-align:right;">

61.898

</td>

<td style="text-align:right;">

220.352

</td>

<td style="text-align:right;">

0.281

</td>

<td style="text-align:right;">

0.779

</td>

</tr>

<tr>

<td style="text-align:left;">

marstatWidowed

</td>

<td style="text-align:right;">

\-65.965

</td>

<td style="text-align:right;">

239.106

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

edyrs

</td>

<td style="text-align:right;">

40.744

</td>

<td style="text-align:right;">

11.658

</td>

<td style="text-align:right;">

3.495

</td>

<td style="text-align:right;">

0.001

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeManufacturing

</td>

<td style="text-align:right;">

98.217

</td>

<td style="text-align:right;">

62.732

</td>

<td style="text-align:right;">

1.566

</td>

<td style="text-align:right;">

0.118

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeProfessional

</td>

<td style="text-align:right;">

210.262

</td>

<td style="text-align:right;">

107.431

</td>

<td style="text-align:right;">

1.957

</td>

<td style="text-align:right;">

0.051

</td>

</tr>

<tr>

<td style="text-align:left;">

occtypeService

</td>

<td style="text-align:right;">

156.424

</td>

<td style="text-align:right;">

68.580

</td>

<td style="text-align:right;">

2.281

</td>

<td style="text-align:right;">

0.023

</td>

</tr>

<tr>

<td style="text-align:left;">

usdur1

</td>

<td style="text-align:right;">

1.388

</td>

<td style="text-align:right;">

0.903

</td>

<td style="text-align:right;">

1.537

</td>

<td style="text-align:right;">

0.125

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Legal resident

</td>

<td style="text-align:right;">

\-9.188

</td>

<td style="text-align:right;">

142.545

</td>

<td style="text-align:right;">

\-0.064

</td>

<td style="text-align:right;">

0.949

</td>

</tr>

<tr>

<td style="text-align:left;">

usdoc1Temporary: Tourist/visitor

</td>

<td style="text-align:right;">

\-188.611

</td>

<td style="text-align:right;">

152.159

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

usdoc1Undocumented

</td>

<td style="text-align:right;">

\-151.449

</td>

<td style="text-align:right;">

119.304

</td>

<td style="text-align:right;">

\-1.269

</td>

<td style="text-align:right;">

0.205

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitycentcal

</td>

<td style="text-align:right;">

26.930

</td>

<td style="text-align:right;">

98.859

</td>

<td style="text-align:right;">

0.272

</td>

<td style="text-align:right;">

0.785

</td>

</tr>

<tr>

<td style="text-align:left;">

uscitysocal

</td>

<td style="text-align:right;">

28.950

</td>

<td style="text-align:right;">

79.150

</td>

<td style="text-align:right;">

0.366

</td>

<td style="text-align:right;">

0.715

</td>

</tr>

<tr>

<td style="text-align:left;">

usdurl

</td>

<td style="text-align:right;">

1.122

</td>

<td style="text-align:right;">

0.445

</td>

<td style="text-align:right;">

2.525

</td>

<td style="text-align:right;">

0.012

</td>

</tr>

<tr>

<td style="text-align:left;">

age:edyrs

</td>

<td style="text-align:right;">

2.161

</td>

<td style="text-align:right;">

0.610

</td>

<td style="text-align:right;">

3.545

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

\-1.753

</td>

<td style="text-align:right;">

0.905

</td>

<td style="text-align:right;">

\-1.938

</td>

<td style="text-align:right;">

0.053

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnCentral Mexico:edyrs

</td>

<td style="text-align:right;">

\-320.472

</td>

<td style="text-align:right;">

116.397

</td>

<td style="text-align:right;">

\-2.753

</td>

<td style="text-align:right;">

0.006

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnNorthern Mexico:edyrs

</td>

<td style="text-align:right;">

\-121.452

</td>

<td style="text-align:right;">

186.428

</td>

<td style="text-align:right;">

\-0.651

</td>

<td style="text-align:right;">

0.515

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnPacific Coast:edyrs

</td>

<td style="text-align:right;">

\-36.102

</td>

<td style="text-align:right;">

13.435

</td>

<td style="text-align:right;">

\-2.687

</td>

<td style="text-align:right;">

0.007

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnSouth East Mexico:edyrs

</td>

<td style="text-align:right;">

18.837

</td>

<td style="text-align:right;">

36.091

</td>

<td style="text-align:right;">

0.522

</td>

<td style="text-align:right;">

0.602

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnCentral Mexico:usdurl

</td>

<td style="text-align:right;">

11.040

</td>

<td style="text-align:right;">

6.443

</td>

<td style="text-align:right;">

1.713

</td>

<td style="text-align:right;">

0.087

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnNorthern Mexico:usdurl

</td>

<td style="text-align:right;">

\-0.507

</td>

<td style="text-align:right;">

6.126

</td>

<td style="text-align:right;">

\-0.083

</td>

<td style="text-align:right;">

0.934

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnPacific Coast:usdurl

</td>

<td style="text-align:right;">

\-1.234

</td>

<td style="text-align:right;">

0.550

</td>

<td style="text-align:right;">

\-2.244

</td>

<td style="text-align:right;">

0.025

</td>

</tr>

<tr>

<td style="text-align:left;">

statebrnSouth East Mexico:usdurl

</td>

<td style="text-align:right;">

\-6.997

</td>

<td style="text-align:right;">

11.524

</td>

<td style="text-align:right;">

\-0.607

</td>

<td style="text-align:right;">

0.544

</td>

</tr>

</tbody>

</table>

### 2.3 Final model

    ## Start:  AIC=6185.45
    ## hhincome ~ sex + age + statebrn + marstat + edyrs + occtype + 
    ##     usdur1 + usdoc1 + uscity + age * edyrs + sex * usdur1 + statebrn * 
    ##     edyrs + statebrn * usdurl
    ## 
    ##                   Df Sum of Sq       RSS    AIC
    ## - marstat          5    987504 111581409 6179.9
    ## - uscity           2     31970 110625875 6181.6
    ## - usdoc1           3    983154 111577059 6183.9
    ## <none>                         110593905 6185.5
    ## - occtype          3   1516662 112110568 6186.2
    ## - statebrn:usdurl  4   2031661 112625566 6186.5
    ## - sex:usdur1       1    895218 111489123 6187.5
    ## - statebrn:edyrs   4   3705114 114299019 6193.8
    ## - age:edyrs        1   2994663 113588568 6196.7
    ## 
    ## Step:  AIC=6179.87
    ## hhincome ~ sex + age + statebrn + edyrs + occtype + usdur1 + 
    ##     usdoc1 + uscity + usdurl + age:edyrs + sex:usdur1 + statebrn:edyrs + 
    ##     statebrn:usdurl
    ## 
    ##                   Df Sum of Sq       RSS    AIC
    ## - uscity           2     48929 111630338 6176.1
    ## - usdoc1           3   1087721 112669130 6178.7
    ## - occtype          3   1346657 112928066 6179.8
    ## <none>                         111581409 6179.9
    ## - statebrn:usdurl  4   2061820 113643229 6181.0
    ## - sex:usdur1       1    789341 112370750 6181.4
    ## - statebrn:edyrs   4   3557176 115138585 6187.5
    ## - age:edyrs        1   3447605 115029014 6193.0
    ## 
    ## Step:  AIC=6176.09
    ## hhincome ~ sex + age + statebrn + edyrs + occtype + usdur1 + 
    ##     usdoc1 + usdurl + age:edyrs + sex:usdur1 + statebrn:edyrs + 
    ##     statebrn:usdurl
    ## 
    ##                   Df Sum of Sq       RSS    AIC
    ## - usdoc1           3   1044811 112675149 6174.7
    ## <none>                         111630338 6176.1
    ## - occtype          3   1387379 113017717 6176.2
    ## - statebrn:usdurl  4   2047162 113677499 6177.1
    ## - sex:usdur1       1    781293 112411631 6177.6
    ## - statebrn:edyrs   4   3588784 115219122 6183.8
    ## - age:edyrs        1   3462078 115092416 6189.3
    ## 
    ## Step:  AIC=6174.72
    ## hhincome ~ sex + age + statebrn + edyrs + occtype + usdur1 + 
    ##     usdurl + age:edyrs + sex:usdur1 + statebrn:edyrs + statebrn:usdurl
    ## 
    ##                   Df Sum of Sq       RSS    AIC
    ## - occtype          3   1231106 113906255 6174.1
    ## <none>                         112675149 6174.7
    ## - sex:usdur1       1    711951 113387100 6175.9
    ## - statebrn:usdurl  4   2201113 114876262 6176.3
    ## - statebrn:edyrs   4   3921676 116596824 6183.7
    ## - age:edyrs        1   3151179 115826328 6186.4
    ## 
    ## Step:  AIC=6174.12
    ## hhincome ~ sex + age + statebrn + edyrs + usdur1 + usdurl + age:edyrs + 
    ##     sex:usdur1 + statebrn:edyrs + statebrn:usdurl
    ## 
    ##                   Df Sum of Sq       RSS    AIC
    ## <none>                         113906255 6174.1
    ## - sex:usdur1       1    486521 114392775 6174.2
    ## - statebrn:usdurl  4   2210929 116117184 6175.7
    ## - statebrn:edyrs   4   4101064 118007318 6183.7
    ## - age:edyrs        1   3551299 117457553 6187.4

| term                             |  estimate | std.error | statistic | p.value |   conf.low | conf.high |
| :------------------------------- | --------: | --------: | --------: | ------: | ---------: | --------: |
| (Intercept)                      |   254.970 |   149.676 |     1.703 |   0.089 |   \-39.136 |   549.075 |
| sexM                             |   350.585 |   120.403 |     2.912 |   0.004 |    113.999 |   587.170 |
| age                              |   \-4.906 |     3.815 |   \-1.286 |   0.199 |   \-12.402 |     2.591 |
| statebrnCentral Mexico           |  2472.628 |   877.636 |     2.817 |   0.005 |    748.118 |  4197.138 |
| statebrnNorthern Mexico          |   607.701 |   840.620 |     0.723 |   0.470 | \-1044.075 |  2259.477 |
| statebrnPacific Coast            |   166.767 |    94.755 |     1.760 |   0.079 |   \-19.421 |   352.956 |
| statebrnSouth East Mexico        | \-254.609 |   662.895 |   \-0.384 |   0.701 | \-1557.164 |  1047.945 |
| edyrs                            |    49.546 |    10.980 |     4.512 |   0.000 |     27.970 |    71.121 |
| usdur1                           |     0.954 |     0.859 |     1.111 |   0.267 |    \-0.734 |     2.642 |
| usdurl                           |     1.273 |     0.432 |     2.949 |   0.003 |      0.425 |     2.122 |
| age:edyrs                        |     2.270 |     0.589 |     3.856 |   0.000 |      1.113 |     3.426 |
| sexM:usdur1                      |   \-1.225 |     0.858 |   \-1.427 |   0.154 |    \-2.911 |     0.461 |
| statebrnCentral Mexico:edyrs     | \-294.617 |   115.150 |   \-2.559 |   0.011 |  \-520.880 |  \-68.354 |
| statebrnNorthern Mexico:edyrs    | \-128.919 |   185.366 |   \-0.695 |   0.487 |  \-493.153 |   235.316 |
| statebrnPacific Coast:edyrs      |  \-40.249 |    13.130 |   \-3.065 |   0.002 |   \-66.048 |  \-14.449 |
| statebrnSouth East Mexico:edyrs  |    21.516 |    35.245 |     0.610 |   0.542 |   \-47.740 |    90.771 |
| statebrnCentral Mexico:usdurl    |    11.170 |     6.423 |     1.739 |   0.083 |    \-1.450 |    23.790 |
| statebrnNorthern Mexico:usdurl   |   \-0.278 |     6.092 |   \-0.046 |   0.964 |   \-12.248 |    11.692 |
| statebrnPacific Coast:usdurl     |   \-1.285 |     0.537 |   \-2.393 |   0.017 |    \-2.341 |   \-0.230 |
| statebrnSouth East Mexico:usdurl |   \-5.334 |    11.431 |   \-0.467 |   0.641 |   \-27.795 |    17.127 |

    ## # A tibble: 19 x 2
    ##    names                                x
    ##    <chr>                            <dbl>
    ##  1 sexM                              1.22
    ##  2 age                               3.95
    ##  3 statebrnCentral Mexico           19.1 
    ##  4 statebrnNorthern Mexico          11.7 
    ##  5 statebrnPacific Coast             4.66
    ##  6 statebrnSouth East Mexico        33.6 
    ##  7 edyrs                             3.46
    ##  8 usdur1                            8.01
    ##  9 usdurl                            2.91
    ## 10 age:edyrs                         3.87
    ## 11 sexM:usdur1                       6.66
    ## 12 statebrnCentral Mexico:edyrs     19.6 
    ## 13 statebrnNorthern Mexico:edyrs    35.8 
    ## 14 statebrnPacific Coast:edyrs       6.87
    ## 15 statebrnSouth East Mexico:edyrs   5.43
    ## 16 statebrnCentral Mexico:usdurl     1.08
    ## 17 statebrnNorthern Mexico:usdurl   14.7 
    ## 18 statebrnPacific Coast:usdurl      1.65
    ## 19 statebrnSouth East Mexico:usdurl 24.3

    ## [1] 0.1481558

    ##   Gender pred_hhincome
    ## 1   Male        893.32
    ## 2 Female        590.11

![](final-writeup_files/figure-gfm/unnamed-chunk-15-1.png)<!-- -->![](final-writeup_files/figure-gfm/unnamed-chunk-15-2.png)<!-- -->
