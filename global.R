source('configure.R')
source('functions.R')
library(googlesheets4)
library(shiny)
library(shinydashboard)
library(DT)
library(dplyr)
library(data.table)
library(plotly)
library(shinythemes)
# library(DBI)
library(tidyr)
library(stats)
# library(sf)
# library(soilprofile2)

gs4_deauth()
# options(stringsAsFactors = FALSE)


df2022 <- clean_student_df2022(googlesheets4::read_sheet(googleSheetId2022, sheet = "studinfo_GEM_20220410"))

df2023_submission <- clean_student_df2022(googlesheets4::read_sheet(googleSheetId2023, sheet = "submission"))
df2023_recommendation <- clean_student_df2022(googlesheets4::read_sheet(googleSheetId2023, sheet = "recommendation"))
df2023_tutorial <- clean_student_df2022(googlesheets4::read_sheet(googleSheetId2023, sheet = "tutorial"))
df2023_rep <- clean_student_df2022(googlesheets4::read_sheet(googleSheetId2023, sheet = "student rep"))




