# Libraries
library(ggplot2)
library(dplyr)
library(pracma)

# load AirPassengers data from Rdatasets
data("AirPassengers")

# converting time series to vector for easy manipulation
AirPassengers_data = as.numeric(AirPassengers)

# plotting data for preliminary observation
plot(AirPassengers_data, type = 'l')

# scaling original data using log
log_AirPassengers = log(AirPassengers_data)
plot(log_AirPassengers, type='l')


# estimating the additive model
## eliminating linear trend (as per observation) by differencing
detrended_log_AirPassengers = detrend(log_AirPassengers)
plot(detrended_log_AirPassengers, type='l')

## finding and eliminating non-zero mean
m_tilde = mean(detrended_log_AirPassengers)
zero_mean_detrended_log_AirPassengers = detrended_log_AirPassengers - m_tilde
plot(zero_mean_detrended_log_AirPassengers, type='l')

## estimating seasonality - we know seasonality is annual, and data is for 12 years
## number of seasons M = 12
## number of periods P = 12
## therefore,can be verified as, total number of datapoints N = M*P = 144
M = 12; P = 12; 

s0 = numeric(P)

for (i in 1:M)
{
  start_index = (((i-1)*P)+1)
  end_index = i*P
  s0 = s0 + (zero_mean_detrended_log_AirPassengers[start_index:end_index])/M
}

s_unit = s0 - mean(s0)
plot(s_unit, type='l')

s = rep(s_unit, times = M)
plot(s, type='l')

w = (detrend(log_AirPassengers-s))
w = w - mean(w);
plot(w, type='l')

m = log_AirPassengers - s - w
plot(m, type='l')
