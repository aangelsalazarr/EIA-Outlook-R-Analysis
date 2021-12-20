EIA Data Retrieval - Electricity
================
Angel Salazar
12/16/2021

-----

-----

``` r
# function used to show main categories
eia_cats()
```

    ## $category
    ## # A tibble: 1 x 3
    ##   category_id name          notes
    ##   <chr>       <chr>         <chr>
    ## 1 371         EIA Data Sets ""   
    ## 
    ## $childcategories
    ## # A tibble: 14 x 2
    ##    category_id name                               
    ##          <int> <chr>                              
    ##  1           0 Electricity                        
    ##  2       40203 State Energy Data System (SEDS)    
    ##  3      714755 Petroleum                          
    ##  4      714804 Natural Gas                        
    ##  5      711224 Total Energy                       
    ##  6      717234 Coal                               
    ##  7      829714 Short-Term Energy Outlook          
    ##  8      964164 Annual Energy Outlook              
    ##  9     1292190 Crude Oil Imports                  
    ## 10     2123635 U.S. Electric System Operating Data
    ## 11     2134384 International Energy Data          
    ## 12     2251604 CO2 Emissions                      
    ## 13     2631064 International Energy Outlook       
    ## 14     2889994 U.S. Nuclear Outages

``` r
# EIA_DATA_SETS -> ELECTRICITY -> NET GENERATION
us_electricity_net <- eia_series(id = "ELEC.GEN.ALL-US-99.M") 

# viewing structure of data
str(us_electricity_net$data)
```

    ## List of 1
    ##  $ : tibble [249 x 4] (S3: tbl_df/tbl/data.frame)
    ##   ..$ value: num [1:249] 348077 413949 404663 373671 318831 ...
    ##   ..$ date : Date[1:249], format: "2021-09-01" "2021-08-01" ...
    ##   ..$ year : int [1:249] 2021 2021 2021 2021 2021 2021 2021 2021 2021 2020 ...
    ##   ..$ month: int [1:249] 9 8 7 6 5 4 3 2 1 12 ...

``` r
# unnesting columns 
select(us_electricity_net, data) %>% unnest(cols = data)
```

    ## # A tibble: 249 x 4
    ##      value date        year month
    ##      <dbl> <date>     <int> <int>
    ##  1 348077. 2021-09-01  2021     9
    ##  2 413949. 2021-08-01  2021     8
    ##  3 404663. 2021-07-01  2021     7
    ##  4 373671. 2021-06-01  2021     6
    ##  5 318831. 2021-05-01  2021     5
    ##  6 292469. 2021-04-01  2021     4
    ##  7 312152. 2021-03-01  2021     3
    ##  8 327824. 2021-02-01  2021     2
    ##  9 350705. 2021-01-01  2021     1
    ## 10 344335. 2020-12-01  2020    12
    ## # ... with 239 more rows

``` r
# graphing our data
filter(unnest(us_electricity_net, cols = data), year >= 2020) %>%
  ggplot(aes(x = date, 
             y = value)) + 
  scale_x_date(date_label = "%m-%y", breaks = scales::pretty_breaks(n = 10)) + geom_line() +
  labs(y = us_electricity_net$units[1], 
       title = "US Electricity Generation, Net (Monthly)", 
       subtitle = "From all fuels") +
  geom_smooth(method = lm) # linear model 
```

    ## `geom_smooth()` using formula 'y ~ x'

![](eia_electricity_files/figure-gfm/us%20electricity%20generation-1.png)<!-- -->

-----

``` r
# EIA DATA SETS -> ELECTRICITY -> RETAIL SALES OF ELECTRICITY
us_retail_sales_electricity <- eia_series(id = "ELEC.SALES.US-ALL.M")

# viewing structure of data
str(us_retail_sales_electricity$data)
```

    ## List of 1
    ##  $ : tibble [249 x 4] (S3: tbl_df/tbl/data.frame)
    ##   ..$ value: num [1:249] 336003 380366 372649 337506 289027 ...
    ##   ..$ date : Date[1:249], format: "2021-09-01" "2021-08-01" ...
    ##   ..$ year : int [1:249] 2021 2021 2021 2021 2021 2021 2021 2021 2021 2020 ...
    ##   ..$ month: int [1:249] 9 8 7 6 5 4 3 2 1 12 ...

``` r
# first few data points
head(us_retail_sales_electricity$data)
```

    ## [[1]]
    ## # A tibble: 249 x 4
    ##      value date        year month
    ##      <dbl> <date>     <int> <int>
    ##  1 336003. 2021-09-01  2021     9
    ##  2 380366. 2021-08-01  2021     8
    ##  3 372649. 2021-07-01  2021     7
    ##  4 337506. 2021-06-01  2021     6
    ##  5 289027. 2021-05-01  2021     5
    ##  6 271618. 2021-04-01  2021     4
    ##  7 293378. 2021-03-01  2021     3
    ##  8 298684. 2021-02-01  2021     2
    ##  9 320935. 2021-01-01  2021     1
    ## 10 315330. 2020-12-01  2020    12
    ## # ... with 239 more rows

