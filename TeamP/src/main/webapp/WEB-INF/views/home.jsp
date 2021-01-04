<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> --%>
<%@ page session="true" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Main Page</title>
<%@ include file="include/header.jsp" %>	
</head>
<script type="text/javascript">
$(function() {
	//만약 info_view에서 와플 로고(홈 화면으로 이동)를 클릭했을 시 코드를 입력하면 null처리된 이메일 때문에 페이지 로딩이 되지 않는 에러 수정
	var email="${sessionScope.email}";
	var code=${sessionScope.code}+0;
	//null값으로 처리된 email을 다시 원상복구시켜준다.
	var param = { "email" : email , "code" : code };
	$.ajax({
		type:"post",
		url:"${path}/waffleMember/email_put.do",
		data:param,
		success:function() {
			console.log();
		}
	});
	
	//로그인 버튼 클릭
	$(".btnLogin").click(function() {
		location.href="${path}/waffleMember/login.do";
	});
	//회원가입 버튼 클릭
	$("#btnJoin").click(function() {
		location.href="${path}/waffleMember/join.do";
	});
});
</script>
<%-- <c:if test="${message == 'byebye'}">
	<script>
		alert("로그아웃 되었습니다.");
	</script>
</c:if> --%>
<link rel="stylesheet" href="${path}/include/font.css" />
<style type="text/css">
/* 기본설정 */
body {
	margin: 0;
	padding: 0;	
	color: black;	
}
nav {
	padding: 50px 55px;
}
nav h1 {
	display: inline-block;
	margin: 10px;
}
/* 컨텐츠 */
#center {
	width: 100%;
	height: 500px;
	margin: 0 auto;
	text-align: center;
}
#login_f {
	margin-top: 50px;
	width: 100%;
	height: 800px;
	text-align: center;
}
#login_f h1, #login_f h2, #login_f h3, #join{
	margin: 10px;
	padding: 5px 0px;
	color: white;
}
#join {
	width: 100%;
	height: auto;
	vertical-align: middle;
	margin: 30px auto;
	cursor: pointer;
}
/* 회원가입 버튼 */
#btnJoin {
	color: #000000;
    border: #000000 solid 1px;
    padding: 10px;
    background-color: #ffffff;	
}
#btnJoin:hover {
    color: #ffffff;
    background-color: #000000;
}
/* 로그인 버튼 */
.btnLogin {
    background: white;
    color:#fff;
    border:none;
    position:relative;
    height:60px;
    font-size:1.6em;
    padding:0 2em;
    margin-top: 30px;
    cursor:pointer;
    transition:800ms ease all;
    outline:none;
}
.btnLogin:hover{
    background: white;
    color:#60108E;
}
.btnLogin:before, .btnLogin:after{
	content:'';
	position:absolute;
	top:0;
	right:0;
	height:4px;
	width:0;
	background: #60108E;
	transition:400ms ease all;
}
.btnLogin:after{
  	right:inherit;
  	top:inherit;
  	left:0;
  	bottom:0;
}
.btnLogin:hover:before,.btnLogin:hover:after{
  	width:100%;
  	transition:800ms ease all;
}
.video{
	position: absolute;
	min-width: 100%;
	min-height: 100%;
	right: 0;
	bottom: 0;
	z-index: -1;
}
.home {
	clear: both;
}
font{
	font-family: 'Unica One', cursive;
	font-size: 40px;
	color: white;
	cursor: pointer;
}
</style>

<body>
	<section class="wrap">
		<video class="video" muted autoplay loop >
			<source src="${path}/video/v6.mp4" type="video/mp4">
		</video>  
		<nav>
			<a href="${path}"><font style="float: left;">W a f f l e</font></a>
			<button id="btnJoin" type="button" style="font-family: 'Unica One', cursive; font-size: 20px; float: right; cursor: pointer;">SIGN UP</button>
		</nav>
		<div class="home">
			<div id="center" style="width: 880px; margin-top: 200px;">
				<div id="login_f" style="height: 500px;" >
				<h2 style="font-family: 'Noto Sans KR', sans-serif; font-size: 50px; height: 70px;">영화, 드라마를 무제한으로<br></h2>
				<h3 style="font-family: 'Noto Sans KR', sans-serif; font-size: 35px;" >매주 신작이 업데이트 됩니다. 마음껏 즐겨보세요!</h3>
					<button class="btnLogin"><font style="font-family: 'Unica One', cursive; color: #60108E; margin-top: 70px;">L O G I N</font></button>			 
				</div>
			</div>
		</div>
	</section>
</body>
</html>