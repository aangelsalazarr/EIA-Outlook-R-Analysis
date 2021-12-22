Annual Energy Outlook 2021
================
Angel Salazar
12/17/2021

``` r
# carbon dioxide emissions, commercial, reference 2021
ems_commercial_ref <- eia_series(id = "AEO.2021.REF2021.EMI_CO2_COMM_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Commercial")

# carbon dioxide emissions, electric power, reference 2021
ems_electricity_ref <- eia_series(id = "AEO.2021.REF2021.EMI_CO2_ELEP_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Electricity")

# carbon emissions, industrial, reference 2021
ems_industrial_ref <- eia_series(id = "AEO.2021.REF2021.EMI_CO2_IDAL_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Industrial")

# per capita carbon emissions, US, reference 2021
ems_per_capita_ref <- eia_series(id = "AEO.2021.REF2021.EMI_CO2_NA_NA_NA_NA_NA_MILLMTCO2PP.A")

# carbon emissions, residential, reference 2021
ems_residential_ref <- eia_series(id = "AEO.2021.REF2021.EMI_CO2_RESD_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Residential")

# carbon emissions, transportation, reference 2021
ems_transportation_ref <- eia_series(id = "AEO.2021.REF2021.EMI_CO2_TRN_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Transportation")

# carbon emissions, coal, reference 2021
ems_coal_ref <- eia_series(id = "AEO.2021.REF2021.EMI_CO2_TEN_NA_CL_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Coal")

# carbon emissions, natural gas, reference 2021
ems_ng_ref <- eia_series(id = "AEO.2021.REF2021.EMI_CO2_TEN_NA_NG_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Natural Gas")

# carbon emissions, other, reference 2021
ems_other_ref <- eia_series(id = "AEO.2021.REF2021.EMI_CO2_TEN_NA_OTH_NA_NA_MILLMETNCO2.A")

# carbon emissions, petroleum, reference 2021
ems_petro_ref <- eia_series(id = "AEO.2021.REF2021.EMI_CO2_TEN_NA_PET_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Petroleum")
```

``` r
# first we want to merge all data frames related to emissions by fuel type
emissions_by_fuel <- (merge(merge(merge(ems_coal_ref, 
                           ems_ng_ref, 
                           all = TRUE), 
                           ems_other_ref, 
                           all = TRUE), 
                           ems_petro_ref, 
                           all = TRUE))

# now we want to unnest data columns since it is a vector with 3 entities
fuel_emissions <- emissions_by_fuel %>%
  unnest(cols = data)

# now we want to visualize the data
fuel_emissions %>%
  filter(series_id != "AEO.2021.REF2021.EMI_CO2_TEN_NA_OTH_NA_NA_MILLMETNCO2.A") %>%
  ggplot(aes(x = date, 
             y = value, 
             color = name)) +
  scale_x_date(breaks = scales::pretty_breaks(n = 10)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(y = fuel_emissions$units,
       title = "Carbon Emissions, Total by Fuel, U.S. (Reference)", 
       subtitle = NULL) +
  theme(legend.position = "bottom", 
        legend.title = element_blank(), 
        axis.text.x = element_text(angle = 0)) +
  scale_color_discrete(labels = c("Coal", "Natural Gas", "Petroleum"))
```

    ## `geom_smooth()` using formula 'y ~ x'

![](long_term_outlook_2021_files/figure-gfm/emissions%20by%20fuel%20type%20in%20reference-1.png)<!-- -->

``` r
# first let us merge all relevant dfs
emissions_sector <- merge(merge(merge(merge(ems_commercial_ref,
                                      ems_industrial_ref,
                                      all = TRUE), 
                                ems_residential_ref,
                                all = TRUE),
                          ems_transportation_ref, 
                          all = TRUE), 
                          ems_electricity_ref,
                          all = TRUE)

# now let us unnest last column -- data
sector_emissions <- emissions_sector %>%
  unnest(cols = data)

# now let us visualize data
sector_emissions %>%
  ggplot(aes(x = date, 
             y = value, 
             color = name)) +
  scale_x_date(breaks = scales::pretty_breaks(n = 10)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(y = sector_emissions$units,
       title = "Carbon Emissions, Total by Sector, U.S. (Reference)", 
       subtitle = NULL) +
  theme(legend.position = "bottom", 
        legend.title = element_blank(), 
        axis.text.x = element_text(angle = 0)) +
  scale_color_discrete(labels = c("Commercial", "Industrial", "Residential",
                                  "Transportation", "Electricity"))
```

    ## `geom_smooth()` using formula 'y ~ x'

