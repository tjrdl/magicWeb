<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.jspsmart.upload.File"%>
<%@page import="com.jspsmart.upload.SmartUpload"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.lang.ProcessBuilder.Redirect"%>
<%@page import="magic.board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
	
<jsp:useBean id="board" class="magic.board.BoardBean" />
<jsp:setProperty property="*" name="board" />

<%-- <%
//파일 업로드 처리
SmartUpload upload = new SmartUpload();
upload.initialize(pageContext);
upload.upload();
String fName="";
int fileSize = 0;

File file = upload.getFiles().getFile(0);

if(!file.isMissing()) {
	fName = file.getFileName();
	file.saveAs("./board/upload/"+file.getFileName());
	fileSize = file.getSize();
}
%> --%>

<%
String path = request.getRealPath("/upload");
int size = 1024 * 1024 * 10; // 10MB 제한
int fileSize = 0;
String file = "";
String orifile="";

// DefaultFileRenamePolicy : 파일명 넘버링 처리
MultipartRequest multi = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());
Enumeration files = multi.getFileNames();
String str = files.nextElement().toString();
multi.getFilesystemName(str);

if(file != null) {
	//실제 파일명 original file
	orifile = multi.getOriginalFileName(str);
	fileSize = file.getBytes().length;	
}
%>
<% 


// 자바 클래스를 이용한 ip 추가
InetAddress address = InetAddress.getLocalHost();
String j_ip = address.getHostAddress();


String ip = request.getRemoteAddr();
%>
<%-- <jsp:setProperty property="b_ip" name="board" value="<%= ip %>"/> --%>
<jsp:setProperty property="b_ip" name="board" value="<%= j_ip %>"/>
<%
// board.setB_name(upload.getRequest().getParameter("b_name"));
// board.setB_email(upload.getRequest().getParameter("b_email"));
// board.setB_title(upload.getRequest().getParameter("b_title"));
// board.setB_content(upload.getRequest().getParameter("b_content"));
// board.setB_pwd(upload.getRequest().getParameter("b_pwd"));

// board.setB_fname(fName);
board.setB_name(multi.getParameter("b_name"));
board.setB_email(multi.getParameter("b_email"));
board.setB_title(multi.getParameter("b_title"));
board.setB_content(multi.getParameter("b_content"));
board.setB_pwd(multi.getParameter("b_pwd"));

board.setB_id(Integer.parseInt(multi.getParameter("b_id")));
board.setB_ref(Integer.parseInt(multi.getParameter("b_ref")));
board.setB_step(Integer.parseInt(multi.getParameter("b_step")));
board.setB_level(Integer.parseInt(multi.getParameter("b_level")));

if(file != null) {
	board.setB_fname(file);
	board.setB_fsize(fileSize);
	board.setB_rfname(orifile);
}

BoardDBBean db = BoardDBBean.getInstance();
int re = db.insertBoard(board);
%>
<% if (re == 1) {
	response.sendRedirect("list.jsp");
} else {
	response.sendRedirect("write.jsp");
}
%>
<script>
	location.href = "write.jsp";
</script>