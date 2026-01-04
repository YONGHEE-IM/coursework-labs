# 필요한 패키지 설치 및 로드
install.packages("neuralnet")
library(neuralnet)
install.packages("MASS")
library(MASS)

# 보스턴 주택 가격 데이터셋 로드
data("Boston")

# 데이터 준비 (데이터프레임으로 변환)
boston <- Boston
boston$medv <- scale(boston$medv)
boston <- data.frame(scale(boston))

# 훈련 데이터와 테스트 데이터 분할
set.seed(123)
train_index <- sample(1:nrow(boston), 0.8 * nrow(boston))
train_data <- boston[train_index, ]
test_data <- boston[-train_index, ]

# 모델 정의 및 학습
set.seed(123)
formula <- medv ~ .
model_neuralnet <- neuralnet(formula, data = train_data, hidden = c(5, 3), linear.output = TRUE)

# 예측
predictions_neuralnet <- compute(model_neuralnet, test_data[, -14])$net.result
predictions_neuralnet 

# 모델 평가
mse_neuralnet <- mean((test_data$medv - predictions_neuralnet)^2)
cat("MSE (neuralnet):", mse_neuralnet, "\n")

# 예측 값 시각화
plot(test_data$medv, predictions_neuralnet, xlab = "실제값", ylab = "예측값", main = "neuralnet: Actual vs Predicted")
abline(0, 1, col = "red")

# 모델 시각화
plot(model_neuralnet)

# 필요한 패키지 설치 및 로드
install.packages("neuralnet")
install.packages("caret")
library(neuralnet)
library(caret)

# iris 데이터셋 로드 및 전처리
data(iris)
iris$setosa <- ifelse(iris$Species == "setosa", 1, 0)
iris$versicolor <- ifelse(iris$Species == "versicolor", 1, 0)
iris$virginica <- ifelse(iris$Species == "virginica", 1, 0)
iris$Species <- NULL

iris

# 훈련 데이터와 테스트 데이터 분할
set.seed(123)
train_index <- createDataPartition(iris$setosa, p = 0.8, list = FALSE)
train_data <- iris[train_index, ]
test_data <- iris[-train_index, ]
test_data
train_data

# 모델 정의 및 학습
set.seed(123)
formula <- setosa + versicolor + virginica ~ sepal.Length + Sepal.Width + Petal.Length +
  Petal.Width
model_neuralnet <- neuralnet(formula, data=train_data, hidden=c(5,5), linear.output=F)

# 예측
perdictions_neuralnet <- compute(model_neuralnet, test_data[,1:4])$net.result
predicted_classes <- apply(predictions_neuralnet, 1, which.max)
predicted_classes <- factor(predicted_classes, levels=1:3, labels=c("setosa", "versicolor",
                                                                    "virginica"))

# 실제 클래스 
actual_classes <- factor(apply(test_data[,5:7],1,which.max), levels=1:3, labels=c
                         ("setosa", "versicolor", "virginica"))

# 혼동 행렬 계산
conf_matrix <- confusionMatrix(predicted_classes, actual_classes)
print(conf_matrix)
                          
# 모델 시각화
plot(model_neuralnet)

# 패키지 설치 및 로드
install.packages("keras")
library(keras)

# 데이터셋 로드
boston_housing <- dataset_boston_housing()
x_train <- boston_housing$train$x
y_train <- boston_housing$train$y
x_test <- boston_housing$test$x
y_test <- boston_housing$test$y

# 데이터 스케일링
x_train <- scale(x_train)
x_test <- scale(x_test)

# 모델 정의
model <- keras_model_sequential() %>%
  layer_dense(units=64, activation='relu', input_shape=dim(x_train)[2]) %>%
  layer_dense(units=32, activation='relu') %>%
  layer_dense(units=1)

model %>% compile(
  loss='mse',
  optimizer=optimizer_rmsprop(),
  metrics=c('mae')
)

# 모델 학습 
history <- model %>% fit(
  x_train, y_train, epochs=100,
  batch_size=32, 
  validation_split=0.2
)

# 모델 평가
score <- model %>% evaluate(x_test, y_test)
score

plot_model(model, to_file="model.png", show_shapes=T, show_layer_names=T)
plot(model)

library(keras)
library(caret)

data(iris)

iris$Species <- as.factor(iris$Species)
y <- to_categorical(as.integer(iris$Species) - 1)
y

x <- scale(as.matrix([, -5]))

# 훈련 데이터, 테스트 데이터 분할
set.seed(123)
train_index <- createdDataPartition(iris$Species, p=0.8, list=F)
x_train <- x[train_index, ]
y_train <- y[train_index, ]
x_test <- x[-train_index, ]
y_test <- y[-train_index, ]

model <- keras_model_sequential() %>%
  layer_dense(unit=64, activation = 'relu', input_shape = ncol(x_train)) %>%
  layer_dense(unit=32, activation = 'relu') %>%
  layer_dense(unit=3, activation = 'softmax')

model %>% compile(
  loss = 'categorical_crossentropy',
  optimizer = optimizer_adam(),
  metrics = c('accuracy')
)

history <- model %>% fit(
  x_train, y_train, epochs=256, batch_size=5, validation_split = 0.2)
)

