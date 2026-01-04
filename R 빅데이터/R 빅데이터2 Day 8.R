# 워크 디렉토리 설정
setwd("c:/data/")

# 데이터 읽어오기
data <- read.csv("restaurant_customer_satisfaction.csv")
data

########## 데이터 설명 ##########
# CustomerID : 각 고객의 고유 식별자.
# Age : 고객의 연령.
# Gender : 고객의 성별(남성/여성).
# Income : 고객의 연간 수입(USD)
# VisitFrequency : 고객이 레스토랑을 방문하는 빈도(매일, 매주, 매달, 거의 없음).
# AverageSpend : 고객이 방문당 지출한 평균 금액(USD)입니다.
# PreferredCuisine : 고객이 선호하는 요리 유형(이탈리아, 중국, 인도, 멕시코, 미국).
# TimeOfVisit : 고객이 일반적으로 방문하는 시간대(아침, 점심, 저녁).
# GroupSize : 방문 중 고객 그룹에 포함된 사람 수입니다.
# DiningOccasion : 식사할 장소(캐주얼, 비즈니스, 축하).
# MealType : 식사 유형(매장 내 식사, 테이크어웨이)
# OnlineReservation : 고객이 온라인으로 예약을 했는지 여부(0: 아니요, 1: 예).
# DeliveryOrder : 고객이 배달을 주문했는지 여부(0: 아니요, 1: 예).
# LoyaltyProgramMember : 고객이 레스토랑의 로열티 프로그램 회원인지 여부(0: 아니요, 1: 예).
# WaitTime : 고객이 대기하는 평균 시간(분)입니다.
# ServiceRating : 서비스에 대한 고객 평가(1~5점).
# FoodRating : 고객이 음식을 평가한 점수(1~5점).
# AmbianceRating : 레스토랑 분위기에 대한 고객 평가(1~5점).
# HighSatisfaction : 고객이 매우 만족하는지(1) 또는 그렇지 않은지(0)를 나타내는 이진 변수입니다.

# 데이터 구조 확인
str(data)

########## 고객 그룹 분석 ##########
# 필요한 패키지 설치 및 로드
install.packages("dplyr")
install.packages("ggplot2")
install.packages("factoextra")  # K-means 결과 시각화를 위한 패키지
library(dplyr)
library(ggplot2)
library(factoextra)

# 필요한 변수 선택
segment_data <- data %>% select(Age, Gender, Income, VisitFrequency, AverageSpend, PreferredCuisine, GroupSize, TimeOfVisit)

# 결측치 제거
segment_data <- na.omit(segment_data)

# 레이블 인코딩
segment_data$Gender <- as.numeric(factor(segment_data$Gender))
segment_data$VisitFrequency <- as.numeric(factor(segment_data$VisitFrequency))
segment_data$PreferredCuisine <- as.numeric(factor(segment_data$PreferredCuisine))
segment_data$TimeOfVisit <- as.numeric(factor(segment_data$TimeOfVisit))

# 데이터 정규화 (K-means 클러스터링에서는 데이터 정규화가 중요)
segment_data_scaled <- scale(segment_data)

# 엘보우 방법을 사용하여 적절한 클러스터 수 찾기
fviz_nbclust(segment_data_scaled, kmeans, method = "wss") +
  labs(title = "Elbow Method for Optimal Number of Clusters")

# K-means 클러스터링 수행
set.seed(123)  # 결과의 재현성을 위해 시드 설정
kmeans_result <- kmeans(segment_data_scaled, centers = 5, nstart = 25)

# 클러스터링 결과 확인
print(kmeans_result$centers)  # 각 클러스터의 중심
print(kmeans_result$cluster)  # 각 데이터 포인트의 클러스터 할당

# 클러스터링 결과 시각화
fviz_cluster(kmeans_result, data = segment_data_scaled) +
  labs(title = "Customer Segmentation using K-means Clustering")

