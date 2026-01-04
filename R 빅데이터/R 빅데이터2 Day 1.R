# 필요한 패키지 설치 및 로드
install.packages("e1071")
library(e1071)
library(ggplot2)

# 데이터셋 로드
data("mtcars")

# 서포트벡터모델 적합 
srv_model <- svm(mpg ~ wt + hp + disp, data=mtcars)

# 모델 요약
print(srv_model)

# 예측 
mtcars$predicted_mpg_svr <- predict(srv_model, mtcars)

# 시각화 
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point(aes(color = hp, size = disp)) +
  geom_line(aes(y = predicted_mpg_svr), color = "green", linetype = "dashed") +
  ggtitle("Support Vector Regression: Weight, Horsepower & Displacement vs. MPG") +
  xlab("Weight (1000 lbs)") +
  ylab("Miles Per Gallon (MPG)") +
  theme_minimal()

# 필요한 패키지 설치 및 로드
install.packages("caret")
library(caret)
library(dplyr)
library(ggplot2)

# 데이터 준비
data(iris)
iris_binary <- iris %>% filter(Species != "setosa")
iris_binary$Species <- factor(iris_binary$Species)

# 로지스틱 희귀 모델 적합 
model_logistic <- glm(Species ~ Sepal.length + Sepal.Width, data=iris_binary, family
                      =binomial)
                        

# 모델 요약
summary(model_logistic)

# 예측
predictions <- predict(model_logistic, iris_binary, type="response")
# 예측 확률 확인
predictions

# 예측 확률을 품종으로 치환
predicted_classes <- ifelse(predictions > 0.5, "versicolor", "virginica")

# 예측결과 확인
predicted_classes
# 실제 데이터 확인
iris_binary$Species

# 혼동행렬
table(predicted_classes, iris_binary$Species)

# 혼동 행렬 계산
confusionMartix(table(predicted_classes, iris_binary$Species))

# 결정 경계 시각화를 위한 그리드 생성
sepal_length_seq <- seq(min(iris$Sepal.Length), max(iris$Sepal.Length), by = 0.1)
sepal_width_seq <- seq(min(iris$Sepal.Width), max(iris$Sepal.Width), by = 0.1)
petal_length_seq <- seq(min(iris$Petal.Length), max(iris$Petal.Length), by = 0.1)
petal_width_seq <- seq(min(iris$Petal.Width), max(iris$Petal.Width), by = 0.1)
grid <- expand.grid(Sepal.Length = sepal_length_seq, 
                    Sepal.Width = sepal_width_seq, 
                    Petal.Length = mean(iris$Petal.Length), 
