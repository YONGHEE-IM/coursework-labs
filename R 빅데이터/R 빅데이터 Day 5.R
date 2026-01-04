data1 <- data.frame(ID = 1:5, name = c("alice", "bob", "charlie", "david", "eva"),
age = c(25, 30, 35, 40, 45))
            
data2 <- data.frame(ID = 3:7, Score = c(88,92,95,80,85), 
                   grade=c("B","A","A","C","B"))

data3 <- data.frame(ID = 6:10, name = c("frank", "grace", "helen", "ian", "jack"),
                    age = c(50,55,60,65,70))

# 데이터셋 확인
data1
data2                
data3

# 데이터 병합 
# 내부 조인 (inner join)
merged_data_inner <- merge(data1, data2, by = "ID")
merged_data_inner

merged_data_left <- merge(data1, data2, by = "ID", all.x = TRUE)
merged_data_left

merged_data_right <- merge(data1, data2, by ="ID", all.y = TRUE)
merged_data_right

merged_data_all <- merge(data1, data2, by = "ID", all = TRUE)
merged_data_all

# 데이터 결합 행
bind_data_row <- rbind(data1, data3)
bind_data_row

# 데이터 결합 열 
bind_data_col <- cbind(data1, data2) 
bind_data_col

# 데이터 통합 연습
# data1, data2, data3 을 하나의 data로 통합하세요

# 데이터 행 결합
bind_data_row <- rbind(data1, data3)
bind_data_row

# 왼쪽 조인으로 데이터 결합
merged_data_left <- merge(bind_data_row, data2, by = "ID", all.x = TRUE)
merged_data_left

mean(merged_data_left$Score, na.rm = T)

# 예제 데이터 프레임 생성
data <- data.frame(
  ID = c(1, 2, 3, 4, 2, 5, 3, 6, 7, 8, 5),
  Name = c("Alice", "Bob", "Charlie", "David", "Bob", "Eva", "Charlie", "Frank", "Grace", "Hannah", "Eva"),
  Age = c(25, 30, 35, 40, 30, 45, 35, 50, 55, 60, 45)
)

data

duplicates <- duplicated(data)
duplicates

data[duplicates,]

data_unique <- data[!duplicated(data), ]
data_unique

# VIM 패키지 설치 및 로드
install.packages("VIM")
library(VIM)

# 예제 데이터셋 생성
set.seed(123)
data <- data.frame(
  Age = sample(c(20:50, NA), 100, replace = TRUE),
  Height = sample(c(150:200, NA), 100, replace = TRUE),
  Weight = sample(c(50:100, NA), 100, replace = TRUE),
  Score = sample(c(60:100, NA), 100, replace = TRUE)
)

# 결측치 시각화
aggr(data, col = c('navyblue', 'red'), numbers = TRUE, sortVars = TRUE, labels = names(data), cex.axis = .7, gap = 3, ylab = c("Missing data", "Pattern"))

# 결측치 위치 시각화
matrixplot(data, main = "Matrix Plot of Missing Data", col = c("navyblue", "red"))

# 결측치 대체 (KNN)
data_imputed <- kNN(data, variable = c("Age", "Height", "Weight", "Score"), k = 5)

# 대체 후 데이터 확인
summary(data_imputed)

# 결측치 대체 (IRMI)
data_imputed_irmi <- irmi(data)

# 대체 후 데이터 확인
summary(data_imputed_irmi)

# dplyr 패키지 설치 및 로드
install.packages("dplyr")
library(dplyr)

# 예제 데이터 프레임 생성
data <- data.frame(
  ID = 1:5,
  Name = c("Alice", "Bob", "Charlie", "David", "Eva"),
  Age = c(25, 30, 35, 40, 45),
  Score = c(90, 85, 88, 92, 95)
)

# 데이터셋 확인
print(data)

# select(): Name과 Score 열 선택
selected_data <- select(data, Name, Score)
print(selected_data)

# filter(): Age가 30 이상인 행 선택
filtered_data <- filter(data, Age >= 30)
print(filtered_data)

# arrange(): Age를 기준으로 오름차순 정렬
arranged_data <- arrange(data, Age)
print(arranged_data)

# Score를 기준으로 내림차순 정렬
arranged_data_desc <- arrange(data, desc(Score))
print(arranged_data_desc)

# mutate(): 새로운 변수 Grade 추가
mutated_data <- mutate(data, Grade = ifelse(Score >= 90, "A", "B"))
print(mutated_data)

# summarise(): 평균 Age와 평균 Score 계산
summary_data <- summarise(data, Avg_Age = mean(Age), Avg_Score = mean(Score))
print(summary_data)

# group_by(): Grade별로 그룹화하고 평균 Score 계산
grouped_data <- data %>%
  mutate(Grade = ifelse(Score >= 90, "A", "B")) %>%
  group_by(Grade) %>%
  summarise(Avg_Score = mean(Score))
print(grouped_data)

# 추가 데이터 프레임 생성
data2 <- data.frame(
  ID = 3:7,
  Subject = c("Math", "Science", "English", "History", "Art")
)

# inner_join: 공통된 ID를 기준으로 결합
inner_join_data <- inner_join(data, data2, by = "ID")
print(inner_join_data)

# left_join: data를 기준으로 결합
left_join_data <- left_join(data, data2, by = "ID")
print(left_join_data)

# right_join: data2를 기준으로 결합
right_join_data <- right_join(data, data2, by = "ID")
print(right_join_data)

# full_join: 모든 행을 결합
full_join_data <- full_join(data, data2, by = "ID")
print(full_join_data)

# reshape2 패키지 설치 및 로드
install.packages("reshape2")
library(reshape2)

# 예제 데이터 프레임 생성
data <- data.frame(
  ID = 1:5,
  Time = c("Morning", "Afternoon", "Evening", "Night", "Morning"),
  Value1 = c(10, 20, 30, 40, 50),
  Value2 = c(5, 15, 25, 35, 45)
)

data

# 데이터를 긴 형식으로 변환
data_melted <- melt(data, id.vars = c("ID", "Time"))
print(data_melted)

# 데이터를 넓은 형식으로 변환
data_casted <- dcast(data_melted, ID + Time ~ variable)
print(data_casted)

# 간단한 데이터 생성
counts <- c(10, 20, 30, 40, 50)

# 막대차트 그리기
barplot(counts, 
        names.arg = c("A", "B", "C", "D", "E"),
        col = "red",
        border = 1,
        horiz = T,
        main = "Simple Bar Plot",
        xlab = "Categories",
        ylab = "Values")

# 간단한 데이터 생성
data <- c(4.5, 2.3, 5.7, 3.8, 4.1)
names(data) <- c("A", "B", "C", "D", "E")

# 점 차트 그리기
dotchart(data, 
         main = "Simple Dot Chart", 
         xlab = "Values", 
         ylab = "Categories", 
         color = c("blue","red"))

set.seed(123)
data <- rnorm(1000, mean = 50, sd = 10)  # 평균 50, 표준편차 10인 정규분포 데이터 생성

# 히스토그램 그리기 (빈도)
hist(data, 
     breaks = 20,  # 막대(bin)의 수를 20개로 설정
     main = "Histogram with 20 Bins", 
     xlab = "Values", 
     ylab = "Frequency", 
     col = "lightblue", 
     border = "black")

# 히스토그램 그리기 (밀도)
hist(data, 
     breaks = 20, 
     main = "Histogram with Density", 
     xlab = "Values", 
     ylab = "Density", 
     col = "lightgreen", 
     border = "black", 
     freq = FALSE)

# 밀도 곡선 추가
lines(density(data), col = "red", lwd = 2)

