# Global data file.
# RS25012015

# Load IMDB data.
load("data/imdb.rda")

# Some last minute data modifications.
topMovies$Year <- as.integer(topMovies$Year)
topMovies$Country <- as.factor(topMovies$Country)
topMovies$Name <- as.factor(topMovies$Name)

countries <- levels(topMovies$Country)

minRating <- min(topMovies$Rating)
maxRating <- max(topMovies$Rating)

minVotes <- min(topMovies$VotingCount)
maxVotes <- max(topMovies$VotingCount)

