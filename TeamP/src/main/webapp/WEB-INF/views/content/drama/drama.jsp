<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../../include/header.jsp" %>	
<!-- base css -->
<link href="${path}/include/slider_small.css" rel= "stylesheet"  type="text/css">
<!-- header css (search 기능 포함) -->
<link href="${path}/include/head_s.css" rel= "stylesheet"  type="text/css">
<!-- footer css -->
<link href="${path}/include/footer.css" rel= "stylesheet"  type="text/css">
<!-- font -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&family=Rubik:ital,wght@1,700&family=Unica+One&display=swap" rel="stylesheet">
<!-- fontawsome -->
<script src="https://kit.fontawesome.com/a0fe62b208.js" crossorigin="anonymous"></script>
<!-- slick : https://kenwheeler.github.io/slick/ -->
<!-- slider css -->
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<!-- slider JS -->
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

<script type="text/javascript">
$(function() {
	drama_romance();
	drama_thriller();
	drama_action(); 
	drama_comedy();
	drama_sf(); 
	$("#btnLogout").click(function() {
		location.href="${path}/waffleMember/logout.do";
	});
});
/* 슬라이더 적용 안됐을때 참조한 사이트
 * https://stackoverflow.com/questions/47880328/slick-not-working-after-ajax-call
 */
//(영화)전체 슬라이드 적용
$(function () {
    var $sliders = $(".post-wrapper");
    var $arrows = $('.arrows');
   
    $(".post-slider").each(function(){
        
        var $this = $(this);
        var slick = $this.find( $sliders ).slick({
	        
            appendArrows: $this.find( $arrows )
        });
    });
});

//첫번째 카테고리 : 로맨스
function drama_romance() {
	$.ajax({
		type:"post",
		url:"${path}/waffleContent/drama_romance.do",
		dataType:"html",
		success:function(result) {
			destroyCarousel1(); // destroy slick slider first
            $("#post-wrapperR").html(''); // now make html empty          
			$("#post-wrapperR").html(result);
            applySlider1(); // apply slick slider again
		}
	});
}
//슬라이드 (로맨스)
function destroyCarousel1() {
    if ($('#post-wrapperR').hasClass('slick-initialized')) {
        $('#post-wrapperR').slick('unslick');
    }
}
function applySlider1(){
	$('#post-wrapperR').slick({
	slidesToShow: 7,
	slidesToScroll: 7,
	nextArrow:$('.next1'),
	prevArrow:$('.prev1')
	});
}

//두번째 카테고리 : 스릴러
function drama_thriller() {
	$.ajax({
		type:"post",
		url:"${path}/waffleContent/drama_thriller.do",
		dataType:"html",
		success:function(result) {
			destroyCarousel2(); // destroy slick slider first
            $("#post-wrapperT").html(''); // now make html empty          
			$("#post-wrapperT").html(result);
            applySlider2(); // apply slick slider again
		}
	});
}
//슬라이드 (스릴러)	
function destroyCarousel2() {
    if ($('#post-wrapperT').hasClass('slick-initialized')) {
        $('#post-wrapperT').slick('unslick');
    }
}
function applySlider2(){
	$('#post-wrapperT').slick({
	slidesToShow: 7,
	slidesToScroll: 7,
	nextArrow:$('.next2'),
	prevArrow:$('.prev2')
	});
}

//세번째 카테고리 : 액션
function drama_action() {
	$.ajax({
		type:"post",
		url:"${path}/waffleContent/drama_action.do",
		dataType:"html",
		success:function(result) {
			destroyCarousel3(); // destroy slick slider first
            $("#post-wrapperA").html(''); // now make html empty          
			$("#post-wrapperA").html(result);
            applySlider3(); // apply slick slider again
		}
	});
}
//슬라이드 (액션)
function destroyCarousel3() {
    if ($('#post-wrapperA').hasClass('slick-initialized')) {
        $('#post-wrapperA').slick('unslick');
    }
}
function applySlider3(){
	$('#post-wrapperA').slick({
	slidesToShow: 7,
	slidesToScroll: 7,
	nextArrow:$('.next3'),
	prevArrow:$('.prev3')
	});
}

