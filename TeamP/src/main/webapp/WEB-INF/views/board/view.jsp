<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>view</title>
<%@ include file="../include/header.jsp" %>
<!-- fontawsome -->
<script src="https://kit.fontawesome.com/a0fe62b208.js" crossorigin="anonymous"></script>
<script type="text/javascript">
$(function() {
	//댓글 목록 출력
	listReply();

	//댓글 쓰기
	$("#btnReply").click(function(){
		if(confirm("댓글을 등록하시겠습니까?")){
			var replytext=$("#replytext").val(); //댓글 내용
			var bno="${dto.bno}"; //게시물 번호

			if(replytext=="") {
				alert("댓글 내용을 입력해주세요");
				$("#replytext").focus();
				return;
			}
			
			var param={ "replytext": replytext, "bno": bno};
			//var param="replytext="+replytext+"&bno="+bno;
			$.ajax({
				type: "post",
				url: "${path}/waffleBoard/replyInsert.do",
				data: param,
				success: function(){
					alert("댓글이 등록되었습니다.");
					$("#replytext").val("");	//텍스트 창 초기화
					listReply(); //댓글 목록 출력
				}
			});
		}
	});
	
	//수정페이지로 이동하는 버튼
	$("#btnEdit").click(function(){
		document.form1.action="${path}/waffleBoard/edit.do";
		document.form1.submit();
	});
	//삭제 버튼
	$("#btnDelete").click(function(){
		if(confirm("게시물을 삭제하시겠습니까?")){
			document.form1.action="${path}/waffleBoard/delete.do";
			document.form1.submit();
		}
	});
	//목록으로 이동하는 버튼
	$("#btnList").click(function(){
		location.href="${path}/waffleBoard/list.do";
	});
	//로그아웃
	$("#btnLogout").click(function() {
		location.href="${path}/waffleMember/logout.do";
	});
});
//댓글 목록 출력 함수
function listReply(){
	$.ajax({
		type: "post",
		url: "${path}/waffleBoard/replyList.do",
		data: "bno=${dto.bno}",
		success: function(result){
			//result : responseText 응답텍스트(html)
			console.log(result);
			$("#listReply").html(result);
		}
	});
}
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
#cont_wrap h2, #cont_wrap h3 {
	margin: 50px auto 40px;
	text-align: center;
}
#cont_wrap h4 {
	margin: 0;
	text-align: center;
}
/* 커뮤니티 뷰 테이블 양식 */
table {
	clear: both;
	width: 70%;
	height: auto;
	margin: 50px auto 100px;
	border-collapse: collapse;
	border: 1px solid white;
	text-align: justify;
}
table.content td {
	border: 1px solid white;
	padding: 15px;
}
table.reply {
	text-align: center;
	margin: 50px auto;
}
table.reply td {
	padding: 15px;
}

table a {
	color: white;
	text-decoration: none;
}
table a:hover {
	background-color: white;
	color: black;
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
/* 댓글 입력 양식 */
textarea {
	width: -webkit-fill-available;
}
/* 댓글 입력 placeholder 글자 색 수정 */
textarea::placeholder {
  color: black;
  font-weight: bold;
}
</style>
</head>
<body>
	<%@ include file="../include/head.jsp" %>
	
	<!-- 컨텐츠 파트 -->
	<div id="cont_wrap">
		<form id="form1" name="form1" method="post">
		<h2>- ${dto.title} -</h2>
			<table class="content">
				<tr>
					<td width="20%">날짜</td>
					<td width="60%">
						<fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd HH:mm:ss" />
					</td>
					<td width="10%">조회수</td>
					<td width="10%">${dto.viewcnt}</td>
				</tr>
				<tr>
					<td>아이디</td>
					<td colspan="3">${dto.writer}</td>
				</tr>
				<tr height="300px">
					<td>본문</td>
					<td colspan="3">${dto.content}</td>
				</tr>
				<tr>
					<td colspan="4" align="center">
						<!-- 수정, 삭제에 필요한 글번호를 hidden 태그에 저장 -->
						<input type="hidden" name="bno" value="${dto.bno}">
						<!-- 본인만 수정, 삭제 버튼 표시 -->
						<c:if test="${sessionScope.userid == dto.writer || sessionScope.admin_userid != null}">
							<button type="button" id="btnEdit">수정</button>
							<button type="button" id="btnDelete">삭제</button>
						</c:if>
						<button type="button" id="btnList">목록</button>
					</td>
				</tr>
			</table>
		</form>
		<hr>
		<h3>- Comment -</h3>
		<!-- 댓글 목록을 출력할 영역 -->
		<div id="listReply"></div>
		<!-- 댓글 작성 -->
		<table class="reply">
			<tr>
				<td>
					<h4> w r i t e r ✒️ ---- ${sessionScope.userid} ---- </h4>
				</td>
				<td rowspan="2" width="10%" style="padding-right: 30px">
					<button type="button" id="btnReply">Post</button>
				</td>
			</tr>
			<tr>
				<td>
					<textarea rows="5" id="replytext" placeholder="댓글을 입력하세요"></textarea>
				</td>
			</tr>
		</table>
		<br>
	</div>
	
	<%@ include file="../include/footer.jsp" %>
</body>
</html>