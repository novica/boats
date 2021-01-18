test_that("returns leaflet map", {
  
    vdata <- distances[1, ]
    
    expect_s3_class(vessel_map(vdata),  "leaflet")
    
    expect_s3_class(vessel_map(vdata),  "htmlwidget")
    
})
