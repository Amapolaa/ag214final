library(tidyverse)

#STEP 2:
qs_data <- read_csv("data/QuebradaSonadora_Fall1984.csv")

#STEP 3:
qs_smoothed <- tibble(
    window_start = seq(ymd("1984-09-04"), ymd("1984-11-28"), by = "9 days"),
  k_mgl = NA, mg_mgl = NA)

qs_smoothed

#Step 4: Moving average for loop
for(i in 1:nrow(qs_smoothed)) {
  #i is our iterator
  #1:nrow(qs_smoothed) is our sequence
  #i wil take on those values , one at a time
  #whats the start of the window, call it w1
w1 <- qs_smoothed$window_start[i]
w1
  #whats the end of the window? call it w2
w2 <- qs_smoothed$window_start[i]+ 9
w2  #9 days after the start date
  #what potassium values are inside that window?
k_ranges <- qs_data$k_mgl[qs_data$sample_date >= w1 &
  qs_data$sample_date < w2]
  k_ranges
  #how do you  put it in the result?
  qs_smoothed$k_mgl[i] <- mean(k_ranges)

#find the average mean
mg_ranges <- qs_data$mg_mgl[qs_data$sample_date >= w1 & qs_data$sample_date < w2]
qs_smoothed$mg_mgl[i] <- mean(mg_ranges)
}

#if(qs_data$sample_date[1] >= qs_smoothed$window_start[1])
    # print("something")}
    # else (qs_data$sample_date[1] <= qs_smoothed$window_start[1]) {
    # print("hell yeah")}


#step 6:plot it
qs_longer <- qs_smoothed |> 
  pivot_longer(
    cols = c(k_mgl, mg_mgl),
    names_to = "Nutrient",
    values_to = "Concentration"
  )
qs_longer #check it out
    
  
#lets get it plotted
ggplot(
  data = qs_longer,
  mapping = aes(x = window_start, y = Concentration, color = Nutrient)
) +
  geom_point()
