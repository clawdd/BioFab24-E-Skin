library(ggplot2)
library(readr)

csv_file <- "tempSensorData2.csv"

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
  geom_line(color = "#ffe6cc") + 
  geom_point(color = "#ffbf80") +  
  labs(title = "Serial Data over Time",
       x = "Time (seconds)",
       y = "Serial Data Value") +
  theme_minimal()

