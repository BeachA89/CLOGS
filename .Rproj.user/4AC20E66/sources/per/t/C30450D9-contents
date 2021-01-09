library(shiny)
library(shinydashboard)
library(tidyverse)
library(stringr)
library(data.table)
library(DT)
#data_folder <- "/rawdata"

filenames = list.files("./rawdata", pattern = "*.csv", full.names = T)
dataname = basename(filenames)
dataname <-  str_remove_all(dataname, ".csv")


table1 <-  lapply(filenames, fread, header=TRUE, stringsAsFactors=FALSE)

Collateddata =rbindlist(table1, fill=TRUE)
names(Collateddata)<-str_replace_all(names(Collateddata), c(" " = "_"))

Collateddata <-  mutate(Collateddata, ID = paste(Measurement_date, Swimmer, Stroke, sep='_')) 
