library(readr)
library(knitr)
library(tidyverse)

pers170 <- read_csv(paste0("/Users/qintianzhang/Downloads/pers170.csv"))
imm <- pers170 %>%
  select(sex, relhead, yrborn, age, statebrn, marstat, edyrs, occ, hhincome, ldowage, health, healthly, healthnw)
imm %>%
  filter(hhincome != 9999, hhincome != 8888)
imm %>%
  filter(!is.na(health))
imm %>%
  filter(!is.na(hhincome))
imm %>%
  filter(!is.na(healthy))
imm %>%
  filter(!is.na(healthnw))
imm %>%
  filter(!is.na(ldowage))