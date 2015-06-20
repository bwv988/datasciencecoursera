# scrape_IMDB.r - Web scraping of IMDB.
# RS24012015

library(rvest)

setwd("~/Dropbox/Coursera/data_science/data_products/dataproducts_assignmnent/imdbapp")

# Top 250
SIZE <- 250
TOP_URL <- "http://www.imdb.com/chart/top"

#
# Make delayed requests.
#
makeIMDBRequest <- function(url) {
  ret <- html(url)
  Sys.sleep(sample(seq(0.3, 1.0, by = 0.1), size = 1))
  ret
}

# Little helper function to trim leading spaces.
removeWhiteSpc <- function(str) {
  gsub("^\\s+", "", str)
}



# The data structure we want to produce.
topMovies <- data.frame(Name=character(SIZE), Year=character(SIZE), 
                        Rating=numeric(SIZE), VotingCount=integer(SIZE),
                        Country=character(SIZE), stringsAsFactors = FALSE)

imdbHTMLStruct <- makeIMDBRequest(TOP_URL)

tmp <- imdbHTMLStruct %>% html_nodes("table") %>% html_table()
tmpTable <- tmp[[1]]

#
# Create clean data frame.
# FIXME: There is a lot of potential to make this smarter!
#
for(i in 1:nrow(tmpTable)) {
  # Separate out name and year from first column.
  row <- tmpTable[i, ][[2]]
  tmp <- strsplit(row, "\n")
  cleanRow <- unlist(lapply(tmp, removeWhiteSpc))
  name <- cleanRow[2]
  # Surely there must be a smarter way for the below.
  year <- gsub("\\(", "", cleanRow[3])
  year <- gsub("\\)", "", year)
  
  topMovies[i, ]$Name <- name
  topMovies[i, ]$Year <- year
  topMovies[i, ]$Rating = as.numeric(tmpTable[i, ][[3]])
}

# Extract URL refs for each movie title.
contents <- imdbHTMLStruct %>% html_nodes("table") %>% html_node("tbody")
rf <- contents[1] %>% html_nodes("a") %>% html_attr("href")
refs <- unique(rf)
reqURLs <- unlist(lapply(refs, function(ref) paste("http://www.imdb.com", ref, sep = "")))

# Make one request per movie to retrieve additional information.
for(i in 1:SIZE) {
  moviePage <- makeIMDBRequest(reqURLs[i])
  
  # Extract voting count.
  count <- moviePage %>% html_node(xpath="//*[@class='star-box-details']") %>% 
    html_node(xpath="//*[@itemprop='ratingCount']") %>% html_text()
  topMovies[i, ]$VotingCount <- as.integer(gsub(",", "", count))
                                           
  # Get the country of origin.
  detailDivs <- moviePage %>% html_node(xpath="//*[@id='titleDetails']") %>% html_nodes("div") 
  topMovies[i, ]$Country <- detailDivs[2] %>% html_node("a") %>% html_text()
}

save(topMovies, file = "data/imdb.rda")