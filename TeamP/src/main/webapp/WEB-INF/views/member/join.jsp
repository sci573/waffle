<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>join</title>
<%@ include file="../include/header.jsp" %>
<script type="text/javascript">
$(function() {
	//로그인 버튼 클릭
	$("#btnLogin").click(function() {
		location.href="${path}/waffleMember/login.do";
	});

	//아이디 중복 체크
	$("#userid").focusout(function () {
		var param="userid="+$("#userid").val();
		$.ajax({
			type:"post",
			url:"${path}/waffleMember/id_check.do",
			data:param,
			dataType:'json',
			success:function(response) {
				console.log(response);
				/* alert(response.result); */
				if(response.result=="true") {
					$("#userid").val("");
					$("#userid").focus();
					document.getElementById('guide').style.display="inline-block";
					document.getElementById('guide').style.color="red";
					document.getElementById('guide').innerHTML="<p>이미 사용중인 아이디 입니다.</p>";
				} else {
					document.getElementById('guide').style.display="none";
				}
			}
		});
	});

	//이메일 중복 체크
	$("#email").focusout(function () {
		var param="email="+$("#email").val();
		$.ajax({
			type:"post",
			url:"${path}/waffleMember/email_check.do",
			data:param,
			dataType:'json',
			success:function(response) {
				console.log(response);
				/* alert(response.result); */
				if(response.result=="true") {
					$("#email").val("");
					$("#email").focus();
					document.getElementById('guide').style.display="inline-block";
					document.getElementById('guide').style.color="red";
					document.getElementById('guide').innerHTML="<p>이미 존재하는 이메일 입니다.</p>";
				} else {
					document.getElementById('guide').style.display="none";
				}
			}
		});
	});
	
	//회원가입 버튼 클릭
	$("#btnJoin").click(function() {
		//정규표현식(아이디,패스워드,이름,이메일)
		var regid = /^[a-zA-Z0-9]{3,10}$/;//아이디(알파벳 대소문자, 숫자로 시작해서 끝냄, 3~10 자리수)
		var regpw = /^[a-zA-Z0-9]{4,10}$/;//패스워드(알파벳 대소문자, 숫자로 시작해서 끝냄, 4~10 자리수)
		var regname = /^[가-힣ㄱ-ㅎㅏ-ㅣ]{2,4}$/;//이름(한글로 시작해서 끝냄, 2~4 자리수(이름은 두자에서 4자까지))
		var regemail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

		//값의 입력을 확인하기 위한 변수 선언
		var userid=$("#userid").val();
		var passwd=$("#passwd").val();
		var name=$("#name").val();
		var email=$("#email").val();

		//입력 확인
		if(userid=="") {
			alert("아이디를 입력하세요.");
			$("#userid").focus();
			return;	//함수 종료
		}
		//아이디 정규식 확인 (정규식대로 입력하지 않았을 경우)
		else if(!regid.test(userid)) {
			alert("아이디는 알파벳 대소문자 및 숫자를 포함한 3~10자를 입력해주세요.");
			$("#userid").focus();
			return;
		}
		else if(passwd=="") {
			alert("비밀번호를 입력하세요.");
			$("#passwd").focus();
			return;
		}
		//비밀번호 정규식 확인 (정규식대로 입력하지 않았을 경우)
		else if(!regpw.test(passwd)) {
			alert("비밀번호는 알파벳 대소문자 및 숫자를 포함한 4~10자를 입력해주세요.");
			$("#passwd").focus();
			return;
		}
		else if(name=="") {
			alert("이름을 입력하세요.");
			$("#name").focus();
			return;
		}
		//이름 정규식 확인 (정규식대로 입력하지 않았을 경우)
		else if(!regname.test(name)) {
			alert("이름은 한글로 2~4자를 입력해주세요.");
			$("#name").focus();
			return;
		}
		else if(email=="") {
			alert("이메일을 입력하세요.");
			$("#email").focus();
			return;
		}
		//이메일 정규식 확인 (정규식대로 입력하지 않았을 경우)
		else if(!regemail.test(email)) {
			alert("영문을 사용한 [abc@abcd.com] 의 형식을 맞춰주세요.");
			$("#email").focus();
			return;
		}
		
		document.form1.action="${path}/waffleMember/insert.do";
		document.form1.submit();
	});
});
</script>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Yeseva+One&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="${path}/include/font.css" />
<style>
body {
	margin: 0;
	padding: 0;	
	background-color: black;
	color: white;
	box-sizing: border-box;
}

font{
	font-family: 'Unica One', cursive;
	font-size: 40px;
	color: white;
	float: left;
	cursor: pointer;
}

nav {
	padding: 50px 55px;
}

.join-content {
	clear: both;
	margin: 150px auto;
	width: 800px;
	text-align: center;
}

#joinForm {
	margin: 0 auto;
    padding: 50px 80px 70px;
    width: 70%;
}

.form-in {
	/* Spring에서 깨져서 width값 수정 */
	width: 73.5%;
	padding: 15px;
	border-bottom-width: 1px;
	height: 21px;
}

.form {
	height: 50px;
}

h1 {
	font-size: 50px;
	font-family: 'Yeseva One', cursive;
	letter-spacing: 10px;
}

a {all: unset;}

#btnLogin {
	color: #000000;
    border: #000000 solid 1px;
    padding: 10px;
    background-color: #ffffff;
    font-family: 'Unica One', cursive;
    font-size: 20px;
    float: right;
    cursor: pointer;
}
#btnLogin:hover {
    color: #ffffff;
    background-color: #000000;
}
#btnJoin{
	background-color: purple;
	color: white;
	border-radius: 40px;
	text-align: center;
	/* Spring에서 깨져서 button width값 수정 */
	width: 79%;
	height: 48px;
	margin: 20px auto;
	border-style: unset;
	font-size: 15px;
	cursor: pointer;
}
/* 중복체크 안내 */
#guide {
	display: none;
}
</style>
</head>
<body>
	<nav>
		<a href="${path}"><font>W a f f l e</font></a>
		<button type="button" id="btnLogin">LOGIN</button>
	</nav>
	
	<div class="join-content">
		<h1>SIGN UP</h1>
		<hr>
		<div id="joinForm">
			<form method="post" name="form1">
				<div class="form">
					<input placeholder="ID" class="form-in" name="userid" id="userid"
						style="border-top-left-radius: 20px; border-top-right-radius: 20px;">
				</div>
				<div class="form">
					<input placeholder="Password" type="password" name="passwd" id="passwd" class="form-in">
				</div>
				<div class="form">
					<input placeholder="Name" class="form-in" name="name" id="name">
				</div>
				<div class="form">
					<input placeholder="Email(example@gmail.com)" class="form-in" name="email" id="email"
						style="border-bottom-left-radius: 20px; border-bottom-right-radius: 20px;">
				</div>
				<div id="guide">
				</div>
				<div class="form">
					<button id="btnJoin" class="form-in" type="button">CREATE ACCOUNT</button>
				</div>
			</form>
		</div>
		<hr>
	</div>
</body>
</html>