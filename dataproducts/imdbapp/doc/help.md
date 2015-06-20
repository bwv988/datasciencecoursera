## Help

### Overview

This app allows to visualize some information about the top 250 movies in the Internet Movie Database (IMDB) using Google's **Bubble Chart**.

Each movie is represented by a bubble. The size and color of the bubble may have additional meaning (see below).

### How to use
There are two main views which can be accessed through the tabs above: _Ratings_ and _Country_.

Using the touchpad / mouse, **pan** and **zoom** allows to navigate the chart.

**Hovering** the mouse over a bubble will reveal additional information about the movie.

#### Ratings
In this view the movie data is filtered by the selected rating (using a slider).

The size of the bubble is relative to the number of votes the movie recieved, i.e. the more votes the larger the disc. 

The color indicates the country of origin.

#### Country
The _Country_ view focuses on all the movies from a single country and plots movie rating by year.

Here, the bubbles are colored according to the grand total number of votes. There is a bar above the plot relating the number of votes to the color.


### Data

The data for this app was retrieved on 24/1/2015 using a custom web scraping script `scrape_IMDB.R`. 

This script is available in the application's [Github repo] (https://github.com/bwv988/dataproducts_assignmnent).

### References

1. [Rvest blog - Rstudio Blogs] (http://blog.rstudio.org/2014/11/24/rvest-easy-web-scraping-with-r/)
2. [Google Charts - Github] (https://github.com/jcheng5/googleCharts)
3. [Top 250 Movies - R Bloggers] (http://www.r-bloggers.com/top-250-movies-at-imdb/)



