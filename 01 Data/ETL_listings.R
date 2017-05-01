require(readr)
require(plyr)


file_path = "../01 Data/listings_summary.csv"
ticker <- readr::read_csv(file_path)

df <- plyr::rename(ticker, c("table"="tbl"))

df <- plyr::rename(ticker, c("table"="tbl"))

measures <- c("price")

for(n in names(df)) {
  df[n] <- data.frame(lapply(df[n], gsub, pattern="[^ -~]",replacement= ""))
}

dimensions <- setdiff(names(df), measures)
dimensions



na2emptyString <- function (x) {
  x[is.na(x)] <- ""
  return(x)
}
if( length(dimensions) > 0) {
  for(d in dimensions) {
    df[d] <- data.frame(lapply(df[d], na2emptyString))
    df[d] <- data.frame(lapply(df[d], gsub, pattern="[\"']",replacement= ""))
    df[d] <- data.frame(lapply(df[d], gsub, pattern="&",replacement= " and "))
    df[d] <- data.frame(lapply(df[d], gsub, pattern=":",replacement= ";"))
  }
}

na2zero <- function (x) {
  x[is.na(x)] <- 0
  return(x)
}

if( length(measures) > 1) {
  for(m in measures) {
    
    df[m] <- data.frame(lapply(df[m], as.numeric))
  }
}
str(df)
write.csv(df, gsub("listings_summary", "clean_listings_summary", file_path), row.names=FALSE, na = "")





