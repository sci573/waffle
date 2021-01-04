<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>write</title>
<%@ include file="../include/header.jsp" %>
<!-- fontawsome -->
<script src="https://kit.fontawesome.com/a0fe62b208.js" crossorigin="anonymous"></script>
<script src="${path}/include/common.js"></script>
<!-- ckEditor의 라이브러리 -->
<script src="${path}/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
$(function() {
	//등록 버튼
	$("#btnSave").click(function() {
		if(confirm("게시물을 등록하시겠습니까?")){
			//폼 데이터를 서버로 제출
			document.form1.action="${path}/waffleBoard/insert.do";
			document.form1.submit();
		}
	});
	//취소 버튼
	$("#btnCancel").click(function() {
		if(confirm("게시물 작성을 취소하시겠습니까?")){
			location.href="${path}/waffleBoard/list.do";
		}
	});
	//로그아웃
	$("#btnLogout").click(function() {
		location.href="${path}/waffleMember/logout.do";
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
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&family=Rubik:ital,wght@1,700&family=Unica+One&display=swap" rel="stylesheet">
<style type="text/css">
/* 컨텐츠 파트 */
#cont_wrap {
	font-family: "맑은 고딕";
}
#cont_wrap h1 {
	margin: 50px auto 40px;
	text-align: center;
}
/* 커뮤니티 테이블 양식 */
table {
	clear: both;
	width: 50%;
	height: auto;
	margin: 30px auto;
	border-collapse: collapse;
	border: 1px solid white;
	text-align: center;
}
table tr {
	border-bottom: 1px solid white;
}
table td {
	padding: 15px;
}
/* 제목 입력창 양식 */
input {
	padding: 5px;
	width: -webkit-fill-available;
}
/* 버튼 양식 */
button {
	width: 53px;
	height: 25px;
	margin-left: 3px;
	padding-bottom: 3.5px;
	border: 1px solid white;
	border-radius: 3px;
	background-color: black;
	color: white;
	cursor: pointer;
}
button:hover {
	background-color: white;
	color: black;
}
</style>
</head>
<body>
	<%@ include file="../include/head.jsp" %>

	<!-- 컨텐츠 파트 -->
	<div id="cont_wrap">
		<h1>WRITE</h1>
		<form id="form1" name="form1" method="post">
			<table>
				<tr>
					<td>제목</td>
					<td><input name="title" id="title" placeholder="제목을 입력하세요"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td>
						<textarea id="content" name="content" placeholder="내용을 입력하세요"></textarea>
						<script type="text/javascript">
							//ckEditor 적용
							CKEDITOR.replace("content",{
								filebrowserUploadUrl: "${path}/wfImageUpload.do",
								height: "350px"
							});
						</script>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<button type="button" id="btnSave">확인</button>
						<button type="button" id="btnCancel">취소</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<%@ include file="../include/footer.jsp" %>
</body>
</html>