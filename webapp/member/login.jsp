<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border="1" align="center">
		<form method="post" action="loginOk.jsp">
			<tr height="30">
				<td width="100" align="center">사용자ID</td>
				<td width="100"><input type="text" name="mem_uid"></td>
			</tr>
			<tr height="30">
				<td width="100" align="center">비밀번호</td>
				<td width="100"><input type="password" name="mem_pwd"></td>

			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="로그인">
					<input type="button" value="회원가입" onclick="location='register.jsp'">
				</td>
			</tr>
		</form>
	</table>
</body>
</html>