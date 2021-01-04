<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>find</title>
<%@ include file="../include/header.jsp" %>
<script type="text/javascript">
//뒤로가기 방지 (다시 check_code로 돌아오도록 설정)
window.history.forward();

$(function() {
	$("#btnFind").click(function() {
		document.form1.action="${path}/waffleMember/send.do";
		document.form1.submit();
	});
	$("#btnJoin").click(function() {
		location.href="${path}/waffleMember/join.do";
	});
});
</script>
<c:if test="${message == 'wrongCode'}">
	<script>
		alert("인증코드가 일치하지 않습니다.");
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
	font-family: 'Unica One', cursive;
	font-size: 40px;
	color: white;
	float: left;
	cursor: pointer;
}
.find-content{
    margin: 150px auto;
    width: 800px;
} 
#findForm{
	margin-left: auto;
    margin-right: auto;
    padding: 50px 80px;
    width: 80%;
}
#btnFind{
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
.form p {
	margin: 50px auto 25px;
	color: white;
	text-align: center;
	font-size: 13px;
}
h1{
	font-size: 50px;
	font-family: 'Yeseva One', cursive;
	letter-spacing: 10px;
}
a{all:unset;}
</style>
</head>
<body>
	<nav>
		<a href="${path}"><font>W a f f l e</font></a>
	</nav>

	<div class="find-content">
		<h1>Did you Forget?</h1>
		<hr>

		<div id="findForm">
			<form method="post" name="form1">
				<div class="form">
					<input placeholder="Email" class="form-in" name="email" id="email"
						style="border-radius: 20px;">
				</div>
				<div class="form">
					<p>Fill in your email below to request a certification code<br>An email will be sent to the address below containing your own certification code.</p>
				</div>
				<div class="form">
					<button type="button" id="btnFind" class="form-in">CONFIRM</button>
				</div>
			</form>
			
			<div style="color: gray; margin: 50px auto 0;">
				Aren't you a Waffle's member yet? <a id="btnJoin">SIGN UP NOW!</a>
			</div>
		</div>
		<hr>
	</div>
</body>
</html>