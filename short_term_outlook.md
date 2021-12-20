Short-Term Energy Outlook
================
Angel Salazar
12/17/2021

-----

``` r
# SHORT TERM ENERGY OUTLOOK -> US PRICES -> MACROECONOMIC PRICE INDICES
us_cpi <- eia_series(id = "STEO.CICPIUS.M")

# viewing structure of data
str(us_cpi$data)
```

    ## List of 1
    ##  $ : tibble [396 x 4] (S3: tbl_df/tbl/data.frame)
    ##   ..$ value: num [1:396] 2.81 2.8 2.8 2.8 2.79 ...
    ##   ..$ date : Date[1:396], format: "2022-12-01" "2022-11-01" ...
    ##   ..$ year : int [1:396] 2022 2022 2022 2022 2022 2022 2022 2022 2022 2022 ...
    ##   ..$ month: int [1:396] 12 11 10 9 8 7 6 5 4 3 ...

``` r
# unnesting columns 
select(us_cpi, data) %>% unnest(cols = data)
```

    ## # A tibble: 396 x 4
    ##    value date        year month
    ##    <dbl> <date>     <int> <int>
    ##  1  2.81 2022-12-01  2022    12
    ##  2  2.80 2022-11-01  2022    11
    ##  3  2.80 2022-10-01  2022    10
    ##  4  2.80 2022-09-01  2022     9
    ##  5  2.79 2022-08-01  2022     8
    ##  6  2.79 2022-07-01  2022     7
    ##  7  2.79 2022-06-01  2022     6
    ##  8  2.79 2022-05-01  2022     5
    ##  9  2.78 2022-04-01  2022     4
    ## 10  2.78 2022-03-01  2022     3
    ## # ... with 386 more rows

``` r
# graphing our data
filter(unnest(us_cpi, cols = data), year >= 2018) %>%
  ggplot(aes(x = date, 
             y = value)) + 
  scale_x_date(date_label = "%m-%y", breaks = scales::pretty_breaks(n = 10)) +
  geom_line() +
  labs(y = "Index",
       x = "Date",
       title = "US Consumer Price Index (Monthly)", 
       subtitle = "All Urban Consumers") +
  geom_smooth(method = lm) # linear model 
```

    ## `geom_smooth()` using formula 'y ~ x'

![](short_term_outlook_files/figure-gfm/us%20cpi-1.png)<!-- -->

-----

``` r
# brent crude oil spot price
brent_oil_spot <- eia_series(id = "STEO.BREPUUS.M")

# imported crude oil price
imported_oil_price <- eia_series(id = "STEO.RAIMUUS.M")

# refiner average crude oil acquisition cost
refiner_acquisition_cost <- eia_series(id = "STEO.RACPUUS.M")

# west texas intermediate crude oil price
wti_oil_price <- eia_series(id = "STEO.WTIPUUS.M")

# joining our data frames
crude_oil_prices <- merge(merge(merge(brent_oil_spot, 
                          imported_oil_price, all = TRUE),  
                          refiner_acquisition_cost, all = TRUE),
                          wti_oil_price, all = TRUE)


# checking out structure of merged data
str(crude_oil_prices$data)
```

    ## List of 4
    ##  $ : tibble [396 x 4] (S3: tbl_df/tbl/data.frame)
    ##   ..$ value: num [1:396] 66 67 68 69 70 70 70 71 71 73 ...
    ##   ..$ date : Date[1:396], format: "2022-12-01" "2022-11-01" ...
    ##   ..$ year : int [1:396] 2022 2022 2022 2022 2022 2022 2022 2022 2022 2022 ...
    ##   ..$ month: int [1:396] 12 11 10 9 8 7 6 5 4 3 ...
    ##  $ : tibble [396 x 4] (S3: tbl_df/tbl/data.frame)
    ##   ..$ value: num [1:396] 60.5 61.5 62.5 63.5 65 ...
    ##   ..$ date : Date[1:396], format: "2022-12-01" "2022-11-01" ...
    ##   ..$ year : int [1:396] 2022 2022 2022 2022 2022 2022 2022 2022 2022 2022 ...
    ##   ..$ month: int [1:396] 12 11 10 9 8 7 6 5 4 3 ...
    ##  $ : tibble [588 x 4] (S3: tbl_df/tbl/data.frame)
    ##   ..$ value: num [1:588] 59.5 60.5 61.5 62.5 64 ...
    ##   ..$ date : Date[1:588], format: "2022-12-01" "2022-11-01" ...
    ##   ..$ year : int [1:588] 2022 2022 2022 2022 2022 2022 2022 2022 2022 2022 ...
    ##   ..$ month: int [1:588] 12 11 10 9 8 7 6 5 4 3 ...
    ##  $ : tibble [396 x 4] (S3: tbl_df/tbl/data.frame)
    ##   ..$ value: num [1:396] 62 63 64 65 66.5 66.5 66.5 67.5 67.5 69.5 ...
    ##   ..$ date : Date[1:396], format: "2022-12-01" "2022-11-01" ...
    ##   ..$ year : int [1:396] 2022 2022 2022 2022 2022 2022 2022 2022 2022 2022 ...
    ##   ..$ month: int [1:396] 12 11 10 9 8 7 6 5 4 3 ...

