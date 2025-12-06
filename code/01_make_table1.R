here::i_am("code/01_make_table1.R")

data <- readRDS(
  file = here::here("output/clean_data.rds")
)

library(gtsummary)

table_one <- data |>
  select("Sex", "Age", "ChestPainType", "RestingBP", "Cholesterol", "MaxHR",
         "ExerciseAngina", "ST_Slope", "HeartDisease") |>
  tbl_summary(by = HeartDisease) |>
  modify_spanning_header(c("stat_1", "stat_2") ~ "**Heart Disease Status**") |>
  add_overall() |>
  add_p()

saveRDS(
  table_one,
  file = here::here("output/table_one.rds")
)

