# The input to this function should be a data frame containing stream chemistry data
moving_average <- function(streamdata) {
  # Initialize a tibble to contain the results

  streamdata <- streamdata |>
  select(Sample_Date, Sample_ID, `NH4-N`,`NO3-N`, Ca, Mg, K) |>
  filter(Sample_Date >= "1986-05-16" & Sample_Date < "1995-01-03")
  
 

  result <- tibble(
    Sample_Date = seq(
      ymd(streamdata$Sample_Date[1]),
      ymd(streamdata$Sample_Date[nrow(streamdata)]),
      by = "63 days",
    ),
    site = streamdata$Sample_Date
    NH4N = NA,
    NO3N = NA,
    Ca = NA,
    K = NA,
    Mg = NA
  )

  # Fill in the iterator and sequence
  for (i in 1:nrow(result)) {
    w1 <- result$Sample_Date[i] #whats the start of the window, call it w1 and [i] wil take on those values , one at a time
    w2 <- w1 + 63
    # Create a logical vector, called "in_window", that says which samples are inside the window
    # Hint: you'll compare sample dates to the start and end of the window
    in_window <- streamdata$Sample_Date >= w1 & streamdata$Sample_Date < w2
    in_window

    # Use indexing to pull out the ion concentrations that fall inside the window
    NH4N_window <- streamdata$`NH4-N`[in_window]
    NO3N_window <- streamdata$`NO3-N`[in_window]
    Ca_window <- streamdata$Ca[in_window]
    K_window <- streamdata$K[in_window]
    Mg_window <- streamdata$Mg[in_window]
    # The line above gets potassium in the window. Get the rest of the ions too

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
