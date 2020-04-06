complete <- function(directory, id = 1:332){
  library(stringr)
  file_names <- paste(str_pad(id, 3, pad = "0"), "csv", sep = ".")
  result <- data.frame("id" = id, "nobs" = integer(length(id)))
  for(i in seq_along(id)) {
    full_fn <- file.path(directory, file_names[i])
    # print(paste("Processing", full_fn))
    df <- read.csv(full_fn)
    sum_of_cols <- df$sulfate + df$nitrate
    result$nobs[i] <- sum(!is.na(sum_of_cols))
  }
  result
}
