<%@page import="java.io.File"%>
<%@page import="magic.board.BoardBean"%>
<%@page import="magic.board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String pageNum = request.getParameter("pageNum");
String pw = request.getParameter("b_pwd");
int id = Integer.parseInt(request.getParameter("id"));
String b_id = request.getParameter("id");
BoardDBBean manager = BoardDBBean.getInstance();

//파일 삭제 처리
BoardBean board = manager.getBoard(b_id);
String fName = board.getB_fname();
String up = "C:\\Users\\user\\eclipse-workspace\\jdbc_250311\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\magicWeb_250319\\board\\upload\\";

int re = manager.deleteBoard(id, pw);
if (re == 1) {
	// 파일 삭제
	if(fName != null) {
		File file=new File(up+fName);
		file.delete();
	}
%>
<script>
	alert("삭제 완료");
	location.href = "list.jsp?pageNum=<%= pageNum %>";
</script>
<%
} else if (re == 0) {
%>
<script>
	alert("비밀번호가 다릅니다.");
	history.back();
</script>
<%

}

else {
	%>
	<script>
		alert("삭제실패");
		history.back();
	</script>
	<%
}
%>