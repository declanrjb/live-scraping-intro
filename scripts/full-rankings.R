library(tidyverse)
library(rvest)

get_college_rankings <- function(page) {
  df <- page |> html_node("table") |> html_table()
  df <- df |> filter(!is.na(Rank))
  return(df)
}

page <- read_html_live("https://www.forbes.com/top-colleges/")
Sys.sleep(1)
df <- get_college_rankings(page)

while (is.na(page |> html_node('button[aria-label="Next"]') |> html_attr("disabled"))) {
  page$click('button[aria-label="Next"]')
  Sys.sleep(1)
  df <- rbind(df, get_college_rankings(page))
}

write_csv(df,"forbes-rankings.csv")