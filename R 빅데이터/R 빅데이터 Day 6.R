install.packages("ggplot2")
library(ggplot2)

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


qplot(data, geom="histogram", main="히스토그램")

# 기본 데이터 생성
x <- rnorm(50)  # 평균 0, 표준편차 1인 정규분포를 따르는 50개의 난수 생성
y <- rnorm(50)

# 산점도 그리기
plot(x, y, main = "Simple Scatter Plot", xlab = "X-axis", ylab = "Y-axis",lwd=5, pch = 20, col = "blue")

# 기본 데이터 생성
set.seed(123)  # 재현성을 위해 시드 설정
data <- rnorm(100)  # 평균 0, 표준편차 1인 정규분포를 따르는 100개의 난수 생성

# 데이터에 이상치 추가
data <- c(data, rnorm(5, mean = 3, sd = 0.5))  # 평균 3, 표준편차 0.5인 이상치 5개 추가

# 박스 플롯 그리기 (이상치 표시)
boxplot(data, main = "Box Plot with Outliers", ylab = "Values")

# 기본 데이터 생성
set.seed(123)  # 재현성을 위해 시드 설정
data <- matrix(rnorm(100), nrow = 10, ncol = 10)  # 10x10 행렬 생성

# 히트맵 그리기
heatmap(data, main = "Simple Heatmap")

install.packages("treemap")
library(treemap)

# 간단한 데이터셋 생성
data <- data.frame(
  group = c("A", "B", "C", "D"),
  value = c(10, 20, 30, 40)
)

# 트리맵 그리기
treemap(data,
        index = "group",
        vSize = "value",
        title = "Simple Treemap")

# treemap 패키지에서 제공하는 GNI2014 데이터셋 로드
data(GNI2014)

# 트리맵 그리기
treemap(GNI2014,
        index = c("continent", "iso3"),
        vSize = "population",
        vColor = "GNI",
        type = "index",
        palette = "HCL",
        title = "Treemap of Global Population and GNI")

# 패키지 설치 및 로드
install.packages("tm")
install.packages("wordcloud")
library(tm)
library(wordcloud)

install.packages("ggplot2")
install.packages("sf")
library(ggplot2)
library(sf)


daejeon_map <- st_read("c:/data/인구정보1세단위.shp")
daejeon_map

ggplot(data=daejeon_map) +
  geom_sf() +
  geom_sf(aes(fill=CNT))+
  geom_sf_text(aes(label = STTY_END_N), size=3, color="white") +
  scale_fill_viridis_c(option="plasma") + 
  ggtitle("대전광역시 동구") +
  theme_minimal()

korea_map <- st_reaad("c:/data/ctprvn.shp")
korea_map

ggplot(data=korea_map) +
  geom_sf() +
  geom_sf_text
