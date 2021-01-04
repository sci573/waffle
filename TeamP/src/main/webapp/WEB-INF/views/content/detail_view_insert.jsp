<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header.jsp" %>
<script type="text/javascript">
$(function(){
	//디테일 삽입
	$("#btnInsert").click(function(){
		var title= $("#title").val();
		var year= $("#year").val();
		var cast= $("#cast").val();
		var description= $("#description").val();
		var rated= $("#rated").val();
		var genre= $("#genre").val();
		var category= $("#category").val();
	
		if(title=="") {
			alert("제목을 입력해주세요");
			$("#title").focus();
			return;
		}if(year=="") {
			alert("연도를 입력해주세요");
			$("#year").focus();
			return;
		}if(cast=="") {
			alert("출연진을 입력해주세요");
			$("#cast").focus();
			return;
		}if(description=="") {
			alert("줄거리를 입력해주세요");
			$("#description").focus();
			return;
		}if(rated=="") {
			alert("등급을 입력해주세요");
			$("#rated").focus();
			return;
		}if(genre=="") {
			alert("장르를 입력해주세요");
			$("#genre").focus();
			return;
		}if(category==""){
			alert("카테고리를 입력해주세요");
			$("#category").focus();
			return;
		}
		if(confirm("등록하시겠습니까?")){
			document.form1.action="${path}/waffleContent/admin_insert.do";
			document.form1.submit();
		}
	});
});
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header.jsp" %>
<!-- base css -->
<link href="${path}/include/slider1.css" rel= "stylesheet"  type="text/css">
<!-- header css (search 기능 미포함) -->
<link href="${path}/include/head.css" rel= "stylesheet"  type="text/css">
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
	font-size: 20px;
	display:inline-block;
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
}

/* 줄거리 div */
.desc {
	height:auto;
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
	text-align: center;
	margin: 0 auto 15px;
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
/* insert 폼 수정 */
.cont_long{
	padding: 5px;
	width: 200px;
}
.cont_small{
	padding: 5px;
	width: 75%;
}
/* 년도 입력창 */
#year {padding: 5px; width: 70px;}
/* 포스터 링크 입력창 */
#poster {padding: 5px; width: 93.5%;}

input, textarea{font-size: 15px;}
textarea {width: 100%;}

#btnInsert {
    border: 2px solid white;
    border-radius: 50px;
    color: white;
    padding: 14px 27px;
    float: right;
    background-color: black;
    font-size: 17px;
    font-weight: bold;
    cursor: pointer;
}
#btnInsert:hover{
	background-color: white;
	color: black;
}
</style>
</head>
<body>
	<%@ include file="../include/head.jsp" %>

	<!-- 컨텐츠 디테일 뷰 -->
	<div id="cont_wrap">
		<form name="form1" method="post">
			<!-- 왼쪽 컨텐츠 -->
			<div id="cont_left">
				<h1><input placeholder="Title" class="cont_long" id="title" name="title"></h1>
				<p>| <input placeholder="Year" id="year" name="year"></p>
				
				<div class="box">
					<div class="actor">CAST</div>
					<p><input placeholder="Cast" class="cont_long" id="cast" name="cast"></p>
				</div>
				<div class="desc">
					<p><textarea id="description" name="description" rows="10" cols="80" placeholder="Description"></textarea></p>
				</div>
			</div>
			
			<!-- 오른쪽 컨텐츠 -->
			<div id="cont_right">
				<div class="intro_post">
					<input placeholder="Poster URL" id="poster" name="poster">
				</div>
				<div id="box_cont">
					<ul>
						<li>
							<h4 face="malgun gothic">RATED</h4>
					    	<h3><input placeholder="Rated" class="cont_small" id="rated" name="rated"></h3>  
						</li>
						<li>
							<h4 face="malgun gothic">GENRE</h4>
					 		<h3><input placeholder="Genre" class="cont_small" id="genre" name="genre"></h3>
						</li>
						<li>
							<h4 face="malgun gothic">CATEGORY</h4>
							<h3><input placeholder="Category" class="cont_small" id="category" name="category"></h3>
						</li>
					</ul>
				</div>
			</div>
				<button type="button" id="btnInsert">CONFIRM</button>
		</form>
	</div>
	
	<%@ include file="../include/footer.jsp" %>
</body>
</html>