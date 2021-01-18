library(dplyr)
library(readr)
library(geosphere)
library(usethis)

ships <- read_csv("data-raw/ships.csv")
glimpse(ships)

# the data are 0.5 Gb, we don't need it all
ships_reduced <- dplyr::select(ships, LAT, LON, ship_type, SHIPNAME, DATETIME)

# also, we can pre-calculate the biggest distance for each ship
# and deploy with this dataset of one row per ship
# so the app only needs to plot, rather than calculate the distances

distances <-
  ships_reduced %>% 
  group_by(ship_type, SHIPNAME) %>%
  mutate(next_lat = lead(LAT)) %>%
  mutate(next_lon = lead(LON)) %>% 
  rowwise() %>%
  mutate(Distance = distm(
    x = c(LON, LAT),
    y = c(next_lon, next_lat), 
    fun = distVincentyEllipsoid)
    ) %>%
  ungroup %>%
  group_by(ship_type, SHIPNAME) %>%
  slice_max(order_by = Distance, n=1, with_ties = TRUE) %>%
  slice_max(order_by = DATETIME, n=1, with_ties = FALSE) %>%
  rename_all(toupper)

# check that we have each ship only once
nrow(distinct(distances, SHIPNAME)) == nrow(distances)

# include this dataset in the package
usethis::use_data(distances, internal = TRUE, overwrite = TRUE)
# the data will be available as `appsilon.task:::distances` or `data(distances)`