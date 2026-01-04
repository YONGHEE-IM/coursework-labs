getwd()
setwd("c:/data/")

data <- read.csv("practice.csv")
data

# 결측치 확인 1
colSums(is.na(data))

# 결측치 포함 행 확인
data[!complete.cases(data),]

# 결측치 제거(행)
data_no_na <-na.omit(data)
data_no_na

# 대부분의 데이터가 결측치로 채워진 컬럼 추가
set.seed(123)
data$Age
data$MostNa <- c(rep(NA,90), sample(1:5,10, replace=T))
data
tail(data)
edit(data)

colSums(is.na(data))

subset(data, select=-MostNa)
data <- subset(data, select=-MostNa)
data


# 결측치 데이터 대체
# 평균값으로 대체 
colSums(is.na(data))

round(mean(data$Age, na.rm=T))

data_mean <- data
data_mean

# 컬럼별 NA에 평균값 대체 
data_mean$Age[is.na(data_mean$Age)] <- round(mean(data_mean$Age, na.rm=T))
data_mean

round(mean(data$Height, na.rm=T))

data_mean$Height[is.na(data_mean$Height)] <- round(mean(data$Height, na.rm=T))
data_mean

colSums(is.na(data_mean))


# VIM 패키지 설치 및 로드
install.packages("VIM")
library(VIM)

data

data_knn <- kNN(data, variable=c("Age", "Height", "Weight", "Score1", "Score2", "Score3", "Income", "Expenses", "Satisfaction"), k=5)

data_knn
data

# 대체된 데이터 확인
data_knn[,c("ID","Age", "Height", "Weight", "Score1", "Score2", "Score3", "Income","Expenses", "Satisfaction" )]
data_knn

set.seed(123)
data <- data.frame(
  ID = 1:100,
  Age = c(sample(20:50, 95, replace = TRUE), 200, 210, 220, 230, 240),
  Score = c(rnorm(95, mean = 70, sd = 10), 10, 20, 30, 40, 50)
)

data

# 박스 플롯을 사용한 이상치 탐지
boxplot(data$Age, main = "Boxplot of Age")
boxplot(data$Score, main = "Boxplot of Score")

# IQR 방법을 사용한 이상치 탐지
Q1 <- quantile(data$Age, 0.25)
Q3 <- quantile(data$Age, 0.75)
IQR <- Q3 - Q1

# 위아래 경계값
lower_bound <- Q1 - 1.5 * IQR
upper_bound <- Q3 + 1.5 * IQR

age_outlier <- data$Age[data$Age < lower_bound | data$Age > upper_bound]

data_clean <- data[data$Age >= lower_bound & data$Age <= upper_bound, ]
data_clean

data_mean <- data
data_mean$Age[data_mean$Age < lower_bound | data$Age > upper_bound] <- round(mean
(data_mean$Age, na.rm =T))
data_mean

# 원-핫 인코딩을 위한 패키지 설치 및 로드
install.packages("caret")
library(caret)

search()

# 데이터 프레임 생성
df <- data.frame(
  ID = 1:5,
  Color = c("Red", "Blue", "Green", "Blue", "Red")
)

# 원-핫 인코딩 적용
df_onehot <- dummyVars("~ Color", data = df)
df_transformed <- data.frame(predict(df_onehot, newdata = df))
df_transformed