![](long_term_outlook_2021_files/figure-gfm/emissions%20by%20sector%20in%20reference-1.png)<!-- -->

``` r
# carbon dioxide emissions, commercial, high growth 2021
ems_commercial_high_g <- eia_series(id = "AEO.2021.HIGHMACRO.EMI_CO2_COMM_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Commercial")

# carbon emissions, electric power, high growth 2021
ems_electricity_high_g <- eia_series(id = "AEO.2021.HIGHMACRO.EMI_CO2_ELEP_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Electricity")

# carbon emissions, industrial, high growth 2021
ems_industrial_high_g <- eia_series(id ="AEO.2021.HIGHMACRO.EMI_CO2_IDAL_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Industrial")

# per capita carbon emissions, US, high growth 2021
ems_per_cap_high_g <- eia_series(id = "AEO.2021.HIGHMACRO.EMI_CO2_NA_NA_NA_NA_NA_MILLMTCO2PP.A")

# carbon emissions, residential, high growth 2021
ems_residential_high_g <- eia_series(id = "AEO.2021.HIGHMACRO.EMI_CO2_RESD_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Residential")

# carbon emissions, transportation, high growth 2021
ems_trans_high_g <- eia_series(id = "AEO.2021.HIGHMACRO.EMI_CO2_TRN_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Transportation")

# carbon emissions, coal, high growth, 2021
ems_coal_high_g <- eia_series(id = "AEO.2021.HIGHMACRO.EMI_CO2_TEN_NA_CL_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Coal")

# carbon emissions, natural gas, high growth, 2021
ems_ng_high_g <- eia_series(id = "AEO.2021.HIGHMACRO.EMI_CO2_TEN_NA_NG_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Natural Gas")

# carbon emissions, other, high growth 2021
ems_other_high_g <- eia_series(id = "AEO.2021.HIGHMACRO.EMI_CO2_TEN_NA_OTH_NA_NA_MILLMETNCO2.A")

# carbon emissions, petroleum, high growth 2021
ems_petro_high_g <- eia_series(id = "AEO.2021.HIGHMACRO.EMI_CO2_TEN_NA_PET_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Petroleum")
```

``` r
# first we want to merge all data frames related to emissions by fuel type
emissions_by_fuel_high_g <- (merge(merge(merge(ems_coal_high_g, 
                           ems_ng_high_g, 
                           all = TRUE), 
                           ems_other_high_g, 
                           all = TRUE), 
                           ems_petro_high_g, 
                           all = TRUE))

# now we want to unnest data columns since it is a vector with 3 entities
fuel_emissions_high_g <- emissions_by_fuel_high_g %>%
  unnest(cols = data)

# now we want to visualize the data
fuel_emissions_high_g %>%
  filter(series_id != "AEO.2021.HIGHMACRO.EMI_CO2_TEN_NA_OTH_NA_NA_MILLMETNCO2.A") %>%
  ggplot(aes(x = date, 
             y = value, 
             color = name)) +
  scale_x_date(breaks = scales::pretty_breaks(n = 10)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(y = fuel_emissions$units,
       title = "Carbon Emissions, Total by Fuel, U.S. (High Growth)", 
       subtitle = "MMmt CO2") +
  theme(legend.position = "bottom", 
        legend.title = element_blank(), 
        axis.text.x = element_text(angle = 0)) +
  scale_color_discrete(labels = c("Coal", "Natural Gas", "Petroleum"))
```

    ## `geom_smooth()` using formula 'y ~ x'

![](long_term_outlook_2021_files/figure-gfm/emissions%20from%20fuel%20from%20high%20growth%20scenario-1.png)<!-- -->

``` r
# first let us merge all relevant dfs
emissions_sector_high_g <- merge(merge(merge(merge(ems_commercial_high_g,
                                      ems_industrial_high_g,
                                      all = TRUE), 
                                ems_residential_high_g,
                                all = TRUE),
                          ems_trans_high_g, 
                          all = TRUE), 
                          ems_electricity_high_g,
                          all = TRUE)

# now let us unnest last column -- data
sector_emissions_high_g <- emissions_sector_high_g %>%
  unnest(cols = data)

# now let us visualize data
sector_emissions_high_g %>%
  ggplot(aes(x = date, 
             y = value, 
             color = name)) +
  scale_x_date(breaks = scales::pretty_breaks(n = 10)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(y = sector_emissions_high_g$units,
       title = "Carbon Emissions, Total by Sector, U.S. (High Growth)", 
       subtitle = "MMmt CO2") +
  theme(legend.position = "bottom", 
        legend.title = element_blank(), 
        axis.text.x = element_text(angle = 0)) +
  scale_color_discrete(labels = c("Commercial", "Industrial", "Residential",
                                  "Transportation", "Electricity"))
```

    ## `geom_smooth()` using formula 'y ~ x'

