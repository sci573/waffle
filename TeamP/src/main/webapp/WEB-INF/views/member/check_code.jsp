<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>check_code</title>
<%@ include file="../include/header.jsp" %>
<script type="text/javascript">
$(function() {
	//만약 info_view에서 뒤로가기를 클릭했을 시 코드를 입력하면 null처리된 이메일 때문에 페이지 로딩이 되지 않는 에러 수정
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
	
	$("#btnCheck").click(function() {
		var c_code=$("#c_code").val();
		//null값 입력 방지
		if(c_code=="") {
			alert("코드를 입력하세요");
			$("#c_code").focus();
			return;
		}
		document.form1.action="${path}/waffleMember/codeConfirm.do";
		document.form1.submit();
	});		
});
</script>
<!-- 계정찾기 후 전달된 메시지 값 -->
<c:if test="${message == 'sended'}">
	<script>
		alert("이메일이 발송되었습니다.");
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
.code-content{
    margin: 150px auto;
    width: 800px;
} 
#codeForm{
	margin: 0 auto;
    padding: 50px 80px;
    width: 80%;
}
#btnCheck{
  	background-color: purple;
	color: white;
	border-radius: 40px;
	text-align: center;
	/* Spring에서 깨져서 button width값 수정 */
	width: 75%;
	height: 48px;
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
	margin: 45px auto 10px;
	color: white;
	text-align: center;
	font-size: 15px;
}
h1{
	font-size: 45px;
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

	<div class="code-content">
		<h1>Enter the Code!</h1>
		<hr>

		<div id="codeForm">
			<form method="post" name="form1">
				<div class="form">
					<input placeholder="Code" class="form-in" name="c_code" id="c_code"
						style="border-radius: 20px;">
				</div>
				<div class="form">
					<p>Verify your code</p>
				</div>
				<div class="form">
					<button type="button" id="btnCheck" class="form-in">CONFIRM</button>
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