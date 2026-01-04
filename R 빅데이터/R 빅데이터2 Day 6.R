# 워크디렉토리 설정
getwd()
setwd('c:/data')

# 필요 패키지 로딩
library(readxl)
library(dplyr)
library(ggplot2)

# 데이터 읽어오기
df1 <- read_excel("2023_4.xlsx")
df1
df2 <- read_excel("2023_5.xlsx")
df3 <- read_excel("2023_6.xlsx")
df4 <- read_excel("2023_7.xlsx")
df5 <- read_excel("2023_8.xlsx")
df6 <- read_excel("2023_9.xlsx")
warnings()
df3

data_df <- rbind(df1,df2,df3,df4,df5,df6)
str(data_df)
data_df

# 결측치 확인
# 각 컬럼의 결측치 개수 확인
colSums(is.na(data_df))
data_df[!is.na(data_df$'폭염영향예보(단계)'),'폭염영향예보(단계)'] 
# '폭염영향예보(단계)' 결측치를 '보통'으로 대체
data_df$'폭염영향예보(단계)'[is.na(data_df$'폭염영향예보(단계)')] <- '보통'

library(VIM)

# KNN을 사용한 결측치 대체
data_knn <- kNN(data_df, variable = c("최고체감온도(°C)", "최고기온(°C)", "평균기온(°C)", "최저기온(°C)", "평균상대습도(%)"), k = 5)
data_knn

# knn 결측치 대체 구조 확인
str(data_knn)
# 일시~자외선지수 컬럼 선택
data_knn %>% select('일시':'자외선지수(단계)')
# 선택한 컬럼 원본 데이터로 대체
data_df <- data_knn %>% select('일시':'자외선지수(단계)')

# 이상치 확인
boxplot(data_df$`최고체감온도(°C)`)
boxplot(data_df$`최고기온(°C)`)
boxplot(data_df$`평균기온(°C)`)
boxplot(data_df$`최저기온(°C)`)
boxplot(data_df$`평균상대습도(%)`)

# 기본통계
summary(data_df)

# 범주형데이터 통계
table(data_df$`폭염여부(O/X)`)
table(data_df$`폭염특보(O/X)`)
table(data_df$`폭염영향예보(단계)`)
table(data_df$`열대야(O/X)`)
table(data_df$`자외선지수(단계)`)

# 원본 데이터 피신
data_df_incode <- data_df

# 범주형 데이터 인코딩
data_df_incode$`폭염여부(O/X)` <- ifelse(data_df_incode$`폭염여부(O/X)` == "O", 1, 0)
data_df_incode$`폭염특보(O/X)` <- ifelse(data_df_incode$`폭염특보(O/X)` == "O", 1, 0)
data_df_incode$`열대야(O/X)` <- ifelse(data_df_incode$`열대야(O/X)` == "O", 1, 0)
data_df_incode

# 순위형 데이터 인코딩
# 폭염영향예보(단계) 순서형 변환
heat_factor <- factor(data_df_incode$`폭염영향예보(단계)`, 
                      levels = c("보통", "관심", "주의", "경고", "심각"), 
                      labels = c(0, 1, 2, 3, 4))

data_df_incode$`폭염영향예보(단계)` <- heat_factor
# factor형을 숫자형으로 변환
data_df_incode$`폭염영향예보(단계)` <- as.numeric(as.character(data_df_incode$`폭염영향예보(단계)`))
data_df_incode
# 자외선지수(단계) 순서형 변환
uv_factor <- factor(data_df_incode$`자외선지수(단계)`, 
                    levels = c("낮음", "보통", "높음", "매우높음", "위험"), 
                    labels = c(0, 1, 2, 3, 4))

data_df_incode$`자외선지수(단계)` <- uv_factor
# factor형을 숫자형으로 변환
data_df_incode$`자외선지수(단계)` <- as.numeric(as.character(data_df_incode$`자외선지수(단계)`))
data_df_incode

# 상관행렬 계산
# 수치형 변수만 선택
data_df_incode[, 3:12]
data_df_incode_numeric <- data_df_incode[, 3:12]
data_df_incode_numeric

# 상관행렬 계산
cor_matrix <- cor(data_df_incode_numeric)
cor_matrix

# 상관행렬 시각화
library(ggcorrplot)

# 상관행렬 히트맵 시각화
ggcorrplot(cor_matrix, type = "full", lab = TRUE) +
  ggtitle("Correlation Matrix Heatmap for Iris Dataset") +
  theme_minimal()

data_df

library(GGally)

ggpairs(
  data_df, 
  columns = 4:8,
  mapping = aes(color = `폭염영향예보(단계)`),
  upper = list(continuous = wrap("cor", size = 3)),
  lower = list(continuous = wrap("points", alpha = 0.7, size = 0.5)),
  diag = list(continuous = wrap("densityDiag", alpha = 0.5))
)

# 의사결정나무를 이용한 폭염 단계 기준 분석
library(rpart)
library(rpart.plot)
library(caret)

# 의사결정나무 모델링
model <- rpart(`폭염영향예보(단계)` ~ `최고체감온도(°C)` + `최고기온(°C)` + `평균기온(°C)` + `최저기온(°C)` + `평균상대습도(%)`, data=data_df, method='class')

# 모델 요약
printcp(model)
summary(model)

# 의사결정나무 시각화
par(cex = 2.0)  # 텍스트 크기 조정
par(mar = c(0, 0, 0, 0) + 0.1)  # 여백 조정
rpart.plot(model)

rpart.plot(model, cex = 0.7)


# 폭염특보가 발생한 일수 (O)만 필터링
heatwave_days <- data_df[data_df$`폭염특보(O/X)` == "O", ]

# 지점별 폭염특보 발생 일수 계산
heatwave_count <- table(heatwave_days$지점)

# 데이터프레임으로 변환
heatwave_count_df <- as.data.frame(heatwave_count)
colnames(heatwave_count_df) <- c("지점", "폭염특보_일수")

# 지점별 폭염특보 발생 일수 시각화
ggplot(heatwave_count_df, aes(x = reorder(지점, -폭염특보_일수), y = 폭염특보_일수)) +
  geom_bar(stat = "identity", fill = "orange") +
  labs(title = "지점별 폭염특보 발생 일수", x = "지점", y = "폭염특보 발생 일수") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# 열대야(O/X)가 발생한 일수 (O)만 필터링
heatwave_days <- data_df[data_df$`열대야(O/X)` == "O", ]

# 지점별 폭염특보 발생 일수 계산
heatwave_count <- table(heatwave_days$지점)

# 데이터프레임으로 변환
heatwave_count_df <- as.data.frame(heatwave_count)
colnames(heatwave_count_df) <- c("지점", "열대야_일수")

heatwave_count_df

# 지점별 폭염특보 발생 일수 시각화
ggplot(heatwave_count_df, aes(x = reorder(지점, -열대야_일수), y = 열대야_일수)) +
  geom_bar(stat = "identity", fill = "orange") +
  labs(title = "지점별 열대야 발생 일수", x = "지점", y = "열대야 발생 일수") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
