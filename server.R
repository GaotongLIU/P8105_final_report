server <- shinyServer(function(input, output) {
  
  output$trendPlot <- renderPlotly({
    
    ##plot function
    
    happy = read_csv("data/final_data_all_country.csv") %>% 
      janitor::clean_names() %>% 
      unique %>% 
      mutate(label = str_c("<b>Happiness: ", round(life_ladder,2), 
                           "</b><br>Country : ", country_name,
                           sep = ""),
             code = countrycode(country_name, 'country.name', 'iso3c'),## match code
             code = replace_na(code,"XKX"))
    
    
    # light grey boundaries
    l <- list(color = toRGB("grey"), width = 0.5)
    
    # specify map projection/options
    g <- list(
      showframe = FALSE,
      showcoastlines = FALSE,
      projection = list(type = 'Mercator')
    )
    
    ## making map according to year
    
    global_happy_year <- function(i){
      happy_yeari = happy %>% 
        filter(year == i)
      p <- plot_geo(happy_yeari) %>%
        add_trace(
          z = ~life_ladder, color = ~life_ladder, colors = 'Blues',
          text = ~label, locations = ~code, marker = list(line = l)
        ) %>%
        colorbar(title = 'Happiness index') %>%
        layout(
          title = paste(as.character(i), "Global Happiness Index"),
          geo = g
        )
      return(p)
    }
    p <- global_happy_year(input$year)
    layout(p)
  })
})
