# Data Dimensions 

`pers170` has 176701 observations and 132 variables. Our cleaned data, labeled `data` has 19 variables and 2,824 observations.

# Data Dictionary

`X1` Number of observation (numeric)

`sex` Sex (categorical)

    1 male
    2 female
  
`relhead`: Relationship to household head (categorical)

    1 Head 
    2 Husband/wife 
    3 Son/daughter
    4 Father/mother
    5 Brother/sister 
    6 Niece/nephew
    7 Uncle/aunt 
    8 Cousin
    9 Grandfather/grandmother
    10 Grands on/granddaughter
    11 Stepson/stepdaughter 
    12 Stepbrother/stepsister 
    13 Stepmother/stepfather
    14 Son-in-law/daughter-in-law
    15 Brother-in-law/sister-in-law
    16 Father-in-law/m other-in-law
    17 Other blood relative
    18 Other relative by marriage
    19 Non-relative
    20 Adopted/foster child

`yrborn` Year of birth (numeric)

`age` Age (numeric)

`statebrn` State of birth (categorical)

    1 Aguascalientes
    2 Baja California del Norte
    3 Baja California del Sur
    4 Campeche
    5 Coahuila
    6 Colima
    7 Chiapas
    8 Chihuahua
    9 Mexico City
    10 Durango
    11 Guanajuato
    12 Guerrero
    13 Hidalgo
    14 Jalisco
    15 México
    16 Michoacán
    17 Morelos
    18 Nayarit
    19 Nuevo Leon
    20 Oaxaca
    21 Puebla
    22 Querétaro
    23 Quintana Roo
    24 San Luis Potosí
    25 Sinaloa
    26 Sonora
    27 Tabasco
    28 Tamaulipas
    29 Tlaxcala
    30 Veracruz
    31 Yucatán
    32 Zacatecas
    212 El Salvador

`marstat` Marital status (categorical)

    1 Never married 
    2 Married (civil or religious) 
    3 Consensual union 
    4 Widowed 
    5 Divorced 
    6 Separated
    
`edyrs` School years completed (numeric)

`occ` Principal occupation

  Unemployed/Not in the labor force (10 - 99)
  
    10 Unemployed (seeking work)
    20 Homemaker
    30 Idle (adult not seeking work and not helping around
    the house)
    42 Student
    50 Retired, unspecified
    60 Other, unspecified (disabled, incarcerated, tourist and other)
    
  Professionals (110-119)
  
    110 Architects; civil, chemical, industrial engineers; etc.
    113 Physicians; dentists; optometrists; nutritionists; professional nurses, etc.
    116 Social scientists, lawyers, and psychologists
    119 Other professionals
    
  Technical workers (120 - 129)
  
    120 Draftsmen; equipment technicians; video and sound technicians; etc.
    123 Lab technicians (chemical, biological, pharmacological, and ecological)
    124 Technicians in agriculture, veterinary sciences, forestry, fisheries, etc.
    129 Other technicians
    
  Educators (130 - 139)
  
    130 Professors in universities and other institutions of higher learning
  
  Occupations in the arts, performances and sports (140 - 149)
  
    142 Painters; sculptors; illustrators (fine artists);
    designers; choreographers; etc.
    143 Directors; producers; broadcasters; etc.
    144 Athletes
    145 Sports referees, umpires and coaches
    146 Cartoonists; magicians; clowns; etc.
    149 Other artists
    
  Administrators and directors in both public and private sector (210 - 219)
  
    210 Government administrators and legislators 
    211 Presidents, directors, senior managers, large
    factory owners
    
  Agriculture, husbandry, forestry/fisheries workers (410 - 419)
  
    410 Agricultural workers
    411 Husbandry workers
    415 Fishery or marine workers
    417 Foremen, overseers and other control persons of
    agricultural, husbandry or fishery activities
    419 Other agriculture, husbandry, forestry, fishery
    workers
    
  Manufacturing /repair supervisors (510 - 519)
  
    519 Other supervisors including those in unspecified
    industry
    
  Manufacturing /repair skilled workers (520 - 529)
  
    520 Food, beverage and tobacco production workers, including cooks in establishments.
    522 Textile and leather production workers. (Examples: tailors, upholsterers, cobblers, embroiderers, lithographers, seamstresses; for unskilled finishing work, see 542; for clothing designers, see 142.)
    523 Wood and paper production or printing workers. (Examples: carpenter, cabinetmaker, linotypist, film developer, other skilled carpentry work)
    524 Metal production and treatment workers; vehicle, machinery and equipment repair. (Examples: casters, lathe operators, boilermakers, welders, jewelers, goldsmiths, locksmiths, metal polishers, tool sharpeners, blacksmiths, metal forgers, refrigerator repair people, musical instrument repair people)
    526 Construction, installation, maintenance and finishing workers. (Examples: bricklayers, house painters, plasterers, roofers, floor polishers, plumbers, parts installers)
    527 Electrical equipment, electronics and telecommunications installation and repair workers. (Examples: electricians, television/radio repair people).
    529 Other craftsmen or manufacturing workers, including those in unspecified industry
    
  Manufacturing/repair heavy equipment operators (530 - 539)
  
    539 Other operators of heavy machinery and equipment,
    including those in unspecified industry
    
  Manufacturing/repair unskilled workers (540 - 549)
  
    541 Mine, quarry and well unskilled workers
    547 Electrical equipment, electronics and
    telecommunications installation and repair unskilled
    workers
    549 Other unskilled workers including those in
    unspecified industry (includes unspecified helpers or trainees)
    
  Transportation workers (550 - 559)
  
    552 Truck drivers and land-transport drivers (see also
    712) and passenger vehicle drivers
    559 Other conductors, drivers, pilots
    
  Administrative and support workers (620 - 629)
    
    620 Secretaries; typists; data entry, recorders; etc.
    621 Cashiers; collectors; ticket sellers; etc.
    625 Postal and messenger workers
    629 Other related workers, including generic office
    workers and public servants when no further specification was provided
    
  Sales workers (710 - 719)
  
    711 Workers in retail establishments. (Examples: clerks, dispatchers)
    713 Sales agents or representatives; brokers; insurance and real estate agents; auctioneers; etc.
    719 Other retail workers, including sales people (unknown whether or not person works in an establishment).
    
  Ambulatory workers (720 - 729) (those who work in their own house are included in the previous group)
  
    720 Ambulatory salespeople: toys, lottery tickets, household goods, paper, other inedible items
    721 Ambulatory service workers: food vendors, shoe shiners, car/windshield washers, street performers
    
  Personal services workers in establishments; (not in private households) (810 - 819)
  
    810 Innkeepers; bartenders; waiters; flight attendants.
    819 Other personal service worker: e.g., parking lot
    attendants
    
  Domestic services workers (820)
  
    820 Domestic services workers; caregivers, drivers,
    gardeners, butler, and other service workers in private households, e.g. baby sitter.
    Protection services workers (830 - 839)
    830 Security personnel; police officers; watchmen, firefighters.
    831 Armed forces personnel
    
    9999 Other unspecified occupation; unknown

