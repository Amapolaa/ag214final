library(tidyverse)

##add the csv
prm <- read_csv("RioMameyesPuenteRoto.csv")
q1 <- read_csv("QuebradaCuenca1-Bisley.csv")
q2 <- read_csv("QuebradaCuenca2-Bisley.csv")
q3 <- read_csv("QuebradaCuenca3-Bisley.csv")

glimpse(prm)

#combine the data csv(s)
combine_data <- bind_rows(prm,q1,q2,q3) 

#clean the datasets
clean_combined_data <- combine_data  |> 
  select(Sample_ID,Sample_Date,`NH4-N`, Ca, Mg, `NO3-N`, K) |> 
   mutate(Sample_Date = as_date(Sample_Date))

spaghetti_date <- tibble(
   window_start = seq(ymd("1986-05-20"), 
   ymd("2004-12-21"), by = "9 weeks"),
   `NH4-N`= NA,
   `NO3-N`= NA,
  Ca = NA,
  Mg = NA,
  K = NA
)
spaghetti_date

long_spaghetti <- spaghetti_date |> 
  pivot_longer(
    cols = c(k_mgl, mg_mgl),
    names_to = "Nutrient",
    values_to = "Concentration"
  )
long_spaghetti

#for loop to initalizw
for(i in 1:nrow(long_spaghetti)) {
w1 <- long_spaghetti$window_start[i]
w1
  #whats the end of the window? call it w2
w2 <- long_spaghetti$window_start[i]+ 9
w2  #9 days after the start date
  #what potassium values are inside that window?
k_ranges <- combine_data$k_mgl[combine_data$sample_date >= w1 &
  combine_data$sample_date < w2]
  k_ranges
  #how do you  put it in the result?
  long_spaghetti$k_mgl[i] <- mean(k_ranges)

#find the average mean
mg_ranges <- combine_data$mg_mgl[combine_data$sample_date >= w1 & combine_data$sample_date < w2]
long_spaghetti$mg_mgl[i] <- mean(mg_ranges)
}

ggplot(
  data = long_spaghetti,
  mapping = aes(x = window_start, y = Concentration, color = Nutrient)
) +
  geom_point()
