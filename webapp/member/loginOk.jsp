<%@page import="magic.member.MemberBean"%>
<%@page import="magic.member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String id = request.getParameter("mem_uid");
	String pwd = request.getParameter("mem_pwd");

	MemberDBBean manager = MemberDBBean.getInstance();

	int check = manager.userCheck(id, pwd);
	MemberBean mb = manager.getMember(id);
	
	if (mb == null){
		%>
		<script>
			alert("존재하지 않는 회원");
			history.back();
		</script>
		<%
	} else {
		String name = mb.getMem_name();
		if(check == 1){
			// session.setAttribute(id, mb.getMem_name());
			session.setAttribute("uid", id);
			session.setAttribute("name", mb.getMem_name());
			session.setAttribute("Member", "yes"); //회원여부
			response.sendRedirect("main.jsp");
		} else if (check == 0){
			%>
			<script>
				alert("비밀번호가 맞지 않습니다.");
				history.back();
			</script>
			<%
		} else {
			%>
			<script>
				alert("아이디가 맞지 않습니다.");
				history.back();
			</script>
			<%
		}
	}
	
	 	//if(manager.userCheck(id, pwd) == 1){
		//session.setAttribute(id, id);
		//
		//<script>
			//alert("로그인완료");
			//location.href="main.jsp";
		//</script>
	//} else if(manager.userCheck(id, pwd) == 0){
		
	//} else {
		//<script>
			//alert("로그인실패");
			//history.back();
		//</script>
	//}
%>
</body>
</html>