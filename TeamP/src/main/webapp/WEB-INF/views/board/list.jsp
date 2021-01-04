<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Community</title>
<%@ include file="../include/header.jsp" %>
<!-- fontawsome -->
<script src="https://kit.fontawesome.com/a0fe62b208.js" crossorigin="anonymous"></script>
<script type="text/javascript">
$(function() {
	//게시물 작성
	$("#btnWrite").click(function() {
		location.href="${path}/waffleBoard/write.do";
	});
	//로그아웃
	$("#btnLogout").click(function() {
		location.href="${path}/waffleMember/logout.do";
	});
});

function list(page) {
	location.href="${path}/waffleBoard/list.do?curPage="+page;
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
#cont_wrap h1 {
	margin: 30px;
	text-align: center;
}
/* 커뮤니티 테이블 양식 */
table {
	clear: both;
	width: 90%;
	height: auto;
	margin: 30px auto;
	border-collapse: collapse;
	border: black;
	text-align: center;
}
table tr {
	border-bottom: 1px solid white;
}
table th, table td {
	padding: 15px 0;
}
table a {
	text-decoration: none;
}
table a:hover {
	text-shadow: 1px 1px 10px white;
	cursor: pointer;
}
/* 댓글 갯수 */
table span {
	margin-left: 10px;
	padding-bottom: 2px;
	display: inline-block;
	width: 20px;
	background-color: #d11aff;
	border-radius: 6.5px;
	color: white;
}
/* 검색 폼 태그 양식 */
#s_form {
	margin: 40px 5% 50px;
	float: right;
}
#s_form select {
	width: 135px;
	height: 26px;
	padding: 1px;
	border: 1px solid white;
	border-radius: 3px;
}
#s_form input {
	width: 200px;
	height: 21.5px;
	margin-left: 3px;
	border: 1px solid white;
	border-radius: 3px;
}
#s_form button {
	width: 55px;
	height: 26px;
	margin-left: 2px;
	padding: 0 3px;
	border: 1px solid white;
	border-radius: 3px;
	background-color: black;
	color: white;
	cursor: pointer;
}
#s_form button:hover {
	background-color: white;
	color: black;
}
/* 글쓰기 버튼 */
#btnWrite{
	float: right;
	margin: 10px 5% 50px;
	width: 65px;
	height: 30px;
	padding-bottom: 5px;
	border: 1px ridge white;
	border-radius: 5px;
	background-color: black;
	color: white;
	cursor: pointer;
}
#btnWrite:hover {
	background-color: white;
	color: black;
}
</style>
</head>
<body>
	<%@ include file="../include/head.jsp" %>
	
	<!-- 컨텐츠 파트 -->
	<div id="cont_wrap">
		<h1>COMMUNITY</h1>
		<div id="s_form">
			<form name="form1" method="post" action="${path}/waffleBoard/list.do">
				<select name="search_option">
					<option value="writer"
						<c:if test="${map.search_option == 'writer'}">selected</c:if>
					>작성자</option>
					<option value="title"
						<c:if test="${map.search_option == 'title'}">selected</c:if>
					>제목</option>
					<option value="content"
						<c:if test="${map.search_option == 'content'}">selected</c:if>
					>내용</option>
					<option value="all"
						<c:if test="${map.search_option == 'all'}">selected</c:if>
					>작성자+제목+내용</option>
				</select>
				<input name="keyword" value="${map.keyword}">
				<button>Search</button>
			</form>
		</div>
		
		<table border="1">
			<tr>
				<th>번호 </th>
				<th>제목 </th>
				<th>작성자 </th>
				<th>작성일 </th>
				<th>조회수 </th>
			</tr>
			<!-- forEach var="개별데이터" items="집합데이터" -->
		<c:forEach var="row" items="${map.list}">
			<tr>
				<td>${row.bno}</td>
				<td><a href="${path}/waffleBoard/view.do?bno=${row.bno}">${row.title}</a>
					<!-- 댓글 갯수 표시 -->
					<c:if test="${row.cnt > 0}">
						<span>${row.cnt}</span>
					</c:if>
				</td>
				<td>${row.writer}</td>
				<td><fmt:formatDate value="${row.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/> </td><!-- 우리가 보기 편한 시간 패턴 -->
				<td>${row.viewcnt}</td>
			</tr>
		</c:forEach>
		<!-- 페이지 네비게이션 출력 -->
			<tr>
				<td colspan="5" align="center">
					<c:if test="${map.pager.curBlock > 1}">
						<a href="#" onclick="list('1')">[처음]</a>
					</c:if>
					<c:if test="${map.pager.curBlock > 1}">
						<a href="#" onclick="list('${map.pager.prevPage}')">
						[이전]</a>
					</c:if>
					<c:forEach var="num" 
						begin="${map.pager.blockStart}"
						end="${map.pager.blockEnd}">
						<c:choose>
							<c:when test="${num == map.pager.curPage}">
							<!-- 현재 페이지인 경우 하이퍼링크 제거 -->
								<span style="margin: 0;">${num}</span>
							</c:when>
							<c:otherwise>
								<a href="#" onclick="list('${num}')">${num}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${map.pager.curBlock < map.pager.totBlock}">
						<a href="#" 
						onclick="list('${map.pager.nextPage}')">[다음]</a>
					</c:if>
					<c:if test="${map.pager.curPage < map.pager.totPage}">
						<a href="#" 
						onclick="list('${map.pager.totPage}')">[끝]</a>
					</c:if>
				</td>
			</tr>
		</table>
		<button type="button" id="btnWrite">글쓰기</button>
	</div>
	
	<%@ include file="../include/footer.jsp" %>
</body>
</html>