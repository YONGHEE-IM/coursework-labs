# 필요한 패키지 설치 및 로드
install.packages("forecast")
library(forecast)

# 데이터셋 로드 
data("AirPassengers")
ts_data <- AirPassengers
ts_data
plot(ts_data)

# 시계열 데이터 분해
decompose_ts <-  decompose(ts_data)
decompose_ts
plot(decompose_ts)


# 자기상관 분석 ACF PACF
acf(ts_data)
pacf(ts_data)

# ARIMA 모델 적합
fit <- auto.arima(ts_data)
summary(fit)

# 예측
forecasted <- forecast(fit, h = 12)
plot(forecasted)


# 패키지 설치 및 로드
install.packages("quantmod")
library(quantmod)

# 주가 데이터 가져오기(APPLE)
getSymbols("AAPL",src="yahoo", from="2023-01-01", to="2023-12-31")
AAPL
plot(AAPL)

close_price <- Cl(AAPL)

# 시계열 객체로 변환
close_ts <- ts(close_price, frequency=252)

# 시계열 데이터 시각화
plot(close_ts, main="애플 주가", xlab="Date", ylab="Price")

# 이동평균(MA)
ma_5 <- SMA(close_ts, n=5)
ma_20 <- SMA(close_ts, n=20)
ma_120 <- SMA(close_ts, n=120)

# 이동평균 시각화
chartSeries(AAPL, TA = "addSMA(n=120,col='blue')", theme = chartTheme("white"))

# 자기 상관 분석 ACF PACF
acf(close_ts)
pacf(close_ts)

# ARIMA 모델 훈련
arima_model <- auto.arima(close_ts)

# 모델 요약
summary(arima_model)

# 예측
forecasted_value <- forecast(arima_model, h=20)
forecasted_value
plot(forecasted_value, main="ARIMA 모델 예측")


library(ggplot2)

# 주가 데이터 가져오기(AMAZON)
getSymbols("AMZN",src="yahoo", from="2018-01-01", to="2023-12-31")
amazon_df <- data.frame(date=index(AMZN), coredata(AMZN))

# 시각화
ggplot(amazon_df, aes(x=date, y=AMZN.Close)) +
  geom_line(color='blue') +
  labs(title='Amazon 주가', x='Date', y='AMZN.Close') +
  theme_minimal()

library(dplyr)
library(zoo)
library(ggplot2)

# 이동편균 계산 컬럼 추가
amazon_df <- amazon_df %>%
  mutate(
    ma5 = rollmean(close, 5, fill=NA, align="right"),
    ma20 = rollmean(close, 20, fill=NA, align="right"),
    ma60 = rollmean(close, 60, fill=NA, align="right"),
    ma120 = rollmean(close, 120, fill=NA, align="right"),
    ma250 = rollmean(close, 250, fill=NA, align="right")
  )

amazon_df

# 결측치 제거
amazon_df <- amazon_df %>% drop_na()

# 학습 및 평가 데이터 분리
train_index <- 1:(nrow(df) * 0.8)
train_data <- amazon_df[train_index, ]
test_data <- amazon_df[-train_index, ]

# 희귀모델 훈련
model <- train(AMZN.close ~ ma5 + ma20 + ma60 + ma120 + ma250, data=amazon_df, method="lm")
summary(model)

# 예측
y_pred <- predict(model, test_data)

# 모델 평가
mse <- mean((test_data$AMZN.Close - y_pred)^2)
mse

# 실제값과 예측값 비교 시각화
test_data$predict <- y_pred
ggplot(test_data, aes(x = date)) +
  geom_line(aes(y=AMZN.Close, color='blue')) + 
  geom_line(aes(y=predict, color='red'), linetype = 'dashed') +
  labs(title="실제값과 예측값 비교", x='date', y='종가') +
  theme_minimal()



new_df <- data.frame(c(152.5,152.13,141.13,137.65,135.0),c('ma5','ma20','ma60','ma120','ma250'))
new_df <- data.frame(ma5=152.5,ma20=152.13,ma60=141.13,ma120=137.65,ma250=135.0)
new_df

predict(model, newdata=new_df)
