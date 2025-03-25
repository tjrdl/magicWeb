<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="magic.board.BoardBean"%>
<%@page import="magic.board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
String pageNum = request.getParameter("pageNum");
if(pageNum == null) {
	pageNum="1";
}
BoardDBBean manager = BoardDBBean.getInstance();
ArrayList<BoardBean> board = manager.listBoard(pageNum);
int b_fsize = 0;
int b_level = 0;
// null 값 존재시 에러 발생
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	window.addEventListener("pageshow", function(event) {
		if (event.persisted) {
			location.reload(); // 뒤로 가기 시 강제 새로고침
		}
	});
</script>
</head>
<body>
	<center>

		<h3>게시판에 등록된 글 목록 보기</h3>
		<table width="560">
			<tr>
				<td align="right"><a href="write.jsp?pageNum=<%= pageNum %>">글쓰기</a></td>
			</tr>
		</table>

		<form>
			<table border="1">
				<tr>
					<td width="50" align="center">번호</td>
					
					<td width="80" align="center">첨부파일</td>

					<td width="450" align="center">글제목</td>

					<td width="120" align="center">작성자</td>

					<td width="120" align="center">작성일</td>

					<td width="120" align="center">조회수</td>

				</tr>
				<tr>
					<%
					for (BoardBean bd : board) {
					%>
				
				<tr align="left" bgcolor="#f7f7f7"
					onmouseover="this.style.backgroundColor='#eeeeef'"
					onmouseout="this.style.backgroundColor='#f7f7f7'">
					<td align="center"><%=bd.getB_id()%></td>
					<td align="left"><% if(bd.getB_fsize() >0) {
						%> 
						<img src="./images/zip.gif">
						<% 
					}
					%>
					<%= bd.getB_fsize() %></td>
					<td>
						<%
						if (bd.getB_level() > 0) {
							for (int j = 0; j < bd.getB_level(); j++) {
						%> &nbsp; <%
 }
 %> <img src="./images/AnswerLine.gif" width="16" height="16">
						<%
						}
						%> <a href="show.jsp?id=<%=bd.getB_id()%>&pageNum=<%= pageNum %>"><%=bd.getB_title()%>
					</a>
					</td>
					<td align="center"><a href="mailto:<%=bd.getB_email()%>">
							<%=bd.getB_name()%></a></td>
					<td align="center"><%=sdf.format(bd.getB_date())%></td>
					<td align="center"><%=bd.getB_hit()%></td>

					<%
					}
					%>
				</tr>
				<!-- for(int i = 0; i< boardList.size(); i++  {
		// ArrayList 데이터의 BoardBean 객체를 가져온다.
		BoardBean bd = boardList.get(i);
		// board 객체에 있는 컬럼 데이터를 가져옴
		b_id = board.getB_id();
		b_ name = board.getB_title();
		b_email = board.getB_name();
		b_title = board.getB_email();
		b_content = board.getB_content();
}
-->

			</table>
		</form>
		<%= BoardBean.pageNumber(4) %>
	</center>
</body>
</html>