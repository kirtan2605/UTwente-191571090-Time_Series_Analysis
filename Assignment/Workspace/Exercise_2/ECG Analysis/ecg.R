# Libraries
library(ggplot2)
library(dplyr)
library(pracma)
library(readr)
library(psd)

# load Dow Jones Index data from file in working directory of Rscript
data = read_tsv("ecg.txt", col_names = TRUE)
data = data[["x1"]]

# plotting data for preliminary observation
plot(data, type = 'l')

# eliminating trend
detrended_data = detrend(data)
plot(detrended_data, type='l')

# finding and eliminating non-zero mean
m_tilde = mean(detrended_data)
zero_mean_detrended_data = detrended_data - m_tilde
plot(zero_mean_detrended_data, type='l')

# renaming dataset
working_data = zero_mean_detrended_data
plot(working_data, type = 'l')

# computing and plotting correlations
acf_data = acf(working_data, 50)
pacf_data = pacf(working_data, 20)


# Estimating ARMA Model
ARMA_Model = arima(working_data, c(4,0,5))
print(ARMA_Model)





## Residual Diagnostics
ARMA_Model_Residual = residuals(ARMA_Model)
plot(ARMA_Model_Residual)
acf(ARMA_Model_Residual)

# computing spectral density function (AKA periodogram)
## raw periodogram
periodogram_data = spec.pgram(working_data, taper = 0, plot = FALSE)
plot(periodogram_data)

## raw periodogram with log
raw.spec <- spec.pgram(working_data, taper = 0, plot = FALSE)
plot(raw.spec, log = "no")

## smoothing the periodogram by taking moving averages using kernel functions

### N = 2499, M = cbrt(N) = nearly 14 <<< N 
periodogram_data_14_01 = spec.pgram(working_data, kernel = kernel("daniell", m = 14) , plot = FALSE)
periodogram_data_14_02 = spec.pgram(working_data, kernel = kernel("daniell", c(14,14)) , plot = FALSE)
periodogram_data_14_03 = spec.pgram(working_data, kernel = kernel("daniell", c(14,14,14)) , plot = FALSE)

plot(periodogram_data_14_01,type="l",col="red")
lines(periodogram_data_14_02,type="l",col="green")
lines(periodogram_data_14_03,type="l",col="blue")

legend(0.3, 50, 
       legend=c("m=14", "c(14,14)", "c(14,14,14)"), 
       fill = c("red","green", "blue"))

### N = 2499, M = 30 << N, an intermediate value
periodogram_data_30_01 = spec.pgram(working_data, kernel = kernel("daniell", m = 30) , plot = FALSE)
periodogram_data_30_02 = spec.pgram(working_data, kernel = kernel("daniell", c(30,30)) , plot = FALSE)
periodogram_data_30_03 = spec.pgram(working_data, kernel = kernel("daniell", c(30,30,30)) , plot = FALSE)

plot(periodogram_data_30_01,type="l",col="red")
lines(periodogram_data_30_02,type="l",col="green")
lines(periodogram_data_30_03,type="l",col="blue")

legend(0.3, 50, 
       legend=c("m=30", "c(30,30)", "c(30,30,30)"), 
       fill = c("red","green", "blue"))


### N = 2499, M = sqrt(N) = nearly 50 << N
periodogram_data_50_01 = spec.pgram(working_data, kernel = kernel("daniell", m = 50) , plot = FALSE)
periodogram_data_50_02 = spec.pgram(working_data, kernel = kernel("daniell", c(50,50)) , plot = FALSE)
periodogram_data_50_03 = spec.pgram(working_data, kernel = kernel("daniell", c(50,50,50)) , plot = FALSE)

plot(periodogram_data_50_01,type="l",col="red")
lines(periodogram_data_50_02,type="l",col="green")
lines(periodogram_data_50_03,type="l",col="blue")

legend(0.3, 50, 
       legend=c("m=50", "c(50,50)", "c(50,50,50)"), 
       fill = c("red","green", "blue"))


## plotting across window sizes
### m = 14, 30, 50
plot(periodogram_data_14_01,type="l",col="red")
lines(periodogram_data_30_01,type="l",col="green")
lines(periodogram_data_50_01,type="l",col="blue")

legend(0.3, 50, 
       legend=c("m = 14", "m = 30", "m = 50"), 
       fill = c("red","green", "blue"))

### (c,c) = 16, 32, 64
plot(periodogram_data_14_02,type="l",col="red")
lines(periodogram_data_30_02,type="l",col="green")
lines(periodogram_data_50_02,type="l",col="blue")

legend(0.3, 50, 
       legend=c("c(14,14)", "c(30,30)", "c(50,50)"), 
       fill = c("red","green", "blue"))

### (c,c,c) = 16, 32, 64
plot(periodogram_data_14_03,type="l",col="red")
lines(periodogram_data_30_03,type="l",col="green")
lines(periodogram_data_50_03,type="l",col="blue")

legend(0.3, 50, 
       legend=c("c(14,14,14)", "c(30,30,30)", "c(50,50,50)"), 
       fill = c("red","green", "blue"))

# spectrum comparison
plot(periodogram_data)
lines(periodogram_data_14_03,type="l",col="green")
lines(periodogram_data_30_03,type="l",col="red")
lines(periodogram_data_50_03,type="l",col="blue")
legend(0.0, 1, 
       legend=c("raw_periodogram", "c(64,64,64)", "c(32,32,32)", "c(16,16,16)"), 
       fill = c("black","green", "red", "blue"))
