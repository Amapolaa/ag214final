#Use the source() function to load your function.
source("R/moving-average.R")

library(tidyverse)

##reading my downloaded csv
prm <- read_csv("RioMameyesPuenteRoto.csv")
q1 <- read_csv("QuebradaCuenca1-Bisley.csv")
q2 <- read_csv("QuebradaCuenca2-Bisley.csv")
q3 <- read_csv("QuebradaCuenca3-Bisley.csv")


q1_smooth <- moving_average(q1)


# getting a glimpse to see what the atomic types are
glimpse(q1)
#initalizing the results by creating a tibble table called q1_sample_date
qb_1 <- q1 |>
  select(Sample_Date, K, NO3N, Mg, Ca, NH4N) |>
  filter(Sample_Date >= "1986-05-16" & Sample_Date < "1995-01-03")

#were sequencing the window start for q1 from 5/20/1986 to 12/01/1996 by 9 weeks
qb_1_smoothed <- tibble(
  window_start = seq(
    ymd(qb_1$Sample_Date[1]),
    ymd(qb_1$Sample_Date[nrow(qb_1)]),
    by = "63 days",
  ),
  NH4N = NA,
  NO3N = NA,
  Ca = NA,
  K = NA,
  Mg = NA
)

#moving average for loop
for (i in 1:nrow(qb_1_smoothed)) {
  # [i] is our iterator and 1:nrow(q1_sample-date) is our sequence
  w1 <- qb_1_smoothed$window_start[i] #whats the start of the window, call it w1 and [i] wil take on those values , one at a time
  w2 <- w1 + 63 #this is the end of the window which we will call it w2 and 63 days after the start date
  w2 # me testing to see if it works

  #Ranges for the following :NH4N, NO3N, Ca,Mg, K
  NH4N <- qb_1$NH4N[
    qb_1$Sample_Date >= w1 &
      qb_1$Sample_Date < w2
  ]

  NO3N <- qb_1$NO3N[
    qb_1$Sample_Date >= w1 &
      qb_1$Sample_Date < w2
  ]

  Ca <- qb_1$Ca[
    qb_1$Sample_Date >= w1 &
      qb_1$Sample_Date < w2
  ]

  K <- qb_1$K[
    qb_1$Sample_Date >= w1 &
      qb_1$Sample_Date < w2
  ]

  Mg <- qb_1$Mg[
    qb_1$Sample_Date >= w1 &
      qb_1$Sample_Date < w2
  ]

  #Find the the average mean of each :NH4N, NO3N, Ca,Mg, K
  qb_1_smoothed$NH4N[i] <- mean(NH4N, na.rm = TRUE)
  qb_1_smoothed$NO3N[i] <- mean(NO3N, na.rm = TRUE)
  qb_1_smoothed$Ca[i] <- mean(Ca, na.rm = TRUE)
  qb_1_smoothed$Mg[i] <- mean(Mg, na.rm = TRUE)
  qb_1_smoothed$K[i] <- mean(K, na.rm = TRUE)
}

qb_1_smoothed |>
  pivot_longer(
    cols = c(NH4N, NO3N, Ca, Mg, K),
    names_to = "Ion",
    values_to = "Concentration"
  ) |>
  #Creating a visual
  ggplot(
    mapping = aes(x = window_start, y = Concentration, color = Ion)
  ) +
  geom_line() +
  facet_wrap(~Ion)
