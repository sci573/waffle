<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Cache-control" content="no-cache" charset="UTF-8">
<title>main_view</title>
<%@ include file="../include/header.jsp" %>
<!-- base css -->
<link href="${path}/include/slider1.css" rel= "stylesheet"  type="text/css">
<!-- header css (search 기능 포함) -->
<link href="${path}/include/head_s.css" rel= "stylesheet"  type="text/css">
<!-- footer css -->
<link href="${path}/include/footer.css" rel= "stylesheet"  type="text/css">
<!-- font -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&family=Rubik:ital,wght@1,700&family=Unica+One&display=swap" rel="stylesheet">
<!-- slider css -->
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<!-- fontawsome -->
<script src="https://kit.fontawesome.com/a0fe62b208.js" crossorigin="anonymous"></script>
<!-- slick : https://kenwheeler.github.io/slick/ -->
<!-- slider JS -->
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<script type="text/javascript">
$(function() {
	//추천 컨텐츠(슬라이더)
	list_reco();
	//전체 컨텐츠
	list_all();
	//로그아웃
	$("#btnLogout").click(function() {
		location.href="${path}/waffleMember/logout.do";
	});
});
/* 슬라이더 적용 안됐을때 참조한 사이트
 * https://stackoverflow.com/questions/47880328/slick-not-working-after-ajax-call
 */
//메인화면 추천 컨텐츠 슬라이더 적용 
function destroyCarousel() {
    if ($('.post-wrapper').hasClass('slick-initialized')) {
        $('.post-wrapper').slick('unslick');
    }
}
function applySlider(){
	$('.post-wrapper').slick({
	slidesToShow: 3,
	slidesToScroll: 1,
	nextArrow:$('.next'),
	prevArrow:$('.prev'),
	
	autoplay: true,
	autoplaySpeed: 1500,
	
	centerMode: true,
	centerPadding: '60px'
	});
}
function list_reco() {
	$.ajax({
		//type:"post",
		url:"${path}/waffleContent/list_reco.do",
		dataType:"html",
		success:function(result) {
			destroyCarousel(); // destroy slick slider first
            $(".post-wrapper").html(''); // now make html empty          
			$(".post-wrapper").html(result);
            applySlider(); // apply slick slider again
		}
	});
}

