<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>info_view</title>
<%@ include file="../include/header.jsp" %>
<!-- fontawsome -->
<script src="https://kit.fontawesome.com/a0fe62b208.js" crossorigin="anonymous"></script>
<script type="text/javascript">
$(function() {
	//로그아웃
	$("#btnLogout").click(function() {
		location.href="${path}/waffleMember/logout.do";
	});
	
	//비번 확인
	$("#btnCheck").click(function() {
		var passwd=$("#passwd").val();
		if(passwd==""){
			alert("비밀번호를 입력하세요.");
			$("#passwd").focus();
			return;
		}

	//입력값이 세션값과 같은지 확인 (삼항연산자 사용)
	checkpw=("${sessionScope.passwd}" === passwd) ? true : false;

	//일치하면 개인정보 수정 페이지로 이동
	if(checkpw){
		document.form1.action="${path}/waffleMember/info_view.do";
		document.form1.submit();
		}else{
			alert("비밀번호가 일치하지 않습니다.");
			$("#passwd").focus();
			return;
		}
	});
});
</script>
<!-- base css -->
<link href="${path}/include/slider1.css" rel= "stylesheet"  type="text/css">
<!-- header css (search 기능 미포함) -->
<link href="${path}/include/head.css" rel= "stylesheet"  type="text/css">
<!-- footer css -->
<link href="${path}/include/footer.css" rel= "stylesheet"  type="text/css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Yeseva+One&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="${path}/include/font.css" />
<style>
/* 수정폼 */
.update-content {
	clear: both;
	margin-left: auto;
	margin-right: auto;
	width: 800px;
	margin-top: 100px;
}
.update-content > h1 {
	margin: 0;
    padding: 0 130px;
    font-size: 30px;
    font-family: "Yeseva One", cursive;
    text-align: center;
    letter-spacing: 1px;
}

#updateForm {
	margin: 0 auto;
	padding: 50px 80px;
	text-align: center;
	width: 65%;
}
/* 폼 전체 */
.form {
	height: 50px;
}
/* 폼 내부(아이디, 비번 등) */
.form-in {
	/* Spring에서 깨져서 width값 수정 */
	width: 73.5%;
	padding: 15px;
	border-bottom-width: 1px;
	height: 21px;
}
/* 수정 버튼 */
#btnCheck{
	background-color: purple;
	color: white;
	border-radius: 40px;
	text-align: center;
	/* Spring에서 깨져서 button width값 수정 */
	width: 80%;
	height: 48px;
	margin-top: 20px;
	border-style: unset;
	font-size: 15px;
	cursor: pointer;
}
</style>
</head>
<body>
	<%@ include file="../include/head.jsp" %>
	
	<div class="update-content">
		<h1>Please Enter Password To Protect Your Personal Information.</h1>
		<div id="updateForm">
			<form method="post" name="form1">
				<!-- id는 변경하지 않지만 나머지 정보를 수정하기위해서는 필요하다 -->
				<div class="form">
					<input type="hidden" value="${sessionScope.userid}" id="userid" name="userid">
					<input placeholder="Password" class="form-in" type="password" name="passwd" id="passwd"
						style="border-radius: 20px;"> 
				</div>
				<div class="form">
					<button id="btnCheck" class="form-in" type="button">CONFIRM</button>
				</div>
			</form>
		</div>
	</div>
	
	<%@ include file="../include/footer.jsp" %>
</body>
</html>