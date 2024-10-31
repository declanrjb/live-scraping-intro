install.packages("tidyverse")
install.packages("rvest")

library(tidyverse)
library(rvest)

page <- read_html_live("https://www.forbes.com/top-colleges/")
Sys.sleep(1)
df <- page |> html_node("table") |> html_table()

df <- df |> filter(!is.na(Rank))

df |> write_csv('forbes-rankings.csv')
