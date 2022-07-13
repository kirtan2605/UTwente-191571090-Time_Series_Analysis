# Libraries
library(ggplot2)
library(dplyr)
library(pracma)
library(readr)
library(psd)

# load Dow Jones Index data from file in working directory of Rscript
data = read_tsv("dow_jones.txt", col_names = FALSE)
data = data[["X2"]]

# plotting data for preliminary observation
plot(data, type = 'l')

# scaling original data using log
log_data = log(data)
plot(log_data, type='l')


# eliminating trend
detrended_log_data = detrend(log_data)
plot(detrended_log_data, type='l')

# finding and eliminating non-zero mean
m_tilde = mean(detrended_log_data)
zero_mean_detrended_log_data = detrended_log_data - m_tilde
plot(zero_mean_detrended_log_data, type='l')

# renaming dataset
working_data = zero_mean_detrended_log_data
plot(working_data, type = 'l')

# computing and plotting correlations

acf_data = acf(working_data, 500)

pacf_data = pacf(working_data, 50)


# Estimating ARMA Model
ARMA_Model = arima(working_data, c(1,0,0))
print(ARMA_Model)

## Residual Diagnostics
ARMA_Model_Residual = residuals(ARMA_Model)
plot(ARMA_Model_Residual)
plot(ARMA_Model_Residual[1:500], type = 'l')
plot(ARMA_Model_Residual[2500:3000], type = 'l')
acf(ARMA_Model_Residual)

# computing spectral density function (AKA periodogram)
## raw periodogram
periodogram_data = spec.pgram(working_data, taper = 0, plot = FALSE)
plot(periodogram_data)

## raw periodogram with log
raw.spec <- spec.pgram(working_data, taper = 0, plot = FALSE)
plot(raw.spec, log = "no")

## smoothing the periodogram by taking moving averages using kernel functions

### N = 4687, M = cbrt(N) = nearly 17 <<< N , we take powers of 2 i.e 16
periodogram_data_16_01 = spec.pgram(working_data, kernel = kernel("daniell", m = 16) , plot = FALSE)
periodogram_data_16_02 = spec.pgram(working_data, kernel = kernel("daniell", c(16,16)) , plot = FALSE)
periodogram_data_16_03 = spec.pgram(working_data, kernel = kernel("daniell", c(16,16,16)) , plot = FALSE)

plot(periodogram_data_16_01,type="l",col="red")
lines(periodogram_data_16_02,type="l",col="green")
lines(periodogram_data_16_03,type="l",col="blue")

legend(0.3, 1, 
       legend=c("m=16", "c(16,16)", "c(16,16,16)"), 
       fill = c("red","green", "blue"))

### N = 4687, M = 32 << N , we take an intermediate power of 2 i.e 32
periodogram_data_32_01 = spec.pgram(working_data, kernel = kernel("daniell", m = 32) , plot = FALSE)
periodogram_data_32_02 = spec.pgram(working_data, kernel = kernel("daniell", c(32,32)) , plot = FALSE)
periodogram_data_32_03 = spec.pgram(working_data, kernel = kernel("daniell", c(32,32,32)) , plot = FALSE)

plot(periodogram_data_32_01,type="l",col="red")
lines(periodogram_data_32_02,type="l",col="green")
lines(periodogram_data_32_03,type="l",col="blue")

legend(0.3, 1, 
       legend=c("m=32", "c(32,32)", "c(32,32,32)"), 
       fill = c("red","green", "blue"))

### N = 4687, M = sqrt(N) = nearly 69 << N , we take powers of 2 i.e 64
periodogram_data_64_01 = spec.pgram(working_data, kernel = kernel("daniell", m = 64) , plot = FALSE)
periodogram_data_64_02 = spec.pgram(working_data, kernel = kernel("daniell", c(64,64)) , plot = FALSE)
periodogram_data_64_03 = spec.pgram(working_data, kernel = kernel("daniell", c(64,64,64)) , plot = FALSE)

plot(periodogram_data_64_01,type="l",col="red")
lines(periodogram_data_64_02,type="l",col="green")
lines(periodogram_data_64_03,type="l",col="blue")

legend(0.3, 1, 
       legend=c("m=64", "c(64,64)", "c(64,64,64)"), 
       fill = c("red","green", "blue"))

## plotting across window sizes
### m = 16, 32, 64
plot(periodogram_data_16_01,type="l",col="red")
lines(periodogram_data_32_01,type="l",col="green")
lines(periodogram_data_64_01,type="l",col="blue")

legend(0.3, 1, 
       legend=c("m = 16", "m = 32", "m = 64"), 
       fill = c("red","green", "blue"))

### (c,c) = 16, 32, 64
plot(periodogram_data_16_02,type="l",col="red")
lines(periodogram_data_32_02,type="l",col="green")
lines(periodogram_data_64_02,type="l",col="blue")

legend(0.3, 1, 
       legend=c("c(16,16)", "c(32,32)", "c(64,64)"), 
       fill = c("red","green", "blue"))

### (c,c,c) = 16, 32, 64
plot(periodogram_data_16_03,type="l",col="red")
lines(periodogram_data_32_03,type="l",col="green")
lines(periodogram_data_64_03,type="l",col="blue")

legend(0.3, 1, 
       legend=c("c(16,16,16)", "c(32,32,32)", "c(64,64,64)"), 
       fill = c("red","green", "blue"))

# spectrum comparison
plot(periodogram_data)
lines(periodogram_data_64_03,type="l",col="red")
lines(periodogram_data_32_03,type="l",col="deepskyblue")
lines(periodogram_data_16_03,type="l",col="green")
legend(0.25, 50, 
       legend=c("raw_periodogram", "c(64,64,64)", "c(32,32,32)", "c(16,16,16)"), 
       fill = c("black","green", "red", "blue"))