# ui.r - User Interface component.
# RS24012015

library(shiny)
library(markdown)
library(googleCharts)

# This is for the bubble chart.
xlim <- list(
  min = min(topMovies$Year) - 5,
  max = max(topMovies$Year) + 5
)

ylim <- list(
  min = minRating + 3,
  max = maxRating - 3
)

shinyUI(navbarPage("IMDB Top 250 Movies Explorer",
                   tabPanel("Ratings", 
                            fluidPage(
                              # Load Google Charts library.
                              googleChartsInit(),
                              
                              # Use the Google webfont "Source Sans Pro".
                              tags$link(
                                href=paste0("https://fonts.googleapis.com/css?",
                                            "family=Source+Sans+Pro:300,600,300italic"),
                                rel="stylesheet", type="text/css"
                              ),
                              
                              tags$style(type="text/css",
                                         "body {font-family: 'Source Sans Pro'}"
                              ),
                              
                              h3("Explore by Movie Ratings"),
                              HTML("<p><small><strong>Scroll &darr; for controls &mdash; pan / zoom inside chart &mdash; hover over data bubbles.</strong></small></p>"),                                                      
                              
                              hr(),
                              googleBubbleChart("chartRating",
                                                width="90%", height = "475px",
                                                # Set the default options for this chart; they can be
                                                # overridden in server.R on a per-update basis. See
                                                # https://developers.google.com/chart/interactive/docs/gallery/bubblechart
                                                # for option documentation.
                                                options = list(
                                                  fontName = "Source Sans Pro",
                                                  fontSize = 13,
                                                  # Set axis labels and ranges
                                                  hAxis = list(
                                                    title = "Year",
                                                    viewWindow = xlim
                                                  ),
                                                  vAxis = list(
                                                    title = "IMDB Rating",
                                                    viewWindow = ylim
                                                  ),
                                                  # The default padding is a little too spaced out
                                                  chartArea = list(
                                                    top = 50, left = 75,
                                                    height = "75%", width = "75%"
                                                  ),
                                                  # Allow pan/zoom
                                                  explorer = list(),
                                                  # Set bubble visual props
                                                  bubble = list(
                                                    opacity = 0.4, stroke = "none",
                                                    # Hide bubble label
                                                    textStyle = list(
                                                      color = "none"
                                                    )
                                                  ),
                                                  # Set fonts
                                                  titleTextStyle = list(
                                                    fontSize = 16
                                                  ),
                                                  tooltip = list(
                                                    textStyle = list(
                                                      fontSize = 12
                                                    )
                                                  )
                                                )
                              ),
                              
                              hr(),
                              
                              fluidRow(
                                shiny::column(4, offset = 4,                                                                        
                                              sliderInput("selectedRating", "Select Movie Rating", min = minRating, max = maxRating, 
                                                          value = minRating, step = 0.1)                          
                                )                                 
                              )
                            )                            
                   ),
                   
                   tabPanel("Country",
                            fluidPage(                                                    
                              h3("Explore by Country"),
                              HTML("<p><small><strong>Scroll &darr; for controls &mdash; pan / zoom inside chart &mdash; hover over data bubbles.</strong></small></p>"),                             
                              
                              hr(),
                              googleBubbleChart("chartCountry",
                                                width="90%", height = "475px",
                                                # Set the default options for this chart; they can be
                                                # overridden in server.R on a per-update basis. See
                                                # https://developers.google.com/chart/interactive/docs/gallery/bubblechart
                                                # for option documentation.
                                                options = list(
                                                  fontName = "Source Sans Pro",
                                                  fontSize = 13,
                                                  # Set axis labels and ranges
                                                  hAxis = list(
                                                    title = "Year",
                                                    viewWindow = xlim
                                                  ),
                                                  vAxis = list(
                                                    title = "IMDB Rating",
                                                    viewWindow = ylim
                                                  ),
                                                  # The default padding is a little too spaced out
                                                  chartArea = list(
                                                    top = 50, left = 75,
                                                    height = "75%", width = "75%"
                                                  ),
                                                  # Allow pan/zoom
                                                  explorer = list(),
                                                  # Set bubble visual props
                                                  bubble = list(
                                                    opacity = 0.4, stroke = "none",
                                                    # Hide bubble label
                                                    textStyle = list(
                                                      color = "none"
                                                    )
                                                  ),
                                                  # Set fonts
                                                  titleTextStyle = list(
                                                    fontSize = 16
                                                  ),
                                                  tooltip = list(
                                                    textStyle = list(
                                                      fontSize = 12
                                                    )
                                                  )
                                                )
                              ),
                              
                              hr(),
                              
                              fluidRow(
                                shiny::column(4, offset = 4,                                                                        
                                  selectInput("selectedCountry", "Select Country / Language", countries, selected = "USA", multiple = FALSE, selectize = TRUE, width = NULL)                          
                                )                                 
                              )
                            )
                   ),
                   tabPanel("Help", includeMarkdown("doc/help.md")),  
                   tabPanel("About", includeMarkdown("doc/about.md"))                         
))