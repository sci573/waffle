<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<table class="reply">
<!-- fn: header.jsp의 jstl -->
<c:forEach var="row" items="${list}">
<script type="text/javascript">
function del_${row.rno}() {
	if(confirm("댓글을 삭제하시겠습니까?")){
		var replyer=$(".${row.replyer}").val();
		var rno=$("#${row.rno}").val();
		var bno=$(".${row.bno}").val();
		var param="replyer="+replyer+"&rno="+rno+"&bno="+bno;
		$.ajax({
			type : "post",
			url : "${pageContext.request.contextPath}/waffleBoard/replyDelete.do",
			data : param,
			success : function(){
				alert("댓글이 삭제되었습니다");
				listReply();
			}
		});	
	}
}
</script>
	<c:set var="str" value="${fn:replace(row.replytext,'<','&lt;') }" />
	<c:set var="str" value="${fn:replace(str,'>','&gt;') }" />	
	<c:set var="str" value="${fn:replace(str,'  ','&nbsp;&nbsp;')}" />
	<c:set var="str" value="${fn:replace(str,newLineChar,'<br>') }" />
<%-- <c:set var="str" value="${fn:replace(str, '\\','<br>') }" /> --%>
<!-- c:set 태그안에는 역슬래쉬를 쓸 수 없어서 별도로 처리해야함 -->
	<tr>
		<td style="border-right: 1px solid white;" width="10%">
			${row.replyer}			
		</td>
		<td style="text-align: justify;" width="70%">
			${str}
		</td>
		<td style="font-size: 10px;" width="10%">
			<fmt:formatDate value="${row.regdate}" pattern="yyyy-MM-dd a HH:mm:ss" />
		</td>
	<!-- 해당 댓글 작성자가 아닐 시 (삭제 칸 생성으로 인해 테이블 ui가 깨지는 것을 방지) -->
	<%-- <c:if test="${sessionScope.userid != row.replyer && sessionScope.admin_userid == null}">
		<td>
		</td>
	</c:if> --%>
	<!-- 댓글 삭제는 작성자, 관리자만 가능 -->
		<td width="10%" style="padding-right: 30px">
			<input type="hidden" class="${row.replyer}" value="${row.replyer}">
			<input type="hidden" id="${row.rno}" value="${row.rno}">
			<input type="hidden" class="${row.bno}" value="${row.bno}">
		<c:if test="${sessionScope.userid == row.replyer || sessionScope.admin_userid != null}">
			<button type="button" onclick="del_${row.rno}()">Delete</button>
		</c:if>
		</td>
	</tr>
</c:forEach>
</table>