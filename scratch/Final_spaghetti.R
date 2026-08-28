#source("R/moving-average.R")
library(tideverse)

#Import the four raw datasets individually
#prm <- read_csv("RioMameyesPuenteRoto.csv") #ask ale
q1 <- read_csv("QuebradaCuenca1-Bisley.csv")
q2 <- read_csv("QuebradaCuenca2-Bisley.csv")
q3 <- read_csv("QuebradaCuenca3-Bisley.csv")

#create a moving average function
moving_average <- function(streamdata) {
  # Initialize a tibble to contain the results
  result <- tibble(
    Sample_Date = seq(
      ymd(streamdata$Sample_Date[1]),
      ymd(streamdata$Sample_Date[nrow(streamdata)]),
      by = "63 days",
    ),
    site = streamdata$Sample_ID[1],
    NH4N = NA,
    NO3N = NA,
    Ca = NA,
    K = NA,
    Mg = NA
  )

  #fill the iterator and sequence
  for (i in 1:nrow(result)) {
    w1 <- result$Sample_Date[i]
    w2 <- w1 + 63

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
prm1_new <- moving_average(prm)
q1_new <- moving_average(q1)
q2_new <- moving_average(q2)
q3_new <- moving_average(q3)

#combining all rows into one
combined_rows <- bind_rows(prm1_new, q1_new, q2_new, q3_new)

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

#create a visual
ggplot(
  plot_data,
  mapping = aes(
    x = Sample_Date,
    y = Concentration,
    linetype = site
  )
) +
  geom_line() +
  facet_wrap(
    ~Ions,
    scales = "free",
    ncol = 1,
    strip.position = "left"
  ) +
  labs(
    title = " The before and after concentrations from Hurricane Hugo in Bisley, Puerto Rico"
  )
