library(ggplot2)
library(dplyr)
library(tidyverse)

setwd("C:/data/")
subway_data <- read.csv("시간대별승하차인원.csv", fileEncoding = "CP949")
subway_data

# 불요 컬럼 제거
subway_data <- subway_data %>% select(-역번호, -X03.04시, -X02.03시, -X01.02시)
subway_data

# 컬럼명 수정
colnames(subway_data) <- c("날짜", "역명", "구분", "04", "05","06", "07", "08", "09", "10", "11",
                           "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22",
                           "23","00")

# 시간대 피봇용 컬럼 백터
time_columns <- c(sprintf("%02d", 4:23), "00")
time_columns

# 원본 데이터 시간대로 피봇
time_data <- subway_data %>%
  group_by(구분) %>%
  summarise(across(all_of(time_columns), ~ sum(.x, na.rm = TRUE), .names = "sum_{.col}")) %>%
  pivot_longer(cols = starts_with("sum_"), names_to = "시간대", values_to = "승객수")
time_data

# 데이터프레임으로 변환
time_data = as.data.frame(time_data)
time_data

# 문자를 숫자로 변환
time_data$시간대 <- as.numeric(time_data$시간대)
time_data

# 시각화
# 산점도 확인
ggplot(time_data, aes(x = 시간대, y = 승객수, color = 구분, group = 구분)) +
  geom_point() +
  ggtitle("시간대별 승객수") +
  xlab("시간대") +
  ylab("승객수")


# 시각화 
ggplot(time_data, aes(x = 시간대, y = 승객수, color = 구분, group = 구분)) + 
  geom_line() +
  geom_point() +
  labs(title = "시간대별 승객 분포", x = "시간대", y = "승객 수") +
  theme_minimal()


# 아이리스 데이터셋 로드
data("iris")

# 산점도 확인
ggplot(iris, aes(x = Sepal.Length, y = Petal.Length, color = Species)) +
  geom_point() +
  ggtitle("Scatter Plot of Sepal Length vs Petal Length") +
  xlab("Sepal Length") +
  ylab("Petal Length")

# 피어슨 상관계수 계산
cor(iris$Sepal.Length, iris$Petal.Length, method="pearson")

# 스피어만 상관계수 계산
cor(iris$Sepal.Length, iris$Petal.Length, method="spearman")

# 켄달 상관계수 계산
cor(iris$Sepal.Length, iris$Petal.Length, method="kendall")

# 상관행렬 계산
# 수치형 변수만 선택
iris
iris_numeric <- iris[, 1:4]
iris_numeric

# 상관행렬 계산
cor_matrix <- cor(iris_numeric)
cor_matrix

# 상관행렬 시각화
# 상관분석 시각화용 패키지 설치 및 로드
install.packages("ggcorrplot")
library(ggcorrplot)

# 상관행렬 히트맵 시각화
ggcorrplot(cor_matrix, type = "full", lab = TRUE) +
  ggtitle("Correlation Matrix Heatmap for Iris Dataset") +
  theme_minimal()

# 다양한 상관분석 시각화 패키지
# corrgram
install.packages("corrgram")
library(corrgram)

corrgram(iris) # 단순 히트맵 시각화
corrgram(iris, lower.panel=panel.conf) # 하단 상관계수 상단 히트맵 동시 시각화
corrgram(iris, lower.panel=panel.pts, diag.panel = panel.density, upper.panel = panel.fill)

# PerformanceAnalytics
install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)

chart.Correlation(iris_numeric)

# GGally
install.packages("GGally")
library(GGally)

ggpairs(
  iris, 
  columns = 1:4, 
  mapping = aes(color = Species),
  upper = list(continuous = wrap("cor", size = 3)),
  lower = list(continuous = wrap("points", alpha = 0.7, size = 0.5)),
  diag = list(continuous = wrap("densityDiag", alpha = 0.5))
)

data("mtcars")
mtcars
mtcart_matrix <- cor(mtcars)
mtcart_matrix

ggcorrplot(mtcart_matrix, type = "full", lab = TRUE) +
  ggtitle("Correlation Matrix Heatmap for Iris Dataset") +
  theme_minimal

chart.Correlation(mtcart_matrix)

# 시드 설정
set.seed(2024)

# 데이터 생성
x <- 2 * runif(100, 0, 1)
y <- 4 + 3 * x + runif(100, 0, 1)

# 데이터프레임으로 변환
data <- data.frame(x = x, y = y)
data

# 산점도 시각화
ggplot(data, aes(x = x, y = y)) +
  geom_point() +
  ggtitle("Scatter Plot of x and y") +
  xlab("x") +
  ylab("y") +
  theme_minimal()

# 선형 회귀 모델 적합
model <- lm(y ~ x, data = data)

# 모델 요약
summary(model)

# 기울기와 절편 출력
cat("기울기:", coef(model)[2], "\n")
cat("절편:", coef(model)[1], "\n")

# 회귀 분석 시각화
ggplot(data, aes(x = x, y = y)) +
  geom_point(color = 'red', size = 2) +
  geom_abline(intercept = coef(model)[1], slope = coef(model)[2], color = 'orange') +
  ggtitle("Linear Regression: x vs. y") +
  xlab("x") +
  ylab("y") +
  theme_minimal()

# 단순 선형 회귀 모델 적합
model_simple <- lm(mpg ~ wt, data = mtcars)

# 모델 요약
summary(model_simple)

# 회귀선 추가한 시각화
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE) +
  ggtitle("Simple Linear Regression: Weight vs. MPG") +
  xlab("Weight (1000 lbs)") +
  ylab("Miles Per Gallon (MPG)") +
  theme_minimal()

# 다중 선형 회귀 모델 적합
model_multiple <- lm(mpg ~ wt + hp, data = mtcars)

# 모델 요약
summary(model_multiple)

# 예측된 값을 포함한 시각화
mtcars$predicted_mpg <- predict(model_multiple, mtcars)

ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point(aes(color = hp)) +
  geom_line(aes(y = predicted_mpg), color = "orange", linetype = "dashed") +
  ggtitle("Multiple Linear Regression: Weight & Horsepower vs. MPG") +
  xlab("Weight (1000 lbs)") +
  ylab("Miles Per Gallon (MPG)") +
  theme_minimal()