# hello_shiny
shinyUI(pageWithSidebar(
  headerPanel("Hello shiny!"),
  sidebarPanel(
    sliderInput("obs", # inputID
                "Number of observations:", # 컴포넌트에 쓰일 ID
                min=1, # obs의 값 1부터 1000 , default 500
                max=1000,
                value=500)),
  mainPanel( 
    plotOutput("distplot")) # plot 으로 보여주고 싶을때 plotOutput
)
)

shinyServer(function(input, output){
  output$distPlot<-renderPlot({ # renderPlot - Plot 그려라
    dist <-rnorm(input$obs)
    hist(dist)
  })
})

## Input과 Output사용 - ShinyUI
## input과 output으로 id들을 만들고 그 안에 설정된 데이터나 그래프 등을 주고 받는다.
shinyUI(pageWithSidebar(
  headerPanel("Miles Per Gallon"),
  sidebarPanel(
    selectInput("variable","Variable: ",
                list("Cylinders" = "cyl",
                     "Transmission" = "am",
                     "Geers" = "gear")),
    checkboxInput("outliers", "show outliers", FALSE)
  ),
  mainPanel( h3(textOutput("caption")),
             plotOutput("mpgPlot")
  )
))

## Input과 Output 사용 - shinyServer
# checkboxㄹ를 설치하면 mainPanel의 boxplot에 outlier가 나타난다.
# outlier 속성을 지정했고, input 값으로 ui에서 checkboxInput에 outlier라는 id값을 미리 설정했기에 좀더 동적인 그래프로 바뀜
shinyServer(function(input, output){
  formulaText<-reactive({
    paste("mpg ~", input$variable)
  })
  output$caption <-renderText({
    formulatText()
  })
  
  output$mpgPlot<-renderPlot({
    boxplot(as.formula(formulaText()),
            data = mpgData,
            outline=input$outliers) # outlier 속성을 지정했고
  })
})

## Slider : 샤이니는 html기반의 다양한 컴포넌트 제공 - slider 컴포넌트
shinyUI(pageWithSidebar(
  headerPanel("Sliders"),
  sidebarPanel(
    sliderInput("integer","integer:", min=0, max=1000, value=500), # 가장 단순한 형태의 슬라이드바
    sliderInput("range","Range:", min=1, max=1000, value=c(200,500)), # 특정 구간 선택
    sliderInput('animation', 'looping animation:', 1, 2000, 1, animate=animationOptions(interval=300, loop=T))바 # 슬라이더바가 자동으로 움직이게
  ),
  mainPanel(
    tableOutput("values")
  )
))

shinyServer(function(input, output){
  SliderValues <-reactive({ # 동적으로 움직일수 있는 부부
    data.frame(
      Name=c("Integer", # ui.R에서 지정해놨던 값들 넣음.
             "Range",
             "Animation"),
      Value = as.character(c(input$integer, input$decimal, paste(input$range, collapse=' '), input$format, input$animation)),
      stringAsFactors=FALSE)
  })
  output$values <-renderTable({분 # Slider Vlaue의 변하는 값들을 mainPanel 값에 적용되게 할수 있음.
    SliderValues()
  })
})

## Tabsets : 한 화면에 탭을 만들어 탭별로 다른 그래프나 테이블을 보여줄수 있게 하는 것.
shinyUI(pageWithSidebar(
  headerPanel("Tabsets"),
  sidebarPanel(
    radioButtons("dist","Distribution type : ",
                 list("Normal" = "norm",
                      "Uniform" = "unif",
                      "Log-normal" = "lnorm",
                      "Exponential" = "exp")),
    br(),
    sliderInput("n", "Number of observations: ",
                value=500, min=1 ,max=1000)),
  mainPanel(
    tabsetPanel(
      tabPanel("Plot", plotOutput("plot")), # 각각의 Tab이 독립적이도록 만들어줌
      tabPanel("Summary", verbatimTextOutput("summary")),
      tabPanel("Table", tableOutput("table"))
    )
  )
))

## Tabsets  - shinyServer
# Tabsets의 tabPanel선택 여부에 따라서 선택한 분포 그래프가 나타남

shinyServer(function(input, output){
  data<-reactive({
    dist<-switch(input$dist, norm=rnorm, unif=runif, lnorm=rnorm, exp=rexp, rnorm) # 정규분포, 균등분포, 로그노말분포, 지수분포를 랜덤하게 새성해주는 함수
    # ui.R에서 받아온 n값을 적용해, n의 갯수만큼 랜덤하게 만들어 dist라는 id설정해 input값에 적용
    dist(input$n)
  })
  output$plot<-renderPlot({
    dist<-input$dist
    n<-input$n
    hist(data(), main=paset('r', dist, '(',n,')',sep=''))
  })
  output$summary<-renderPrint({
    summary(data())
  })
})

# dataTable (합쳐서 작성 가능, 코드 관리를 위해 나눠서 자성할 것)

runApp(list(
  ui=basicPage(
    h2('The mtcars data'),
    dataTableOutput('mytable')
  ),
  server = function(input, output){
    output$mytable = renderDataTalbe({
      mtcars
    })
  }
)
)

## moreWidget 위젯
shinyUI(pageWithSidebar(
  headerPanel("More Widget"),
  sidebarPanel(
    selectInput("dataset", "Choose a dataset: ",
                choices=c("rock","pressure","cars")),
    numericInput("obs","Number of observations to view: ", 10),
    helpText("Note : WHile `~~ the data sibal will show"),
    submitButton("Updata View")
  ),
  mainPanel(
    h4("Summary"), # <br>태그나 <h4> 태그등도 사용 가능
    verbatimTextOutput("summary"), # summary 함수 출력결과내용
    h4("Observations"),
    tableOutput("view")) 
)
)

shinySrver(function(input, output){
  datasetInput <-reactive({ # function을 만들어주고 보여주길 워하는 Plot, Table Print, text들은 renderPlot, renderTable, renderPrint, renderText 등으로 붙여준다.
    switch(input$dataset,
           "rock"=rock,
           "pressure"=pressure,
           "cars"=cars)
  })
  output$summary<-renderPrint({
    dataset<-datasetInput()
    summary(dataset)
  })
  output$view<-renderTable({
    head(datasetInput(), n=input$obs)
  })
})

## downloadButton이나, uploading_Files로 read.csv사용해서 도 가능
## HTML.ui로 작성하고 SERVER.R 조합도 가능 -> shinyApp(ui=htmlTemplate('index.html'),server) 라는 문구 추가로 돌림