``` r
# making sure our data is well unnested
crude_oil_prices_new <- crude_oil_prices %>%
  unnest(cols = data)

# checking to see if we have unnested our dataframe
head(crude_oil_prices_new)
```

    ## # A tibble: 6 x 15
    ##   series_id      name    units  f     copyright source     geography start end  
    ##   <chr>          <chr>   <chr>  <chr> <chr>     <chr>      <chr>     <chr> <chr>
    ## 1 STEO.BREPUUS.M Brent ~ dolla~ M     None      U.S. Ener~ USA       1990~ 2022~
    ## 2 STEO.BREPUUS.M Brent ~ dolla~ M     None      U.S. Ener~ USA       1990~ 2022~
    ## 3 STEO.BREPUUS.M Brent ~ dolla~ M     None      U.S. Ener~ USA       1990~ 2022~
    ## 4 STEO.BREPUUS.M Brent ~ dolla~ M     None      U.S. Ener~ USA       1990~ 2022~
    ## 5 STEO.BREPUUS.M Brent ~ dolla~ M     None      U.S. Ener~ USA       1990~ 2022~
    ## 6 STEO.BREPUUS.M Brent ~ dolla~ M     None      U.S. Ener~ USA       1990~ 2022~
    ## # ... with 6 more variables: lastHistoricalPeriod <chr>, updated <chr>,
    ## #   value <dbl>, date <date>, year <int>, month <int>

``` r
# graphing our data
crude_oil_prices_new %>%
  filter(year >= 2021) %>%
  ggplot(aes(x = date, 
             y = value, 
             color = name)) +
  scale_x_date(breaks = scales::pretty_breaks(n = 10)) +
  geom_line() +
  labs(x = "Date", 
       y = "$ per Barrel", title = "US Crude Oil Prices", 
       subtitle = "Monthly") +
  theme(legend.position = "bottom", 
        legend.title = element_blank(), 
        axis.text.x = element_text(angle = 0)) + 
  scale_color_discrete(labels = c("Brent Crude Oil", 
                                  "Imported Crude Oil", 
                                 "Refiner Average Crude Oil Acquisition Cost", 
                                 "WTI Crude Oil"))
```

![](short_term_outlook_files/figure-gfm/us%20petroleum%20prices%20-%20crude%20oil-1.png)<!-- -->

-----

