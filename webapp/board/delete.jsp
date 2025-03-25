<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% int b_id = Integer.parseInt(request.getParameter("id"));
String pageNum = request.getParameter("pageNum");
%>
<script src="board.js"></script>
<h3>글 삭제하기</h3>
<form id="del_frm" name="del_frm" method="post" action="delete_ok.jsp?id=<%= b_id %>&pageNum=<%= pageNum %>">
	<table>
		<tr>
			<td colspan="2"><strong> >> 암호를 입력하세요 << </strong></td>
		</tr>
		<tr>
			<td width="80">암호</td>
			<td><input type="password" name="b_pwd" size="10" maxlength="12" ></td>
		</tr>

		<tr>
			<td colspan="2"><input type="button" value="글삭제"
				onclick="delete_ok()"> <input type="reset" value="다시 작성">
				<input type="button" value="글목록" onclick="location.href='list.jsp?pageNum=<%= pageNum %>';"></td>
		</tr>
	</table>
</form>
