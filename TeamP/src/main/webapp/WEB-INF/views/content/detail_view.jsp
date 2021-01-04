<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>detail_view</title>
<%@ include file="../include/header.jsp" %>
<script type="text/javascript">
$(function() {
	//댓글 목록 출력
	comment_list();
	//댓글 입력 후 저장
	$("#btnSave").click(function() {
		alert("댓글을 등록하시겠습니까?");
		comment_add();
	});
	//로그아웃 버튼 클릭	
	$("#btnLogout").click(function() {
		location.href="${path}/waffleMember/logout.do";
	});
	//관리자 수정 뷰 이동 버튼
	$("#btnEdit").click(function(){
		location.href="${path}/waffleContent/admin_edit_view.do/${dto.title}";
	});
	//관리자 삭제 버튼
	$("#btnDelete").click(function(){
		if(confirm("삭제하시겠습니까?")){
			location.href="${path}/waffleContent/admin_delete.do/${dto.title}";
		}
	});
});

//댓글 출력 기능
function comment_list() {
	//백그라운드로 서버 호출
	$.ajax({
		type : "post",
		url : "${path}/waffleContent/commentList.do",
		data : "title=${dto.title}",
		success : function(result){
			//result : responseText 응답텍스트(html)
			console.log(result);
			$("#commentList").html(result);
		}
	});
}

//댓글 추가 기능
function comment_add() {
	var content=$("#content").val();
	// var writer=$("#writer").val();
	var writer=document.querySelector("#writer").value;
	
	if(content=="") {
		alert("댓글 내용을 입력해주세요");
		$("#content").focus();
		return;
	}
	
	var param="title=${dto.title}&writer="+writer+"&content="+content;
	console.log(writer);
	
	$.ajax({
		type : "post",
		url : "${path}/waffleContent/commentAdd.do",
		data : param,
		success : function(){
			$("#content").val("");	//텍스트 창 초기화
			alert("댓글이 등록되었습니다.");
			comment_list();
		}
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
		//댓글 띄우기
		document.querySelector("#comment").style.display='block';
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
				//댓글 폼은 사라짐
				document.querySelector("#comment").style.display='none';
				//검색 결과 파트 띄우기
				document.querySelector("#search_wrap").style.display='block';
				$("#search_wrap > .content_All").html(result);
			}
		});
	}
}
</script>
<!-- base css -->
<link href="${path}/include/slider1.css" rel= "stylesheet"  type="text/css">
<!-- header css (search 기능 포함) -->
<link href="${path}/include/head_s.css" rel= "stylesheet"  type="text/css">
<!-- footer css -->
<link href="${path}/include/footer.css" rel= "stylesheet"  type="text/css">
<!-- font -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&family=Rubik:ital,wght@1,700&family=Unica+One&display=swap" rel="stylesheet">
<!-- fontawsome -->
<script src="https://kit.fontawesome.com/a0fe62b208.js" crossorigin="anonymous"></script>
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=East+Sea+Dokdo&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Jua&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Song+Myung&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Kalam&display=swap');

/* 컨텐츠 디테일 뷰 */

#cont_wrap { 
	clear:both;
	box-sizing: border-box;
	width:80%;
	height:auto;
	margin:80px auto 50px;
	padding:100px;
	border: 1px solid #1a1a1a;
	border-radius: 5px;
}

/* 왼쪽 */
#cont_left {
	width:57%;
	display: inline-block;
	vertical-align: top;
	margin-right: 5%;
}
#cont_left h1 {
	margin:0;
	color:white;
	font:bold 42px san-serif;
	display:inline-block;
	/* font-family: "Caveat", cursive; */
	font-family: "Song Myung", serif;
	-webkit-font-smoothing: antialiased;
}
#cont_left p {
	margin:0;
	font-size: 18px;
	display:inline-block;
}

/* 버튼 (찜, 수정, 삭제) */
form{
	/* float: right; */
	display: inline;
}
.btn{
	display: inline-block;
	float: right;	
	margin-left: 11px;
}
.icon {
	position: relative; 
	display: inline-block;
	background-color: black;
    border: 2px solid gray;
    border-radius: 50px;
    padding: 15px;
    font-size: 23px;
    color: white;
    float: right;
    cursor: pointer;
}
.icon:hover .tt-text, .tt-text1 { visibility: visible; }

