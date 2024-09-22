# Load required libraries
library(ggplot2)
library(readr)

# Set the file path for the CSV file
csv_file <- "tempSensorData2.csv"  # Replace with your actual CSV file path

# Read the CSV file
data <- read_csv(csv_file)
colnames(data) <- c("Timestamp", "Serial_Data")
data$Timestamp <- as.character(data$Timestamp)

# Clean up the Timestamp column (remove ' and ")
data$Timestamp <- gsub("'", ":", gsub('"', "", data$Timestamp))

# Preview the data
print(head(data))

# Convert the 'Timestamp (MM:SS)' to seconds
convert_to_seconds <- function(timestamp) {
  parts <- unlist(strsplit(timestamp, ":"))
  minutes <- as.numeric(parts[1])
  seconds <- as.numeric(parts[2])
  total_seconds <- minutes * 60 + seconds
  return(total_seconds)
}

# Apply the conversion function to the 'Timestamp (MM:SS)' column
data$time_seconds <- sapply(data$`Timestamp`, convert_to_seconds)

# Plot the data using ggplot
ggplot(data, aes(x = time_seconds, y = as.numeric(`Serial_Data`))) +
  geom_line(color = "#ffe6cc") +  # Line plot
  geom_point(color = "#ffbf80") +  # Points on the line
  labs(title = "Serial Data over Time",
       x = "Time (seconds)",
       y = "Serial Data Value") +
  theme_minimal()