//네번째 카테고리 : 코미디
function drama_comedy() {
	$.ajax({
		type:"post",
		url:"${path}/waffleContent/drama_comedy.do",
		dataType:"html",
		success:function(result) {
			destroyCarousel4(); // destroy slick slider first
            $("#post-wrapperC").html(''); // now make html empty          
			$("#post-wrapperC").html(result);
            applySlider4(); // apply slick slider again
		}
	});
}
//슬라이드 (코미디)
function destroyCarousel4() {
    if ($('#post-wrapperC').hasClass('slick-initialized')) {
        $('#post-wrapperC').slick('unslick');
    }
}
function applySlider4(){
	$('#post-wrapperC').slick({
	slidesToShow: 7,
	slidesToScroll: 7,
	nextArrow:$('.next4'),
	prevArrow:$('.prev4')
	});
}

//다섯번째 카테고리 : sf
function drama_sf() {
	$.ajax({
		type:"post",
		url:"${path}/waffleContent/drama_sf.do",
		dataType:"html",
		success:function(result) {
			destroyCarousel5(); // destroy slick slider first
            $("#post-wrapperS").html(''); // now make html empty          
			$("#post-wrapperS").html(result);
            applySlider5(); // apply slick slider again
		}
	});
}
//슬라이드 (sf)
function destroyCarousel5() {
    if ($('#post-wrapperS').hasClass('slick-initialized')) {
        $('#post-wrapperS').slick('unslick');
    }
}
function applySlider5(){
	$('#post-wrapperS').slick({
	slidesToShow: 7,
	slidesToScroll: 7,
	nextArrow:$('.next5'),
	prevArrow:$('.prev5')
	});
}

/* Search 바 script */
$(function() {
	/* 돋보기 아이콘에 마우스를 올릴 시 */
	$('.search_1').hover(function() {
		//input(검색창) 페이드인 효과(서서히 보이게함)
		$(".input").fadeIn(500,'linear');
		//input(검색창) 보이게 하기
		document.querySelector(".input").style.visibility="visible";
		document.querySelector(".input").style.opacity="1";
		//input(검색창) 페이드인 후 크기
		document.querySelector(".input").style.width="300px";
		//검색기능을 위한 Search(돋보기) 아이콘을 제일 위로 보이도록 설정
		document.querySelector(".search_2").style.zIndex="2";
		//input(검색창)에 포커스(데이터를 입력할 수 있도록 focus처리)
		$(".input").focus();
		//.fa-search 클래스의 모든 요소 스타일 변경
		var fa_all=document.querySelectorAll(".fa-search");
		for(var i=0; i<fa_all.length; i++) {
			fa_all[i].style.paddingTop="1.5px";
			fa_all[i].style.fontSize="25px";
		}
	});
	/* input(검색창)에서 focusout될 시 */
	$('.input').focusout(function() {
		search();//search함수 실행
	}).keydown(function() {
		/* input(검색창)에서 엔터키를 눌렀을 시 */
		/* 참조 : https://webisfree.com/2017-08-07/input-%EC%9E%85%EB%A0%A5%ED%8F%BC-%EC%97%94%ED%84%B0%ED%82%A4-%EB%88%84%EB%A5%BC-%EA%B2%BD%EC%9A%B0-submit-%EB%A7%89%EA%B8%B0-prevent */
		if (event.keyCode === 13) {
	        search();//search함수 실행
	    } else if(event.keyCode === 27) {//input(검색창)에서 esc키를 눌렀을 시
			$('.input').val("");//검색창을 비워준다.
	    }
	});
});
//검색기능 함수
function search() {
	var input=$('.input').val();
	console.log(input);
	//input에 아무 값도 넣지 않았을 때
	if(input=="") {
		//input(검색창) 페이드아웃 효과(서서히 사라지게함)
		$(".input").fadeOut(500,'linear');
		//input(검색창) 페이드아웃 후 크기
		document.querySelector(".input").style.width="0px";
		//검색기능을 위한 Search(돋보기) 아이콘을 보이지 않도록 설정
		document.querySelector(".search_2").style.zIndex="-1";
		//.fa-search 클래스의 모든 요소 스타일 변경
		var fa_all=document.querySelectorAll(".fa-search");
		for(var i=0; i<fa_all.length; i++) {
			fa_all[i].style.paddingTop="0px";
			fa_all[i].style.fontSize="30px";
		}
		//전체 컨텐츠 띄우기
		document.querySelector("#cont_wrap").style.display='block';
		//검색 결과 파트는 사라짐
		document.querySelector("#search_wrap").style.display='none';
	}
	//input에 값이 넣어져 있을 때 search()함수 실행
	else {
		console.log(input);
		//input에 넣은 값에 공백이 있을시 구분(split함수 사용)
		var inputArr = input.split(" ");
		for(var num in inputArr) {
			//공백을 구분한 각각의 키워드 콘솔창에서 출력
			console.log(inputArr[num]);
		}
		//ajax에서 controller로 보낼 데이터 (json 형식) -> 쿼리스트링 방식은 불가 (값이 배열이기 때문이다.)
		var param= { "inputArr" : inputArr };
		$.ajax({
			type: "post",
			url: "${path}/waffleContent/search.do",
			data: param,
			dataType: "html",
			success:function(result) {
				//전체 컨텐츠는 사라짐
				document.querySelector("#cont_wrap").style.display='none';
				//검색 결과 파트 띄우기
				document.querySelector("#search_wrap").style.display='block';
				$("#search_wrap > .content_All").html(result);
			}
		});
	}
}
</script>
<style type="text/css">
/* 컨텐츠 */
#cont_wrap {
	width: 100%;
	height: auto;
}