![](long_term_outlook_2021_files/figure-gfm/emissions%20by%20sector%20high%20growth%20scenario-1.png)<!-- -->

``` r
# carbon dioxide emissions, commercial, low growth 2021
ems_commercial_low_g <- eia_series(id = "AEO.2021.LOWMACRO.EMI_CO2_COMM_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Commercial")

# carbon emissions, electric power, low growth 2021
ems_electricity_low_g <- eia_series(id = "AEO.2021.LOWMACRO.EMI_CO2_ELEP_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Electricity")

# carbon emissions, industrial, low growth 2021
ems_industrial_low_g <- eia_series(id = "AEO.2021.LOWMACRO.EMI_CO2_IDAL_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Industrial")

# per capita carbon emissions, US, low growth 2021
ems_per_cap_low_g <- eia_series(id = "AEO.2021.LOWMACRO.EMI_CO2_NA_NA_NA_NA_NA_MILLMTCO2PP.A")

# carbon emissions, residential, low growth 2021
ems_residential_low_g <- eia_series(id = "AEO.2021.LOWMACRO.EMI_CO2_RESD_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Residential")

# carbon emissions, transportation, low growth 2021
ems_trans_low_g <- eia_series(id = "AEO.2021.LOWMACRO.EMI_CO2_TRN_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Transportation")

# carbon emissions, coal, low growth, 2021
ems_coal_low_g <- eia_series(id = "AEO.2021.LOWMACRO.EMI_CO2_TEN_NA_CL_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Coal")

# carbon emissions, natural gas, low growth, 2021
ems_ng_low_g <- eia_series(id = "AEO.2021.LOWMACRO.EMI_CO2_TEN_NA_NG_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Natural Gas")

# carbon emissions, other, low growth 2021
ems_other_low_g <- eia_series(id = "AEO.2021.LOWMACRO.EMI_CO2_TEN_NA_OTH_NA_NA_MILLMETNCO2.A")

# carbon emissions, petroleum, low growth 2021
ems_petro_low_g <- eia_series(id = "AEO.2021.LOWMACRO.EMI_CO2_TEN_NA_PET_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Petroleum")
```

``` r
# carbon dioxide emissions, commercial, high price2021
ems_commercial_high_p <- eia_series(id = "AEO.2021.HIGHPRICE.EMI_CO2_COMM_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Commercial")

# carbon emissions, electric power, high price 2021
ems_electricity_high_p <- eia_series(id = "AEO.2021.HIGHPRICE.EMI_CO2_ELEP_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Electricity")

# carbon emissions, industrial, high price 2021
ems_industrial_high_p <- eia_series(id = "AEO.2021.HIGHPRICE.EMI_CO2_IDAL_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Industrial")

# per capita carbon emissions, US, high price 2021
ems_per_cap_high_p <- eia_series(id = "AEO.2021.HIGHPRICE.EMI_CO2_NA_NA_NA_NA_NA_MILLMTCO2PP.A")

# carbon emissions, residential, high price 2021
ems_residential_high_p <- eia_series(id = "AEO.2021.HIGHPRICE.EMI_CO2_RESD_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Residential")

# carbon emissions, transportation, high price 2021
ems_trans_high_p <- eia_series(id = "AEO.2021.HIGHPRICE.EMI_CO2_TRN_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Transportation")

# carbon emissions, coal, high price, 2021
ems_coal_high_p <- eia_series(id = "AEO.2021.HIGHPRICE.EMI_CO2_TEN_NA_CL_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Coal")

# carbon emissions, natural gas, high price, 2021
ems_ng_high_p <- eia_series(id = "AEO.2021.HIGHPRICE.EMI_CO2_TEN_NA_NG_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Natural Gas")

# carbon emissions, other, high price 2021
ems_other_high_p <- eia_series(id = "AEO.2021.HIGHPRICE.EMI_CO2_TEN_NA_OTH_NA_NA_MILLMETNCO2.A")

# carbon emissions, petroleum, high price 2021
ems_petro_high_p <- eia_series(id = "AEO.2021.HIGHPRICE.EMI_CO2_TEN_NA_PET_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Petroleum")
```

