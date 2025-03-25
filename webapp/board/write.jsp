<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="magic.board.BoardBean"%>
<%@page import="magic.board.BoardDBBean"%>
<%
String pageNum = request.getParameter("pageNum");

String id = request.getParameter("id");

int b_id = 0, b_ref = 1, b_step = 0 , b_level = 0; 
String b_title = "";

if (id != null && !id.isEmpty()) { // null 및 빈 문자열 체크
    try {
        b_id = Integer.parseInt(id);
    } catch (NumberFormatException e) {
        b_id = 0; // 기본값 설정
    }
}

BoardDBBean manager = BoardDBBean.getInstance();
BoardBean board = null;

if (b_id > 0) { // 유효한 id 값이 있을 때만 조회
    board = manager.getBoard(id);
}

if (board != null) { // 답변글
    b_ref = board.getB_ref();
    b_step = board.getB_step();
    b_level = board.getB_level();
    b_title = board.getB_title();
}


%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="board.js"></script>
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); %>

	<center>
		<h3>글 올리기</h3>
		<form id="reg_frm" name="reg_frm" method="post" action="write_ok.jsp" enctype="multipart/form-data">
		<input type="hidden" name="b_id" value="<%= b_id %>">
		<input type="hidden" name="b_ref" value="<%= b_ref %>">
		<input type="hidden" name="b_step" value="<%= b_step %>">
		<input type="hidden" name="b_level" value="<%= b_level %>">
			<table>
				<tr height="30">
					<td width="80">작성자</td>
					<td width="140"><input type="text" name="b_name" size="10"
						maxlength="20"></td>

					<td width="80">이메일</td>
					<td width="240"><input type="text" name="b_email" size="10"
						maxlength="50"></td>
				</tr>
				<tr height="30">
					<td width="80">글제목</td>
					<td colspan="3" width="460">
					<% if(b_id == 0) {
						%> 
						<input type="text" name="b_title"
						size="55" maxlength="80">
						<%
					}
					else {
						%> 
						<input type="text" name="b_title"
						size="55" maxlength="80" value="[답글]:<%= b_title %>">
						<%
					}%>
					</td>
				</tr>
				<tr height="30">
					<td width="80">파 일</td>
					<td colspan="3" width="140"><input type="file" name="b_fname"
						size="40" maxlength="100"></td>
				</tr>
				<tr>
					<td colspan="4"><textarea name="b_content" cols="65" rows="10"></textarea>
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
						onclick="location.href='list.jsp?pageNum=<%= pageNum %>'"></td>
				</tr>
			</table>
		</form>
	</center>
</body>
</html>