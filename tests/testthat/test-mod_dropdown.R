test_that("UI function returns shiny.tag object", {
  expect_s3_class(dropdown_UI("id", c(1, 2, 3), "abc"),  "shiny.tag.list")
})