//메인화면 하단 컨텐츠 전체 컨텐츠 출력(영화+드라마)
function list_all() {
	$.ajax({
		//type:"post",
		url:"${path}/waffleContent/list_all.do",
		dataType:"html",
		success:function(result) {
			console.log(result);
			$(".content_All").html(result);
			//console.log(result);
			/*
			for(var c in result){
				//받아온 list파일 index번호와 String(이미지 url)출력
				console.log(c,result[c])
				
				//insertAdjacentHTML 적용 안됨.
				
				//div
				var appdiv=document.createElement('div');

				//form
				//var appform=document.createElement('form');

				//input
				//var appinput=document.createElement('input');
				
				//a
				var apphref=document.createElement('a');
				
				//img
				var appimg=document.createElement('img');

				//a태그에 servlet으로 보낼 path추가
				apphref.href="${path}/waffleContent/detail_view.do?title="+result[c].title;
				
				//이미지에 아이디, 소스 추가(이미지 파일 넣기)
				//appimg.id="img"+c;
				appimg.src=result[c].poster;
				
				//div에 클래스 추가
				appdiv.classList.add('content_All_in');

				//form태그에 name추가
				//appform.id="form"+c;
				
				//input태그에 type, name값을 추가
				//appinput.type="hidden";
				//appinput.name="poster";
				//appinput.value=result[c];
				
				//div의 클래스 이름 출력
				console.log(appdiv.className);
				//img태그와 src(소스) 출력
				console.log(appimg);
				
				//content_All 클래스의 자식으로 div태그 추가
				var div_child=document.querySelector('.content_All').appendChild(appdiv);

				//div태그의 자식으로 form태그, input태그 추가
				//div_child.appendChild(appform).appendChild(appinput);
				
				//div태그의 자식으로 img태그 추가
				div_child.appendChild(apphref).appendChild(appimg);
			}*/
		}
	});
}
//메인화면 하단 컨텐츠 관련
$(function() {
	//하단 메뉴바 마우스 올릴 시
	$("#main-menu > li:nth-child(2), #main-menu > li:nth-child(3)").hover(function(){
		document.querySelector('#navigation').style.height="124px";
		//$("#navigation").animate({height:"124px"},200);
	});
	$("#main-menu > li:nth-child(1)").hover(function(){
		document.querySelector('#navigation').style.height="64px";
		//$("#navigation").animate({height:"64px"},400);
	});
	$(".content_All").hover(function(){
		document.querySelector('#navigation').style.height="64px";
		//$("#navigation").animate({height:"64px"},400);
	});
	$("#cont_t_wrap").hover(function(){
		document.querySelector('#navigation').style.height="64px";
		//$("#navigation").animate({height:"64px"},400);
	});

	//메인화면 하단 컨텐츠 카테고리별 컨텐츠 출력
	//전체
	$("#all").click(function (a) {
		console.log(a);//a 태그의 기본기능(기본동작) 출력
		a.preventDefault();//anchor(a)이벤트의 기본동작을 막는다.
		list_all();
		//하단 컨텐츠 네비게이션으로 스크롤 이동
		/* var offset=$("#navigation").offset();
		$('html, body').animate({scrollTop : offset.top}, 400); */
		//좀 더 부드럽게 진행됨.
		var location=document.querySelector("#navigation").offsetTop;
		window.scrollTo({top:location, behavior:'smooth'});
	});

	//드라마 전체
	$("#drama").click(function (a) {
		a.preventDefault();//anchor(a)이벤트의 기본동작을 막는다.
		$.ajax({
			url:"${path}/waffleContent/drama_M.do",
			dataType:"html",
			success:function(result) {
				$(".content_All").html(result);
			}
		});
		//하단 컨텐츠 네비게이션으로 스크롤 이동
		var location=document.querySelector("#navigation").offsetTop;
		window.scrollTo({top:location, behavior:'smooth'});
	});
	
	//로맨스 드라마
	$("#d_romance").click(function () {
		$.ajax({
			url:"${path}/waffleContent/drama_romance_M.do",
			dataType:"html",
			success:function(result) {
				$(".content_All").html(result);
			}
		});
		//하단 컨텐츠 네비게이션으로 스크롤 이동
		var location=document.querySelector("#navigation").offsetTop;
		window.scrollTo({top:location, behavior:'smooth'});
	});

	//스릴러 드라마
	$("#d_thriller").click(function () {
		$.ajax({
			url:"${path}/waffleContent/drama_thriller_M.do",
			dataType:"html",
			success:function(result) {
				$(".content_All").html(result);
			}
		});
		//하단 컨텐츠 네비게이션으로 스크롤 이동
		var location=document.querySelector("#navigation").offsetTop;
		window.scrollTo({top:location, behavior:'smooth'});
	});

	//액션 드라마
	$("#d_action").click(function () {
		$.ajax({
			url:"${path}/waffleContent/drama_action_M.do",
			dataType:"html",
			success:function(result) {
				$(".content_All").html(result);
			}
		});
		//하단 컨텐츠 네비게이션으로 스크롤 이동
		var location=document.querySelector("#navigation").offsetTop;
		window.scrollTo({top:location, behavior:'smooth'});
	});

	//코미디 드라마
	$("#d_comedy").click(function () {
		$.ajax({
			url:"${path}/waffleContent/drama_comedy_M.do",
			dataType:"html",
			success:function(result) {
				$(".content_All").html(result);
			}
		});
		//하단 컨텐츠 네비게이션으로 스크롤 이동
		var location=document.querySelector("#navigation").offsetTop;
		window.scrollTo({top:location, behavior:'smooth'});
	});

	//SF 드라마
	$("#d_sf").click(function () {
		$.ajax({
			url:"${path}/waffleContent/drama_sf_M.do",
			dataType:"html",
			success:function(result) {
				$(".content_All").html(result);
			}
		});
		//하단 컨텐츠 네비게이션으로 스크롤 이동
		var location=document.querySelector("#navigation").offsetTop;
		window.scrollTo({top:location, behavior:'smooth'});
	});

	//영화 전체
	$("#movie").click(function (a) {
		a.preventDefault();//anchor(a)이벤트의 기본동작을 막는다.
		$.ajax({
			url:"${path}/waffleContent/movie_M.do",
			dataType:"html",
			success:function(result) {
				$(".content_All").html(result);
			}
		});
		//하단 컨텐츠 네비게이션으로 스크롤 이동
		var location=document.querySelector("#navigation").offsetTop;
		window.scrollTo({top:location, behavior:'smooth'});
	});
	
	//로맨스 드라마
	$("#m_romance").click(function () {
		$.ajax({
			url:"${path}/waffleContent/movie_romance_M.do",
			dataType:"html",
			success:function(result) {
				$(".content_All").html(result);
			}
		});
		//하단 컨텐츠 네비게이션으로 스크롤 이동
		var location=document.querySelector("#navigation").offsetTop;
		window.scrollTo({top:location, behavior:'smooth'});
	});

	//스릴러 드라마
	$("#m_thriller").click(function () {
		$.ajax({
			url:"${path}/waffleContent/movie_thriller_M.do",
			dataType:"html",
			success:function(result) {
				$(".content_All").html(result);
			}
		});
		//하단 컨텐츠 네비게이션으로 스크롤 이동
		var location=document.querySelector("#navigation").offsetTop;
		window.scrollTo({top:location, behavior:'smooth'});
	});

	//액션 드라마
	$("#m_action").click(function () {
		$.ajax({
			url:"${path}/waffleContent/movie_action_M.do",
			dataType:"html",
			success:function(result) {
				$(".content_All").html(result);
			}
		});
		//하단 컨텐츠 네비게이션으로 스크롤 이동
		var location=document.querySelector("#navigation").offsetTop;
		window.scrollTo({top:location, behavior:'smooth'});
	});

	//코미디 드라마
	$("#m_comedy").click(function () {
		$.ajax({
			url:"${path}/waffleContent/movie_comedy_M.do",
			dataType:"html",
			success:function(result) {
				$(".content_All").html(result);
			}
		});
		//하단 컨텐츠 네비게이션으로 스크롤 이동
		var location=document.querySelector("#navigation").offsetTop;
		window.scrollTo({top:location, behavior:'smooth'});
	});

	//SF 드라마
	$("#m_sf").click(function () {
		$.ajax({
			url:"${path}/waffleContent/movie_sf_M.do",
			dataType:"html",
			success:function(result) {
				$(".content_All").html(result);
			}
		});
		//하단 컨텐츠 네비게이션으로 스크롤 이동
		var location=document.querySelector("#navigation").offsetTop;
		window.scrollTo({top:location, behavior:'smooth'});
	});
});

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
<%-- <c:if test="${message == 'hello'}">
	<script>
		alert("${sessionScope.userid}님 방문을 환영합니다~!");
	</script>
