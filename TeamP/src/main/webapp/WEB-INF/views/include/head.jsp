<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 헤드 파트 -->
<div id="head_wrap">
	<nav id="head_content">
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