`hhincome` Household income (numeric)

`usstate1` First US mig: State of residence (categorical)

`usstatel` Latest US mig: State of residence (categorical)

    100 Alabama
    102 Alaska
    103 Arizona
    104 Arkansas
    105 California
    106 Colorado
    107 Connecticut
    108 Delaware
    109 District of Columbia 
    110 Florida
    111 Georgia
    112 Hawaii
    113 Idaho
    114 Illinois
    115 Indiana
    116 Iowa
    117 Kansas
    118 Kentucky
    119 Louisiana
    120 Maine
    121 Maryland
    122 Massachusetts 
    123 Michigan
    124 Minnesota
    125 Mississippi
    126 Missouri
    127 Montana
    128 Nebraska
    129 Nevada
    130 New Hampshire 
    131 New Jersey 
    132 New Mexico 
    133 New York
    134 North Carolina 
    135 North Dakota 
    136 Ohio
    137 Oklahoma 
    138 Oregon
    139 Pennsylvania 
    140 Rhode Island 
    141 South Carolina 
    142 South Dakota 
    143 Tennessee 
    144 Texas
    145 Utah
    146 Vermont
    147 Virginia
    148 Washington
    149 West Virginia
    150 Wisconsin
    151 Wyoming
    152 Various States
    153 Puerto Rico
    199 US, State Unknown

`usplace1` First US mig: City of residence (categorical)

    640 Austin-San Marcos, TX MSA
    680 Bakersfield, CA MSA
    1240 Brownsville-Harlingen-San Benito, TX MSA
    1600 Chicago, IL PMSA
    1920 Dallas, TX PMSA
    2080 Denver, CO PMSA
    2320 El Paso, TX MSA
    2840 Fresno, CA MSA
    3360 Houston, TX PMSA
    4120 Las Vegas, NV-AZ MSA
    4480 Los Angeles-Long Beach, CA PMSA
    4880 McAllen-Edinburg-Mission, TX MSA
    4940 Merced, CA MSA
    5945 Orange County, CA PMSA
    6200 Phoenix-Mesa, AZ MSA
    6720 Reno, NV MSA
    6780 Riverside-San Bernardino, CA PMSA
    6920 Sacramento, CA PMSA
    7240 San Antonio, TX MSA
    7320 San Diego, CA MSA
    7360 San Francisco, CA PMSA
    7400 San Jose, CA PMSA
    7480 Santa Barbara-Santa Maria-Lompoc, CA MSA
    7485 Santa Cruz-Watsonville, CA PMSA
    7777 Outside of city
    8720 Vallejo-Fairfield-Napa, CA PMSA
    8735 Ventura, CA PMSA
    9999 NA
    Other number (less than 5 immigrants) Other

`usplacel` Latest US mig: City of residence (same key as usplace1) (categorical)

`usdur1` First US mig: Duration (in months) (numeric)

`usdurl` Latest US mig: Duration (in months) (numeric)

`usdoc1` First US migration: Documentation used (categorical)

    1 Legal resident
    2 Contract - Bracero
    3 Contract - H2A (agricultural)
    4 Temporary: Worker
    5 Temporary: Tourist/visitor
    6 Citizen
    7 Silva Letter
    8 Undocumented (includes false documents)
    9 Refugee / asylum
    12 DACA (Deferred Action for Childhood Arrivals)
    8888 N/A (never migrated to the US)
    9999 Unknown

`occtype` Category of occupation (categorical)

`uscity` City of residence for first US migration (categorical)