``` r
# carbon dioxide emissions, commercial, low price 2021
ems_commercial_low_p <- eia_series(id = "AEO.2021.LOWPRICE.EMI_CO2_COMM_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Commercial")

# carbon emissions, electric power, low price 2021
ems_electricity_low_p <- eia_series(id = "AEO.2021.LOWPRICE.EMI_CO2_ELEP_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Electricity")

# carbon emissions, industrial, low price 2021
ems_industrial_low_p <- eia_series(id = "AEO.2021.LOWPRICE.EMI_CO2_IDAL_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Industrial")

# per capita carbon emissions, US, low price 2021
ems_per_cap_low_p <- eia_series(id = "AEO.2021.LOWPRICE.EMI_CO2_NA_NA_NA_NA_NA_MILLMTCO2PP.A")

# carbon emissions, residential, low price 2021
ems_residential_low_p <- eia_series(id = "AEO.2021.LOWPRICE.EMI_CO2_RESD_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Residential")

# carbon emissions, transportation, low price 2021
ems_trans_low_p <- eia_series(id = "AEO.2021.LOWPRICE.EMI_CO2_TRN_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Transportation")

# carbon emissions, coal, low price, 2021
ems_coal_low_p <- eia_series(id = "AEO.2021.LOWPRICE.EMI_CO2_TEN_NA_CL_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Coal")

# carbon emissions, natural gas, low price, 2021
ems_ng_low_p <- eia_series(id = "AEO.2021.LOWPRICE.EMI_CO2_TEN_NA_NG_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Natural Gas")

# carbon emissions, other, low price 2021
ems_other_low_p <- eia_series(id = "AEO.2021.LOWPRICE.EMI_CO2_TEN_NA_OTH_NA_NA_MILLMETNCO2.A")

# carbon emissions, petroleum, low price 2021
ems_petro_low_p <- eia_series(id = "AEO.2021.LOWPRICE.EMI_CO2_TEN_NA_PET_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Petroleum")
```

``` r
# carbon dioxide emissions, commercial, high ff supply 2021
ems_commercial_high_ff_s <- eia_series(id = "AEO.2021.HIGHOGS.EMI_CO2_COMM_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Commercial")

# carbon emissions, electric power, high ff supply 2021
ems_electricity_high_ff_s <- eia_series(id = "AEO.2021.HIGHOGS.EMI_CO2_ELEP_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Electricity")

# carbon emissions, industrial, high ff supply 2021
ems_industrial_high_ff_s <- eia_series(id = "AEO.2021.HIGHOGS.EMI_CO2_IDAL_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Industrial")

# per capita carbon emissions, US, high ff supply2021
ems_per_cap_high_ff_s<- eia_series(id = "AEO.2021.HIGHOGS.EMI_CO2_NA_NA_NA_NA_NA_MILLMTCO2PP.A")

# carbon emissions, residential, high ff supply 2021
ems_residential_high_ff_s <- eia_series(id = "AEO.2021.HIGHOGS.EMI_CO2_RESD_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Residential")

# carbon emissions, transportation, high ff supply2021
ems_trans_high_ff_s <- eia_series(id = "AEO.2021.HIGHOGS.EMI_CO2_TRN_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Transportation")

# carbon emissions, coal, high ff supply, 2021
ems_coal_high_ff_s <- eia_series(id = "AEO.2021.HIGHOGS.EMI_CO2_TEN_NA_CL_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Coal")

# carbon emissions, natural gas, high ff supply 2021
ems_ng_high_ff_s <- eia_series(id = "AEO.2021.HIGHOGS.EMI_CO2_TEN_NA_NG_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Natural Gas")

# carbon emissions, other, high ff supply 2021
ems_other_high_ff_s <- eia_series(id = "AEO.2021.HIGHOGS.EMI_CO2_TEN_NA_OTH_NA_NA_MILLMETNCO2.A")

# carbon emissions, petroleum, high ff supply 2021
ems_petro_high_ff_s <- eia_series(id = "AEO.2021.HIGHOGS.EMI_CO2_TEN_NA_PET_NA_NA_MILLMETNCO2.A")%>%
  mutate(sector = "Petroleum")
```

