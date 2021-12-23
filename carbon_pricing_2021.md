Carbon Pricing
================
Angel Salazar
12/22/2021

``` r
# importing packages to be able to plot the data
library(ggplot2)
```

    ## Warning: package 'ggplot2' was built under R version 4.0.5

``` r
library(tidyr)
```

    ## Warning: package 'tidyr' was built under R version 4.0.5

``` r
library(tidyverse)
```

    ## Warning: package 'tidyverse' was built under R version 4.0.5

    ## -- Attaching packages --------------------------------------- tidyverse 1.3.1 --

    ## v tibble  3.1.6     v dplyr   1.0.7
    ## v readr   2.1.1     v stringr 1.4.0
    ## v purrr   0.3.4     v forcats 0.5.1

    ## Warning: package 'tibble' was built under R version 4.0.5

    ## Warning: package 'readr' was built under R version 4.0.5

    ## Warning: package 'dplyr' was built under R version 4.0.5

    ## Warning: package 'forcats' was built under R version 4.0.5

    ## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
library(dplyr)
library(ggstance)
```

    ## Warning: package 'ggstance' was built under R version 4.0.5

    ## 
    ## Attaching package: 'ggstance'

    ## The following objects are masked from 'package:ggplot2':
    ## 
    ##     geom_errorbarh, GeomErrorbarh

``` r
library(ggthemes)
```

    ## Warning: package 'ggthemes' was built under R version 4.0.5

``` r
# import excel into r
carbon_price <- read.csv("carbon_pricing_2021.csv")
```

``` r
# subsetting to get rid of past carbon prices
current_prices <- subset(carbon_price, select = c(Name.of.the.initiative, 
                                                  Instrument.Type, 
                                                  Jurisdiction.Covered, 
                                                  Price_rate_1_2021))

# now removing all rows with N/A value
current_prices <- current_prices[!(current_prices$Price_rate_1_2021 == "N/A"),]

# converting price columns to integers
current_prices$Price_rate_1_2021 <- as.integer(current_prices$Price_rate_1_2021)

# checking if our N/A rows were dropped
head(current_prices)
```

    ##   Name.of.the.initiative Instrument.Type Jurisdiction.Covered Price_rate_1_2021
    ## 1           Alberta TIER             ETS              Alberta                31
    ## 2   Argentina carbon tax      Carbon tax            Argentina                 5
    ## 3              BC GGIRCA             ETS     British Columbia                19
    ## 4          BC carbon tax      Carbon tax     British Columbia                35
    ## 5      Beijing pilot ETS             ETS              Beijing                 4
    ## 7         California CaT             ETS           California                17

``` r
# plotting our data
current_prices %>%
  drop_na(Price_rate_1_2021) %>%
  filter(Price_rate_1_2021 > 0) %>%
  ggplot(aes(x = Price_rate_1_2021, 
             y = Name.of.the.initiative)) +
  geom_barh(stat="identity") +
  labs(x = "US$ / tCO2e", y = NULL,
       title = "Prices in Implemented Carbon Pricing Initiatives, as of April 2021", 
       caption = "Source: The World Bank, Carbon Pricing Dashboard") +
    scale_x_continuous(breaks = scales::pretty_breaks(n = 20)) +
  theme_economist() + scale_color_economist()
```

![](carbon_pricing_2021_files/figure-gfm/plotting%20carbon%20prices%20for%202021-1.png)<!-- -->
