library(ggplot2)
library(readr)

csv_file <- "humiditySensorData.csv"

data <- read_csv(csv_file)
colnames(data) <- c("Timestamp", "Serial_Data")
data$Timestamp <- as.character(data$Timestamp)

data$Timestamp <- gsub("'", ":", gsub('"', "", data$Timestamp))

convert_to_seconds <- function(timestamp) {
  parts <- unlist(strsplit(timestamp, ":"))
  minutes <- as.numeric(parts[1])
  seconds <- as.numeric(parts[2])
  total_seconds <- minutes * 60 + seconds
  return(total_seconds)
}

data$time_seconds <- sapply(data$`Timestamp`, convert_to_seconds)

ggplot(data, aes(x = time_seconds, y = as.numeric(`Serial_Data`))) +
  geom_line(color = "#ccddff") +  
  geom_point(color = "#6699ff") +  
  labs(title = "Serial Data over Time",
       x = "Time (seconds)",
       y = "Serial Data Value") +
  theme_minimal()

