#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @importFrom shiny uiOutput 
#' @importFrom shiny.semantic semanticPage message_box
#' @importFrom leaflet leafletOutput
#' 
#' @noRd
app_ui <- function(request) {
  tagList(golem_add_external_resources(),
          semanticPage(title = "Appsilon entry task",
                       div(
                         class = "ui container",
                         h1(class = "ui header", "Vessels in the Baltic Sea"),
                         div(class = "ui grid",
                             div(
                               class = "two column row",
                               div(
                                 class = "four wide column ui raised segment",
                                 message_box(class = "info", header = NULL,
                                             content = "Select vessel type and name to see a summary and map of its longest traveled distance between two consecutive observations"),
                                   dropdown_UI(
                                     id = "ship_type",
                                     choices = unique(distances$SHIP_TYPE),
                                     def_text = "Select vessel type"
                                 ),
                                 div(style = "height: 20px;"),
                                 uiOutput(outputId = "second_dropdown"),
                                 div(style = "height: 30px;"),
                                 div(class = "ui horizontal divider", "Result"),
                                 div(style = "height: 10px;"),
                                 uiOutput(outputId = "ship_card")
                               ),
                               div(
                                 class = "twelve wide column ui raised segment",
                                 leaflet::leafletOutput(outputId = "map", height = "600px")
                               )
                             ))
                       )))
}
#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path('www', app_sys('app/www'))
  
  tags$head(favicon(),
            bundle_resources(path = app_sys('app/www'),
                             app_title = 'Vessels | Baltic'))
}
