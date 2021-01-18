#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @importFrom dplyr filter pull %>%
#' @importFrom leaflet renderLeaflet
#' @importFrom rlang .data
#' @importFrom shiny eventReactive renderUI

#' 
#' @noRd
app_server <- function(input, output, session) {
  
  # call dropdown modules
  vessel_type <- dropdown(id = "ship_type")
  vessel_name <- dropdown(id = "ship_name")
  
  # filter to get the names of vessels corresponding to selected vessel type
  ship_name_choices <- eventReactive(vessel_type(), {
    distances %>%
      filter(.data$SHIP_TYPE == vessel_type()) %>%
      pull(.data$SHIPNAME)
  }, ignoreInit = TRUE)
  
  # render the second dropdown dependent on selection in first
  output[["second_dropdown"]] <- renderUI({
    dropdown_UI(
      id = "ship_name",
      choices = ship_name_choices(),
      def_text = "Select vessel"
    )
  })
  
  # filter the table for the selected vessel
  vessel_data <- eventReactive(vessel_name(), {
    req(vessel_name())
    distances %>% 
      filter(.data$SHIP_TYPE == vessel_type()) %>% 
      filter(.data$SHIPNAME == vessel_name())
  }, ignoreInit = TRUE)
  
  # render the map
  output[["map"]] <- renderLeaflet({
    req(vessel_data())
    vdata <- vessel_data()
    vessel_map(vdata)
  })
  
  # render the card
  output[["ship_card"]] <- renderUI({
    req(vessel_data())
    vdata <- vessel_data()
    vessel_card(vdata)
  })
}