</c:if> --%>
<c:if test="${param.message == 'noadmin'}">
	<script>
		alert("관리자만 이용가능합니다.");
	</script>		
</c:if>
<style type="text/css">
/* 컨텐츠 파트 */
#cont_wrap {
	clear: both;
}

#cont_t_wrap {
	width: 100%;
	height: auto;
}

#cont_m_wrap {
	width: 100%;
	height: auto;
}
/* 하단 메뉴바 */
#navigation { 
	font-family: "Unica One", cursive;
	width: 100%;
	display: flex;
	justify-content: center;
	position: relative;
	padding: 5px;
	border-top: 1px solid white;
	transition: all 0.5s ease-in-out;
}
#main-menu, #sub-menu{
	margin: 0;
	padding: 0;
	list-style: none;
}
#main-menu > li {
	float: left;
	position: relative;
	font-family: 'Unica One', cursive;
}
#main-menu > li > a {
	font-size: 30px;
	color: rgba(255,255,255,0.85);
	text-align: center;
	text-decoration: none;
	display: block;
	padding: 14px 36px;
	border-right: 1px solid rgba(0,0,0,0.15);
	letter-spacing: 10px;
	font-weight: 800;
	cursor: pointer;
}
#main-menu > li > a:hover {
	color: #f3e6ff;
	text-shadow: 0 0 0.2em #f3e6ff;
}
#sub-menu {
	position: absolute;
	opacity: 0;
	visibility: hidden;
	transition: all 0.5s ease-in-out;
	width: 580px;
	left: -215px;
	border: 1px solid #151515;
	border-radius: 20px;
	text-align: center;
}
#sub-menu > li {
	display: inline-block;
	margin: 5px;
	padding: 7px;
	color: #999999;
	font-size: 18px;
	letter-spacing: 5px;
	cursor: pointer;
}
/* a 태그 없애서 위의 li태그에 속성 합해둠 */
/* .subemenu {
	color: #999999;
	font-size: 18px;
	letter-spacing: 5px;
	cursor: pointer;
} */
/* 하단 메뉴 카테고리에 mouse hover시 */
#main-menu > li:nth-child(2):hover #sub-menu, #main-menu > li:nth-child(3):hover #sub-menu {
	opacity: 1;
	visibility: visible;
}
.subemenu:hover {
	text-decoration: underline;
	color: #f3e6ff;
	text-shadow: 0 0 0.1em #f3e6ff;
}

