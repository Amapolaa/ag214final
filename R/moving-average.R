#Filtering the datasets from 1988-1995 and selecting sample_date and 5 ions
library(tidyverse)
# The input to this function should be a data frame containing stream chemistry data
moving_average <- function(streamdata) {
  streamdata <- streamdata |>
    select(Sample_Date, Sample_ID, K, `NO3-N`, Mg, Ca, `NH4-N`) |>
    filter(Sample_Date >= "1988-01-01" & Sample_Date < "1994-12-31")

  result <- tibble(
    Sample_Date = seq(
      ymd(streamdata$Sample_Date[1]),
      ymd(streamdata$Sample_Date[nrow(streamdata)]),
      by = "9 weeks",
    ),
    site = streamdata$Sample_ID[1],
    NH4N = NA,
    NO3N = NA,
    Ca = NA,
    K = NA,
    Mg = NA
  )

  # Fill in the iterator and sequence
  for (i in 1:nrow(result)) {
    w1 <- result$Sample_Date[i]
    w2 <- w1 + weeks(9)

    in_window <- streamdata$Sample_Date >= w1 & streamdata$Sample_Date < w2
    in_window

    # Use indexing to pull out the ion concentrations that fall inside the window
    NH4N_window <- streamdata$`NH4-N`[in_window]
    NO3N_window <- streamdata$`NO3-N`[in_window]
    Ca_window <- streamdata$Ca[in_window]
    K_window <- streamdata$K[in_window]
    Mg_window <- streamdata$Mg[in_window]

    # Calculate the mean of each ion concentration and fill in the result
    result$NH4N[i] <- mean(NH4N_window, na.rm = TRUE)
    result$NO3N[i] <- mean(NO3N_window, na.rm = TRUE)
    result$Ca[i] <- mean(Ca_window, na.rm = TRUE)
    result$K[i] <- mean(K_window, na.rm = TRUE)
    result$Mg[i] <- mean(Mg_window, na.rm = TRUE)
  }

  # Return the results
  return(result)
}
