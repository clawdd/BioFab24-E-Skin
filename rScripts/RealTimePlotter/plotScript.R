library(serial)
library(ggplot2)

# List available ports
available_ports <- listPorts()
print(available_ports)

# Open a serial connection
con <- serialConnection(port = "COM3", baudrate = 9600)
open(con)

# Initialize a data frame to store data
data <- data.frame(Time = numeric(0), Value = numeric(0))

# Start a loop to read and plot data
tryCatch({
  while (TRUE) {
    # Check if there's data in the queue
    bytes_in_queue <- nBytesInQueue(con)
    
    if (bytes_in_queue > 0) {
      # Read a line from the serial port
      line <- read.serialConnection(con)
      
      # Assuming the line is comma-separated values (time, value)
      values <- strsplit(line, ",")[[1]]
      time <- as.numeric(values[1])
      value <- as.numeric(values[2])
      
      # Append new data
      data <- rbind(data, data.frame(Time = time, Value = value))
      
      # Plot the data
      ggplot(data, aes(x = Time, y = Value)) +
        geom_line(color = "blue") +
        geom_point(color = "red") +
        labs(title = "Live Data from Serial Port", x = "Time", y = "Value") +
        theme_minimal()
      
      Sys.sleep(1)  # Pause for a second before reading again
    }
  }
}, finally = {
  # Close the connection when done
  close(con)
})
