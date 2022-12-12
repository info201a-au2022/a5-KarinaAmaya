library(tidyverse)
library(ggplot2)
library(plotly)
library(lintr)
library(shiny)

CO2 <- read.csv("owid-co2-data.csv", stringsAsFactors = FALSE)


filtered_to <- CO2 %>% 
  filter(year >= 1950 & year <= 2021, na.rm = TRUE)

#View(filtered_to)

#What is the average value of my variable across all countries (in the current year)?
avg_val <- CO2 %>% 
  filter(year == 2018) %>% 
  select(country, year, population, gdp, iso_code, cumulative_co2_including_luc) %>% 
  group_by(country) %>% 
  summarize(cumulative_co2_including_luc = mean(cumulative_co2_including_luc, na.rm = TRUE))

#View(avg_val)



#Where is my variable the highest/lowest?
new_avg_val <- avg_val[-c(2, 3, 11, 16, 17, 18, 19, 47, 76, 77, 78, 79, 81, 82, 107, 114, 141,
                          142, 177, 179, 180, 185, 186, 225, 226, 227, 258, 266 ),]

#View(new_avg_val)

highest_cumulative <- new_avg_val %>% 
  filter(cumulative_co2_including_luc == max(cumulative_co2_including_luc, na.rm = TRUE))

#View(highest_cumulative)
#having trouble finding minimum
lowest_cumulative <- new_avg_val %>% 

  filter(cumulative_co2_including_luc == min(cumulative_co2_including_luc, na.rm = TRUE))
lowest_cumulative

# How has my variable changed over the last N years?
#Over the last 10 years from 2018 to 2008 for all countries together

changed_variable <- CO2 %>% 
  filter(year >= 2008 & year <= 2018, na.rm = TRUE) %>% 
  select(year, country, cumulative_co2_including_luc)

#View(changed_variable)

removed_noncountries <- changed_variable[-c(12:33, 155:198, 496:506, 806:880, 1123:1133, 1200:1210, 1475:1496,
                                            1662:1672, 1871:1914, 1948:1958, 1970:1980, 2388:2409, 2729:2739,
                                            2817:2827),]


#2018

cum_2018 <- removed_noncountries %>% 
  filter(year == 2018) %>% 
  summarize(cumulative_co2_including_luc = mean(cumulative_co2_including_luc, na.rm = TRUE))
cum_2018
#2008
cum_2008 <- removed_noncountries %>% 
  filter(year == 2008) %>% 
  summarize(cumulative_co2_including_luc = mean(cumulative_co2_including_luc, na.rm = TRUE))
cum_2008

difference_2018_2008 <- cum_2008 - cum_2018
difference_2018_2008

#Carbon dioxide in El Salvador
#removed some early and some later years because they were missing

#selecting only central american countries
Central_America <- filtered_to[c(1894:1965, 3821:3892, 4829:4900,6929:6999, 7433:7504, 11749:11820, 13020:13091 ),]

View(Central_America)
#filtering to specific years and columns
Central_America_ghg <- Central_America %>% 
  select(country, year, ghg_per_capita) %>% 
  filter(year >= 1990 & year <= 2019, na.rm = TRUE)

#View(Central_America_ghg)

#plot
ca_only_plot <- ggplot(data = Central_America_ghg) + 
  geom_line(mapping = aes(x = year, y = ghg_per_capita, color = country)) +
  
  labs(title = "Greenhouse Gas Distribution in Central America",
       x = "Year",
       y = "Greenhouse Gas Emission in Tonnes",
       color = "Countries",
       caption = "This graph focuses on countries in Central America and their greenhouse has emissions from 1990 to 2018. This includes Belize, Honduras, El Salvador, Nicaragua, Guatemala, Mexico, Panama, and Costa Rica. For most countries the greenhouse gase distribution over the years has steadily been around the same. With most countries decreasing. However, Belize, has had a significant amount produced over the years. It has decreased greatly beginning in mid 1990's. It seems to continue to decrease but it has produced much more than all the other countries in Central America. ")

ggplotly(ca_only_plot)
