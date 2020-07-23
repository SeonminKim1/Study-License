########################################## 막대차트그리기 ##############################

var width=500; var height=200;

# 차트 객체 생성
var svg=d3.select("#chart")
        .append("svg")
        .attr('width',width)
        .attr('height',height);
        
# 데이터 입력
var dataset = [5,10,13,19,21,25,22,18,15,13]
var padding = 20;

# 차트 스케일 정의
var y = d3.scale.linear()
                .domain([0,d3.max(dataset)])
                .range([height-padding+5, 5])
var x = d3.scale.linear()
                .domain([0, dataset.length])
                .range([padding,width])

# 차트에 막대 추가하기
svg.selectAll('rect')
        .data(datset)
        .enter()
        .append('rect')
        .attr('y', function(d){ return x(i);})
        .attr('y', function(d){ return y(d); })
        .attr('width', function(d,i){ return parseInt((width-padding)/dataset.length) -1; })
        .attr('height', function(d){ return height -y(d)-padding; })
        .attr('fill', 'blue');

# 차트에 레이블 추가
svg.selectAll('text')
        .data(dataset)
        .enter()
        .apend('text')
        .text(function(d){ return d; })
        .attr('x', function(d,i){ return parseInt(x(i)) + 1;})
        .attr('y', function(d){ return y(d) + 10})
        .attr('font-size', '10px')
        .attr('fill','white')

# 차트에 축 추가
var xAxis = d3.svg.axis().scale(x).orient('bottom'); # 정렬 아래쪽
var yAxis = d3.svg.axis().scale(y).ticks(5).orient('left'); # 왼쪽

svg.append('g')
        .attr('class','axis') # class 클래스 넣는 것(클래수 갯수 증가 x) / classed : 지정된 클래스 모두 넣는 것(클래스갯수증가)
        # transform 은 항상 정의 해야 함
        .attr('transform', "translate(0, "+(height-padding)+")")
        .call(yAxis);

svg.append('g')
        .attr('class','axis')
        .attr('transform', "translate("+padding+",0)")
        .call(yAxis);
        


########################################## 파이차트그리기 ##############################
# SVG 객체 생성 - 이상태로 하면 차트가 다안보이므로 이동시켜야 함
var svg = d3.select("#chart")
            .append("svg")
            .attr('width', 400)
            .attr('height', 400);
            
var group = svg.append("g") # 차트 이동 필수
                .attr("transform", "translate(200, 200)");

# arc 클래스 정의 - 파이 객체 생성
var arc = d3.svg.arc()
            .innerRadius(100)
            .outerRadius(200);
            
# 파이 객체 그리기! layout작업
var pie = d3.layout.pie()
            .value(function(d){
                return d;
            })
            
var arcs = group.selectAll(".arc")
                .data(pie(dataset))
                .enter()
                .append("g")
                .attr("class", "arc");
                
# 차트 옵션 지정 - 컬러 생성, pie 컬러 연결
var color = d3.scale.ordinal()
                    .range(["red", "orange", "blue"]);
arcs.append("path")
            .attr("d", arc)
            .attr("fill", function(d){ return color(d.data); });

# 차트 레이블 추가
arcs.append("text")
            .attr("transform", function(d){return "translate("+arc.centroid(d) + ")";})
            .attr("text-anchor", "middle")
            .attr("text-size", "10px")
            .text(function(d){ return d.data; });



########################################## 스캐터 플롯으로 관계 시각화 ##############################

# margin 설정 및 svg 객체 생성
var margin = {top:20, right:20, bottom:30, left:40},
            width=960-margin.left-margin.right,
            height=500-margin.top-margin.bottom;

var svg = d3.select("body").append("svg")
            .attr("width", width+margin.left+margin.right)
            .attr("height", height + margin.bottom)
            .append("g")
            .attr("transform", "translate("+margin.left+", "+margin.top+")");

# sclae 생성 및 축 범위 지정 => 축을 위한 선을 생성하는 것이고.
var x = d3.scale.linear().range([0, width]);
var y = d3.scale.linear().range([height, 0]);
var color = d3.scale.caegory10();

# 축 자체를 생성하는 것이다.
var xAxis = d3.svg.axis().scale(x).orient("bottom");
var yAxis = d3.svg.axis().scale(y).orient("left");

var data = [{y:5.1, x:3.5, class:"class1"}, 
            {y:4.9, x:3.3, class:"class1"},
            {y:5.2, x:3.7, class:"class1"},
            {y:4.6, x:3.4, class:"class2"},
            {y:5.0, x:3.7, class:"class2"}];

# 자동으로 최대, 최소 찾아서 반환 => extent / 반올림 해줌 => nice()
x.domain(d3.extent(data, function(d){return d.x;})).nice();
y.domain(d3.extent(data, function(d){return d.y;})).nice(); # 자동으로 최대 최소 찾아서 반환

# 포인트 생성 (dot 원 생성)
svg.selectAll(".dot")
            .data(data).enter().append("circle").attr("class", "dot").attr("r", 3.5)
            .attr("cx", function(d){return x(d.x);})
            .attr("cy", function(d){return y(d.y);})
            .style("fill", function(d){return color(d.class);});
            
# 축 생성된 것을 축 구현(call)  
# => 선 생성 -> 축 생성 -> 축 구현 구별 잘해야함
# x축과 y축을 각각 아래쪽과 왼쪽 정렬을 해서 그림.
svg.append("g")
        .attr("class","x axis")
        .attr("transform","translate(0, "+height+")")
        .call(xAxis)
        .append("text")
        .attr("class", "label")
        .attr("x", width)
        .attr("y", -6)
        .style("text-anchor","end")
        .text("Sepal Width(cm)");
svg.append("g")
        .attr('class', 'y axis')
        .call(yAxis)
        .append("text")
        .attr("class", 'label')
        .attr('transform','rotate(-90')
        .attr('y', 6)
        .attr("dy",".71em")
        .style("text-anchor",'end')
        .text("Sepal Length(cm)")

var legend = svg.selectAll(".legend")
                .data(color.domain())
                .enter().append("g")
                .attr("class","legend")
                .attr("transform", function(d, i){return "translate(0, "+i*20+")";});
                
legend.append("rect")
            .attr("x",width-18)
            .attr("width",18)
            .attr("height",18)
            .style("fill",color);
legend.append("text")
            .attr("x", wdith-24)
            .attr("y",9)
            .attr("dy", 35em")
            .style("text-anchor","end")
            .text(function(d){return d;});
            
# 히트맵으로 비교 시각화 구현
- 히트맵을 구현하기 위해서는 canvas 객체가 필요함 (drawImage-canvas이미지 출력하기 위한 함수)
- SVG 객체와 canvs 객체는 모두 시각화를 구현하기 위해 사용되지만 큰 차이점이 있어 시각화에 맞게 잘 선택 필요

