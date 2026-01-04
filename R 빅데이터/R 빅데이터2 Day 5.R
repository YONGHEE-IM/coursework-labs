getwd()
setwd("c:/data/")
# 필요한 패키지 설치 및 로드
library(readxl)

# 데이터셋 불러오기
retail_df <- read_excel("Online Retail.xlsx")
retail_df

# 데이터 구조 확인
str(retail_df)

# 데이터 통계정보
summary(retail_df)

# 결측치 확인
sum(is.na(retail_df))

# 각 컬럼의 결측치 개수 확인
colSums(is.na(retail_df))

# 결측치가 있는 Description을 가진 행 식별
missing_description <- retail_df[is.na(retail_df$Description),] 
matching_description_list <-list()
for(i in 1:nrow(missing_description)){
  stock_code <- missing_description$StockCode[i]
  matching_rows <- retail_df[retail_df$StockCode == stock_code,c("StockCode","Description")]
  matching_description_list[[i]]<- matching_rows
}
matching_description_list


# 결측치가 있는 행들을 식별
missing_description <- is.na(retail_df$Description) 
retail_df$Description[missing_description] <- sapply(retail_df$StockCode[missing_description], function(stock_code) {
  non_missing_description <- retail_df$Description[retail_df$StockCode == stock_code & !is.na(retail_df$Description)] 
  if(length(non_missing_description) > 0) { return(non_missing_description[1]) } 
  else { return(NA) }
})

colSums(is.na(retail_df))

missing_description_records <- retail_df[is.na(retail_df$Description),]
print(missing_description_records)

# Description 열에 결측치가 있는 행들을 제거
retail_df <- retail_df[!is.na(retail_df$Description),]# 결측치가 제대로 제거되었는지 확인
colSums(is.na(retail_df))

# CustomerID가 결측치인 행의 수 계산
missing_customer_id_count <-sum(is.na(retail_df$CustomerID))# 전체 행 수 계산
total_count <- nrow(retail_df)# 결측치 비율 계산 (퍼센트로)
missing_percentage <-(missing_customer_id_count / total_count)*100# 결과 출력
print(paste("CustomerID가 결측치인 데이터의 비율:",round(missing_percentage,2),"%"))

# CustomerID가 결측치인 부분을 '비회원'으로 대체
retail_df$CustomerID[is.na(retail_df$CustomerID)]<-"비회원"

# 이상치 탐지
boxplot(retail_df$Quantity, main = "Boxplot of Quantity")
boxplot(retail_df$UnitPrice, main = "Boxplot of UnitPrice")

# 최대값 최소값 계산
max_quantity <-max(retail_df$Quantity)
min_quantity <-min(retail_df$Quantity)
# 최대값을 가진 레코드 출력
max_quantity_records <- retail_df[retail_df$Quantity == max_quantity,]
print("Quantity의 최대값을 가진 레코드:")
print(max_quantity_records)
# 최소값을 가진 레코드 출력
min_quantity_records <- retail_df[retail_df$Quantity == min_quantity,]
print("Quantity의 최소값을 가진 레코드:")
print(min_quantity_records)
# 최소값을 가진 레코드 삭제
retail_df <- retail_df[!(retail_df$Quantity == max_quantity | retail_df$Quantity == min_quantity),]

# 상품코드가 "84826"이면서 단가가 0인 데이터 삭제
retail_df[retail_df$StockCode =="84826"& retail_df$UnitPrice ==0,]
retail_df <- retail_df[!(retail_df$StockCode =="84826"& retail_df$UnitPrice ==0),]

# 가격이 0인 데이터 삭제
retail_df <- retail_df[!retail_df$UnitPrice == 0,]

# 상품명이 'AMAZON FEE'인 데이터 삭제
retail_df[retail_df$Description == 'AMAZON FEE',]
retail_df <- retail_df[!retail_df$Description == 'AMAZON FEE',]

# 상품단가를 내림차순 검색해서 10개 추출
retail_df[order(-retail_df$UnitPrice),][1:10,]

# 상품명이 'DOTCOM POSTAGE' 인 데이터 삭제
retail_df[retail_df$Description == 'DOTCOM POSTAGE',]
retail_df <- retail_df[!retail_df$Description == 'DOTCOM POSTAGE',]

# 상품명이 'POSTAGE' 인 데이터 삭제
retail_df[retail_df$Description == 'POSTAGE',]
retail_df <- retail_df[!retail_df$Description == 'POSTAGE',]

# 상품명이 'Manual' 인 데이터 삭제
retail_df[retail_df$Description == 'Manual',]
retail_df <- retail_df[!retail_df$Description == 'Manual',]

# 상품명이 'Discount', 'CRUK Commission', 'Bank Charges'
retail_df <- retail_df[!retail_df$Description == 'Discount',]
retail_df <- retail_df[!retail_df$Description == 'CRUK Commission',]
retail_df <- retail_df[!retail_df$Description == 'Bank Charges',]

# 상품명이 'SAMPLES' 삭제
retail_df[retail_df$Description == 'SAMPLES',]
retail_df <- retail_df[!retail_df$Description == 'SAMPLES',]


library(ggplot2)
# StockCode별 총 판매량 계산
total_quantity_by_stock <- aggregate(Quantity ~ StockCode, data = retail_df,sum)
# 총 판매량 상위 20개의 StockCode 시각화
top_20_quantity <- total_quantity_by_stock[order(-total_quantity_by_stock$Quantity),][1:20,]
# Bar plot 시각화
ggplot(top_20_quantity, aes(x = reorder(StockCode,-Quantity), y = Quantity))+
  geom_bar(stat ="identity", fill ="steelblue")+
  labs(title ="Top 20 StockCodes by Total Quantity Sold", x ="StockCode", y ="Total Quantity")+
  theme(axis.text.x = element_text(angle =45, hjust =1))


