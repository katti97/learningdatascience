library(tidyverse)
library(rvest)

#importing from the website using the website link
webtable <- read_html("https://en.wikipedia.org/wiki/List_of_best-selling_music_artists")%>%
  
  #importing the table's style that contains the required table
  html_nodes("table.wikitable:nth-child(14)")%>%
  
  
  html_table()%>%
  rbind.data.frame()

webtable