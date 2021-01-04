<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Cache-control" content="no-cache" charset="UTF-8">
<title>login</title>
<%@ include file="../include/header.jsp" %>
<script type="text/javascript">
//뒤로가기 방지 (다시 main_view로 돌아오도록 설정)
window.history.forward();

$(function() {
	//로그인(세션off일때)
	$("#btnLogin").click(function() {
		var userid=$("#userid").val();
		var passwd=$("#passwd").val();
		//입력 확인
		if(userid=="") {
			alert("아이디를 입력하세요.");
			$("#userid").focus();
			return;	//함수 종료
		}
		else if(passwd=="") {
			alert("비밀번호를 입력하세요.");
			$("#passwd").focus();
			return;
		}
		document.form1.action="${path}/waffleMember/login_check.do";
		document.form1.submit();
	});
	//회원가입
	$("#btnJoin").click(function() {
		location.href="${path}/waffleMember/join.do";
	});
	//로그아웃(세션on일때)
	$("#btnLogout").click(function() {
		location.href="${path}/waffleMember/logout.do";
	});
});
</script>
<c:if test="${message == 'error'}">
	<script>
		alert("아이디 또는 비밀번호가 일치하지 않습니다.");
	</script>
</c:if>
<c:if test="${message == 'welcome'}">
	<script>
		alert("환영합니다.");
	</script>
</c:if>
<!-- 회원탈퇴 후 메시지 -->
<c:if test="${message == 'good-bye'}">
	<script>
		alert("안녕히 가세요...");
	</script>
</c:if>
<!-- 계정찾기 후 전달된 메시지 값 -->
<c:if test="${message == 'nowhere'}">
	<script>
		alert("해당 이메일은 가입되지 않은 이메일입니다.");
	</script>
</c:if>
<c:if test="${message == 'failed'}">
	<script>
		alert("이메일 발송이 실패했습니다.");
	</script>
</c:if>
<c:if test="${message == 'modified'}">
	<script>
		alert("회원정보가 수정되었습니다.");
		alert("변경된 정보로 로그인 해주세요");
	</script>
</c:if>
<!-- 관리자 이메일을 입력했을시 -->
<c:if test="${message == 'admin'}">
	<script>
		alert("관리자 이메일 입니다.");
	</script>
</c:if>
<!-- 로그인 인터셉터에서 전달된 메시지 -->
<c:if test="${param.message == 'nologin'}">
	<script>
		alert("로그인 후 이용가능합니다.");
	</script>		
</c:if>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Yeseva+One&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${path}/include/font.css" />
<style>
body{
	margin: 0;
	padding: 0;	
	background-color: black;
	text-align: center;
	color: white;
	box-sizing: border-box;
}
nav {
	padding: 50px 55px;
}
font{
	font-family: "Unica One", cursive;
	font-size: 40px;
	color: white;
	float: left;
	cursor: pointer;
}
/* 로그아웃 버튼 */
#btnLogout {
	color: #000000;
    border: #000000 solid 1px;
    padding: 10px;
    background-color: #ffffff;
    font-family: 'Unica One', cursive;
    font-size: 20px;
    float: right;
    cursor: pointer;
}
#btnLogout:hover {
    color: #ffffff;
    background-color: #000000;
}

.login-content{
    margin: 150px auto;
    width: 800px;
} 
#loginForm{
	margin: 0 auto;
    padding: 50px 80px;
    width: 80%;
}
#btnLogin{
  	background-color: purple;
	color: white;
	border-radius: 40px;
	text-align: center;
	/* Spring에서 깨져서 button width값 수정 */
	width: 75%;
	height: 48px;
	margin-top: 20px;
	border-style: unset;
	font-size: 20px;
    padding: 7px;
    cursor: pointer;
}
#btnJoin{
	color: white;
	cursor: pointer;
}
#btnJoin:hover{
	text-decoration: underline;
}

.form-in{
	/* Spring에서 깨져서 width값 수정 */
	width: 69.5%;
	padding: 16.5px 18px 13.5px;
    border-bottom-width: 1px;
    height: 32px;
    font-size: 17px;
	}
.form{
	height: 50px;
}
h1{
	font-size: 45px;
	font-family: 'Yeseva One', cursive;
	letter-spacing: 10px;
}

a{all:unset;}

#searchInfo{
	font-size: small;
	color: white;
	cursor: pointer;
}
#searchInfo:hover {
	text-decoration: underline;
}
</style>
</head>
<body>
	<nav>
		<a href="${path}"><font>W a f f l e</font></a>
	<!-- 서버가 재시작 될 때 세션을 초기화하고 싶을 때 : tomcat서버 context.xml 의 <Manager pathname=""/> 에서 주석 제거 [참조 : https://dololak.tistory.com/738] -->
	<c:if test="${sessionScope.userid != null}">
		<button type="button" id="btnLogout">LOG-OUT</button>
	</c:if>
	</nav>

	<div class="login-content">
	<c:choose>
		<c:when test="${sessionScope.userid == null}">
			<h1>LOGIN</h1>
			<hr>
	
			<div id="loginForm">
				<form method="post" name="form1">
					<div class="form">
						<input placeholder="ID" class="form-in" name="userid" id="userid"
							style="border-top-left-radius: 20px; border-top-right-radius: 20px;">
					</div>
					<div class="form">
						<input placeholder="Password" type="password" class="form-in" name="passwd" id="passwd"
							style="border-bottom-left-radius: 20px; border-bottom-right-radius: 20px; margin-top: 14px;">
					</div>
					<div class="form" style="margin-top: 50px;">
						<button type="button" id="btnLogin" class="form-in">LOGIN</button>
					</div>
				</form>
				
				<div style="margin: 30px;">
					<a id="searchInfo" href="${path}/waffleMember/find.do">
						Forgot your password?
					</a>
				</div>
				<div style="color: gray;">
					Aren't you a Waffle's member yet? <a id="btnJoin">SIGN UP NOW!</a>
				</div>
			</div>
			<hr>
		</c:when>
		<c:otherwise>
			<h1>You've logged in</h1>
		</c:otherwise>
	</c:choose>
	</div>
</body>
</html>