/* 툴팁 말풍선 */
.tt-text { 
	visibility: hidden;
    width: 200px;
    text-align: center;
    border-radius: 7px;
    padding: 10px 5px;
    position: absolute;
    z-index: 1;
    bottom: 130%;
    left: 50%;
    margin-left: -105px;
    color: black;
    background-color: white;
} 
.tt-text::after { 
	content: "";
    position: absolute;
    top: 100%;
    left: 50%;
    margin-left: -5px;
    border-width: 5px;
    border-style: solid;
    border-color: white transparent transparent transparent;
	color: black;
}

/* 배우 div */
.box {
	clear:both;
	color: white;
	font-family:"맑은 고딕";
	margin-top: 10px;
}
.actor {
	float:left;
	width:70px;
	height:25px;
	border-radius:6px;
	border:2px solid #666;
	text-align:center;
	font-weight: 550;
	margin: 0 15px 0 1px;
	padding: 3px 0 0;
}
.box > p {
	margin: 0;
	padding-top: 2px;
}

/* 줄거리 div */
.desc {
	height: auto;
	margin: 0;
	padding-top: 50px;
}


/* 오른쪽 */
#cont_right {
	display:inline-block;
	width:37%;
}

/* 포스터 div */
.intro_post {
	width: 100%;
}
.intro_post img {
	width:100%; 
	height:600px;
	border-radius: 6px; 
	border: 1px solid #e8e8e8;
}
.intro_post>p { 
	text-align: center; 
	padding-top: 10px; 
	padding-bottom: 30px; 
	font-size: 14px; 
}

/* 카테고리, 장르, 연령 */
#box_cont {
	margin-top: 2px;
	text-align: center;
}
#box_cont ul {
	list-style: none;
	margin: 0;
	padding: 0;
}
#box_cont li {
	display: inline-block;
	border-radius:6px;
	border:2px solid #666;
	text-align:center;
	width:30%;
}
#box_cont h4 {
	font-size:16px;
	font-family:"맑은 고딕";
	margin:15px 3px;
	color:white;
}
#box_cont h3 {
	font-size:13px;
	margin:15px;
	color:red;
	font-family:"맑은 고딕";
	font-weight:bold;
	letter-spacing:-1px;
	-webkit-font-smoothing: antialiased;
}

/* 댓글 폼 */
#comment {
	width: 100%;
	text-align: center;
}

#comment h2 {
	margin: 0 auto;
	padding: 30px;
	border-top: 1px solid white;
	border-bottom: 1px solid white;
	width: 75%;
	font-family: "Jua", cursive;
	color: white;
}

/* 댓글 리스트 */
#commentList {
	margin: 0 auto;
	color: white;
	width: 75%;
}
#commentList table {
	width: 100%;
	border-collapse: collapse;
}
#commentList tr {
	border-bottom: 1px solid white;
}
#commentList td {
	padding: 20px;
}

/* 댓글 입력 placeholder 글자 색 수정 */
textarea::placeholder {
  color: black;
  font-weight: bold;
}
/* 댓글 쓰기 테이블 */
#commentWrite {
	margin: 30px auto;
	padding: 10px 50px 10px 10px;
	width: 75%;
	border: 1px solid white;
	font-family: "Song Myung", cursive;
}
#commentWrite table {
	width: 100%
}
#commentWrite h4 {
	margin: 10px;
}
/* 댓글 입력 양식 */
textarea {
	width: -webkit-fill-available;
}

/* 댓글 등록 버튼 */
#btnSave{
  	background:black;
  	color:gray;
  	border:none;
  	position:relative;
  	height:30px;
  	font-size:1.1em;
  	padding:0.5em 0.5em 1.5em 0.5em;
  	cursor:pointer;
  	transition:800ms ease all;
  	outline:none;
}
#btnSave:before{
	content:'';
	display:inline-block;
	vertical-align:middle;
	position:absolute;
  	top:0;
 	right:0;
  	height:4px;
  	width:0;
  	background: black;
  	transition:400ms ease all;
}
#btnSave:hover {
  	background:#fff;
  	color:black;
}
#btnSave:after{
  	right:inherit;
  	top:inherit;
  	left:0;
  	bottom:0;
}
#btnSave:hover:before, #btnSave:hover:after{
  	width:100%;
  	transition:800ms ease all;
}

/* 검색 결과를 띄워주는 파트 */
#search_wrap {
	width: 100%;
	height: auto;
	display: none;
}

