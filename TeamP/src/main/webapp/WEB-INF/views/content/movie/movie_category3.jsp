<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:forEach var="row" items="${list}">
	<div class="post" style="cursor: pointer;">
		<a href="${pageContext.request.contextPath}/waffleContent/detail_view.do?title=${row.title}">
	   		<img src="${row.poster}" class="slider-image">
	   	</a>
	</div>
</c:forEach>