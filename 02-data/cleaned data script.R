library(readr)
library(knitr)
library(tidyverse)
library(dplyr)

pers170 <- read_csv(paste0("/cloud/project/02-data/pers170.csv"))
mmp <- pers170 %>%
  select(sex, relhead, yrborn, age, statebrn, marstat, edyrs, occ, hhincome, usstate1, usstatel, usplace1, usplacel, usdur1, usdurl, usdur1, usdoc1)%>%
  filter(hhincome != 9999 & hhincome !=8888,
         usstate1 != 9999 & usstate1 !=  8888,
         usstatel != 9999 &  usstatel !=8888,
         usdur1 != 9999 & usdur1 !=8888,
         usdurl != 9999 & usdurl !=8888,
         usdoc1 != 9999 & 8888)
<<<<<<< HEAD

write.csv(mmp, file = "raw_data.csv")

=======
write.csv(imm,  "dat.csv")
view()
>>>>>>> 30acbc8a510f990864c4c8d5dfffce61eb40511f
