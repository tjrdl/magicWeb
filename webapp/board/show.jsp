<%@page import="java.text.SimpleDateFormat"%>
<%@page import="magic.board.BoardBean"%>
<%@page import="magic.board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String pageNum = request.getParameter("pageNum");

String id = request.getParameter("id");
BoardDBBean manager = BoardDBBean.getInstance();
manager.updateCount(id);
BoardBean board = manager.getBoard(id);
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<center>

	<h3>글 내용 보기</h3>

	<table border="1" width="600" cellspacing="0">

		<tr align="center" bgcolor="#f7f7f7"
			onmouseover="this.style.backgroundColor='#eeeeef'"
			onmouseout="this.style.backgroundColor='#f7f7f7'">
			<td height="30" width="120" align="center">글번호</td>
			<td height="30" width="240" align="center"><%=board.getB_id()%>
			</td>
			<td height="30" width="120" align="center">조회수</td>
			<td height="30" width="240" align="center"><%=board.getB_hit()%>
			</td>
		</tr>
		<tr align="center" bgcolor="#f7f7f7"
			onmouseover="this.style.backgroundColor='#eeeeef'"
			onmouseout="this.style.backgroundColor='#f7f7f7'">
			<td height="30" width="120" align="center">작성자</td>
			<td><%=board.getB_name()%></td>
			<td height="30" width="120" align="center">작성일</td>
			<td><%=sdf.format(board.getB_date())%></td>
		</tr>
		<tr align="center" bgcolor="#f7f7f7"
			onmouseover="this.style.backgroundColor='#eeeeef'"
			onmouseout="this.style.backgroundColor='#f7f7f7'">
			<td width="110">파&nbsp;&nbsp;일</td>
			<td colspan="3">
				&nbsp;
				<%-- <%
					if(board.getB_fname() != null) {
						%> 
						<img src="./images/zip.gif">
						<a href="./upload/<%=board.getB_fname()%>">
						원본 파일:<%=board.getB_fname()%>
						</a>
						<%
						
					}
				%> --%>
				<%
				out.print("<p>첨부파일"+"<a href='fileDownload.jsp?fileN="+board.getB_id()+"'>"+board.getB_rfname()+"</a>"+"</p>");
				%>
		</tr>
		<tr align="center" bgcolor="#f7f7f7"
			onmouseover="this.style.backgroundColor='#eeeeef'"
			onmouseout="this.style.backgroundColor='#f7f7f7'">
			<td height="30" width="120" align="center">글제목</td>
			<td height="30" width="240" align="left" colspan="3"><%=board.getB_title()%></td>
		</tr>
		<tr align="center" bgcolor="#f7f7f7"
			onmouseover="this.style.backgroundColor='#eeeeef'"
			onmouseout="this.style.backgroundColor='#f7f7f7'">
			<td height="30" width="120" align="center">글내용</td>
			<td height="30" width="240" align="left" colspan="3"><%=board.getB_name()%></td>
		</tr>
		<tr align="center" bgcolor="#f7f7f7"
			onmouseover="this.style.backgroundColor='#eeeeef'"
			onmouseout="this.style.backgroundColor='#f7f7f7'">
			<td align="right" colspan="4"><input type="button" value="글수정"
				onclick="location.href='edit.jsp?id=<%=id%>&pageNum=<%=pageNum%>'">
				<input type="button" value="글목록"
				onclick="location.href = 'list.jsp?pageNum=<%=pageNum%>'">
				<input type="button" value="글삭제"
				onclick="location.href='delete.jsp?id=<%=id%>&pageNum=<%=pageNum%>';">
				<input type="button" value="답변글"
				onclick="location.href='write.jsp?id=<%=id%>&pageNum=<%=pageNum%>';">
			</td>
		</tr>


	</table>
</center>