``` r
# visualizing our data and applying linear method
filter(unnest(us_retail_sales_electricity, cols = data), year >= 2020) %>%
  ggplot(aes(x = date, y = value)) + 
  scale_x_date(date_label = "%m-%y", breaks = scales::pretty_breaks(n = 10)) +
  geom_line() +
  labs(y = us_retail_sales_electricity$units[1], 
       title = "US Retail Sales of Electricty (Monthly)", 
       subtitle = "All Sectors") + 
  geom_smooth(method = lm) #linear model
```

    ## `geom_smooth()` using formula 'y ~ x'

![](eia_electricity_files/figure-gfm/us%20electricity%20retail%20sales-1.png)<!-- -->

-----

``` r
# EIA DATA SETS -> ELECTRICITY -> AVERAGE RETAIL PRICE OF ELECTRICITY
us_electricity_price <- eia_series(id = "ELEC.PRICE.US-ALL.M")

# viewing structure of data
str(us_electricity_price$data)
```

    ## List of 1
    ##  $ : tibble [249 x 4] (S3: tbl_df/tbl/data.frame)
    ##   ..$ value: num [1:249] 11.7 11.6 11.6 11.3 10.8 ...
    ##   ..$ date : Date[1:249], format: "2021-09-01" "2021-08-01" ...
    ##   ..$ year : int [1:249] 2021 2021 2021 2021 2021 2021 2021 2021 2021 2020 ...
    ##   ..$ month: int [1:249] 9 8 7 6 5 4 3 2 1 12 ...

``` r
# unnesting columns 
select(us_electricity_price, data) %>% unnest(cols = data)
```

    ## # A tibble: 249 x 4
    ##    value date        year month
    ##    <dbl> <date>     <int> <int>
    ##  1  11.7 2021-09-01  2021     9
    ##  2  11.6 2021-08-01  2021     8
    ##  3  11.6 2021-07-01  2021     7
    ##  4  11.3 2021-06-01  2021     6
    ##  5  10.8 2021-05-01  2021     5
    ##  6  10.7 2021-04-01  2021     4
    ##  7  10.9 2021-03-01  2021     3
    ##  8  11.4 2021-02-01  2021     2
    ##  9  10.4 2021-01-01  2021     1
    ## 10  10.4 2020-12-01  2020    12
    ## # ... with 239 more rows

``` r
# graphing our data
filter(unnest(us_electricity_price, cols = data), year >= 2020) %>%
  ggplot(aes(x = date, 
             y = value)) + 
  scale_x_date(date_label = "%m-%y", breaks = scales::pretty_breaks(n = 10)) +
  geom_line() +
  labs(y = us_electricity_price$units[1], 
       title = "US Average Retail Price of Electricity (Monthly)") +
  geom_smooth(method = lm) # linear model 
```

    ## `geom_smooth()` using formula 'y ~ x'

![](eia_electricity_files/figure-gfm/average%20price%20of%20electricity-1.png)<!-- -->

-----

``` r
# EIA DATA SETS -> ELECTRICITY -> AVERAGE RETAIL PRICE OF ELECTRICITY
us_fossil_cost <- eia_series(id = "ELEC.COST.NG-US-99.M")

# viewing structure of data
str(us_fossil_cost$data)
```

    ## List of 1
    ##  $ : tibble [165 x 4] (S3: tbl_df/tbl/data.frame)
    ##   ..$ value: num [1:165] 5.09 4.44 4.11 3.56 3.34 ...
    ##   ..$ date : Date[1:165], format: "2021-09-01" "2021-08-01" ...
    ##   ..$ year : int [1:165] 2021 2021 2021 2021 2021 2021 2021 2021 2021 2020 ...
    ##   ..$ month: int [1:165] 9 8 7 6 5 4 3 2 1 12 ...

``` r
# unnesting columns 
select(us_fossil_cost, data) %>% unnest(cols = data)
```

    ## # A tibble: 165 x 4
    ##    value date        year month
    ##    <dbl> <date>     <int> <int>
    ##  1  5.09 2021-09-01  2021     9
    ##  2  4.44 2021-08-01  2021     8
    ##  3  4.11 2021-07-01  2021     7
    ##  4  3.56 2021-06-01  2021     6
    ##  5  3.34 2021-05-01  2021     5
    ##  6  3.11 2021-04-01  2021     4
    ##  7  3.37 2021-03-01  2021     3
    ##  8 16.1  2021-02-01  2021     2
    ##  9  3.3  2021-01-01  2021     1
    ## 10  3.28 2020-12-01  2020    12
    ## # ... with 155 more rows

``` r
# graphing our data
filter(unnest(us_fossil_cost, cols = data), year >= 2020) %>%
  ggplot(aes(x = date, 
             y = value)) + 
  scale_x_date(date_label = "%m-%y", breaks = scales::pretty_breaks(n = 10)) +
  geom_line() +
  labs(y = us_fossil_cost$units[1], 
       title = "US Average Cost of Fossil Fuels for Electricity Generation, Natural Gas (Monthly)") +
  geom_smooth(method = lm) # linear model 
```

    ## `geom_smooth()` using formula 'y ~ x'

![](eia_electricity_files/figure-gfm/fossil%20fuel%20cost%20for%20electric%20generation-1.png)<!-- -->
