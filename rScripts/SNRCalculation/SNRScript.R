# Load necessary library
install.packages("readr")
library(readr)


# Step 1: Read the CSV files
signal1 <- read_csv("withl1.csv", col_names = FALSE)
signal2 <- read_csv("with2.csv", col_names = FALSE)
noise1 <- read_csv("without1.csv", col_names = FALSE)
noise2 <- read_csv("without2.csv", col_names = FALSE)

# Step 2: Combine all signal and noise values
# Use unlist to convert the data frames into a single vector of values
all_signals <- c(unlist(signal1), unlist(signal2))
all_noises  <- c(unlist(noise1), unlist(noise2))

# Step 3: Calculate mean square of signal and noise
mean_signal_square <- mean(all_signals^2)
mean_noise_square <- mean(all_noises^2)

# Step 4: Calculate SNR (in dB)
SNR <- 10 * log10(mean_signal_square / mean_noise_square)

# Print the SNR value
print(paste("The Signal-to-Noise Ratio (SNR) is:", SNR, "dB"))
