## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(jsontools)
got_json <- got_chars_json

## ----type---------------------------------------------------------------------
json_type(got_json)

## ----array-infos--------------------------------------------------------------
json_array_length(got_json)
json_array_types(got_json)

## ----flatten------------------------------------------------------------------
json_flatten(got_json)

## ----flatten-ptype------------------------------------------------------------
got_chars <- json_flatten(got_json, ptype = new_json_object())

## ----got_chars_1--------------------------------------------------------------
got_chars[1]

## ----prettify-----------------------------------------------------------------
json_prettify(got_chars[1])

## ----extract-simple-----------------------------------------------------------
json_extract(got_chars, "$.name")

## ----extract------------------------------------------------------------------
tibble::tibble(
  id = json_extract(got_chars, "$.id"),
  name = json_extract(got_chars, "$.name"),
  alive = json_extract(got_chars, "$.alive")
)

## ----error=TRUE---------------------------------------------------------------
tibble::tibble(
  id = json_extract(got_chars, "$.id"),
  name = json_extract(got_chars, "$.name"),
  alive = json_extract(got_chars, "$.alive"),
  titles = json_extract(got_chars, "$.titles")
)

## -----------------------------------------------------------------------------
json_extract(got_chars, "$.titles", ptype = character())

## -----------------------------------------------------------------------------
json_extract(got_chars, "$.titles", wrap_scalars = TRUE)

## ----unnest-wider-------------------------------------------------------------
got_chars_df <- tibble::tibble(chars_json = got_chars) %>%
  json_unnest_wider(chars_json, wrap_scalars = TRUE)

got_chars_df

## ----unnest-longer------------------------------------------------------------
got_chars_df[c("id", "name", "titles")] %>% 
  json_unnest_longer(titles)

## -----------------------------------------------------------------------------
got_chars_small <- json_delete(got_chars, "$.url", "$.aliases", "$.allegiances")

## -----------------------------------------------------------------------------
json_mutate(
  got_chars_small,
  .id = 1:5,
  .alive = !json_extract(got_chars_small, "$.alive")
)

## -----------------------------------------------------------------------------
x <- c(
  '{"id": 1, "a": 3}',
  '{"id": 2, "a": 4}',
  '{"id": 3}'
)

# remove element at "a"
json_merge(x, '{"a": null}')

# it is vectorised
json_merge(
  x,
  c(
    '{"a": null}',
    '{"a": 5}',
    '{"a": 6}'
  )
)