/* 하단 컨텐츠 설정 */
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

/* 검색 결과를 띄워주는 파트 */
#search_wrap {
	width: 100%;
	height: auto;
	display: none;
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
		<%@ include file="../include/head_s.jsp" %>
		
		<!-- 컨텐츠 파트 -->
		<div id="cont_wrap">
		
			<!-- 상단 컨텐츠 -->
			<div id="cont_t_wrap">
				<!-- 슬라이더 -->
				<div class="page-wrapper" style="position:relative;">
					<!--page slider -->
					<div class="post-slider">
						<h1>RECOMMENDE</h1>
						<i class="fas fa-chevron-left prev"></i>  
				        <i class="fas fa-chevron-right next"></i>
				        <div class="post-wrapper">
				        <!-- 추천 작품 슬라이드가 표시되는 영역 -->
				        </div>
					</div>
					<!--post slider-->
				</div>
			</div>
			
			<!-- 하단 컨텐츠 -->
			<div id="cont_m_wrap">
				<!-- 하단 메뉴바 -->
				<nav id="navigation">
					<ul id="main-menu">
						<li><a id="all">ALL</a></li>
						<li><a id="drama">DRAMA</a>
							<ul id="sub-menu">
								<li class="subemenu" id="d_romance">romance</li>
								<li class="subemenu" id="d_thriller">thriller</li>
								<li class="subemenu" id="d_action">action</li>
								<li class="subemenu" id="d_comedy">comedy</li>
								<li class="subemenu" id="d_sf">sf</li>
							</ul>
						</li>
						<li><a id="movie">MOVIE</a>
							<ul id="sub-menu">
								<li class="subemenu" id="m_romance">ROMANCE</li>
								<li class="subemenu" id="m_thriller">THRILLER</li>
								<li class="subemenu" id="m_action">ACTION</li>
								<li class="subemenu" id="m_comedy">COMEDY</li>
								<li class="subemenu" id="m_sf">SF</li>
							</ul>
						</li>
					</ul>
				</nav>
				<div class="content_All">
				<!-- 하단 컨텐츠가 표시되는 영역 -->
				</div>
			</div>
		</div>
		
		<!-- 검색 파트 -->
		<div id="search_wrap">
			<h1>SEARCH RESULTS...</h1>
			<div class="content_All">
			<!-- 검색한 결과의 컨텐츠가 표시되는 영역 -->
			</div>
		</div>
		
		<%@ include file="../include/footer.jsp" %>
	</div>
	<!-- wrap -->
</body>
</html>