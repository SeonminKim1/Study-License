######################################################### 5-2 시각화 R버전 ##############################################################
install.packages("ggplot2")
library(ggplot2)

data("ChickWeight"); data("mtcars"); data(economics); data("diamonds")


# aes (그래프 축 지정), colour(data) 표현 Diet를 Chick으로 group 지어서  diet 값들 표현
graph<-ggplot(ChickWeight, aes(x=Time, y=weight, colour=Diet, group=Chick))
# graph <- graph +geom_line() # geom_line() 선 그래프 그리기 없으면 아무것도 안나옴
# graph <- graph + geom_point(alpha=.3) # geom_point() 포인트형태로 나오고 투명도 설정
# graph <- graph + geom_smooth(alpha=.4, size=3) # geom_smooth (연결된 직선 배경의 투명도와, 선의 굵기 출력)
# graph <- graph + geom_point(alpha=.3) + geom_smooth(size=3) # 합쳐서도 가능

# 히스토그램 = 도수 분포표를 그래프로 나타낸 것
# 분포가 연속적인 값이고 선으로 되어있어서 내용을 파악하기 어렵거나 분류 유형이 많을 경우 히스토그램을 이용하여 쉽게 파악
# subset = Time 변수가 21인 것들만
graph2 = ggplot(subset(ChickWeight, Time=21), aes(x=weight, fill=Diet))

# black 막대의 테두리 색상 = black
# facet_grid(Diet ~.) : 가로로 출력 가로로 꽉차고 세로로 분할 / facet_grid(.~Diet) : 세로로 출력 세로로 꽉차고 가로로 분할됨
# graph2 <- graph2 + geom_histogram(colour='black', binwidth=50) + facet_grid(Diet ~.) # 히스토그램 가로로 꽉차고 세로로 분할
graph2

## 포인트 그래프 = 포인트 그래프는 가장 간단하게 데이터를 정적으로 보여주며, 유형별로 색상을 다르게하여 특성을 파악할 수 있음.
## 데이터 건수가 너무 많으면 복잡성만 올라갈 뿐 아니라 내용 파악이 불가능한 경우들 발생, 데이터 랜덤 추출 or 특정 건수만 보는 방법 적용 가능
p = qplot(data=mtcars, wt, mpg, colour = hp)
p+coord_cartesian(ylim=c(0,40)) # y축 범위 지정
p+scale_colour_continuous(breaks=c(100,300)) # hp의 범위를 100에서 300사이로 지정하는 옵션
p+guides(colour = 'colourbar') # hp의 수치에 따른 색의 범위르 랑ㄹ려줌

c <- ggplot(mtcars, aes(factor(cyl)))
c + geom_bar() # 막대그래프를 그리는 함수
c + geom_bar(fill='white', colour='red') # fill=막대의 내부 색상 / colur=막대의 테두리 색상

library(ggplot2movies)
m = ggplot(movies, aes(x=rating)) # 
m + geom_histogram(aes(fill=..count..)) # 

## 선 그래프 : 시간의 흐름에 따른 등락을 보기 쉽기 때문에 주로 시계열 지표에서 많이 쓰임
b = ggplot(economics, aes(x=date, y=unemploy)) + geom_line() # 기본 선그래프
b + geom_line(colour='blue', size=0.3, linetype=3) # linetype 1-실선, 2-선이 긴 점선, 3-선이 짧은 점선, 4-선이 길고 짧음이 반복되는 점선

## 효과주기
k <-ggplot(diamonds, aes(carat, ..density..)) + geom_histogram(binwidth=0.2)
k + facet_grid(.~cut) # 

# 점선 그래프 (오른쪽 위로 올라가는 점선 그래프)
df <-data.frame(x=1:10, y=1:10)
f <-ggplot(df, aes(x=x, y=y)) + geom_line(linetype='dotdash')
f

# 포인트 그래프 - 원형 모양의 점 생김
## 투명도를 조절하면 실제 어디에 값이 많이 분포하는지를 쉽게 파악할 수 있다
df = data.frame(x=rnorm(5000), y=rnorm(5000))
h = ggplot(df, aes(x,y))
h + geom_point(alpha=1/10)

## 요인별 분포를 보다 쉽게 알아보기 위한 방법으로 요인별 색 할당, 모양 할당, 크기 할당 등 방법이 있다.
p <-ggplot(mtcars, aes(wt, mpg)) # 아무포인트 안줬을 때
p + geom_point(aes(colour = factor(cyl)), size=4) # 색별로 요인 구분
p + geom_point(aes(shape=factor(cyl), size=4)) # 모양별로 요인 구분 - 흑백이여도 구분하기 쉬움
p + geom_point(aes(size=qsec)) # 점 크기별로 요인 구분

