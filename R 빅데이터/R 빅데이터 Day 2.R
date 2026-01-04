df <- data.frame(x=c(1:3),y=c(2,4,6),z=c("가","나","다"))
df

df2 <- data.frame(번호 = c(1:3), 이름 = c("김철수", "신짱구", "이훈이"), 
                 점수 = c(100, 30, 70), 주소 = c('도쿄', '오사카', '삿포로'))
df2

num <- c(1:5)
name <- c("홍길동", "김민식", "최효리", "나문세", "유영식")
jumsu <- c(80, 95, 66, 88, 90)
addr <- c("서울", "부산", "인천", "대구", "대전")

df3 <- data.frame(num, name, jumsu, addr)
df3

str(df3)

df3$name

df3[3,2]
df3[3, "name"]

df3[,c("name", "jumsu")]

df3[, 1:3]

a <- c(11:15)
b <- c(21:25)
c <- c(41:45)
x <- data.frame(a,b,c)
x

colnames(x) <- c("A제품 판매", "B제품 판매", "C제품 판매")
rownames(x) <- c("서울", "경기", "대전", "대구", "부산")
x

colSums(x)
colMeans(x)

rowSums(x)
rowMeans(x)

x <- 5
if (x%%2 == 0) {
  print("짝수")
} else {
  print("홀수")
}

x <- 30
y <- 30
if(x>y) {
  print("x가 더 큽니다.")
} else if (x<y) {
  print("y가 더 큽니다.")
} else {
  print("x와 y가 같습니다.")
}

jumsu <- 55
if (jumsu >= 90) {
  print("A학점")
} else if (jumsu >= 80) {
  print("B학점")
} else if (jumsu >= 70) {
  print("C학점")
} else if (jumsu >= 60) {
  print("D학점")
} else {
  print("F학점")
}

for (i in c(1:5)) {
  print(i)
}

for (n in name) {
  print(n)
}

for (i in c(1:10)) {
  if(i%%2 == 0) {
    print(i)
    print("짝수")
  } else {
    print(i)
    print("홀수")
  }
}

for (i in df3$num) {
  print(df3[i,])
}

for (x in 2:9) {
  cat(x, "단\n")
  for (y in 1:9) {
    cat(x,"*",y,"=",x*y, "\n")
  }
  cat("\n")
}

tot <- 0
i <- 1
while(i<=10) {
  tot <- tot + i
  i <- i + 1
}
cat("1~10 합계 :", tot)

num <- scan()

name <- scan(what=character())

# 수학 함수 예제
numbers <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
sum(numbers) 
mean(numbers)
median(numbers)
sd(numbers)
min(numbers)
max(numbers)
quantile(numbers)

# 문자열 함수 예제
str <- "Hello, R"
nchar(str)          # 출력: 8
toupper(str)        # 출력: "HELLO, R"
tolower(str)        # 출력: "hello, r"
substr(str, 1, 5)   # 출력: "Hello"
paste("Hello", "R") # 출력: "Hello R"
paste0("Hello", "R")# 출력: "HelloR"

str <- "hello. My name is kim."
substr(str,8,14)

# 논리 함수 예제
logical_vec <- c(TRUE, FALSE, TRUE,F,F,T,F,T,T,T)
any(logical_vec)  # 출력: TRUE
all(logical_vec)  # 출력: FALSE
which(logical_vec) # 출력: 1 3


df <- data.frame(
                 num=c(1:10),
                 name=c("a","b","c","d","e","f","g","h","i","j"),
                 option=c(F,F,T,F,T,T,F,T,F,F)
                 )
for(i in which(df$option)) {
  print(df[i, ])
}

df[which(df$option), ]


# 두 숫자의 합을 계산하는 함수 정의
add <- function(x, y) {
  result <- x + y
  return(result)
}

# 함수 호출
sum <- add(3, 5)
print(sum)  # 출력: 8




  