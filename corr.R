corr <- function(directory, threshold = 0){
  library(stringr)
  id <- 1:332
  file_names <- paste(str_pad(id, 3, pad = "0"), "csv", sep = ".")
  result <- data.frame("id" = id, "cor" = double(length(id)))
  for(i in seq_along(id)) {
    full_fn <- file.path(directory, file_names[i])
    df <- read.csv(full_fn)
    sum_of_cols <- df$sulfate + df$nitrate
    valid_rows <- !is.na(sum_of_cols)
    if(sum(valid_rows) > threshold) {
      result$cor[i] = cor(df$sulfate[valid_rows], df$nitrate[valid_rows])
    }
    else {
      result$cor[i] <- NA
    }
  }
  result$cor[!is.na(result$cor)]
}
