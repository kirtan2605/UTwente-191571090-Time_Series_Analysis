# Time Series Analysis Project

## Overview
This project focuses on advanced time series analysis techniques, exploring methodological approaches to characterizing and modeling time series data across different domains.

🔗 [Complete Project Report](https://github.com/kirtan2605/UTwente-191571090-Time_Series_Analysis/blob/master/TSA_Assignment_s2935848.pdf)

## Project Methodology

### Analytical Procedure
<div align="center">
  <img src="https://raw.githubusercontent.com/kirtan2605/UTwente-191571090-Time_Series_Analysis/master/images/Procedure.png" width="600">
</div>

Key steps in the analysis:
- Eliminate trend and seasonal components
- Mathematical modeling of incidental component
- Residual analysis
- Model verification using white noise test

## Case Studies

### 1. Dow Jones Index Analysis

#### Time Series Characteristics
<div align="center">
  <img src="https://raw.githubusercontent.com/kirtan2605/UTwente-191571090-Time_Series_Analysis/master/images/Dow_Jones_1.png" width="800">
</div>

#### Correlation and Model Selection
<div align="center" style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px;">
  <img src="https://raw.githubusercontent.com/kirtan2605/UTwente-191571090-Time_Series_Analysis/master/images/Dow_Jones_2.png" width="100%">
  <img src="https://raw.githubusercontent.com/kirtan2605/UTwente-191571090-Time_Series_Analysis/master/images/Dow_Jones_AIC.png" width="100%">
</div>

**Key Findings:**
- Multiplicative model with underlying variation
- Autocorrelation Function (ACF) shows weak geometric decay
- Partial Autocorrelation Function (PACF) cuts off after 1-lag
- Suggested Model: ARIMA(1,0,0)

**Final Model Equation:**
$$
X_t = 0.9966 X_{t-1} + \epsilon_t
$$
- White noise variance: 0.0007594
- Residuals considered white noise

#### Residual Analysis
<div align="center">
  <img src="https://raw.githubusercontent.com/kirtan2605/UTwente-191571090-Time_Series_Analysis/master/images/Dow_Jones_3.png" width="800">
</div>

### 2. ECG Signal Analysis

#### Correlation Analysis
<div align="center">
  <img src="https://raw.githubusercontent.com/kirtan2605/UTwente-191571090-Time_Series_Analysis/master/images/ECG_1.png" width="800">
</div>

#### Model Selection
<div align="center">
  <img src="https://raw.githubusercontent.com/kirtan2605/UTwente-191571090-Time_Series_Analysis/master/images/ECG_AIC.png" width="800">
</div>

**Key Findings:**
- ACF shows decaying pattern (AR component present)
- PACF displays slight decay
- Best Models: ARMA(4,5) and ARMA(5,4)

**Final Model Equation:**
$$
X_t = 1.1436 X_{t-1} + 0.4225 X_{t-2} − 0.943 X_{t-3} + 0.318 X_{t-4} + 0.57 \epsilon_{t-1} − 0.4815 \epsilon_{t-2} − 0.4158 \epsilon_{t-3} − 0.3354 \epsilon_{t-4} − 0.0905 \epsilon_{t-5} + \epsilon_t
$$

#### Residual Analysis
<div align="center">
  <img src="https://raw.githubusercontent.com/kirtan2605/UTwente-191571090-Time_Series_Analysis/master/images/ECG_2.png" width="800">
</div>

## Key Techniques
- Time Series Decomposition
- ARIMA Modeling
- Autocorrelation Analysis
- Akaike Information Criterion (AIC)
- Residual White Noise Testing

## Tools and Technologies
- R Programming
- Time Series Analysis Libraries
- Statistical Modeling
- Signal Processing Techniques

## Contact
[Your Contact Information]
