<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>info_view</title>
<%@ include file="../include/header.jsp" %>
<!-- fontawsome -->
<script src="https://kit.fontawesome.com/a0fe62b208.js" crossorigin="anonymous"></script>
<script type="text/javascript">
//뒤로가기 방지 (다시 login으로 돌아오도록 설정)
window.history.forward();

$(function() {
	//로그인 버튼 클릭
	/* $("#btnLogin").click(function() {
		location.href="${path}/waffleMember/login.do";
	}); */
	//로그아웃 버튼 클릭
	$("#btnLogout").click(function() {
		location.href="${path}/waffleMember/logout.do";
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
	
	//회원정보 수정
	$("#btnUpdate").click(function() {
		var passwd=$("#passwd").val();
		var name=$("#name").val();
		var email=$("#email").val();
		//입력 확인
		if(passwd=="") {
			alert("비밀번호를 입력하세요.");
			$("#passwd").focus();
			return;
		}
		else if(name=="") {
			alert("이름을 입력하세요.");
			$("#name").focus();
			return;
		}
		else if(email=="") {
			alert("이메일을 입력하세요.");
			$("#email").focus();
			return;
		}
		
		document.form1.action="${path}/waffleMember/update.do";
		document.form1.submit();
	});

	//회원 탈퇴
	$("#btnDelete").click(function() {
		//탈퇴할지 확인
		if(confirm("회원탈퇴 하시겠습니까?")){
			//폼 데이터를 제출할 주소
			document.form1.action="${path}/waffleMember/delete.do";
			//폼 데이터를 서버에 제출
			document.form1.submit();
		}
	});
});
</script>
<!-- base css -->
<link href="${path}/include/slider1.css" rel= "stylesheet"  type="text/css">
<!-- footer css -->
<link href="${path}/include/footer.css" rel= "stylesheet"  type="text/css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Yeseva+One&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="${path}/include/font.css" />
<style>
/* 헤드 파트 */
#head_wrap {
	width: 100%;
	height: auto;
}

/* 상단바 */
/* session on */
.head_content_1 {
	padding: 30px;
	height: 88px;
}
.head_content_1 h1 {
	display: inline-block;
	margin: 0 0 0 30px;
	cursor: pointer;
}
#head_content_1 > h1 > a:hover {
	color: #f3e6ff;
	text-shadow: 2px 2px 4px #f3e6ff, 0 0 0.1em #f3e6ff;
}
/* session off */
.head_content_2 {
	padding: 50px 55px;
}
font{
	font-family: 'Unica One', cursive;
	font-size: 40px;
	color: white;
	float: left;
	cursor: pointer;
}
/* 왼쪽 메뉴 */
/* ul */
#left_nav {
	display: inline-block;
	margin:0 0 0 35px;
	list-style: none;
	vertical-align: top;
}
#left_nav li {
	display: inline-block;
	font-family: "Unica One", cursive;
	padding: 15px;
	font-size: 23px;
	cursor: pointer;
}
#left_nav a:hover {
	color: #f3e6ff;
	text-shadow: 2px 2px 5px #f3e6ff;
}

/* 오른쪽 메뉴 */
/* ul */
#right_nav {
	display: inline-block;
	list-style: none;
	float: right;
	margin-right: 20px;
}
#right_nav li {
	position: relative;
	display: inline-block;
	font-family: "Unica One", cursive;
	padding: 13.5px;
	font-size: 20px;
	cursor: pointer;
}
#right_nav li:hover {
	color: lightgray;
}
/* 이름표시 */
#right_nav p {
	display: inline-block;
    margin: 0;
    padding-left: 6px;
    vertical-align: super;
    font-size: 17px;
    font-family: "맑은 고딕";
}

/* 오른쪽 메뉴 드롭다운 */
#right_sub_nav {
	position: absolute;
	opacity: 0;
	visibility: hidden;
	background-color: white;
	transition: all 0.5s ease-in-out;
	top: 60px;
	right: -6px;
}
#right_sub_nav li {
	padding: 5px;
	border-bottom: 1px solid black;
	width: 120px;
	clear: both;
	display: block;
	text-align: center;
}
#right_sub_nav a {
	color: black;
}
/* 유저 아이콘 */
.fa-user-circle, #right_sub_nav {padding: 0; margin: 0;}

.fa-user-circle {font-size: 35px;}

/* 이미지에 mouse hover시 */
#right_nav > li:hover #right_sub_nav {
	opacity: 1;
	visibility: visible;
}

