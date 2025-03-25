<%@page import="magic.board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="board" class="magic.board.BoardBean" />
<jsp:setProperty property="*" name="board" />
<%
String pageNum = request.getParameter("pageNum");

int id = Integer.parseInt(request.getParameter("id"));
BoardDBBean db = BoardDBBean.getInstance();
int re = db.editBoard(board, id);

if (re == 1) {
	%>
	<script>
		alert("수정 완료");
		location.href = "list.jsp?pageNum=<%= pageNum %>";
		
	</script>
	<%
} 
else if( re == 0) {
	%>
	<script>
		alert("비밀번호가 틀림");
		history.back();
	</script>
	<%
}

else {
	%>
	<script>
		alert("수정 실패");
		history.back();
	</script>
	<%
}
%>
