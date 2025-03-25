<%
    // 세션 무효화 (모든 세션 데이터 삭제)
    session.invalidate();

    response.sendRedirect("login.jsp");
%>
