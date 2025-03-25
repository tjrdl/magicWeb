<%@page import="java.util.ArrayList"%>
<%@page import="test.emp.emp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="test.emp.empdb"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
empdb manager = empdb.getInstance();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
ArrayList<emp> empboard = manager.listBoard();
%>

<table border="1">
	<tr>
		<td width="80">사원번호</td>
		<td width="80">사원명</td>
		<td width="100">직급</td>
		<td width="80">상관번호</td>
		<td width="100">입사일자</td>
		<td width="50">급여</td>
		<td width="50">커미션</td>
		<td width="70">부서번호</td>
	</tr>
	<tr>
		<%
		for (emp emp1 : empboard) {
		%>
	
	<tr>
		<td><%=emp1.getEmpno()%></td>
		<td><%=emp1.getEname()%></td>
		<td><%=emp1.getJob()%></td>
		<td><%=emp1.getMgr()%></td>
		<td><%=sdf.format(emp1.getHiredate())%></td>
		<td><%=emp1.getSal()%></td>
		<td><%=emp1.getComm()%></td>
		<td><%=emp1.getDeptno()%></td>
	</tr>
	<%
	}
	%>


</table>