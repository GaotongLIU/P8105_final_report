describiton
================
YuaoYang
2019/11/17

``` r
library(tidyverse)
library(corrplot) 
knitr::opts_chunk$set(
  fig.width = 12,
  fig.asp = 1,
  out.width = "100%"
)
theme_set(theme_bw() + theme(legend.position = "right"))
```

# manipulate the data

``` r
data = read_csv("data/final_data_all_country.csv") %>%
  select(country_name:negative_affect) %>%
  unique() %>%
  mutate(gdp = exp(log_gdp_per_capita)) %>%# in the original data, they use log get the result, i try to transfer in the real way
  mutate( category = ifelse(gdp > 25000, "developed", "developing")) # actually there is no speicific cretiria to distinguish the developed and developing country.
```

    ## Warning: Missing column names filled in: 'X1' [1]

    ## Parsed with column specification:
    ## cols(
    ##   X1 = col_double(),
    ##   country_name = col_character(),
    ##   year = col_double(),
    ##   life_ladder = col_double(),
    ##   log_gdp_per_capita = col_double(),
    ##   social_support = col_double(),
    ##   healthy_life_expectancy_at_birth = col_double(),
    ##   freedom_to_make_life_choices = col_double(),
    ##   positive_affect = col_double(),
    ##   negative_affect = col_double(),
    ##   generosity = col_double(),
    ##   perceptions_of_corruption = col_double()
    ## )

``` r
data  %>%
  mutate(category = factor(category, levels  = c("developed", "developing"))) %>%
  group_by(year, category) %>% 
  summarise(year_mean_score = mean(life_ladder)) %>% 
  drop_na(category)%>%
  ggplot(aes(x = year, y = year_mean_score, color = category)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE) +  
  facet_grid(. ~ category)
```

    ## Warning: Factor `category` contains implicit NA, consider using
    ## `forcats::fct_explicit_na`

<img src="description2_files/figure-gfm/unnamed-chunk-3-1.png" width="100%" />

``` r
data %>%
  group_by(year, category) %>% 
  ggplot(aes(x = year, y = life_ladder, group = year))+ geom_boxplot() + facet_grid(.~category)+ scale_x_continuous(
    breaks = c(2011, 2012, 2013,2014,2015,2016,2017,2018))
```

<img src="description2_files/figure-gfm/unnamed-chunk-4-1.png" width="100%" />

``` r
data %>%
  group_by(year, category) %>%
  drop_na(category)%>%
  ggplot(aes(x = life_ladder, y = log_gdp_per_capita)) +
  geom_point() +
  geom_smooth(method = lm, color = "red") +
  facet_grid(year ~ category)
```

<img src="description2_files/figure-gfm/unnamed-chunk-5-1.png" width="100%" />
