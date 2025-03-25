<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="script.js"></script>
<style>

</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form name="reg_frm" method="post" action="registerOk.jsp">
		<table border="1" align="center">
			<tr height="50">
				<td colspan="2" align="center">
					<h1>회원 가입 신청</h1>
					 '*' 표시 항목은 필수 입력 항목입니다.
				</td>
			</tr>
			<tr height="30">
				<td width="80">User ID</td>
				<td><input type="text" size="20" name="mem_uid">*</td>
			</tr>
			<tr>
				<td>암호</td>
				<td><input type="password" size="20" name="mem_pwd">*</td>
			</tr>
			<tr>
				<td>암호 확인</td>
				<td><input type="password" size="20" name="mem_pwd_check">*</td>
			</tr>
			<tr>
				<td>이 름</td>
				<td><input type="text" size="20" name="mem_name">*</td>
			</tr>
			<tr>
				<td>E-mail</td>
				<td><input type="text" size="30" name="mem_email">*</td>
			</tr>
			<tr>
				<td>주 소</td>
				<td><input type="text" size="40" name="mem_addr"></td>
			</tr>
			<tr>
				<td colspan="3" align="center">
				<input type="button" value="등록" onclick="check_ok()">
				<input type="reset" value="다시입력">
				<input type="button" value="가입안함" onclick="location='login.jsp'">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>