#right_sub_nav > li > a:hover {
	text-decoration: underline;
}

/* 수정 폼 */
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
	font-size: 35px;
	font-family: "Yeseva One", cursive;
	text-align: center;
	letter-spacing: 3px;
}
#updateForm {
	margin: 0 auto;
	padding: 50px 80px;
	text-align: center;
	width: 65%;
}
#updateForm h1 {
	font-size: 25px;
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

/* 수정버튼 */
#btnUpdate {
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

/* 탈퇴버튼 */
#btnDelete {
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

/* 로그인 버튼 */
/* #btnLogin {
	font-family: "Unica One", cursive;
	font-size: 20px;
	float: right;
	cursor: pointer;
	color: #000000;
    border: #000000 solid 1px;
    padding: 10px;
    background-color: #ffffff;	
}
#btnLogin:hover {
    color: #ffffff;
    background-color: #000000;
} */

/* 중복체크 안내 */
#guide {
	display: none;
}
</style>
</head>
<body>
<!-- 헤드 파트 -->
<c:choose>
	<c:when test="${sessionScope.userid != null}">
		<div id="head_wrap">
			<nav class="head_content_1">
				<h1><a href="${path}/waffleContent/main_view.do">W a f f l e</a></h1>
				<!-- 왼쪽 -->
				<ul id="left_nav">
					<li><a href="${path}/waffleContent/movie.do">MOVIE</a></li>
					<li><a href="${path}/waffleContent/drama.do">DRAMA</a></li>
					<li><a href="${path}/waffleBoard/list.do">COMMUNITY</a></li>
				</ul>
				<!-- 오른쪽 -->
				<ul id="right_nav">
					<!-- 드롭다운 메뉴 폼 -->
					<li>
				    	<i class="fas fa-user-circle"></i>
						<p>${sessionScope.name}</p>
						<ul id="right_sub_nav">
							<li><a id="btnLogout">LOG-OUT</a></li>
							<c:choose>
								<c:when test="${sessionScope.admin_userid == null}">
									<!-- 관리자는 찜하기 기능을 이용할 수 없다. -->
									<li><a href="${path}/waffleFavor/list.do">FAVORITE</a></li>
								</c:when>
								<c:otherwise>
									<!-- 새 컨텐츠 등록 -->
									<li><a href="${path}/waffleContent/admin_insert_view.do">NEW CONTENT</a></li>
								</c:otherwise>
							</c:choose>
							<li><a href="${path}/waffleMember/idpwCheck_view.do">MY INFO</a></li>
						</ul>
					</li>
				</ul>	
			</nav>
		</div>
	</c:when>
	
	<c:otherwise>
		<nav class="head_content_2">
			<a href="${path}"><font>W a f f l e</font></a>
			<!-- <button type="button" id="btnLogin">LOGIN</button> -->
		</nav>
	</c:otherwise>
</c:choose>

	<div class="update-content">
		<h1>Change Your Info!</h1>
		<div id="updateForm">
			<form method="post" name="form1">
				<h1>[${dto.userid}]님</h1>
				<!-- id는 변경하지 않지만 나머지 정보를 수정하기위해서는 필요하다 -->
				<input type="hidden" name="userid" id="userid" value="${dto.userid}">
				<div class="form">
					<input placeholder="Password" class="form-in" type="password" name="passwd" id="passwd" 
					style="border-top-left-radius: 20px; border-top-right-radius: 20px;">
				</div>
				<div class="form">
					<input placeholder="Name" class="form-in" name="name" id="name" value="${dto.name}">
				</div>
				<div class="form">
					<input placeholder="Email(example@gmail.com)" class="form-in" name="email" id="email" value="${dto.email}"
						style="border-bottom-left-radius: 20px; border-bottom-right-radius: 20px;">
				</div>
				<div id="guide">
				</div>
				<div class="form">
					<button id="btnUpdate" class="form-in" type="button">정보 수정하기</button>
				<!-- 로그인 되어있을때만 회원탈퇴 버튼이 보인다. (관리자는 탈퇴할 수 없음) -->
				<c:if test="${sessionScope.userid != null && sessionScope.admin_userid == null}">
					<button id="btnDelete" class="form-in" type="button">회원 탈퇴</button>
				</c:if>
				</div>
			</form>
		</div>
	</div>
	
	<!-- 로그인 되어있을 때만 footer가 보이도록 한다 -->
	<c:if test="${sessionScope.userid != null}">
		<%@ include file="../include/footer.jsp" %>
	</c:if>
</body>
</html>