``` r
# carbon dioxide emissions, commercial, low ff supply 2021
ems_commercial_low_ff_s <- eia_series(id = "AEO.2021.LOWOGS.EMI_CO2_COMM_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Commercial")

# carbon emissions, electric power, low ff supply 2021
ems_electricity_low_ff_s <- eia_series(id = "AEO.2021.LOWOGS.EMI_CO2_ELEP_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Electricity")

# carbon emissions, industrial, low ff supply 2021
ems_industrial_low_ff_s <- eia_series(id = "AEO.2021.LOWOGS.EMI_CO2_IDAL_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Industrial")

# per capita carbon emissions, US, low ff supply2021
ems_per_cap_low_ff_s<- eia_series(id = "AEO.2021.LOWOGS.EMI_CO2_NA_NA_NA_NA_NA_MILLMTCO2PP.A")

# carbon emissions, residential, low ff supply 2021
ems_residential_low_ff_s <- eia_series(id = "AEO.2021.LOWOGS.EMI_CO2_RESD_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Residential")

# carbon emissions, transportation, low ff supply2021
ems_trans_low_ff_s <- eia_series(id = "AEO.2021.LOWOGS.EMI_CO2_TRN_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Transportation")

# carbon emissions, coal, low ff supply, 2021
ems_coal_low_ff_s <- eia_series(id = "AEO.2021.LOWOGS.EMI_CO2_TEN_NA_CL_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Coal")

# carbon emissions, natural gas, low ff supply 2021
ems_ng_low_ff_s <- eia_series(id = "AEO.2021.LOWOGS.EMI_CO2_TEN_NA_NG_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Natural Gas")

# carbon emissions, other, low ff supply 2021
ems_other_low_ff_s <- eia_series(id = "AEO.2021.LOWOGS.EMI_CO2_TEN_NA_OTH_NA_NA_MILLMETNCO2.A")

# carbon emissions, petroleum, low ff supply 2021
ems_petro_low_ff_s <- eia_series(id = "AEO.2021.LOWOGS.EMI_CO2_TEN_NA_PET_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Petroleum")
```

``` r
# carbon dioxide emissions, commercial, high renewable cost 2021
ems_commercial_high_rc <- eia_series(id = "AEO.2021.HIRENCST.EMI_CO2_COMM_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Commercial")

# carbon emissions, electric power, high renewable cost 2021
ems_electricity_high_rc <- eia_series(id = "AEO.2021.HIRENCST.EMI_CO2_ELEP_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Electricity")

# carbon emissions, industrial, high renewable cost 2021
ems_industrial_high_rc <- eia_series(id = "AEO.2021.HIRENCST.EMI_CO2_IDAL_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Industrial")

# per capita carbon emissions, US, high renewable cost 2021
ems_per_cap_high_rc <- eia_series(id = "AEO.2021.HIRENCST.EMI_CO2_NA_NA_NA_NA_NA_MILLMTCO2PP.A")

# carbon emissions, residential, high renewable cost 2021
ems_residential_high_rc <- eia_series(id = "AEO.2021.HIRENCST.EMI_CO2_RESD_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Residential")

# carbon emissions, transportation, high renewable cost 2021
ems_trans_high_rc <- eia_series(id = "AEO.2021.HIRENCST.EMI_CO2_TRN_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Transportation")

# carbon emissions, coal, high renewable cost, 2021
ems_coal_high_rc <- eia_series(id = "AEO.2021.HIRENCST.EMI_CO2_TEN_NA_CL_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Coal")

# carbon emissions, natural gas, high renewable cost 2021
ems_ng_high_rc <- eia_series(id = "AEO.2021.HIRENCST.EMI_CO2_TEN_NA_NG_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Natural Gas")

# carbon emissions, other, high renewable cost2021
ems_other_high_rc <- eia_series(id = "AEO.2021.HIRENCST.EMI_CO2_TEN_NA_OTH_NA_NA_MILLMETNCO2.A")

# carbon emissions, petroleum, high renewable cost 2021
ems_petro_high_rc <- eia_series(id = "AEO.2021.HIRENCST.EMI_CO2_TEN_NA_PET_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Petroleum")
```

