---
title: "Stocks"
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
library(tidyquant)
library(dygraphs)
library(ggforce)
library(lubridate)
library(timetk)
```

```{r}
df <- tq_get(c("NVDA", "TWTR", "IBM"),
             get = "stock.prices",
             from = "2017-12-01",
             to   = "2022-12-01")

df2 <- df %>% pivot_wider(names_from = symbol, values_from = adjusted, id_cols = date)

xts <- df2 %>%
  tk_xts(date = date)

stocks <- dygraph(xts, main = "Tech Stocks") %>%
  dyRangeSelector(dateWindow = c("2017-12-01", "2022-12-01"))

stocks