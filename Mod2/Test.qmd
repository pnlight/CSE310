---
title: "Project"
format:
  html:
    code-link: true
    code-fold: true
editor: visual
execute:
  keep-md: true
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(warning = FALSE, message = FALSE) 

library(ggplot2)
library(tidyverse)
library(dplyr)
library(USAboundaries)
library(ggrepel)
library(sf)
library(downloader)
library(fs)
library(readxl)
library(leaflet)
library(geojsonio)
```

Diversity Index D = 1 - ∑(n(n-1))

```{r}

states <- geojson_read("https://rstudio.github.io/leaflet/json/us-states.geojson", what = "sp")
class(states)

df <- read.csv("race data.csv", check.names = FALSE)[-c(9:71),]

df <- as.data.frame(t(df))

names(df) <- df[1,]

df <- df[-1,] 

df <- setNames(cbind(rownames(df), df, row.names=NULL), c("name", "total", "one_race", "white", "black", "american_indian", "asian", "pacific_islander", "other")) 

all <- left_join(df, states, by = "name", copy = T)

all <- all %>%
  transform(total = as.numeric(gsub(",","",all$total))) %>%
  transform(one_race = as.numeric(gsub(",","",all$one_race))) %>%
  transform(white = as.numeric(gsub(",","",all$white))) %>%
  transform(black = as.numeric(gsub(",","",all$black))) %>%
  transform(american_indian = as.numeric(gsub(",","",all$american_indian))) %>%
  transform(asian = as.numeric(gsub(",","",all$asian))) %>%
  transform(pacific_islander = as.numeric(gsub(",","",all$pacific_islander))) %>%
  transform(other = as.numeric(gsub(",","",all$other))) %>%
  mutate(two_or_more = total - one_race) %>%
  mutate(dindex = 100*(1 - (((white/total)^2) + ((black/total)^2) + ((american_indian/total)^2) + ((asian/total)^2) + ((pacific_islander/total)^2) + ((two_or_more/total)^2) + ((other/total)^2))))
  
view(all)
all <- sp::merge(states, all, by = "name") 

bins <- c(0, 10, 20, 30, 40, 50, 60, 70, 80, 90)
pal <- colorBin("GnBu", domain = all$dindex, bins = bins)

labels <- sprintf("<strong>%s</strong><br/>Diversity Index: %.2f<span>&#37;</span> <br/>Total Population: %s<br/>White: %.2f <br/>Black: %.2f <br/>American Indian: %.2f <br/>Asian: %.2f <br/>Pacific Islander: %.2f <br/>Other: %.2f <br/>Two or more: %.2f"
                  ,all$name,  all$dindex, prettyNum(all$total, big.mark = ",", scientific = FALSE), all$white/all$total*100, all$black/all$total*100, all$american_indian/all$total*100, all$asian/all$total*100, all$pacific_islander/all$total*100, all$other/all$total*100, all$two_or_more/all$total*100) %>%
  lapply(htmltools::HTML)



m <- leaflet(all) %>%
  setView(-96, 37.8, 4) %>%
  addProviderTiles("CartoDB.Positron") %>%
  addPolygons(
    fillColor = ~pal(dindex),
    weight = 2,
    opacity = 1,
    color = "grey",
    dashArray = "2",
    fillOpacity = 0.7,
    highlightOptions = highlightOptions(
      weight = 3,
      color = "white",
      dashArray = "",
      fillOpacity = 0.7,
      bringToFront = TRUE),
    label = labels,
    labelOptions = labelOptions(
      style = list("font-weight" = "normal", padding = "3px 8px"),
      textsize = "15px",
      direction = "auto")) %>%
  addLegend(pal = pal, values = ~dindex, opacity = 0.7, title = NULL,
    position = "bottomright")
m
```

I combined the 2020 census data and the Spatial Polygons data frame from geojson to create this Diversity Index Choropleth Map. This map calculates the diversity using Simpson's Diversity Index formula. Population breakdown is overlaid on hover. As my wife and I are planning to remove away from Rexburg, it would be nice to live in a place with tons of diversity. 