``` r
# carbon dioxide emissions, commercial, low renewable cost 2021
ems_commercial_low_rc <- eia_series(id = "AEO.2021.LORENCST.EMI_CO2_COMM_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Commercial")

# carbon emissions, electric power, low renewable cost 2021
ems_electricity_low_rc <- eia_series(id = "AEO.2021.LORENCST.EMI_CO2_ELEP_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Electricity")

# carbon emissions, industrial, low renewable cost 2021
ems_industrial_low_rc <- eia_series(id = "AEO.2021.LORENCST.EMI_CO2_IDAL_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Industrial")

# per capita carbon emissions, US, low renewable cost 2021
ems_per_cap_low_rc <- eia_series(id = "AEO.2021.LORENCST.EMI_CO2_NA_NA_NA_NA_NA_MILLMTCO2PP.A")

# carbon emissions, residential, low renewable cost 2021
ems_residential_low_rc <- eia_series(id = "AEO.2021.LORENCST.EMI_CO2_RESD_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Residential")

# carbon emissions, transportation, low renewable cost 2021
ems_trans_low_rc <- eia_series(id = "AEO.2021.LORENCST.EMI_CO2_TRN_NA_NA_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Transportation")

# carbon emissions, coal, low renewable cost, 2021
ems_coal_low_rc <- eia_series(id = "AEO.2021.LORENCST.EMI_CO2_TEN_NA_CL_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Coal")

# carbon emissions, natural gas, low renewable cost 2021
ems_ng_low_rc <- eia_series(id = "AEO.2021.LORENCST.EMI_CO2_TEN_NA_NG_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Natural Gas")

# carbon emissions, other, low renewable cost2021
ems_other_low_rc <- eia_series(id = "AEO.2021.LORENCST.EMI_CO2_TEN_NA_OTH_NA_NA_MILLMETNCO2.A")

# carbon emissions, petroleum, low renewable cost 2021
ems_petro_low_rc <- eia_series(id = "AEO.2021.LORENCST.EMI_CO2_TEN_NA_PET_NA_NA_MILLMETNCO2.A") %>%
  mutate(sector = "Petroleum")
```

