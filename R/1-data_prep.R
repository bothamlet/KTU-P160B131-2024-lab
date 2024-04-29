install.packages("tidyverse")
install.packages("rjson")
install.packages("jsonlite")

library(tidyverse)
library(rjson)
library(jsonlite)

cat("Dabartinė direktorija: ", getwd())
#setwd("C:/Users/1984r/Desktop/R darbas/KTU-P160B131-2024-lab/R")

download.file("https://atvira.sodra.lt/imones/downloads/2023/monthly-2023.json.zip", "../data/temp")
unzip("../data/temp",  exdir = "../data/")

readLines("../data/monthly-2023.json", 20)
data <- fromJSON("../data/monthly-2023.json")

data %>%
  filter(ecoActCode == 479100) %>%
  saveRDS("../data/Data.rds")

file.remove("../data/temp")
file.remove("../data/monthly-2023.json")
