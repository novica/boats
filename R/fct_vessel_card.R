#' vessel_card
#' 
#' A function to create the card with the vessel information
#' 
#' @importFrom shiny.semantic card
#' 
#' @param vdata  a data frame with vessel data
#'
#' @return the HTML to make semantic card
#' @export
#'
#' @examples if(interactive()) {vessel_card(distances[1,])}

vessel_card <- function(vdata) {
  
  card(div(
    class = "content",
    div(class = "header", paste0("Vessel: ", vdata$SHIPNAME, " (", vdata$SHIP_TYPE, ")" )),
    div(class = "meta", paste("Distance travelled:", round(vdata$DISTANCE, 1), "meters")),
    div(class = "description", paste("Date:", format(vdata$DATETIME, "%d %b, %Y")))
    
  ))
}