``` r
# list of all reference dfs
reference_dfs <- list(ems_commercial_ref, ems_electricity_ref, ems_industrial_ref, 
                     ems_per_capita_ref, ems_residential_ref, ems_transportation_ref,
                     ems_coal_ref, ems_ng_ref, ems_other_ref, ems_petro_ref)

# all dfs for high growth case
high_growth_dfs <- list(ems_commercial_high_g, ems_electricity_high_g, ems_industrial_high_g, 
                       ems_per_cap_high_g, ems_residential_high_g, ems_trans_high_g, 
                       ems_coal_high_g, ems_ng_high_g, ems_other_high_g, ems_petro_high_g)

# all dfs for low growth case
low_growth_dfs <- list(ems_commercial_low_g, ems_electricity_low_g, ems_industrial_low_g, 
                      ems_per_cap_low_g, ems_residential_low_g, ems_trans_low_g, 
                      ems_coal_low_g, ems_ng_low_g, ems_other_low_g, ems_petro_low_g)

#  list of all high price dfs
high_price_dfs <- list(ems_commercial_high_p, ems_electricity_high_p, ems_industrial_high_p, 
                       ems_per_cap_high_p, ems_residential_high_p, ems_trans_high_p, 
                       ems_coal_high_p, ems_ng_high_p, ems_other_high_p, ems_petro_high_p)

#  list of all low price dfs
low_price_dfs <- list(ems_commercial_low_p, ems_electricity_low_p, ems_industrial_low_p, 
                       ems_per_cap_low_p, ems_residential_low_p, ems_trans_low_p, 
                       ems_coal_low_p, ems_ng_low_p, ems_other_low_p, ems_petro_low_p)

# list of all high fossil fuel supply dfs
high_ff_s_dfs <- list(ems_commercial_high_ff_s, ems_electricity_high_ff_s, ems_industrial_high_ff_s, 
                       ems_per_cap_high_ff_s, ems_residential_high_ff_s, ems_trans_high_ff_s, 
                       ems_coal_high_ff_s, ems_ng_high_ff_s, ems_other_high_ff_s, ems_petro_high_ff_s)


# list of all low fossil fuel supply
low_ff_s_dfs <- list(ems_commercial_low_ff_s, ems_electricity_low_ff_s, ems_industrial_low_ff_s, 
                       ems_per_cap_low_ff_s, ems_residential_low_ff_s, ems_trans_low_ff_s, 
                       ems_coal_low_ff_s, ems_ng_low_ff_s, ems_other_low_ff_s, ems_petro_low_ff_s)


# list of all high renewable cost dfs
high_rc_dfs <- list(ems_commercial_high_rc, ems_electricity_high_rc, ems_industrial_high_rc, 
                       ems_per_cap_high_rc, ems_residential_high_rc, ems_trans_high_rc, 
                       ems_coal_high_rc, ems_ng_high_rc, ems_other_high_rc, ems_petro_high_rc)


#list of all low renewable costs dfs
low_rc_dfs <- list(ems_commercial_low_rc, ems_electricity_low_rc, ems_industrial_low_rc, 
                       ems_per_cap_low_rc, ems_residential_low_rc, ems_trans_low_rc, 
                       ems_coal_low_rc, ems_ng_low_rc, ems_other_low_rc, ems_petro_low_rc)

# now we want to give them an easier variable name 
a <- reference_dfs
b <- high_growth_dfs
c <- low_growth_dfs
d <- high_price_dfs
e <- low_price_dfs
f <- high_ff_s_dfs
g <- low_ff_s_dfs
h <- high_rc_dfs
i <- low_rc_dfs


a_merged <- Reduce(function(x, y, ...) merge(x, y, all = TRUE, ...), a) %>%
  mutate(scenario = "Reference") %>%
  unnest(cols = data)

b_merged <- Reduce(function(x, y, ...) merge(x, y, all = TRUE, ...), b) %>%
  mutate(scenario = "High Economic Growth") %>%
  unnest(cols = data)
  
c_merged <- Reduce(function(x, y, ...) merge(x, y, all = TRUE, ...), c) %>%
  mutate(scenario = "Low Economic Growth") %>%
  unnest(cols = data)

d_merged <- Reduce(function(x, y, ...) merge(x, y, all = TRUE, ...), d) %>%
  mutate(scenario = "High Oil Price") %>%
  unnest(cols = data)

e_merged <- Reduce(function(x, y, ...) merge(x, y, all = TRUE, ...), e) %>%
  mutate(scenario = "Low Oil Price") %>%
  unnest(cols = data)

f_merged <- Reduce(function(x, y, ...) merge(x, y, all = TRUE, ...), f) %>%
  mutate(scenario = "High Oil and Gas Supply") %>%
  unnest(cols = data)

g_merged <- Reduce(function(x, y, ...) merge(x, y, all = TRUE, ...), g) %>%
  mutate(scenario = "Low Oil and Gas Supply") %>%
  unnest(cols = data)

h_merged <- Reduce(function(x, y, ...) merge(x, y, all = TRUE, ...), h) %>%
  mutate(scenario = "High Renewables Cost") %>%
  unnest(cols = data)

i_merged <- Reduce(function(x, y, ...) merge(x, y, all = TRUE, ...), i) %>%
  mutate(scenario = "Low Renewables Cost") %>%
  unnest(cols = data)

merging_scenarios <- list(a_merged, b_merged, c_merged, d_merged, e_merged, 
                          f_merged, g_merged, h_merged, i_merged)

# merging all data frames that are now labeled by scenario
master_df <- Reduce(function(x, y, ...) merge(x, y, all = TRUE, ...), merging_scenarios)
```

``` r
# lets first visualize emissions by sector and facet wrap scenario
tokens <- c("Commercial", "Industrial", "Residential", "Capita")

# plotting High / Low Renewables Cost Scenarios
master_df %>%
  filter(str_detect(scenario, "Renewables")) %>%
  filter(str_detect(name, "Commercial|Industrial|Residential|Transportation")) %>%
  ggplot(aes(x = date, y = value, color = scenario)) + 
    geom_point() + 
    scale_x_date(breaks = scales::pretty_breaks(n = 5)) + 
    #facet_wrap(vars(name)) + 
  theme(legend.position = "right", legend.key.size = unit(1, 'cm')) +
  labs(x = "Date", y = master_df$units[1], 
       title = "US Emissions by Sector & Scenario") #+
```

![](long_term_outlook_2021_files/figure-gfm/visualizing%20our%20new%20master%20df-1.png)<!-- -->

``` r
   #geom_smooth(method = "lm", se = FALSE)
   
# plotting High/Low Oil and Gas Supply
master_df %>%
  filter(str_detect(scenario, "Supply")) %>%
  filter(str_detect(name, "Commercial|Industrial|Residential|Transportation")) %>%
  ggplot(aes(x = date, y = value, color = scenario)) + 
    geom_point() + 
    scale_x_date(breaks = scales::pretty_breaks(n = 5)) + 
    #facet_wrap(vars(name)) + 
  theme(legend.position = "right", legend.key.size = unit(1, 'cm')) +
  labs(x = "Date", y = master_df$units[1], 
       title = NULL) #+
```

