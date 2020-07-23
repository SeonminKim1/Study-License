# R기본

x<-c(1,2,"3")  # 화살표는 붙여써야함
x # 모두다 문자열형식으로 바뀜

rep(1, time=5) # 11111
rep(1:4, each=2) # 11223344

A<-paste("a","b","c", sep='-') # "a-b-c"
A2 <- paste(A, c("e",'f')) "a-b-c e" "a-b-c f"
length(A2) # 2

A3 <- paste(A,5,sep="") "a-b-c5"

substr("BigdataAnalysis", 1,4)
sub('Big','BigBig','BigdataAnalysis') # 문자열 대체

# 벡터의 기초통계
sd(1:5) # 표준편차

cov # 공분산
cor # 상관계수

# 괄호 치는것과 안치는게 다름.
n=3
1:n+1 # 234
1:(n+1) # 1234

# == 비교연산자 / = 대입연산자

# 벡터 (시작 1)
# 한벡터의 모든 원소는 같은 자료형 
# 위치로 인덱스 
# 원소들은 이름을 가질수 있음

# 리스트
# 여러 자료형의 원소들이 포함 가능
# 위치포 인덱스
# 원소들은 이름을 가질수 있음

# Scalar (단일값)
pi <- 3.1415

# factor 요인값
factor(c("Tom","Yoon","sib")) # 요인형 자료형

# Matrix 행렬
data<-c(7,10,11,14,15,22)
m <-matrix(data,2,3)

dim(m) # 차원정의 2 3 # 2행 3열 이라는 뜻
diag(m) # 대각선 값 반환 - 7, 14
solve(m) # 역행렬 , 단 정사각형 모양이여야 함
rownames(m)<-c('1행','2행') # 행이름 넣어주기

m2 <-matrix(1:6, 3,2) # 3행 2열 짜리 행

# 행렬 끼리의 곱
m3 = m %*% m2 # % * % / * : 동일행렬 값끼리의 곱

# 벡터 데이터 
v<-c('c','5','4','a','b')
append(v, '7', 2) # c 5 7 4 a b
v[1:3] # c 5 4 # 1부터 3까지
v[0:3] # c 5 4 - 벡터의 시작은 1부터
v[c(1,4)] # 벡터내 첫번쨰와 4번째 값 조회 # c a

# 데이터 프레임
new<-data.frame(a=c(1,2), b=c(2,3), c=c(3,4), d=c('a','b'))
new2<-data.frame(a=c(5,6), b=c(7,8), c=c(9,10), d=c('e','f'))

r = rbind(new, new2) # df 행으로 결합
cbind(new, new2) # df 열으로 결합

# 데이터 프레임 조회
r$a[(r$a)>2] # 5,6
subset(r, select=c('c','d')) # c열, d열
subset(r, select=c('c','d'), subset=r$c>5) # subset(df, 열, 조건)

# merge (df1, df2, by='공통열')
new3 <-data.frame(a=c(1,2), i=c(7,8), j=c(9,10), k=c(NA,12))
new4 <- merge(new, new3, by='a') # abcdijk 열의 2행 생성

# 열이름 바꾸기
colnames(new4) <-c('p','q','r','s','k','h','l')
new4<-na.omit(new4) # na 있는 행 삭제

# NA있을 때 결측값 나오는가?
summary(new3)

rm(new2) # 변수를 메모리에서 삭제
setwd('C:') # / 1개나 \\ 2개

head() # 6개 레코드까지 데이터 조회

v<-c(24,23,52,46,75,25)
v2<-c(13,22,56,21,19,32)
f<-factor(c('A','B','C','D','E','F'))
groups <- split(v,f) # 벡터 분리

func<-function(x){
  x=x*2
}

l<-lapply(v,func) # 리스트에 함수 적용 - 리스트 또는 행렬반환 - 세로줄의 list
m<-apply(v, 1, func) # 행렬 함수에 적용
k<-sapply(v, func) # 리스트에 함수 적용 - 벡터 또는 행렬반환 - 한줄의 벡터


z=c(1:3, NA) # 1,2,3,NA
is.na(z) # FFFT
z==NA # NA NA NA NA
c(1,1,1,2)==2 # FFFT

c(2,4) + c(3,5,6) # 오류 메세지 출력
c(3,5,7) + c(11,12,13) # 14 17 20

"+"(2,3) # 숫자 5가 출력

kk <-matrix(1:8,2,4)
as.vector(kk) # 1~8 까지의 하나의 벡터 

y = c(1,2,3,NA)
3*y # 3,6,9 NA

s<-c('Monday','Tueseday','Wednesday')
substr(s,1,2)

x1 <-c(1:5)
y1 <-seq(10,50,10)
xy <-rbind(x1,y1)
xy[1,] # 12345
xy[,1] # 1 10
rownames(xy)<-c('x1','y1','은행')

colnames(xy) <-c('1열','2열','3열','4열','5열')
apply(xy,1,sum) # 행에 대한 합
apply(xy,2,sum) # 열에 대한 합
lapply(xy, sum) # 각각의 원소에 대한 값들 나오..
sapply(xy, sum) # 각각의 원소에 대한 값들 나옴..

length('statics') # 원소 길이옴
nchar('statistics') # 문자열 자체의 길이

X<-C(1,2,3,NA)
mean(x) # NA 반환

xy = rbind(xy, c('신','우','리','하','이'))
xy = as.data.frame(xy)
class(xy) # xy

xy2 = subset(xy, subset=(xy$V1 == '신' )) # 은행 | 신 우 리 하 이 

po = c(2,4,6,8) + c(1,3,6,7,9) # 경고 메시지 출력 및 결과는 출력 3 7 12 15 11

# A반과 B반의 학생을 class 별로 합치려고 한다 R코드는?
merge(A, B, by='class')

x<-1:100 # 1 ~ 100
sum(x>50) # 50 => x>50=True라서 True의 계산값을 세야 되는 것임.




