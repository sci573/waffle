<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
/* 삭제 버튼 양식 */
#del {
	width: auto;
	height: 25px;
	border-radius: 3px;
	background-color: white;
	cursor: pointer;
}
#del:hover {
	background-color: #8600b3;
	color: white;
}
</style>
<table>
<c:forEach var="row" items="${list}">
<script type="text/javascript">
function del_${row.rno}() {
	if(confirm("댓글을 삭제하시겠습니까?")){
		var writer=$(".${row.writer}").val();
		var rno=$("#${row.rno}").val();
		var title=$(".${row.title}").val();
		var param="writer="+writer+"&rno="+rno+"&title="+title;
		$.ajax({
			type : "post",
			url : "${pageContext.request.contextPath}/waffleContent/commentDlt.do",
			data : param,
			success : function(){
				alert("댓글이 삭제되었습니다");
				comment_list();
			}
		});	
	}
}
</script>
	<tr>
		<td style="border-right: 1px solid white;" width="10%">
			${row.writer}
		</td>
		<td style="text-align: justify;" width="70%">
			${row.content} 
		</td>
		<td style="font-size: 10px;" width="10%">
			<fmt:formatDate value="${row.reg_date}" pattern="yyyy-MM-dd a HH:mm:ss"/>
		</td>
	<!-- 해당 댓글 작성자가 아닐 시 (삭제 칸 생성으로 인해 테이블 ui가 깨지는 것을 방지) -->
	<%-- <c:if test="${sessionScope.userid != row.writer}">
		<td>
		</td>
	</c:if> --%>
	<!-- 댓글 삭제는 작성자, 관리자만 가능 -->
		<td width="10%">
			<input type="hidden" class="${row.writer}" value="${row.writer}">
			<input type="hidden" id="${row.rno}" value="${row.rno}">
			<input type="hidden" class="${row.title}" value="${row.title}">
		<c:if test="${sessionScope.userid == row.writer || sessionScope.admin_userid != null}">
			<button type="button" id="del" onclick="del_${row.rno}()">Delete</button>
		</c:if>
		</td>
	</tr>
</c:forEach>
</table>