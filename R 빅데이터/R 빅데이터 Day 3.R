install.packages("readxl")
installed.packages("readxl")

library(readxl)
search()

update.packages()
remove.packages("readxl")
search()

# 폴더 위치 설정
setwd("C:/DATA/")
getwd()

# csv 파일 읽어오기
df1 <- read.csv("students_list.csv", header = F)
df1

df2 <- read.table("students_list.txt", sep=" ", header = T)
df2

install.packages("readxl")
library(readxl)
search()
getwd()
sl_excel <- read_excel(path = "students_list.xlsx", sheet="students_list")
sl_excel

sl_excel2 <- read_excel(path = "students_list.xlsx", sheet="Sheet1", skip=2)
sl_excel2

sl_excel2 <- read_excel(path = "students_list.xlsx", sheet="Sheet1", skip=2, 
                        range = "A3:E7")
sl_excel2

accident <- read.csv("accident.csv", fileEncoding="CP949")
accident
