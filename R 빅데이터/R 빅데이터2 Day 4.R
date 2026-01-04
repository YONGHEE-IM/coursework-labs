# 데이터 준비
data(iris)
x <- iris[, -5]

# PCA 수행
pca <- prcomp(x, scale. = TRUE)

# 결과 확인
summary(pca)
plot(pca$x[,1:2], col=iris$Species, pch=19, xlab='PC1', ylab='PC2' )
legend("topright", legend=levels(iris$Species), col=1:3, pch=19)

# PCA 해석
print(pca$rotation)

x <- scale(as.matrix(iris[,-5]))

# SVD 수행
svd_result <- svd(x)
summary(svd_result)

plot(svd_result$u[,1], svd_result$u[,2], col=iris$Species, pch=19, xlab='U1', ylab='U2')
legend("topright", legend=levels(iris$Species), col=1:3, pch=19)

# 필요 패키지 설치 및 로드
install.packages("MASS")
library(MASS)

iris
# LDA 수행
lda_result <- lda(Species ~ ., data=iris)
summary(lda_result)

# 시각화
plot(predict(lda_result)$x, col=iris$Species, pch=19, xlab='LD1', ylab='LD2')


install.packages("fastICA")
library(fastICA)
iris

x <- scale(as.matrix(iris[,-5]))

ica_result <-  fastICA(x, n.comp=3)

plot(ica_result$S[,1], ica_result$S[,2], col=iris$Species, pch=19, xlab='IC1', ylab='IC2')


dist_matrix <- dist(x)

mds_result <- cmdscale(dist_matrix, k=2)

plot(mds_result, col=iris$Species, pch=19, xlab='dim1', ylab='dim2')
