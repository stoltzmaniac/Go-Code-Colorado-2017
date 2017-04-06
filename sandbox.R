library(rjson)
json_file <- "http://api.worldbank.org/country?per_page=10&region=OED&lendingtype=LNX&format=json"
json_data <- fromJSON(paste(readLines(json_file), collapse=""))