/* 검색 결과에 나올 포스터 폼 설정 */
.content_All {
	width: 100%;
	display: table;
	/* height: auto; */
	/* text-align: justify; */
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
	<%@ include file="../include/head_s.jsp" %>

	<!-- 컨텐츠 디테일 뷰 -->
	<div id="cont_wrap">
		<!-- 왼쪽 컨텐츠 -->
		<div id="cont_left">
			<!-- 뷰 수정을 위한 cno값 -->
			<input type="hidden" name="cno" value="${dto.cno}">
			
			<h1>${dto.title}</h1>
			<p>| ${dto.year}</p>
			<!-- 찜 버튼 -->
			<c:choose>
				<c:when test="${count==0}">
					<c:if test="${sessionScope.admin_userid == null}">
						<!-- 관리자는 찜하기 기능을 이용할 수 없다. -->
						<form name="form1" method="post" action="${path}/waffleFavor/insert.do">
							<div class="btn" style="background-color: black;">
								<button id="btnZzim_in" class="far fa-heart icon" type="submit">
									<span class="tt-text" style="font-size: 16px;">Add To My Favorite List</span>
								</button>
							</div>
							<input type="hidden" name="poster" value="${dto.poster}">
							<input type="hidden" name="title" value="${dto.title}">
						</form>
					</c:if>
				</c:when>
				
				<c:otherwise>
					<c:if test="${sessionScope.admin_userid == null}">
						<!-- 관리자는 찜하기 기능을 이용할 수 없다. -->
						<form name="form1" method="post" action="${path}/waffleFavor/delete.do">
							<div class="btn" style="background-color: black;">
								<button id="btnZzim_in" class="fas fa-heart icon" type="submit">
									<span class="tt-text" style="font-size: 16px; font-weight: 100;">Delete From My Favorite List</span>
								</button>
							</div>
							<input type="hidden" name="poster" value="${dto.poster}">
							<input type="hidden" name="title" value="${dto.title}">
						</form>
					</c:if>
				</c:otherwise>
			</c:choose>
			
			<!-- 관리자용 수정 버튼 -->
			<c:if test="${sessionScope.admin_userid != null}">
				<div class="btn" style="background-color: black;">
					<button id="btnEdit" class="far fa-edit icon" type="submit">
						<span class="tt-text" style="font-size: 16px;">EDIT - Admin Only</span>
					</button>
				</div>
				<div class="btn" style="background-color: black;">
					<button id="btnDelete" class="far fa-trash-alt icon" type="submit">
						<span class="tt-text" style="font-size: 16px;">DELETE - Admin Only</span>
					</button>
				</div>
			</c:if>
			
			
			<div class="box">
				<div class="actor">CAST</div>
				<p>${dto.cast}</p>
			</div>
			<div class="desc">
				<p>${dto.description}</p>
			</div>
		</div>
		
		<!-- 오른쪽 컨텐츠 -->
		<div id="cont_right">
			<div class="intro_post">
				<img src="${dto.poster}">
			</div>
			<div id="box_cont">
				<ul>
					<li>
						<h4 face="malgun gothic">RATED</h4>
				    	<h3>${dto.rated}</h3>  
					</li>
					<li>
						<h4 face="malgun gothic">GENRE</h4>
				 		<h3>${dto.genre}</h3>
					</li>
					<li>
						<h4 face="malgun gothic">CATEGORY</h4>
						<h3>${dto.category}</h3>
					</li>
				</ul>
			</div>
		</div>
	</div>
	
	<!-- 댓글 관련 폼 -->
	<div id="comment">
		<h2>C O M M E N T</h2>
		<!-- 댓글 출력 -->
		<div id="commentList">
			<!-- 댓글이 출력되는 파트(table태그) -->
		</div>
		<!-- 댓글 쓰기 폼 -->
		<table id="commentWrite"> 
			<tr>
				<td>
					<h4> w r i t e r ✒️ ---- ${sessionScope.userid} ---- </h4>
					<input type="hidden" id="writer" value="${sessionScope.userid}">
				</td>
				<td rowspan="2">
					<button id="btnSave" type="button">💾</button>
				</td>
			</tr>
			<tr>
				<td>
					<textarea rows="5" style="color: black;" placeholder="댓글을 입력하세요" id="content"></textarea>
				</td>
			</tr>
		</table>
	</div>
	
	<!-- 검색 파트 -->
	<div id="search_wrap">
		<h1>SEARCH RESULTS...</h1>
		<div class="content_All">
		<!-- 검색한 결과의 컨텐츠가 표시되는 영역 -->
		</div>
	</div>
	
	<%@ include file="../include/footer.jsp" %>
</body>
</html>