/* 검색 결과를 띄워주는 파트 */
#search_wrap {
	width: 100%;
	height: auto;
	display: none;
}

.content_All {
	display: table;
	width: 100%;
	height: auto;
}

.content_All img {
	width: 200px;
    height: 300px;
    padding: 7px;
    margin-left: 20px;
    cursor: pointer;
}

.content_All_in {
	display: inline-block;
}

/* 사진 zoom */
.bottomImg{
	position: relative;
	/* 효과 */
	transform:scale(1);
	-webkit-transform: scale(1);
	-moz-transform: scale(1);
	-ms-transform: scale(1);
	-o-transform: scale(1);
	transition: all 0.4s ease-in-out;
}
.bottomImg:hover{
    border:1px solid white;
	border-radius:3px;
	padding:0;
	box-sizing:border-box;
	z-index: 100;
	/* 효과 */
	transform: scale(1.3);
	-webkit-transform: scale(1.3);
	-moz-transform: scale(1.3);
	-ms-transform: scale(1.3);
	-o-transform: scale(1.3);
}
</style>
</head>
<body>
	<div id="wrap">
		<%@ include file="../../include/head_s.jsp" %>
		
		<!-- 컨텐츠 파트 -->
		<div id="cont_wrap">
			<!-- 슬라이더 -->
			<div class="page-wrapper" style="position: relative;">
				<!--page slider1 -->
				<div class="post-slider">
					<h4>romance</h4>
						 <div class="arrows">
							<i class="fas fa-chevron-right next1"></i>
							<i class="fas fa-chevron-left prev1"></i>
						</div> 
					<div class="post-wrapper" id="post-wrapperR">
					</div>
				</div>
				
				<!--post slider2-->
				<div class="post-slider">	
					 <h4>thriller</h4>
						<div class="arrows">
							<i class="fas fa-chevron-right next2"></i>
							<i class="fas fa-chevron-left prev2"></i>
						</div>
					<div class="post-wrapper" id="post-wrapperT">
					</div>
				</div>
				<!--post slider3-->
				<div class="post-slider">	
					 <h4>action</h4>
						<div class="arrows">
							<i class="fas fa-chevron-right next3"></i>
							<i class="fas fa-chevron-left prev3"></i>
						</div>
					<div class="post-wrapper" id="post-wrapperA">
					</div>
				</div>
				<!--post slider4-->
				<div class="post-slider">	
					 <h4>comedy</h4>
						<div class="arrows">
							<i class="fas fa-chevron-right next4"></i>
							<i class="fas fa-chevron-left prev4"></i>
						</div>
					<div class="post-wrapper" id="post-wrapperC">
					</div>
				</div>
				<!-- post slider5 -->
				<div class="post-slider">	
					 <h4>sf</h4>
						<div class="arrows">
							<i class="fas fa-chevron-right next5"></i>
							<i class="fas fa-chevron-left prev5"></i>
						</div>
					<div class="post-wrapper" id="post-wrapperS">
					</div>
				</div>
			</div>
			<!-- page-wrapper -->
		</div>
		
		<!-- 검색 파트 -->
		<div id="search_wrap">
			<h1>SEARCH RESULTS...</h1>
			<div class="content_All">
			<!-- 검색한 결과의 컨텐츠가 표시되는 영역 -->
			</div>
		</div>
		
		<%@ include file="../../include/footer.jsp" %>
	</div>
</body>
</html>