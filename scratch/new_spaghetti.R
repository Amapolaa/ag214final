#RESTARTING MY CODE BECAUSE I was trying to do all of them
library(tidyverse)

##reading my downloaded csv
prm <- read_csv("RioMameyesPuenteRoto.csv")
q1 <- read_csv("QuebradaCuenca1-Bisley.csv")
q2 <- read_csv("QuebradaCuenca2-Bisley.csv")
q3 <- read_csv("QuebradaCuenca3-Bisley.csv")

##one at a time pola! ##
glimpse(q1) # getting a glimpse to see what the atomic types are

#initalizing the results by creating a tibble table called q1_sample_date
#were sequencing the window start for q1 from 5/20/1986 to 12/01/1996 by 9 weeks
q1_smoothed <- tibble(
   window_start = seq(
    ymd(q1$Sample_Date[1]),
   ymd(q1$Sample_Date[nrow(q1)]),
   by = "63 days",
   ),
   NH4N = NA, NO3N = NA, Ca = NA, K = NA, Mg = NA)



#moving average for loop
for(i in 1:nrow(q1_smoothed)) {  # [i] is our iterator and 1:nrow(q1_sample-date) is our sequence
w1 <- q1_smoothed$window_start[i]  #whats the start of the window, call it w1 and [i] wil take on those values , one at a time 
w2 <- w1+ 63 #this is the end of the window which we will call it w2 and 63 days after the start date
w2 # me testing to see if it works 

#Ranges for the following :NH4N, NO3N, Ca,Mg, K
NH4N <- q1$NH4N[q1$Sample_Date >= w1 & 
  q1$Sample_Date < w2]
  
 NO3N <- q1$ NO3N[q1$Sample_Date >= w1 & 
  q1$Sample_Date < w2] 
  
Ca <- q1$Ca[q1$Sample_Date >= w1 & 
  q1$Sample_Date < w2]
  
K <- q1$K[q1$Sample_Date >= w1 & 
  q1$Sample_Date < w2] 
  
Mg <- q1$Mg[q1$Sample_Date >= w1 & 
  q1$Sample_Date < w2]

#Find the the average mean of each :NH4N, NO3N, Ca,Mg, K
q1_smoothed$NH4N[i] <- mean(NH4N, na.rm = TRUE)
q1_smoothed$NO3N[i] <- mean(NO3N, na.rm = TRUE)
q1_smoothed$Ca[i] <- mean(Ca, na.rm = TRUE)
q1_smoothed$Mg[i] <- mean(Mg, na.rm = TRUE)
q1_smoothed$K[i] <- mean(K, na.rm = TRUE)
}

q1_smoothed |> 
  pivot_longer(
    cols = c(NH4N, NO3N, Ca,Mg, K),
    names_to = "Ion",
    values_to = "Concentration"
  ) |> 
#Creating a visual
ggplot(
  mapping = aes(x = window_start, y = Concentration, color = Ion)
)+
  geom_line() +  
  facet_wrap(~Ion)
 