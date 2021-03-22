## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----customer_infos-----------------------------------------------------------
library(jsontools)

customer_infos <- json2(c(
  '{"name": "Peter", "age": 19, "premium": true}',
  '{"name": "Daniel", "age": 41}',
  NA,
  '{"name": "Pablo", "age": 27, "premium": false}'
))

customer_infos

## ----parse-na-error, error=TRUE-----------------------------------------------
parse_json_vector(customer_infos)

## ----parse-na-success---------------------------------------------------------
parse_json_vector(customer_infos, .na = NULL) %>% str()

## ----customer_infos_df--------------------------------------------------------
customer_infos_df <- tibble::tibble(
  name = c("Peter", "Daniel", NA, "Pablo"),
  age = c(19L, 41L, NA, 27L),
  premium = c(TRUE, NA, NA, FALSE)
)

## ----customer_infos_df-filled-------------------------------------------------
customer_infos_df[3, ] <- tibble::tibble(
  name = "Michael",
  age = 38,
  premium = FALSE
)
customer_infos_df$premium[2] <- TRUE

customer_infos_df

## ----format_json_rowwise------------------------------------------------------
format_json_rowwise(customer_infos_df)

## ----format_json--------------------------------------------------------------
format_json(customer_infos_df)

## ----format_json_list---------------------------------------------------------
customer_infos_list <- parse_json_vector(customer_infos, .na = NULL)
str(customer_infos_list)

format_json_list(customer_infos_list)

## -----------------------------------------------------------------------------
x <- list(customers = 1:2)
format_json(x, auto_unbox = TRUE)

## -----------------------------------------------------------------------------
x <- list(customers = 1)
format_json(x, auto_unbox = TRUE)