![](long_term_outlook_2021_files/figure-gfm/visualizing%20our%20new%20master%20df-2.png)<!-- -->

``` r
   #geom_smooth(method = "lm", se = FALSE)

# now we want to plot all commercial forecasts 
master_df %>%
  filter(str_detect(name, "Commercial")) %>%
  ggplot(aes(x = date, y = value, color = scenario)) +
  geom_line() + 
  labs(x = "Year", y = master_df$units[1], title = "US Commercial Sector Emissions", 
       subtitle = "Scenario Based")
```

![](long_term_outlook_2021_files/figure-gfm/visualizing%20our%20new%20master%20df-3.png)<!-- -->

``` r
# now we want to plot all Industrial forecasts
master_df %>%
  filter(str_detect(name, tokens[1])) %>% 
  filter(scenario == c("High Oil and Gas Supply", "Low Oil and Gas Supply", "Reference")) %>%
  ggplot(aes(x = date, y = value, color = scenario)) +
  geom_line() + 
  labs(x = "Year", y = master_df$units[1], title = "US Commercial Sector CO2 Emissions", 
       subtitle = NULL)
```

![](long_term_outlook_2021_files/figure-gfm/visualizing%20our%20new%20master%20df-4.png)<!-- -->

``` r
# want to see how per capita emissions will be affected on a case by case basis
master_df %>%
  filter(str_detect(name, "Capita")) %>%
  ggplot(aes(x = date, y= value, color = scenario)) +
  geom_line() + 
  scale_x_date(breaks = scales::pretty_breaks(n = 10)) + 
  labs(x = "Year", y = "MMmtCO2/capita", title = "US Per-Capita CO2 Emissions", 
       subtitle = "Various Scenarios", 
       caption = "Source: Energy Information Administration (EIA), Annual Energy Outlook 2021")
```

![](long_term_outlook_2021_files/figure-gfm/visualizing%20our%20new%20master%20df-5.png)<!-- -->

``` r
master_df %>%
  filter(str_detect(name, "Commercial|Industrial|Residential|Transportation")) %>%
  filter(scenario == c("High Economic Growth", "Low Economic Growth", "Reference")) %>%
  ggplot(aes(x = date, y = value, color = scenario)) +
  geom_line() +
  facet_wrap(vars(sector)) +
  theme(legend.position = "bottom") +
  labs(x = "Date", y = master_df$units,
       title = "US Sector CO2 Emissions", 
       subtitle = "Economic Growth Scenarios",
       caption = "Source: Energy Information Administration (EIA), Annual Energy Outlook 2021")
```

![](long_term_outlook_2021_files/figure-gfm/visualizing%20sector%20emissions%20based%20on%20economic%20growth-1.png)<!-- -->

``` r
master_df %>%
  filter(str_detect(name, "Coal|Natural Gas|Petroleum")) %>%
  filter(scenario == c("High Economic Growth", "Low Economic Growth", "Reference")) %>%
  ggplot(aes(x = date, y = value, color = scenario)) +
  geom_line() +
  facet_wrap(vars(sector)) +
  theme(legend.position = "bottom") +
  labs(x = "Date", y = master_df$units,
       title = "US CO2 Emissions by Fuel Type", 
       subtitle = "Economic Growth Scenarios",
       caption = "Source: Energy Information Administration (EIA), Annual Energy Outlook 2021")
```

![](long_term_outlook_2021_files/figure-gfm/plot%20fuel%20emissions%20based%20on%20economic%20growth-1.png)<!-- -->

``` r
master_df %>%
  filter(str_detect(name, "Natural Gas|Petroleum|Coal")) %>%
  ggplot(aes(x = date, y = value, color = scenario)) +
  geom_line() +
  facet_wrap(vars(sector), scales = "free") +
  labs(x = "Year", y = master_df$units, 
       title = "US CO2 Emissions by Fuel Type", 
       subtitle = "Various Scenarios", 
       caption = "Source: Energy Information Administration (EIA), Annual Energy Outlook 2021")
```

![](long_term_outlook_2021_files/figure-gfm/plot%20fuel%20emissions%20by%20scenario-1.png)<!-- -->
