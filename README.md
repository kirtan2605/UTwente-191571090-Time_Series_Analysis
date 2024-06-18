# Time Series Analysis
The assignment deals with characterizing time series data by eliminating the trend and seasonal component followed by the mathematical modeling of the incidental component. The verification of the model is done by analyzing the residual. A white noise residual implies that the model has sufficient accuracy. The assignment deals with performing the above mentioned procedure using R.

<p align="center">
  <img src="https://github.com/kirtan2605/UTwente-191571090-Time_Series_Analysis/blob/master/images/Procedure.png" style="width:500px; height:auto; float:left;">
  <div style="clear:both; margin-bottom:200px;"></div>
</p>

# Dow Jones Index Analysis
The increase in variation over time in the Dow Jones Index data implies an underlying multiplicative model. The model is then reduced to an additive time series and analysed further.

<p align="center">
  <img src="https://github.com/kirtan2605/UTwente-191571090-Time_Series_Analysis/blob/master/images/Dow_Jones_1.png" style="width:500px; height:auto; float:left;">
  <div style="clear:both; margin-bottom:200px;"></div>
</p>

The Autocorrelation Function (ACF) and Partial Autocorrelation Function (PACF) plots help us analyse the data correlations and estimate the order of ARMA process.

<p align="center">
  <img src="https://github.com/kirtan2605/UTwente-191571090-Time_Series_Analysis/blob/master/images/Dow_Jones_2.png" style="width:500px; height:auto; float:left;">
  <div style="clear:both; margin-bottom:200px;"></div>
</p>

The ACF plot displays weak geometric decay (can be seen by plotting the ACF till 500) whereas the PACF cuts off after 1-lag (0-lag has not been plotted). This suggests an AR(1) model or an ARMA(1,0) model. For the arima() function it implies an ARIMA(1,0,0) Model. This can further be verified using the Akaike Information Criterion (AIC) presented for different models.

<p align="center">
  <img src="https://github.com/kirtan2605/UTwente-191571090-Time_Series_Analysis/blob/master/images/Dow_Jones_3.png" style="width:500px; height:auto; float:left;">
  <div style="clear:both; margin-bottom:200px;"></div>
</p>


Thus, the best estimate for a model is
$$
X_t = 0.9966 X_{t-1} + \epsilon_t
$$
with $\epsilon_t$ being a zero-mean white noise with variance $0.0007594$

<p align="center">
  <img src="https://github.com/kirtan2605/UTwente-191571090-Time_Series_Analysis/blob/master/images/Dow_Jones_4.png" style="width:500px; height:auto; float:left;">
  <div style="clear:both; margin-bottom:200px;"></div>
</p>


The residual analysis shows that the residuals can be considered as white noise. The mean is 4.297635e-05, and can be considered to be negligible. The ACF Plot confirms that the residuals are indeed white noise. The ACF Plot deplays only 1 peak, at 0-lag, while the others can be considered insignificant, since they lie below the significance interval.
