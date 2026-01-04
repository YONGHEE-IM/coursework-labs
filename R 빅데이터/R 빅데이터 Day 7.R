data("iris")
iris

dim(iris)
str(iris)
summary(iris)

# 분산(Variance) 계산
var(iris$Sepal.Length)
var(iris$Sepal.Width)
var(iris$Petal.Length)
var(iris$Petal.Width)

# 표준편차(Standard Deviation) 계산
sd(iris$Sepal.Length)
sd(iris$Sepal.Width)
sd(iris$Petal.Length)
sd(iris$Petal.Width)

# 범위(Range) 계산
range(iris$Sepal.Length)
range(iris$Sepal.Width)
range(iris$Petal.Length)
range(iris$Petal.Width)

library(ggplot2)

# 산점도 분석
ggplot(iris, aes(x = Sepal.Length, y = Petal.Length, color = Species)) +
  geom_point() +
  ggtitle("Scatter Plot of Sepal Length vs Petal Length") +
  xlab("Sepal Length") +
  ylab("Petal Length")

# 히스토그램
ggplot(iris, aes(x = Sepal.Length, fill = Species)) +
  geom_histogram(binwidth = 0.5, color = "black", position = "dodge") +
  ggtitle("Histogram of Sepal Length") +
  xlab("Sepal Length") +
  ylab("Frequency")

# 밀도 플롯
ggplot(iris, aes(x = Sepal.Length, fill = Species)) +
  geom_density(alpha = 0.5) +
  ggtitle("Density Plot of Sepal Length") +
  xlab("Sepal Length") +
  ylab("Density")

# 히스토그램과 밀도선을 함께 표시
ggplot(iris, aes(x = Sepal.Length, fill = Species)) +
  geom_histogram(aes(y = ..density..), binwidth = 0.5, color = "black", position = "dodge", alpha = 0.5) +
  geom_density(alpha = 0.2) +
  ggtitle("Histogram and Density Plot of Sepal Length") +
  xlab("Sepal Length") +
  ylab("Density")

# 박스플롯
ggplot(iris, aes(x = Species, y = Sepal.Length, fill = Species)) +
  geom_boxplot() +
  ggtitle("Boxplot of Sepal Length by Species") +
  xlab("Species") +
  ylab("Sepal Length")

getwd()
setwd("C:/DATA/")
accident <- read.csv("accident.csv", fileEncoding = "CP949")
accident

summary(accident)

ggplot(accident, aes(x = 발생년, y = 사고건수)) +
  geom_line(color = "blue") +
  geom_point(color = "red", size = 3) +
  geom_text(aes(label=사고건수), vjust = -0.5) +
  ggtitle("년도별 교통사고 사고건수") +
  xlab("발생년") +
  ylab("사고건수")

library(dplyr)
setwd("c:/data/")
data <- read.csv("불법주정차단속현황.csv")
 

# 데이터프레임에서 순번 컬럼 제거
data <- data %>% select(-순번)
data


summary(data)
freq <- table(data$차량구분)
prp <- prop.table(freq)
round(prp * 100, 2)

# 막대그래프 시각화
ggplot(data, aes(x = 차량구분, fill = 차량구분)) +
  geom_bar() +
  ggtitle("차량종류별 단속현황") +
  xlab("차량종류") +
  ylab("단속건수") +
  theme_minimal()

# 파이차트 시각화
# 빈도분석 결과 데이터 프레임으로 변환
data_freq_df <- as.data.frame(freq)
data_freq_df
colnames(data_freq_df) <- c("차량구분", "건수")

ggplot(data_freq_df, aes(x = "", y = 건수, fill = 차량구분)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y") +
  ggtitle("Pie Chart of Violations by Date") +
  theme_void() +
  theme(legend.title = element_blank())

data$위반월 <- factor(data$위반월, levels = as.character(1:12))


area_table <- table(data$단속동명) 
area_table

# 카이제곱 검증
chi_test_result <- chisq.test(area_table)
chi_test_result

data_table <- table(data$신고구분)
data.table

chi_test_result <- chisq.test(data_table)
chi_test_result

iris_table <- table(iris$Species)
iris_table
chi_test_result <- chisq.test(iris_table)

# 필요한 패키지 설치 및 로드
install.packages("tidyverse")
library(tidyverse)

# 데이터 불러오기
# 데이터 불러오기
data("mtcars")
mtcars

dim(mtcars)
str(mtcars)
summary(mtcars)

# 표본 평균과 표준 오차 계산
sample_mean <- mean(mtcars$mpg)
sample_sd <- sd(mtcars$mpg)
n <- length(mtcars$mpg)
standard_error <- sample_sd / sqrt(n)

# 95% 신뢰구간 계산
alpha <- 0.05
t_value <- qt(1 - alpha / 2, df = n - 1)
confidence_interval <- sample_mean + c(-1, 1) * t_value * standard_error

# 결과 출력
cat("표본 평균 MPG:", sample_mean, "\n")
cat("표본 표준편차:", sample_sd, "\n")
cat("표본 크기:", n, "\n")
cat("표준 오차:", standard_error, "\n")
cat("95% 신뢰구간:", confidence_interval, "\n")

subway_data <- read.csv("시간대별승하차인원.csv", fileEncoding = "CP949")
subway_data

dim(subway_data)
str(subway_data)

summary(subway_data)

# 불요 컬럼 제거
subway_data <- subway_data %>% select(-X03.04시, -X02.03시, -X01.02시)
subway_data

colnames(data_freq_df) <- c("날짜", "역명", "구분", "04", "05", "06", "07","08",
                            "09", "10", "11", "12", "13", "14", "15", "16", "17",
                            "18", "19", "20", "21", "22", "23", "00")

write.csv(subway_data, "subwaydata.csv")