## geom_point(size) vs geom_point(aes(size=qsec)) -> 원의 기본 크기 or 요인별 구분하느냐
p + geom_point(size=2.5) + geom_hline(yintercept=25, size=3.5) # 임의의 선 삽입
# p + geom_pointrange() 선형 모델링 으로 나온 결과를 point range 그래프로 표현 하는 방법

# 포인트 그래프 박스로 강조
p <-ggplot(mtcars, aes(wt, mpg)) + geom_point()
p + annotate("rect", xmin=2, xmax=3.5, ymin=2, ymax=25, fill='dark gray', alpha=.5) # 박스로 해당 영역 강조

# 축의 범위 지정해서 원하는 범위만 그래프를 그림
p <-qplot(disp, wt, data=mtcars) + geom_smooth()
p + scale_x_continuous(limits=c(325, 500))

# Boxplot
box <- qplot(cut, price, data=diamonds, geom='boxplot') # 가운데 가로선은 중앙값(median), 아래선은 1사분위수, 상단선은 4사분위수 / 세로선 윗부분은 이상값으로 측정 된 부분
box
box + coord_flip() # box plot 눕혀서 출력

# qplot을 적용한 막대그래
qplot(cut, data=diamonds, geom='bar')

# 다축 그래프 생성시 -> 
# points(time, pop, pch=20, col='black') 함수 이용해서 크기 20마다 점 찍기 가능
# par(new = T) # 그래프 추가 한다는 것 -> 뒤에 plot( ~~ ) 작성 가능
# legend() 범례지정

library(aplpack) # 줄기-잎 그림, 체르노프 페이스, 스타차트 등의 시각화 방법 제공
score = c(1,2,3,4,10,2,30,42,31,25,40,37,34,22,33,44)
stem.leaf(score) # 줄기 - 잎 그림

faces(WorldPhones) # 체르노프 페이스
starts(WorldPhones) # 별 그림

### 공간분석 - 구글 비즈에서 지원하는 다양한 그래프 -> R그래프보다 보기 좋고, 움직이는 그래프도 가능
# install.packages("googleVis")
library(googleVis)
## 모션차트 - 그래프 축과 관련된 시간과 id 변수 지정 -> 웹브라우저가 열리면서 그래프 생성 및 인터렉티브 작동
data(Fruits)
M1 <- gvisMotionChart(Fruits, idvar="Fruit", timevar="Year")
plot(M1)

# 구글 비즈 2 - 지오차트
# gvisGeoChart(data, locationvar="", colorvar="", sizevar="", hovervar="", options = list(), chartid)

G1 <- gvisGeoChart(Exports, locationvar = 'Country', colorvar = 'Profit') # 국가별 수출, 수익크기를 색상으로 구분
plot(G1)

# 유럽 지역으로 한정하여, 수익 크기를 색상으로 구분하는 방법
# locationvar, colorvar 각각 임.
G2 <- gvisGeoChart(Exports, "Country", "Profit", options=list(region="150")) # 수익크기를 색상으로 구분하는 방법 (유럽한정)
plot(G2)

G3 <- gvisGeoChart(Andrew, "LatLong", colorvar = "Speed_kt", options=list(region='US'))
plot(G3)

head(Andrew)
G4 <- gvisGeoChart(Andrew, "LatLong", sizevar = "Speed_kt", colorvar = "Pressure_mb", options=list(region='US'))
plot(G4)

# 고정 데이터 읽어오기
library(XML)
url <-"https://en.wikipedia.org/wiki/List_of_countries_by_credit_rating"
x<-readHTMLTable(readLines(url), which=3, header=T)

# 가변 데이터 읽어오기
url <-"https://ds.iris.edu/seismon/eventlist/index.phtml"
eq <-readHTMLTable(readLines(url), colClasses=c("factor", rep("numeric", 4), "factor"))$evTable
names(eq) <- c("DATE", "LAT","LON","MAG", "DEPTH", "LOCATION_NAME", "IRIS_ID")

eq$loc = paste(eq$LAT, eq$LON, sep=":")
G9 <- gvisGeoChart(eq, "loc", "DEPTH", "MAG", options=list(displayMode="Markers", colorAxis="{colors:['purple', 'red', 'orange', 'grey']}",
                                                           backgroundColor="lightblue"), chartid='EQ')
G9

## 모자이크 플롯(mosaic plot)은 복수의 categorical variable 분포 파악에 도움이 되는 시각화 방법.
## 제한적인 특징이 있지만 , EDA 진행시 두 변수의 구조적 특징을 파악할 수 있고, 핵심 내용을 보다 간단하게 전달할 수 있다는 장점이 있다.

# install.packages("vcd")
library(vcd)
mosaic(Titanic, shaed= T, legend=T) # 집단 색상 추가
strucplot(Titanic, pop=F) # 특정 집단만
grid.edit("rect:Class=1st, Sex=Male, Age=Adult, Survived=Yes", gp=gpar(fill="red")) # 특정 집단만 색상 추가 가능
