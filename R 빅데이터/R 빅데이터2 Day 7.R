install.packages("readxl")
library(readxl)
setwd("c:/data/")

data <- read_excel("2023년 신입생 충원 현황 및 중도탈락 학생수.xlsx", col_names = F, skip=6)
data

names(data) <- c("기준연도","학교종류","설립구분","지역","상태","학교","입학정원","모집인원_계","모집인원_정원내","모집인원_정원외","지원자_계","지원자_정원내","지원자_정원외","입학자_계","입학자_정원내_남","입학자_정원내_여","입학자_정원외_남","입학자_정원외_여","정원내신입생충원율","중도탈락학생","졸업자","취업자")
data

str(data)
summary(data)
colSums(is.na(data))
print(data[!complete.cases(data),], n=Inf, width=Inf)

install.packages("dplyr")
library(dplyr)

data <- data %>% select(-`졸업자`,-`취업자`)
print(data, n=Inf, width=Inf)

# 두 변수의 기초 통계량 확인
summary(data$중도탈락학생)
summary(data$지원자_계)

# 상관계수 계산
correlation <- cor(data$중도탈락학생, data$지원자_계, use = "complete.obs")

# 상관계수 출력
print(paste("중도탈락학생 수와 지원자 수 간의 상관계수: ", round(correlation, 2)))

# ggplot2 패키지 설치 및 로드 (이미 설치된 경우 생략 가능)
install.packages("ggplot2")
library(ggplot2)

# 산점도 그리기
ggplot(data, aes(x = 지원자_계, y = 중도탈락학생)) +
  geom_point(color = "blue", alpha = 0.6) +
  labs(title = "중도탈락학생 수와 지원자 수 간의 관계",
       x = "지원자 수",
       y = "중도탈락학생 수") +
  geom_smooth(method = "lm", color = "red", se = FALSE) +
  theme_minimal()

boxplot(data$지원자_계)
boxplot(data$중도탈락학생)

# 데이터프레임을 긴 형식으로 변환
data_long <- data.frame(
  변수 = rep(c("지원자_계", "중도탈락학생"), each = nrow(data)),
  값 = c(data$지원자_계, data$중도탈락학생)
)

# ggplot2를 사용하여 Boxplot 생성
ggplot(data_long, aes(x = 변수, y = 값, fill = 변수)) +
  geom_boxplot() +
  labs(title = "지원자 수와 중도탈락학생 수의 Boxplot 비교",
       x = "변수",
       y = "값") +
  theme_minimal()

# IQR 방법을 사용한 이상치 탐지
Q1 <- quantile(data$중도탈락학생, 0.25)
Q3 <- quantile(data$중도탈락학생, 0.75)
IQR <- Q3 - Q1

lower_bound <- Q1 - 1.5 * IQR
upper_bound <- Q3 + 1.5 * IQR

중탈_outliers <- data$중도탈락학생[data$중도탈락학생 < lower_bound | data$중도탈락학생 > upper_bound]
중탈_outliers

# 이상치 제거후 박스플롯 확인
data <- data[data$중도탈락학생 >= lower_bound & data$중도탈락학생 <= upper_bound, ]
boxplot(data$중도탈락학생)

print(data[data$중도탈락학생 < lower_bound | data$중도탈락학생 > upper_bound, ], n=Inf, width=Inf)

# 입학자 수 대비 중도탈락학생 수를 분석
# 중도탈락률 계산
data$중도탈락률 <- (data$중도탈락학생 / data$입학자_계) * 100

# 중도탈락률 요약 통계 확인
summary(data$중도탈락률)

# 탈락률 100%이상
print(data[data$중도탈락률 > 100,], n=Inf, width=Inf)

# 탈락률 10% 미만
print(data[data$중도탈락률 < 10,], n=Inf, width=Inf)

# 중도탈락률 히스토그램
ggplot(data, aes(x = 중도탈락률)) +
  geom_histogram(binwidth = 5, fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "입학자 수 대비 중도탈락학생 수의 분포",
       x = "중도탈락률 (%)",
       y = "학교 수") +
  theme_minimal()

# 설립구분별 중도탈락률 비교
ggplot(data, aes(x = 설립구분, y = 중도탈락률, fill = 설립구분)) +
  geom_boxplot() +
  labs(title = "설립구분별 입학자 수 대비 중도탈락률 비교",
       x = "설립구분",
       y = "중도탈락률 (%)") +
  theme_minimal()

# 지역별 중도탈락률 비교
ggplot(data, aes(x = 지역, y = 중도탈락률, fill = 지역)) +
  geom_boxplot() +
  labs(title = "지역별 입학자 수 대비 중도탈락률 비교",
       x = "지역",
       y = "중도탈락률 (%)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # 지역명이 많을 경우, 텍스트 회전

# 필요 시, 범주형 변수(예: 설립구분, 지역)를 더미 변수로 변환
data$설립구분 <- as.factor(data$설립구분)
data$지역 <- as.factor(data$지역)

set.seed(123)  # 재현성을 위해 시드 설정

# 데이터 분할
index <- sample(1:nrow(data), 0.7 * nrow(data))
train_data <- data[index, ]
test_data <- data[-index, ]

# 선형 회귀 모델 생성
model <- lm(중도탈락학생 ~ 입학자_계 + 지원자_계 + 설립구분 + 지역, data = train_data)

# 모델 요약 출력
summary(model)

# 테스트 데이터로 예측
predictions <- predict(model, newdata = test_data)

# 실제 값과 예측 값 비교
results <- data.frame(Actual = test_data$중도탈락학생, Predicted = predictions)

# 평균 제곱근 오차(RMSE) 계산
rmse <- sqrt(mean((results$Actual - results$Predicted)^2))
print(paste("RMSE:", round(rmse, 2)))

newdata <- data[data$학교 == "국립공주대학교",]
predict(model, newdata = newdata)
data[data$학교 == "국립공주대학교","중도탈락학생"]

# 새로운 데이터 입력
new_data <- data.frame(
  기준연도 = "2023",
  학교종류 = "대학교",
  설립구분 = "사립",
  지역 = "대전",
  상태 = "기존",
  학교 = "대전대학교",
  입학정원 = 100,
  모집인원_계 = 150,
  모집인원_정원내 = 100,
  모집인원_정원외 = 50,
  지원자_계 = 300,
  지원자_정원내 = 150,
  지원자_정원외 = 100,
  입학자_계 = 100,
  입학자_정원내_남 = 30,
  입학자_정원내_여 = 20,
  입학자_정원외_남 = 0,
  입학자_정원외_여 = 0,
  정원내신입생충원율 = 167,
  중도탈락학생 = NA  # 예측할 대상
)

# 기존 학습 데이터와 같은 변수만 선택 (목표 변수는 제외)
new_data_for_prediction <- new_data[, c("입학자_계", "지원자_계", "설립구분", "지역", "학교종류")]

# 범주형 변수 인코딩 (학습 데이터와 동일하게 변환)
new_data_for_prediction$설립구분 <- as.factor(new_data_for_prediction$설립구분)
new_data_for_prediction$지역 <- as.factor(new_data_for_prediction$지역)
new_data_for_prediction$학교종류 <- as.factor(new_data_for_prediction$학교종류)

predict(model, newdata = new_data_for_prediction)