# 원본 데이터에 클러스터 할당 결과 추가
data$Cluster <- kmeans_result$cluster
data

# 클러스터별 평균 값 계산
cluster_summary <- data %>%
  group_by(Cluster) %>%
  summarise(
    Age = mean(Age),
    Income = mean(Income),
    AverageSpend = mean(AverageSpend),
    GroupSize = mean(GroupSize)
  )

print(cluster_summary)

########## 고객 만족도 분석 ##########
# 데이터 읽어오기
data <- read.csv("restaurant_customer_satisfaction.csv")

# 필요한 패키지 설치 및 로드
install.packages("dplyr")
install.packages("ggplot2")
install.packages("caret")  # 머신러닝을 위한 패키지
library(dplyr)
library(ggplot2)
library(caret)

# 데이터 구조 통계 확인
str(data)
summary(data)

# 결측치 처리 (필요 시)
data <- na.omit(data)

# 고객 만족도 분포 확인
table(data$HighSatisfaction)

# 만족도와 각 요인 간의 관계를 살펴보기 위한 시각화
ggplot(data, aes(x = ServiceRating, fill = factor(HighSatisfaction))) +
  geom_bar(position = "dodge") +
  labs(title = "Service Rating vs High Satisfaction", x = "Service Rating", fill = "High Satisfaction")

ggplot(data, aes(x = FoodRating, fill = factor(HighSatisfaction))) +
  geom_bar(position = "dodge") +
  labs(title = "Food Rating vs High Satisfaction", x = "Food Rating", fill = "High Satisfaction")

ggplot(data, aes(x = AmbianceRating, fill = factor(HighSatisfaction))) +
  geom_bar(position = "dodge") +
  labs(title = "Ambiance Rating vs High Satisfaction", x = "Ambiance Rating", fill = "High Satisfaction")

# 로지스틱 회귀 모델 구축
model <- glm(HighSatisfaction ~ ServiceRating + FoodRating + AmbianceRating + WaitTime + Income,
             data = data, family = binomial)

# 모델 요약 출력
summary(model)

# 데이터 분할
set.seed(123)
train_index <- createDataPartition(data$HighSatisfaction, p = 0.7, list = FALSE)
train_data <- data[train_index, ]
test_data <- data[-train_index, ]

# 로지스틱 회귀 모델 훈련
model <- glm(HighSatisfaction ~ ServiceRating + FoodRating + AmbianceRating + WaitTime + Income,
             data = train_data, family = binomial)

# 테스트 데이터에 대한 예측
predicted <- predict(model, newdata = test_data, type = "response")
predicted_class <- ifelse(predicted > 0.5, 1, 0)

# 혼동 행렬 및 정확도 계산
confusionMatrix(factor(predicted_class), factor(test_data$HighSatisfaction))

# 훈련 데이터에 대한 예측
train_data$Predicted_Prob <- predict(model, newdata = train_data, type = "response")

# 테스트 데이터에 대한 예측
test_data$Predicted_Prob <- predict(model, newdata = test_data, type = "response")

# 원래 데이터프레임에 예측된 확률을 추가 (행 병합)
train_data$Dataset <- "Train"
test_data$Dataset <- "Test"

# train_data와 test_data 병합
full_data <- rbind(train_data, test_data)

# full_data에는 이제 원래 데이터와 예측된 확률이 포함되어 있습니다.

# ggplot2를 사용한 시각화
ggplot(full_data, aes(x = ServiceRating, y = Predicted_Prob)) +
  geom_point(aes(color = factor(HighSatisfaction)), alpha = 0.6) +
  geom_smooth(method = "glm", method.args = list(family = "binomial"), se = FALSE, color = "blue") +
  labs(title = "Service Rating vs Predicted Probability of High Satisfaction",
       x = "Service Rating",
       y = "Predicted Probability of High Satisfaction",
       color = "Actual High Satisfaction") +
  theme_minimal()
