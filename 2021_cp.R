# importing packages to be able to plot the data
library(ggplot2)
library(tidyr)
library(tidyverse)
library(dplyr)

# import excel into r
carbon_price <- read.csv("carbon_pricing_2021.csv")


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

# plotting our data
current_prices %>%
  drop_na(Price_rate_1_2021) %>%
  filter(Price_rate_1_2021 > 0) %>%
  ggplot(aes(x = Name.of.the.initiative, 
             y = Price_rate_1_2021)) +
  facet_grid(row = vars(Instrument.Type)) +
  geom_col() +
  coord_flip()



