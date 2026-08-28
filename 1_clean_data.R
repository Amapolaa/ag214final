source("R/moving-average.R")
library(tidyverse)

#Import the four raw datasets individually
prm <- read_csv("data/RioMameyesPuenteRoto.csv") |>
  filter(Sample_Date >= "1988-01-01" & Sample_Date < "1994-12-31")
q1 <- read_csv("data/QuebradaCuenca1-Bisley.csv") |>
  filter(Sample_Date >= "1988-01-01" & Sample_Date < "1994-12-31")
q2 <- read_csv("data/QuebradaCuenca2-Bisley.csv") |>
  filter(Sample_Date >= "1988-01-01" & Sample_Date < "1994-12-31")
q3 <- read_csv("data/QuebradaCuenca3-Bisley.csv") |>
  filter(Sample_Date >= "1988-01-01" & Sample_Date < "1994-12-31")

#calculating the moving average
prm1_result <- moving_average(prm)
q1_result <- moving_average(q1)
q2_result <- moving_average(q2)
q3_result <- moving_average(q3)

#binding the four dataframs
combined_rows <- bind_rows(prm1_result, q1_result, q2_result, q3_result)

#Filtering the datasets from 1988-1995 and selecting sample_date and 5 ions
filtered_rows <- combined_rows |>
  select(Sample_Date, Sample_ID, K, NO3N, Mg, Ca, NH4N)

#Pivoting my data
plot_data <- combined_rows |>
  pivot_longer(
    cols = c(
      NH4N,
      NO3N,
      Ca,
      K,
      Mg
    ),
    names_to = "Ions",
    values_to = "Concentration"
  )


write_csv(plot_data, "output/1_clean_data.csv")
