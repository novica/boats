#' Semantic dropdown menu module
#' 
#' @description Generates the UI and server logic for a Semantic/Fomantic 
#' dropdown menu. The server is quite simple, merely returning the 
#' value selected in the UI to be used downstream
#' 
#' @param id namespace id
#' @param choices character, vector of possible selections
#' @param def_text character, a descriptor of the dropdown field
#' 
#' @importFrom shiny NS moduleServer reactive
#' @importFrom shiny.semantic dropdown_input
#' 
#' @export
dropdown_UI <- function(id, choices, def_text) {
  ns <- NS(id)
  tagList(
    dropdown_input(
      input_id = ns("drop"),
      choices = choices,
      default_text = def_text
    )
  )
}

#' @rdname dropdown_UI
#' @export
dropdown <- function(id) {
  moduleServer(
    id = id,
    module = function(input, output, session) {
      return(reactive(input[["drop"]]))
    }
  )
}