``` r
# retail price of natural gas in the residential sector US average
gas_price_residential <- eia_series(id = "STEO.NGRCUUS.M")

# retail price of natural gas in commercial sector US average
gas_price_commercial <- eia_series(id = "STEO.NGCCUUS.M")

# retail price of natural gas in industrial sector US average
gas_price_industrial <- eia_series(id = "STEO.NGICUUS.M")

# joining our data frames
gas_prices <- merge(merge(gas_price_residential, 
                                gas_price_commercial, 
                          all = TRUE),
                          gas_price_industrial, 
                    all = TRUE)

# check out structure of our data
str(gas_prices)
```

    ## 'data.frame':    3 obs. of  12 variables:
    ##  $ series_id           : chr  "STEO.NGCCUUS.M" "STEO.NGICUUS.M" "STEO.NGRCUUS.M"
    ##  $ name                : chr  "Retail Price of Natural Gas in Commercial Sector, U.S. Average, Monthly" "Retail Price of Natural Gas in Industrial Sector, U.S. Average, Monthly" "Retail price of natural gas in the residential sector, U.S. average, Monthly"
    ##  $ units               : chr  "dollars per thousand cubic feet" "dollars per thousand cubic feet" "dollars per thousand cubic feet"
    ##  $ f                   : chr  "M" "M" "M"
    ##  $ copyright           : chr  "None" "None" "None"
    ##  $ source              : chr  "U.S. Energy Information Administration (EIA) - Short Term Energy Outlook" "U.S. Energy Information Administration (EIA) - Short Term Energy Outlook" "U.S. Energy Information Administration (EIA) - Short Term Energy Outlook"
    ##  $ geography           : chr  "USA" "USA" "USA"
    ##  $ start               : chr  "199001" "199001" "198101"
    ##  $ end                 : chr  "202212" "202212" "202212"
    ##  $ lastHistoricalPeriod: chr  "202109" "202109" "202109"
    ##  $ updated             : chr  "2021-12-07T12:01:25-0500" "2021-12-07T12:01:25-0500" "2021-12-07T12:01:25-0500"
    ##  $ data                :List of 3
    ##   ..$ : tibble [396 x 4] (S3: tbl_df/tbl/data.frame)
    ##   .. ..$ value: num  8.46 8.58 8.91 9.53 9.79 ...
    ##   .. ..$ date : Date, format: "2022-12-01" "2022-11-01" ...
    ##   .. ..$ year : int  2022 2022 2022 2022 2022 2022 2022 2022 2022 2022 ...
    ##   .. ..$ month: int  12 11 10 9 8 7 6 5 4 3 ...
    ##   ..$ : tibble [396 x 4] (S3: tbl_df/tbl/data.frame)
    ##   .. ..$ value: num  5.36 4.97 4.85 4.83 4.91 ...
    ##   .. ..$ date : Date, format: "2022-12-01" "2022-11-01" ...
    ##   .. ..$ year : int  2022 2022 2022 2022 2022 2022 2022 2022 2022 2022 ...
    ##   .. ..$ month: int  12 11 10 9 8 7 6 5 4 3 ...
    ##   ..$ : tibble [504 x 4] (S3: tbl_df/tbl/data.frame)
    ##   .. ..$ value: num  10.8 11.7 14.6 18.1 19.2 ...
    ##   .. ..$ date : Date, format: "2022-12-01" "2022-11-01" ...
    ##   .. ..$ year : int  2022 2022 2022 2022 2022 2022 2022 2022 2022 2022 ...
    ##   .. ..$ month: int  12 11 10 9 8 7 6 5 4 3 ...

``` r
# making sure our data is unnested 
gas_prices_new <- gas_prices %>%
  unnest(cols = data)

# checking first few data points
head(gas_prices_new)
```

    ## # A tibble: 6 x 15
    ##   series_id      name     units   f     copyright source   geography start end  
    ##   <chr>          <chr>    <chr>   <chr> <chr>     <chr>    <chr>     <chr> <chr>
    ## 1 STEO.NGCCUUS.M Retail ~ dollar~ M     None      U.S. En~ USA       1990~ 2022~
    ## 2 STEO.NGCCUUS.M Retail ~ dollar~ M     None      U.S. En~ USA       1990~ 2022~
    ## 3 STEO.NGCCUUS.M Retail ~ dollar~ M     None      U.S. En~ USA       1990~ 2022~
    ## 4 STEO.NGCCUUS.M Retail ~ dollar~ M     None      U.S. En~ USA       1990~ 2022~
    ## 5 STEO.NGCCUUS.M Retail ~ dollar~ M     None      U.S. En~ USA       1990~ 2022~
    ## 6 STEO.NGCCUUS.M Retail ~ dollar~ M     None      U.S. En~ USA       1990~ 2022~
    ## # ... with 6 more variables: lastHistoricalPeriod <chr>, updated <chr>,
    ## #   value <dbl>, date <date>, year <int>, month <int>

``` r
# graphing our data
gas_prices_new %>%
  filter(year >= 2021) %>%
  ggplot(aes(x = date, 
             y = value, 
             color = name)) +
  scale_x_date(breaks = scales::pretty_breaks(n = 10)) +
  geom_line() +
  labs(x = "Date", 
       y = "$ per thousand cubic feet", 
       title = "Retail Price of Natural Gas, US Average", 
       subtitle = "by sector") +
  theme(legend.position = "bottom", 
        legend.title = element_blank(), 
        axis.text.x = element_text(angle = 0)) + 
  scale_color_discrete(labels = c("Commerical", 
                                  "Industrial", 
                                 "Residential"))
```

![](short_term_outlook_files/figure-gfm/us%20natural%20gas%20prices%20by%20sector-1.png)<!-- -->
