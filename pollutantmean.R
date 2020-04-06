pollutantmean <- function(directory, pollutant, id = 1:332){
  library(stringr)
  file_names <- paste(str_pad(id, 3, pad = "0"), "csv", sep = ".")
  sum_of_samples <- vector(mode = "double", length = length(id))
  counts <- vector(mode = "integer", length = length(id))
  for(i in seq_along(id)) {
    full_fn <- file.path(directory, file_names[i])
    df <- read.csv(full_fn)
    sum_of_samples[i] <- sum(df[[pollutant]], na.rm = TRUE)
    counts[i] <- sum(!is.na(df[[pollutant]]))
  }
  sum(sum_of_samples) / sum(counts)
}
