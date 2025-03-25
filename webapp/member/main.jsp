<%@page import="magic.member.MemberBean"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mb" class="magic.member.MemberBean" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
/* 	
	String str_name = "";
	String str_value ="";
	int i = 0;
	//MemberBean mb = manager.getMember(id);
	
	Enumeration enum_app = session.getAttributeNames();
	if(session == null || session.getAttribute(mb.getMem_uid()) == null || session.getAttribute(mb.getMem_uid()).equals("")) {
	}
	while(enum_app.hasMoreElements()) {
		i++;
		// nextElement 메소드 : 열거형 값을 가져옴
		str_name = enum_app.nextElement().toString();
		// getAttribute 메소드 : 세션 이름으로 값을 가져옴
		str_value = session.getAttribute(str_name).toString();

	} */
	if(session.getAttribute("Member") == null) {
		%>
			<jsp:forward page="login.jsp"></jsp:forward>
		<%
	}
	
	String uid = (String)session.getAttribute("uid");
	String name = (String)session.getAttribute("name");
	%>
	<table border="1" align="center">
		<tr>
			<td colspan="2">안녕하세요. <%=name %>(<%=uid %>)</td>
		</tr>
		<tr>
			<td colsapn="2" align="center">
				<input type="button" value="로그아웃" onclick="location='logout.jsp'">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="회원정보변경" onclick="location='memberUpdate.jsp'">
			</td> 
		</tr>
	</table>
	<%
%>

</body>
</html>