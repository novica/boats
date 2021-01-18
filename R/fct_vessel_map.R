#' vessel_map
#' 
#' A function to create a leaflet map
#' 
#' @importFrom leaflet leaflet addMarkers addTiles addScaleBar addMiniMap
#' @importFrom magrittr %>% 
#' @param vdata a data frame with vessel data
#'
#' @return a leaflet map with two points for the start and end of the trip
#' @export
#'
#' @examples if(interactive()) {vessel_map(distances[1,])}


vessel_map <- function(vdata) {

  leaflet() %>% 
  addTiles() %>% 
  addScaleBar() %>%
  addMarkers(lng = c(vdata$LON, vdata$NEXT_LON), lat = c(vdata$LAT, vdata$NEXT_LAT)) %>%
  addMiniMap(
    zoomLevelFixed = 10,
    position = 'bottomright', 
    width = 300, height = 200,
    toggleDisplay = FALSE)
}