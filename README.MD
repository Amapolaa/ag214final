# Analysis code on, "Effects of Hurricane Disturbance on Stream Water Concentrations and Fluxes in Eight Tropical Forest Watersheds of the Luquillo Experimental Forest, Puerto Rico".

## Author
 Garcia, A

# Repository Description
This Github repository contains the raw data and R code that is associated to recreate the (figure 3) from Schaefer et al. (2000). The repository showcases the pre and post-effect disturbances from Hurricane Hugo 1989. What they found was deposits of some nutrients such as, potassium, increased greatly post-disturbances and stayed elevated for years afterwards.

### (Figure 3) will be repoduced showcasing the 9-week moving averages for the stream chemistry. This repository will include the following variables:

* Ammonium (NH4)
* Calcium (Ca)
* Potassium (K)
* Magnesium (Mg)
* Nitrate (NO3)

We will be focusing on the time periods 1988 - 1994 when Hurricane Hugo hit Bisley, Puerto Rico. This will allow us to visually recreate the pattern within the stream-water chemistry.

# Repository structure
 > ## Data  
The data folder will include the provided and downloaded raw data that are from the Enviormental Data Initiative. 

The four raw datasets we will be working with are being represented as (prm,q1,q2,q3):

* prm <- read_csv("RioMameyesPuenteRoto.csv")
* q1 <- read_csv("QuebradaCuenca1-Bisley.csv")
* q2 <- read_csv("QuebradaCuenca2-Bisley.csv")
* q3 <- read_csv("QuebradaCuenca3-Bisley.csv")

For more information [visit(https://portal.edirepository.org/)]

 McDowell, W. and International Institute of Tropical Forestry(IITF), USDA Forest Service.. 2024. Chemistry of stream water from the Luquillo Mountains ver 4923064. Environmental Data Initiative. https://doi.org/10.6073/pasta/f31349bebdc304f758718f4798d25458 (Accessed 2026-08-25).

## Scatch Folder
This folder holds the new_spaghetti.R code that we have been working on this week.

## R
This folder holds the moving-average.R code where we have reorganized our code without changing the functionality.

> ## References
Schaefer, Douglas. A., William H. McDowell, Fredrick N. Scatena, and Clyde E. Asbury. 2000. “Effects of Hurricane Disturbance on Stream Water Concentrations and Fluxes in Eight Tropical Forest Watersheds of the Luquillo Experimental Forest, Puerto Rico.” Journal of Tropical Ecology 16 (2): 189–207. https://doi.org/10.1017/s0266467400001358