retail_df[retail_df$StockCode == '22107',]
retail_df[retail_df$StockCode == '84077',]
retail_df[retail_df$StockCode == '84077',]

# StockCode별 총 판매량 계산
total_quantity_by_stock <- aggregate(Quantity ~ StockCode + Description, data = retail_df,sum)
# 총 판매량 상위 20개의 StockCode 시각화 (Description 포함)
top_20_quantity <- total_quantity_by_stock[order(-total_quantity_by_stock$Quantity),][1:20,]

# Bar plot 시각화 (x축을 Description으로)
ggplot(top_20_quantity, aes(x = reorder(Description,-Quantity), y = Quantity))+
  geom_bar(stat ="identity", fill ="steelblue")+
  labs(title ="Top 20 Products by Total Quantity Sold", x ="Product Description", y ="Total Quantity")+
  theme(axis.text.x = element_text(angle =45, hjust =1), axis.title.x = element_blank())

# StockCode별 총 판매량 계산 (Description 포함)
total_quantity_by_stock <- aggregate(Quantity ~ StockCode + Description, data = retail_df,sum)
# 총 판매량이 가장 적은 하위 20개의 StockCode 시각화 (Description 포함)
bottom_20_quantity <- total_quantity_by_stock[order(total_quantity_by_stock$Quantity),][1:20,]

# Bar plot 시각화 (x축을 Description으로)
ggplot(bottom_20_quantity, aes(x = reorder(Description, Quantity), y = Quantity))+
  geom_bar(stat ="identity", fill ="red")+
  labs(title ="Bottom 20 Products by Total Quantity Sold", x ="Product Description", y ="Total Quantity")+
  theme(axis.text.x = element_text(angle =45, hjust =1), axis.title.x = element_blank())


# Quantity가 0 이상인 데이터만 필터링
filtered_retail_df <- retail_df[retail_df$Quantity >0,]
# StockCode별 총 판매량 계산 (Description 포함)
total_quantity_by_stock <- aggregate(Quantity ~ StockCode + Description, data = filtered_retail_df,sum)
# 총 판매량이 가장 적은 하위 20개의 StockCode 시각화 (Description 포함)
bottom_20_quantity <- total_quantity_by_stock[order(total_quantity_by_stock$Quantity),][1:20,]

# Bar plot 시각화 (x축을 Description으로)
ggplot(bottom_20_quantity, aes(x = reorder(Description, Quantity), y = Quantity))+
  geom_bar(stat ="identity", fill ="red")+
  labs(title ="Bottom 20 Products by Total Quantity Sold (Quantity > 0)", x ="Product Description", y ="Total Quantity")+
  theme(axis.text.x = element_text(angle =45, hjust =1), axis.title.x = element_blank())

# StockCode별 총 판매량 계산
total_quantity_by_stock <- aggregate(Quantity ~ StockCode + Description, data = retail_df,sum)

# 가장 많이 팔린 상품 식별
most_sold_product <- total_quantity_by_stock[which.max(total_quantity_by_stock$Quantity),]
most_sold_stockcode <- most_sold_product$StockCode

# 가장 많이 팔린 상품의 데이터 필터링
most_sold_product_data <- retail_df[retail_df$StockCode == most_sold_stockcode,]
# InvoiceDate를 월별로 변환
most_sold_product_data$Month <- format(as.Date(most_sold_product_data$InvoiceDate),"%Y-%m")
# 월별 총 판매량 계산
monthly_sales <- aggregate(Quantity ~ Month, data = most_sold_product_data,sum)
# 월별 판매량 정렬
monthly_sales <- monthly_sales[order(monthly_sales$Month),]

# 월별 판매량 시각화
ggplot(monthly_sales, aes(x = Month, y = Quantity, group =1))+
  geom_line(color ="blue", size =1)+
  geom_point(color ="red", size =2)+
  labs(title = paste("Monthly Sales Trend of the Most Sold Product:", most_sold_product$Description),
       x ="Month", y ="Quantity Sold")+
  theme(axis.text.x = element_text(angle =45, hjust =1))

## 장바구니 분석
# Quantity가 0 이상인 데이터만 필터링
retail_df_filtered <- retail_df[retail_df$Quantity >0,]
# 필요한 열만 선택 (CustomerID와 Description)
retail_df_basket <- retail_df_filtered[,c("CustomerID","Description")]
# CustomerID와 Description에서 NA 값 제거
retail_df_basket <- na.omit(retail_df_basket)

# arules 패키지 설치 및 로드 (이미 설치한 경우 이 부분은 생략 가능)
library(arules)
# CustomerID를 기준으로 Description을 장바구니 형태로 변환
transactions <- as(split(retail_df_basket$Description, retail_df_basket$CustomerID),"transactions")
# 변환된 데이터를 요약하여 확인
summary(transactions)

# 변환된 데이터의 일부를 확인
inspect(head(transactions,5))

# Apriori 알고리즘을 사용하여 연관 규칙 생성# 최소 지지도(support)와 신뢰도(confidence)를 설정
rules <- apriori(transactions, 
                 parameter =list(supp =0.01, conf =0.5))# 생성된 규칙 요약
summary(rules)

# 상위 10개의 연관 규칙을 확인
inspect(sort(rules, by ="lift")[1:10])

# 특정 조건을 만족하는 규칙 필터링 (예: 신뢰도(confidence)가 0.7 이상)
filtered_rules <- subset(rules, confidence >0.7)
# 필터링된 규칙 중 상위 10개를 lift 기준으로 정렬하여 확인
inspect(sort(filtered_rules, by ="lift")[1:10])
