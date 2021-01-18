test_that("function returns object", {
  
  vdata <- distances[1, ]
  
  expect_s3_class(vdata, "data.frame")
  
  expect_s3_class(vessel_card(vdata),  "shiny.tag")
  
})
