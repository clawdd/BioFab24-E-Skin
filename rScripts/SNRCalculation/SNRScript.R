install.packages("readr")
library(readr)

signal1 <- read_csv("withl1.csv", col_names = FALSE)
signal2 <- read_csv("with2.csv", col_names = FALSE)
noise1 <- read_csv("without1.csv", col_names = FALSE)
noise2 <- read_csv("without2.csv", col_names = FALSE)

all_signals <- c(unlist(signal1), unlist(signal2))
all_noises  <- c(unlist(noise1), unlist(noise2))

mean_signal_square <- mean(all_signals^2)
mean_noise_square <- mean(all_noises^2)

SNR <- 10 * log10(mean_signal_square / mean_noise_square)

print(paste("The Signal-to-Noise Ratio (SNR) is:", SNR, "dB"))
