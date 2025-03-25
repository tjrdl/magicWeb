<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="magic.board.BoardBean"%>
<%@page import="magic.board.BoardDBBean"%>
	<%
	String pageNum = request.getParameter("pageNum");

	String id = request.getParameter("id");
	BoardDBBean manager = BoardDBBean.getInstance();
	BoardBean board = manager.getBoard(id);
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="board.js"></script>
</head>
<body>

	<center>
		<h3>글 수정하기</h3>
		<form id="reg_frm" name="reg_frm" method="post" action="edit_ok.jsp?id=<%= id %>&pageNum=<%= pageNum %>">
			<table>
				<tr height="30">
					<td width="80">작성자</td>
					<td width="140"><input type="text" name="b_name" size="10"
						maxlength="20" value = <%= board.getB_name() %>></td>

					<td width="80">이메일</td>
					<td width="240"><input type="text" name="b_email" size="10"
						maxlength="50" value = <%= board.getB_email() %>></td>
				</tr>
				<tr height="30">
					<td width="80">글제목</td>
					<td colspan="3" width="460"><input type="text" name="b_title"
						size="55" maxlength="80" value = <%= board.getB_title() %>></td>
				</tr>
				<tr height="30">
					<td width="80">파 일</td>
					<td colspan="3" width="140"><input type="file" name="b_fname"
						size="40" maxlength="100"value = <%= board.getB_fname() %>></td>
				</tr>
				<tr>
					<td colspan="4"><textarea name="b_content" cols="65" rows="10"><%= board.getB_content() %></textarea>
					</td>
				</tr>
				<tr height="30">
					<td width="80">암호</td>
					<td width="140">
					<input type="password" name="b_pwd" size="10" maxlength="12">
					</td>
				</tr>
				<tr height="50" align="center">
					<td colspan="4"><input type="button" value="글쓰기"
						onclick="check_ok()"> <input type="reset" value="다시 작성">
						<input type="button" value="글목록"
						onclick="location.href='list.jsp?pageNum=<%= pageNum %>';"></td>
				</tr>
			</table>
		</form>
	</center>
</body>
</html>