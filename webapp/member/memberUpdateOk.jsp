<%@page import="magic.member.MemberBean"%>
<%@page import="magic.member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--<jsp:useBean class="magic.member.MemberBean" id="member"></jsp:useBean>
<jsp:setProperty property="*" name="member"/>-->
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String s_uid = (String)session.getAttribute("uid");
	
	MemberDBBean manager = MemberDBBean.getInstance();

	MemberBean mb = manager.getMember(s_uid);
	mb.setMem_pwd(request.getParameter("mem_pwd"));
	mb.setMem_email(request.getParameter("mem_pwd"));
	mb.setMem_addr(request.getParameter("mem_addr"));
	int check = manager.updateMember(mb);
	
	
	
	if (mb == null){
		%>
		<script>
			alert("mb가 존재하지않음");
			history.back();
		</script>
		<%
	} else {
		if(check == 1){
			%>
			<script>
				alert("회원정보가 수정되었습니다.");
				location.href="main.jsp";
			</script>
			<%
			// response.sendRedirect("main.jsp");
		} else {
			%>
			<script>
				alert("오류가 발생하였습니다.");
				history.back();
			</script>
			<%
		}
	}
%>
</body>
</html>