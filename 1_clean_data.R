source("R/moving-average.R")
library(tidyverse)

#Import the four raw datasets individually
prm <- read_csv("data/RioMameyesPuenteRoto.csv")
q1 <- read_csv("data/QuebradaCuenca1-Bisley.csv")
q2 <- read_csv("data/QuebradaCuenca2-Bisley.csv")
q3 <- read_csv("data/QuebradaCuenca3-Bisley.csv")

#calculating the moving average
prm1_result <- moving_average(prm)
q1_result <- moving_average(q1)
q2_result <- moving_average(q2)
q3_result <- moving_average(q3)

#binding the four dataframs
combined_rows <- bind_rows(prm1_result, q1_result, q2_result, q3_result)

#Pivoting my data
long_bisley <- combined_rows |>
  pivot_longer(
    cols = c(NH4N, NO3N, Ca, K, Mg),
    names_to = "Ions",
    values_to = "Concentration"
  )


write_csv(long_bisley, "output/long_bisley.csv")
