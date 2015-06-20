# server.r - Server component.
# RS24012015

library(shiny)
library(dplyr)

shinyServer(
  function(input, output) {
    
    # Filter output by rating.
    filteredByRating <- reactive({    
      df <- topMovies %>% 
        filter(Rating == input$selectedRating) %>% 
        select(Name, Year, Rating, Country, VotingCount) %>%
        arrange(VotingCount)
    })
    
    # Filter output by country.
    filteredByCountry <- reactive({    
      df <- topMovies %>% 
        filter(Country == input$selectedCountry) %>% 
        select(Name, Year, Rating, Rating, VotingCount) %>%
        arrange(VotingCount)
    })
    
    output$chartRating <- reactive({
      # Return the data and options.
      list(
        data = googleDataTable(filteredByRating()),
        options = list(
          title = sprintf(
            "Movies with a rating of %s.", 
            input$selectedRating)
        )
      )
    })
    
    output$chartCountry <- reactive({
      # Return the data and options.
      list(
        data = googleDataTable(filteredByCountry()),
        options = list(
          title = sprintf(
            "Movies with Country of Origin / Language %s", 
            input$selectedCountry)         
        )
      )
    }) 
})

